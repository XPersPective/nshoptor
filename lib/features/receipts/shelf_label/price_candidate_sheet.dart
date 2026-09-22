import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import 'price_candidates.dart';

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
                '${c.value.toDbString()} ${c.currencyCode}'
                '${c.isUnitPrice ? ' /unit' : ''}',
              ),
              subtitle: Text(c.sourceLine),
              trailing: Text(c.confidence),
              onTap: () => Navigator.of(ctx).pop(c),
            ),
        ],
      ),
    ),
  );
}
