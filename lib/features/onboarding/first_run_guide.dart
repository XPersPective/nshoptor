import 'package:flutter/material.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';
import 'coach_tour.dart';

/// "How to use": the coach-mark tour over the lists home (PB-201, F40).
/// Inside the home shell it switches to the lists tab first, so Settings and
/// the lists help button show the same tour over the real controls.
/// Finishing or skipping acknowledges first use; system back leaves the
/// first-run tour available next launch.
Future<void> showFirstRunGuide(BuildContext context) async {
  final host = GuidedTourHost.maybeOf(context);
  if (host != null) return host.start();
  await runHomeTour(context);
}

/// Lists home steps; finishing queues the list detail part for the next
/// opened list.
Future<void> runHomeTour(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final outcome = await runCoachTour(context, [
    TourStep(
      target: TourTargets.listsNew,
      icon: Icons.add,
      title: l10n.newListButton,
      body: l10n.tourNewListBody,
    ),
    TourStep(
      target: TourTargets.listsReceipt,
      optional: true,
      icon: Icons.receipt_long_outlined,
      title: l10n.fromReceiptListButton,
      body: l10n.tourFromReceiptBody,
    ),
    TourStep(
      icon: Icons.document_scanner_outlined,
      title: l10n.scanReceiptAction,
      body: l10n.tourReceiptFlowBody,
      visual: const _GuideStepDiagram(stepIndex: 3),
    ),
    TourStep(
      target: TourTargets.listsTabs,
      icon: Icons.tab_outlined,
      title: l10n.listsTitle,
      body: l10n.tourTabsBody,
    ),
    TourStep(
      target: TourTargets.listsDiscover,
      optional: true,
      icon: Icons.explore_outlined,
      title: l10n.navDiscover,
      body: l10n.tourDiscoverBody,
    ),
    TourStep(
      target: TourTargets.listsPlan,
      optional: true,
      icon: Icons.workspace_premium_outlined,
      title: l10n.plansTitle,
      body: l10n.guidePlanBody,
    ),
    TourStep(
      target: TourTargets.listsHelp,
      icon: Icons.help_outline,
      title: l10n.howToUseLabel,
      body: l10n.tourHelpBody,
    ),
  ]);
  if (outcome == TourOutcome.dismissed) return;
  AppDefaults.markGuideSeen();
  AppDefaults.setDetailTourPending(outcome == TourOutcome.finished);
}

/// List detail steps: totals, items and sort, adding items, receipt scan.
/// Steps whose control is not shown (read-only or empty list) are dropped.
Future<void> runDetailTour(BuildContext context) async {
  AppDefaults.setDetailTourPending(false);
  final l10n = AppLocalizations.of(context);
  await runCoachTour(context, [
    TourStep(
      target: TourTargets.detailTotals,
      icon: Icons.calculate_outlined,
      title: l10n.compareTotal,
      body: l10n.tourTotalsBody,
    ),
    TourStep(
      target: TourTargets.detailItems,
      optional: true,
      icon: Icons.sort,
      title: l10n.groupsSection,
      body: l10n.tourItemsBody,
    ),
    TourStep(
      target: TourTargets.detailAdd,
      optional: true,
      icon: Icons.mic_none,
      title: l10n.itemFormTitle,
      body: '${l10n.guideAddBody}\n\n${l10n.guideVoiceBody}',
    ),
    TourStep(
      target: TourTargets.detailReceipt,
      optional: true,
      icon: Icons.receipt_long_outlined,
      title: l10n.scanReceiptAction,
      body: '${l10n.guideReceiptBody}\n\n${l10n.tourReceiptFlowBody}',
    ),
  ]);
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
