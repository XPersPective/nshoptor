import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import 'price_candidates.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/money/money_parser.dart';

/// Outcome of [showPriceCandidateSheet]: the candidate the user picked or
/// typed manually, or a request to photograph the label again.
class PriceCandidateSheetResult {
  const PriceCandidateSheetResult({this.candidate, this.retake = false})
    : assert((candidate != null) != retake);

  final PriceCandidate? candidate;

  /// The user asked for a new photo instead of choosing a candidate.
  final bool retake;
}

/// Raf etiketi adaylarını listeler; kullanıcının seçtiği değer döner
/// (spec §6.8: en büyük sayı körlemesine seçilmez, kullanıcı seçer).
/// [imagePath] shows the captured label above the choices, so the user sees
/// what was read before confirming a price (F04). Manual entry and retake
/// keep an unreadable label from dead-ending the flow (PB-208).
Future<PriceCandidateSheetResult?> showPriceCandidateSheet(
  BuildContext context,
  List<PriceCandidate> candidates, {
  String? imagePath,
  String currencyCode = 'TRY',
  bool allowRetake = true,
}) {
  final l10n = AppLocalizations.of(context);
  return showModalBottomSheet<PriceCandidateSheetResult>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Semantics(
              header: true,
              child: Text(l10n.priceCandidatesTitle),
            ),
          ),
          if (imagePath != null && File(imagePath).existsSync())
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(imagePath),
                  key: const Key('price_label_preview'),
                  height: 180,
                  fit: BoxFit.contain,
                  cacheHeight: 540,
                  semanticLabel: l10n.priceCandidatesTitle,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),
            ),
          if (candidates.isEmpty)
            ListTile(
              key: const Key('no_price_candidates'),
              title: Text(l10n.noPriceCandidates),
            ),
          for (final (i, c) in candidates.indexed)
            ListTile(
              key: Key('price_candidate_$i'),
              title: Text(
                '${MoneySeparators.forLocaleCode(formatLocaleCode(context)).formatInput(c.value.toDbString())} ${c.currencyCode}'
                '${c.unitCode != null
                    ? ' / ${c.priceQuantity == null ? '' : MoneySeparators.forLocaleCode(formatLocaleCode(context)).formatInput(c.priceQuantity!.toDbString())} ${unitDisplayName(c.unitCode!, l10n)}'
                    : c.isUnitPrice
                    ? ' · ${l10n.pricingModeUnitPrice}'
                    : ' · ${l10n.pricingModeLineTotal}'}',
              ),
              subtitle: Text(
                {
                  if (c.productName != null) c.productName!,
                  c.sourceLine,
                }.join(' · '),
              ),
              trailing: c.confidence == 'ai'
                  ? Chip(
                      avatar: const Icon(Icons.auto_awesome, size: 16),
                      label: Text(l10n.aiSourceLabel),
                    )
                  : c.confidence == 'manual'
                  ? Chip(
                      avatar: const Icon(Icons.edit_outlined, size: 16),
                      label: Text(l10n.priceManualEntryAction),
                    )
                  : null,
              onTap: () => Navigator.of(ctx).pop(
                PriceCandidateSheetResult(candidate: c),
              ),
            ),
          ListTile(
            key: const Key('price_manual_entry'),
            leading: const Icon(Icons.edit_outlined),
            title: Text(l10n.priceManualEntryAction),
            onTap: () async {
              final candidate = await _promptManualPrice(ctx, currencyCode);
              if (candidate == null || !ctx.mounted) return;
              Navigator.of(
                ctx,
              ).pop(PriceCandidateSheetResult(candidate: candidate));
            },
          ),
          // The flow hides this when no capture attempt is left (PB-208).
          if (allowRetake)
            ListTile(
              key: const Key('price_retake'),
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.priceRetakeAction),
              onTap: () => Navigator.of(
                ctx,
              ).pop(const PriceCandidateSheetResult(retake: true)),
            ),
        ],
      ),
    ),
  );
}

/// Numeric price dialog validated by [MoneyParser.parseDecimal] with the
/// active format-locale separators; returns the typed candidate, or null on
/// cancel. Never a unit price; source is the manual-entry label itself.
Future<PriceCandidate?> _promptManualPrice(
  BuildContext context,
  String currencyCode,
) => showDialog<PriceCandidate>(
  context: context,
  builder: (dialogContext) => _ManualPriceDialog(
    currencyCode: currencyCode,
    separators: MoneySeparators.forLocaleCode(formatLocaleCode(context)),
  ),
);

/// Owns its text field controller so the dialog's teardown can never use a
/// disposed controller (the dialog outlives the sheet that opened it).
class _ManualPriceDialog extends StatefulWidget {
  const _ManualPriceDialog({
    required this.currencyCode,
    required this.separators,
  });

  final String currencyCode;
  final MoneySeparators separators;

  @override
  State<_ManualPriceDialog> createState() => _ManualPriceDialogState();
}

class _ManualPriceDialogState extends State<_ManualPriceDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.priceManualEntryAction),
      content: TextField(
        key: const Key('price_manual_entry_field'),
        controller: _controller,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\u066b]')),
        ],
        decoration: InputDecoration(
          errorText: _error,
          suffixText: widget.currencyCode,
        ),
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancelButton),
        ),
        FilledButton(
          key: const Key('price_manual_entry_confirm'),
          onPressed: () {
            try {
              final value = MoneyParser.parseDecimal(
                _controller.text,
                separators: widget.separators,
              );
              Navigator.pop(
                context,
                PriceCandidate(
                  value: value,
                  currencyCode: widget.currencyCode,
                  sourceLine: l10n.priceManualEntryAction,
                  confidence: 'manual',
                  isUnitPrice: false,
                ),
              );
            } on FormatException {
              setState(() => _error = l10n.invalidAmountError);
            }
          },
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}
