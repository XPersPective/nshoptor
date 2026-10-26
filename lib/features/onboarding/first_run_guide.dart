import 'package:flutter/material.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';

/// Short, replayable guide. Finishing or explicitly closing acknowledges first
/// use. System back leaves the unfinished guide available next launch.
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
                const SizedBox(height: 16),
                _GuideStepDiagram(stepIndex: index),
                const SizedBox(height: 16),
                Text(step.body),
              ],
            ),
            actions: [
              TextButton(
                key: const Key('first_run_guide_close'),
                onPressed: () => Navigator.of(ctx).pop(true),
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

/// Visual help dialog for receipt / shelf-price camera buttons (N044, N045).
Future<void> showScanHelpDialog(
  BuildContext context, {
  required bool isReceipt,
}) async {
  final l10n = AppLocalizations.of(context);
  final material = MaterialLocalizations.of(context);
  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      key: const Key('scan_help_dialog'),
      scrollable: true,
      icon: Icon(
        isReceipt ? Icons.receipt_long_outlined : Icons.camera_alt_outlined,
      ),
      title: Text(isReceipt ? l10n.scanReceiptAction : l10n.tipShelfCamera),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GuideStepDiagram(stepIndex: isReceipt ? 3 : 1),
          const SizedBox(height: 12),
          Text(
            isReceipt
                ? '${l10n.guideReceiptBody}\n\n${l10n.receiptLineActions}'
                : l10n.guidePricesBody,
          ),
        ],
      ),
      actions: [
        FilledButton(
          key: const Key('scan_help_close'),
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(material.closeButtonLabel),
        ),
      ],
    ),
  );
}

class _GuideStepDiagram extends StatelessWidget {
  const _GuideStepDiagram({required this.stepIndex});

  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    if (stepIndex == 3) {
      return Container(
        key: const Key('scan_guide_visual'),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DiagramBand(
              icon: Icons.storefront_outlined,
              label: '1. ${l10n.storeLabel} · ${l10n.shoppingDateLabel}',
              accent: scheme.primaryContainer,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Icon(Icons.expand_more, size: 18),
            ),
            _DiagramBand(
              icon: Icons.view_headline_outlined,
              label: '2. ${l10n.itemsEmptyTitle} (2–3 ↕)',
              accent: scheme.secondaryContainer,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Icon(Icons.expand_more, size: 18),
            ),
            _DiagramBand(
              icon: Icons.summarize_outlined,
              label: '3. ${l10n.reportTotalSpent}',
              accent: scheme.tertiaryContainer,
            ),
          ],
        ),
      );
    }
    final (leftIcon, middleIcon, rightIcon) = switch (stepIndex) {
      0 => (Icons.playlist_add, Icons.shopping_basket_outlined, Icons.check),
      1 => (
        Icons.camera_alt_outlined,
        Icons.sell_outlined,
        Icons.compare_arrows,
      ),
      2 => (Icons.mic_none, Icons.graphic_eq, Icons.checklist_rtl),
      4 => (
        Icons.calendar_month_outlined,
        Icons.bar_chart_outlined,
        Icons.picture_as_pdf_outlined,
      ),
      5 => (
        Icons.event_outlined,
        Icons.schedule_outlined,
        Icons.notifications_active_outlined,
      ),
      _ => (
        Icons.card_giftcard_outlined,
        Icons.auto_awesome_outlined,
        Icons.workspace_premium_outlined,
      ),
    };
    return Container(
      key: const Key('scan_guide_visual'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(leftIcon, color: scheme.primary),
          Icon(Icons.arrow_forward, size: 16, color: scheme.outline),
          Icon(middleIcon, color: scheme.secondary),
          Icon(Icons.arrow_forward, size: 16, color: scheme.outline),
          Icon(rightIcon, color: scheme.tertiary),
        ],
      ),
    );
  }
}

class _DiagramBand extends StatelessWidget {
  const _DiagramBand({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.labelMedium),
          ),
        ],
      ),
    );
  }
}
