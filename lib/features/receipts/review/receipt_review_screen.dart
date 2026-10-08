import '../../../core/money/format_locale.dart';
import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';
import '../../../data/db/app_database.dart';

import 'receipt_review_controller.dart';
import '../../ai/ai_client.dart';
import '../../subscription/subscription_paywall.dart';
import '../../subscription/subscription_service.dart';

/// Fiş inceleme ve eşleştirme ekranı (spec §6.9).
///
/// Kurallar:
/// - Onay öncesi DB yazımı yoktur (controller kuralı; burada da bildirilir).
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

class _ReceiptReviewScreenState extends State<ReceiptReviewScreen> {
  late final ReceiptReviewController _c = widget.controller;

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
    unawaited(_c.prefillSuggestions());
    unawaited(widget.plannedItems.then((items) {
      if (!mounted) return;
      setState(() => _plannedNames = {for (final p in items) p.id: p.name});
    }));
  }

  Map<int, String> _plannedNames = const {};

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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.receiptReviewTitle)),
      body: Column(
        children: [
          if (_c.aiMatched || _c.aiProblem != null)
            MaterialBanner(
              key: const Key('receipt_ai_banner'),
              leading: Icon(_c.aiMatched ? Icons.auto_awesome : Icons.info_outline),
              content: Text(_c.aiMatched
                  ? l10n.receiptAiMatched
                  : switch (_c.aiProblem) {
                      AiQuota(:final used, :final limit) => l10n.aiQuotaReached(used, limit),
                      AiOffline() => l10n.aiOffline,
                      _ => l10n.aiFailed,
                    }),
              actions: [
                if (_c.aiProblem is AiQuota && SubscriptionService.instance != null)
                  TextButton(onPressed: () => openPlans(context), child: Text(l10n.plansTitle))
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
              subtitle: diff == null
                  ? null
                  : Text(
                      '${l10n.receiptDiff}: ${money(diff)}',
                      style: TextStyle(
                        color:
                            _c.lines.any(
                                  (l) => l.status == ReviewStatus.accepted,
                                ) &&
                                diff != 0
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.primary,
                      ),
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
                    title: Text(line.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${_lineQty(line)} · ${money(line.lineTotalMinor)}'),
                        if (line.linkedPlannedItemId != null &&
                            _plannedNames[line.linkedPlannedItemId] != null)
                          Text(
                            '→ ${_plannedNames[line.linkedPlannedItemId]}',
                            key: Key('receipt_line_link_$i'),
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                        if (line.needsCheck || line.isDiscount)
                          Wrap(
                            spacing: 6,
                            children: [
                              if (line.needsCheck)
                                Text(l10n.receiptNeedsCheck,
                                    key: Key('receipt_line_check_$i'),
                                    style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
                              if (line.isDiscount) Text(l10n.receiptDiscountLine),
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
                          onPressed: () => _toggleAccept(i),
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
                          onPressed: () => _c.ignore(i),
                        ),
                      ],
                    ),
                    onTap: () => _showActions(i),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: FilledButton(
                key: const Key('receipt_commit_button'),
                onPressed:
                    _c.lines.any((l) => l.status == ReviewStatus.accepted)
                    ? () => _commit(context)
                    : null,
                child: Text(l10n.receiptCommit),
              ),
            ),
          ),
        ],
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
      case 'merge':
        _c.mergeLines(index, index + 1);
      case 'ignore':
        _c.ignore(index);
    }
  }

  String _lineQty(ReviewLine line) {
    final q = line.quantity?.toDbString();
    return q == null ? '' : '$q ×';
  }

  Future<void> _commit(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await _c.commit();
    if (!context.mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(l10n.receiptCommitted)));
    Navigator.of(context).maybePop();
  }
}
