import '../../../core/money/format_locale.dart';

import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_parser.dart';
import '../../../data/db/app_database.dart';

import 'receipt_review_controller.dart';
import '../../ai/ai_client.dart';
import '../../subscription/subscription_paywall.dart';
import '../../subscription/subscription_service.dart';

/// Fiş inceleme ve eşleştirme ekranı (spec §6.9).
///
/// Kurallar:
/// - Onay öncesi liste/satın alım yazımı yoktur; tarama taslağı ayrı saklanır.
/// - Onay sonrası: kabul edilen satırlar plannersız/bağlı değerlendirilir.
/// - Fark (kabul edilenler vs bildirilen toplam) açıkça görüntülenir.
class ReceiptReviewScreen extends StatefulWidget {
  const ReceiptReviewScreen({
    super.key,
    required this.controller,
    required this.currency,
    required this.plannedItems,
  });

  final ReceiptReviewController controller;
  final String currency;

  /// Bağlama hedefleri (listenin planlanan ürünleri).
  final Future<List<PlannedItem>> plannedItems;

  @override
  State<ReceiptReviewScreen> createState() => _ReceiptReviewScreenState();
}

enum _ReviewPhase { matching, ready, saving }

class _ReceiptReviewScreenState extends State<ReceiptReviewScreen> {
  late final ReceiptReviewController _c = widget.controller;
  _ReviewPhase _phase = _ReviewPhase.matching;
  bool get _saving => _phase == _ReviewPhase.saving;
  bool get _editable => _phase == _ReviewPhase.ready;
  String? _failureMessage;

  @override
  void dispose() {
    _c.removeListener(_sync);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _c.addListener(_sync);
    // Öneriler (PB-040): yüksek güvenli eşleşmeler bağlanmış gelir;
    // kullanıcı tek dokunuşla onaylar/değiştirir (C-003: onaysız DB yok).
    unawaited(_prepareReview());
    unawaited(
      widget.plannedItems.then((items) {
        if (!mounted) return;
        setState(() => _plannedNames = {for (final p in items) p.id: p.name});
      }),
    );
  }

  Map<int, String> _plannedNames = const {};

  Future<void> _prepareReview() async {
    try {
      // Deterministic local matching finishes before approval becomes possible.
      await _c.prefillRules();
    } catch (_) {
      if (mounted) _failureMessage = AppLocalizations.of(context).saveFailed;
    } finally {
      if (mounted) setState(() => _phase = _ReviewPhase.ready);
    }
    if (!mounted) return;
    // Optional AI may enrich unresolved suggestions without delaying review or
    // overriding a row the user has already accepted, ignored or unlinked.
    try {
      await _c.prefillSuggestions();
    } catch (_) {}
  }

  void _sync() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(widget.currency);
    String money(int minor) => formatMoney(
      Money.fromMinorUnits(minor, currency),
      locale: formatLocaleCode(context),
    );

