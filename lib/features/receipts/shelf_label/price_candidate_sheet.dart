import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import 'price_candidates.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/money/money_parser.dart';

/// Raf etiketi adaylarını listeler; kullanıcının seçtiği değer döner
/// (spec §6.8: en büyük sayı körlemesine seçilmez, kullanıcı seçer).
/// [imagePath] shows the captured label above the choices, so the user sees
/// what was read before confirming a price (F04).
Future<PriceCandidate?> showPriceCandidateSheet(
  BuildContext context,
  List<PriceCandidate> candidates, {
  String? imagePath,
}) {
  final l10n = AppLocalizations.of(context);
  return showModalBottomSheet<PriceCandidate>(
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
                '${c.value.toDbString().replaceAll('.', MoneySeparators.forLocaleCode(formatLocaleCode(context)).decimal)} ${c.currencyCode}'
                '${c.unitCode != null
                    ? ' / ${c.priceQuantity?.toDbString() ?? ''} ${unitDisplayName(c.unitCode!, l10n)}'
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
                  : null,
              onTap: () => Navigator.of(ctx).pop(c),
            ),
        ],
      ),
    ),
  );
}
