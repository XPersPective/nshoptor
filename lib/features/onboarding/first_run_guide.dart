import 'package:flutter/material.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';

/// Short, replayable guide. Only finishing the final step acknowledges first use;
/// closing or using the system back button leaves it available next launch.
Future<void> showFirstRunGuide(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final steps = [
    (icon: Icons.add, title: l10n.addItemTooltip, body: l10n.guideAddBody),
    (
      icon: Icons.price_check,
      title: l10n.actualPriceLabel,
      body: l10n.guidePricesBody,
    ),
    (
      icon: Icons.mic_none,
      title: l10n.voiceInputTitle,
      body:
          '${l10n.guideVoiceBody}\n\n${l10n.tipVoiceAdd}\n\n${l10n.voiceUnavailable}\n\n${l10n.aiOffline}',
    ),
    (
      icon: Icons.receipt_long_outlined,
      title: l10n.scanReceiptAction,
      body: '${l10n.guideReceiptBody}\n\n${l10n.receiptLineActions}',
    ),
    (
      icon: Icons.insights_outlined,
      title: l10n.navHistory,
      body:
          '${l10n.purchaseHistoryHint}\n\n${l10n.monthlyReportAction}\n${l10n.reportPdfAction}',
    ),
    (
      icon: Icons.notifications_none,
      title: l10n.setReminderAction,
      body:
          '${l10n.reminderPickDate} → ${l10n.reminderPickTime}\n\n${l10n.reminderPermissionDenied}',
    ),
    (
      icon: Icons.workspace_premium_outlined,
      title: l10n.plansTitle,
      body:
          '${l10n.guidePlanBody}\n\n${l10n.planCoreFeatures}\n\n${l10n.planBackup}',
    ),
  ];
  var index = 0;
  final completed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) {
        final last = index == steps.length - 1;
        final step = steps[index];
        final material = MaterialLocalizations.of(ctx);
        // A new subtree resets the scroll position when changing steps.
        return KeyedSubtree(
          key: ValueKey(index),
          child: AlertDialog(
            key: const Key('first_run_guide'),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            scrollable: true,
            icon: Icon(step.icon),
            title: Text(step.title),
            content: Column(
              key: ValueKey(index),
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: l10n.howToUseLabel,
                  value: '${index + 1} / ${steps.length}',
                  child: ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1} / ${steps.length}',
                          key: const Key('first_run_guide_progress'),
                          style: Theme.of(ctx).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: (index + 1) / steps.length,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(step.body),
              ],
            ),
            actions: [
              TextButton(
                key: const Key('first_run_guide_close'),
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(material.closeButtonLabel),
              ),
              if (index > 0)
                TextButton(
                  key: const Key('first_run_guide_back'),
                  onPressed: () => setState(() => index--),
                  child: Text(material.backButtonTooltip),
                ),
              FilledButton(
                key: const Key('first_run_guide_next'),
                onPressed: () {
                  if (last) {
                    Navigator.of(ctx).pop(true);
                  } else {
                    setState(() => index++);
                  }
                },
                child: Text(last ? l10n.guideDone : l10n.guideNext),
              ),
            ],
          ),
        );
      },
    ),
  );
  if (completed == true) AppDefaults.markGuideSeen();
}