    final diff = _c.reconciliationDifference;
    final metadata = _c.document?.metadata;
    final decisionsComplete = _c.lines.every(
      (l) => l.status != ReviewStatus.pending,
    );
    final material = MaterialLocalizations.of(context);
    final printedAt = metadata?.dateTime;
    final metadataText = [
      if (metadata?.store != null) metadata!.store!,
      if (printedAt != null)
        '${material.formatCompactDate(printedAt)} ${material.formatTimeOfDay(TimeOfDay.fromDateTime(printedAt))}',
      if (metadata?.documentNumber != null)
        '${l10n.reportReceiptNumber}: ${metadata!.documentNumber}',
    ].join('\n');
    return PopScope(
      canPop: !_saving,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.receiptReviewTitle),
          leading: IconButton(
            key: const Key('receipt_cancel'),
            tooltip: l10n.cancelButton,
            icon: const Icon(Icons.close),
            onPressed: _saving ? null : () => Navigator.of(context).maybePop(),
          ),
        ),
        body: Column(
          children: [
            if (_phase == _ReviewPhase.matching)
              const LinearProgressIndicator(),
            if (_c.currencyNeedsConfirmation ||
                _c.detectedCurrency != null &&
                    _c.detectedCurrency != widget.currency)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  '${l10n.currencyLabel}: ${_c.detectedCurrency ?? '?'} → ${widget.currency}. ${l10n.invalidAmountError}',
                  key: const Key('receipt_currency_mismatch'),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            if (_failureMessage != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  _failureMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            if (_c.aiMatched || _c.aiProblem != null)
              MaterialBanner(
                key: const Key('receipt_ai_banner'),
                leading: Icon(
                  _c.aiMatched ? Icons.auto_awesome : Icons.info_outline,
                ),
                content: Text(
                  _c.aiMatched
                      ? l10n.receiptAiMatched
                      : switch (_c.aiProblem) {
                          AiQuota(:final used, :final limit) =>
                            l10n.aiQuotaReached(used, limit),
                          AiOffline() => l10n.aiOffline,
                          _ => l10n.aiFailed,
                        },
                ),
                actions: [
                  if (_c.aiProblem is AiQuota &&
                      SubscriptionService.instance != null)
                    TextButton(
                      onPressed: () => openPlans(context),
                      child: Text(l10n.plansTitle),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(
                  _c.reportedTotalMinor == null
                      ? l10n.receiptTotalUnknown
                      : '${l10n.receiptTotal}: ${money(_c.reportedTotalMinor!)}',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (metadataText.isNotEmpty)
                      Text(
                        metadataText,
                        key: const Key('receipt_document_metadata'),
                      ),
                    if (diff != null && decisionsComplete)
                      Text(
                        '${l10n.receiptDiff}: ${money(diff)}',
                        style: TextStyle(
                          color: diff != 0
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _c.lines.length,
                itemBuilder: (context, i) {
                  final line = _c.lines[i];
                  return Card(
                    child: ListTile(
                      key: Key('receipt_line_$i'),
                      title: Text(
                        line.isDiscount && line.lineTotalMinor < 0
                            ? l10n.receiptDiscountLine
                            : line.name,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            [
                              if (_lineQty(line).isNotEmpty) _lineQty(line),
                              money(line.lineTotalMinor),
                            ].join(' · '),
                          ),
                          if (line.linkedPlannedItemId != null &&
                              _plannedNames[line.linkedPlannedItemId] != null)
                            Text(
                              '→ ${_plannedNames[line.linkedPlannedItemId]}',
                              key: Key('receipt_line_link_$i'),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          if (line.needsCheck || line.isDiscount)
                            Wrap(
                              spacing: 6,
                              children: [
                                if (line.needsCheck)
                                  Text(
                                    l10n.receiptNeedsCheck,
                                    key: Key('receipt_line_check_$i'),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                if (line.isDiscount)
                                  Text(l10n.receiptDiscountLine),
                              ],
                            ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              line.status == ReviewStatus.accepted
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: line.status == ReviewStatus.accepted
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                            ),
                            tooltip: l10n.acceptLine,
                            onPressed: _editable
                                ? () => _toggleAccept(i)
                                : null,
                          ),
                          IconButton(
                            icon: Icon(
                              line.status == ReviewStatus.ignored
                                  ? Icons.cancel
                                  : Icons.cancel_outlined,
                              color: line.status == ReviewStatus.ignored
                                  ? Theme.of(context).colorScheme.error
                                  : null,
                            ),
                            tooltip: l10n.ignoreLine,
                            onPressed: _editable ? () => _c.ignore(i) : null,
                          ),
                        ],
                      ),
                      onTap: _editable ? () => _showActions(i) : null,
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_c.reviewResolved) Text(l10n.receiptResolveLines),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: [
                        TextButton(
                          key: const Key('receipt_accept_all'),
                          onPressed: _editable ? _c.acceptAll : null,
                          child: Text(l10n.receiptCommit),
                        ),
                        FilledButton(
                          key: const Key('receipt_commit_button'),
                          onPressed:
                              _editable &&
                                  _c.documentReady &&
                                  _c.reviewResolved &&
                                  !_c.currencyNeedsConfirmation &&
                                  (_c.detectedCurrency == null ||
                                      _c.detectedCurrency == widget.currency) &&
                                  _c.lines.any(
                                    (l) => l.status == ReviewStatus.accepted,
                                  )
                              ? () => _commit(context)
                              : null,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Visibility(
                                visible: !_saving,
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: Text(l10n.saveButton),
                              ),
                              if (_saving)
                                const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleAccept(int i) {
    final line = _c.lines[i];
    if (line.status == ReviewStatus.accepted) {
      _c.ignore(i);
    } else {
      _c.accept(i);
    }
  }

  Future<void> _showActions(int index) async {
    final l10n = AppLocalizations.of(context);
    final line = _c.lines[index];
    final action = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(line.name),
        children: [
          for (final (key, label) in [
            ('link', l10n.linkToItem),
            if (line.linkedPlannedItemId != null)
              ('unlink', l10n.groupUnplanned),
            if (line.lineTotalMinor > 1) ('split', l10n.splitLine),
            if (index + 1 < _c.lines.length) ('merge', l10n.mergeWithNext),
            ('ignore', l10n.ignoreLine),
          ])
            SimpleDialogOption(
              key: Key('receipt_action_$key'),
              onPressed: () => Navigator.pop(ctx, key),
              child: Text(label),
            ),
        ],
      ),
    );
    if (!mounted) return;
    switch (action) {
      case 'link':
        final items = await widget.plannedItems;
        if (!mounted) return;
        final id = await showDialog<int>(
          context: context,
          builder: (ctx) => SimpleDialog(
            title: Text(l10n.linkToItem),
            children: [
              for (final item in items)
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, item.id),
                  child: Text(item.name),
                ),
            ],
          ),
        );
        if (id != null) _c.linkLine(index, id);
      case 'split':
        _c.splitLine(index, firstMinor: line.lineTotalMinor ~/ 2);
      case 'unlink':
        _c.unlinkLine(index);
      case 'merge':
        try {
          _c.mergeLines(index, index + 1);
        } catch (_) {
          if (mounted) setState(() => _failureMessage = l10n.saveFailed);
        }
      case 'ignore':
        _c.ignore(index);
    }
  }

  String _lineQty(ReviewLine line) {
    final q = line.quantity == null
        ? null
        : formatQuantityNumber(
            line.quantity!,
            decimalSeparator: MoneySeparators.forLocaleCode(
              formatLocaleCode(context),
            ).decimal,
          );
    final unit = line.unitCode == null
        ? ''
        : unitDisplayName(line.unitCode!, AppLocalizations.of(context));
    if (q == null) return '';
    final quantity = '$q $unit'.trim();
    if (line.unitPriceMinor == null) return quantity;
    final price = formatMoney(
      Money.fromMinorUnits(
        line.unitPriceMinor!,
        Currency.fromCode(widget.currency),
      ),
      locale: formatLocaleCode(context),
    );
    return '$quantity × $price';
  }

  Future<void> _commit(BuildContext context) async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _phase = _ReviewPhase.saving;
      _failureMessage = null;
    });
    try {
      var selection = ReceiptSelection.wholeReceipt;
      if (_c.isPartialSelection) {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.receiptReviewTitle),
            content: Text(l10n.receiptPartialConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancelButton),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.saveButton),
              ),
            ],
          ),
        );
        if (!context.mounted || confirmed != true) return;
        selection = ReceiptSelection.confirmedSubset;
      }
      final previous = await _c.replacementEntries();
      if (!context.mounted) return;
      if (previous.isNotEmpty) {
        final currency = Currency.fromCode(widget.currency);
        String money(int minor) => formatMoney(
          Money.fromMinorUnits(minor, currency),
          locale: formatLocaleCode(context),
        );
        final before = previous.fold<int>(
          0,
          (s, e) => s + e.actualLineTotalMinorUnits,
        );
        final after = _c.lines
            .where(
              (l) =>
                  l.status == ReviewStatus.accepted &&
                  l.linkedPlannedItemId != null,
            )
            .fold<int>(0, (s, l) => s + l.lineTotalMinor);
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.receiptReviewTitle),
            content: Text(
              '${previous.map((e) => e.name).toSet().join(', ')}\n${l10n.actualTotalLabel}: ${money(before)} → ${money(after)}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancelButton),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.receiptCommit),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
      }
      await _c.commit(selection: selection);
      if (!context.mounted) return;
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text(l10n.receiptCommitted), showCloseIcon: true),
        );
      Navigator.of(context).pop();
    } on ReceiptAlreadyImported {
      if (mounted) setState(() => _failureMessage = l10n.receiptDuplicate);
    } catch (_) {
      if (mounted) setState(() => _failureMessage = l10n.saveFailed);
    } finally {
      if (mounted) setState(() => _phase = _ReviewPhase.ready);
    }
  }
}
