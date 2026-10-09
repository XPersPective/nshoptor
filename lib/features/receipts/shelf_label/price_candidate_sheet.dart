import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import 'price_candidates.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/money/money_parser.dart';

/// Raf etiketi adaylarını listeler; kullanıcının seçtiği değer döner
/// (spec §6.8: en büyük sayı körlemesine seçilmez, kullanıcı seçer).
Future<PriceCandidate?> showPriceCandidateSheet(
  BuildContext context,
  List<PriceCandidate> candidates,
) {
  final l10n = AppLocalizations.of(context);
  return showModalBottomSheet<PriceCandidate>(
    context: context,
    builder: (ctx) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(title: Text(l10n.priceCandidatesTitle)),
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
                '${c.unitCode != null ? ' / ${unitDisplayName(c.unitCode!, l10n)}' : c.isUnitPrice ? ' · ${l10n.pricingModeUnitPrice}' : ''}',
              ),
              subtitle: Text({if (c.productName != null) c.productName!, c.sourceLine}.join(' · ')),
              trailing: c.confidence == 'ai'
                  ? Chip(
                      avatar: const Icon(Icons.auto_awesome, size: 16),
                      label: Text(l10n.aiSourceLabel),
                    )
                  : Text(c.confidence),
              onTap: () => Navigator.of(ctx).pop(c),
            ),
        ],
      ),
    ),
  );
}
