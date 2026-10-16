import 'package:flutter/material.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../../core/theme/brand_wordmark.dart';

/// İlk açılışta bir kez: ana özellikler ve ne işe yaradıkları. "Tamam" ile
/// adım adım ilerler; son adımda kapanır ve bir daha gösterilmez.
Future<void> showFirstRunGuide(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final steps = [
    (icon: Icons.add, body: l10n.guideAddBody),
    (icon: Icons.mic_none, body: l10n.guideVoiceBody),
    (icon: Icons.receipt_long_outlined, body: l10n.guideReceiptBody),
    (icon: Icons.workspace_premium_outlined, body: l10n.guidePlanBody),
  ];
  var index = 0;
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) {
        final last = index == steps.length - 1;
        final step = steps[index];
        return AlertDialog(
          key: const Key('first_run_guide'),
          icon: Icon(step.icon),
          title: const BrandWordmark(size: 20),
          content: Text(step.body),
          actions: [
            TextButton(
              key: const Key('first_run_guide_next'),
              onPressed: () {
                if (last) {
                  Navigator.of(ctx).pop();
                } else {
                  setState(() => index++);
                }
              },
              child: Text(last ? l10n.guideDone : l10n.guideNext),
            ),
          ],
        );
      },
    ),
  );
  AppDefaults.markGuideSeen();
}
