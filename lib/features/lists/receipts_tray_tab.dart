import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/format_locale.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
import '../../core/text/store_name.dart';
import '../../data/db/app_database.dart';
import '../ai/ai_client.dart';
import '../receipts/receipt_capture_flow.dart';
import '../receipts/receipt_photo_viewer.dart';
import '../receipts/receipt_queue_service.dart';
import 'list_detail_screen.dart';
import 'list_repository.dart';
import 'reminders/reminder_scheduler.dart';

import 'package:napp_ads/napp_ads.dart';

/// Displays queued, processing, ready, duplicate, and failed receipt capture
/// sessions (`Fişlerim (N)`) so users can scan rapidly without waiting, delete
/// any entry anytime, or review & convert ready receipts into lists (`PB-214`).
class ReceiptsTrayTab extends StatefulWidget {
  const ReceiptsTrayTab({
    super.key,
    required this.repository,
    required this.receipts,
    required this.loading,
    this.queueService,
    this.onOpenListDetail,
    this.reminderScheduler,
    this.bannerController,
  });

  final ListRepository repository;
  final List<Receipt> receipts;
  final bool loading;
  final ReceiptQueueService? queueService;
  final void Function(BuildContext context, int listId)? onOpenListDetail;
  final ReminderScheduler? reminderScheduler;
  final BannerAdController? bannerController;

  @override
  State<ReceiptsTrayTab> createState() => _ReceiptsTrayTabState();
}

class _ReceiptsTrayTabState extends State<ReceiptsTrayTab> {
  final Set<int> _busyIds = <int>{};

  ReceiptQueueService get _service =>
      widget.queueService ??
      ReceiptQueueService.activeInstance ??
      ReceiptQueueService(db: widget.repository.db, ai: AiService.client);

  Future<void> _convert(Receipt receipt) async {
    if (_busyIds.contains(receipt.id)) return;
    setState(() => _busyIds.add(receipt.id));
    int? listId;
    try {
      listId = await openQueuedReceiptForReview(
        context,
        db: widget.repository.db,
        draft: receipt,
        ai: AiService.client,
        deleteDraft: _service.deleteTrayReceipt,
      );
    } finally {
      if (mounted) setState(() => _busyIds.remove(receipt.id));
    }
    if (listId == null || !mounted) return;
    final open = widget.onOpenListDetail;
    if (open != null) {
      open(context, listId);
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ListDetailScreen(
            db: widget.repository.db,
            listRepository: widget.repository,
            listId: listId!,
            reminderScheduler: widget.reminderScheduler,
            bannerController: widget.bannerController,
          ),
        ),
      );
    }
  }

  Future<void> _retry(Receipt receipt) async {
    if (_busyIds.contains(receipt.id)) return;
    setState(() => _busyIds.add(receipt.id));
    try {
      await _service.retryReceipt(receipt.id);
    } finally {
      if (mounted) setState(() => _busyIds.remove(receipt.id));
    }
  }

  Future<void> _delete(Receipt receipt) async {
    if (_busyIds.contains(receipt.id)) return;
    setState(() => _busyIds.add(receipt.id));
    try {
      await _service.deleteTrayReceipt(receipt.id);
    } finally {
      if (mounted) setState(() => _busyIds.remove(receipt.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (widget.loading && widget.receipts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (widget.receipts.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            key: const Key('receipt_tray_empty'),
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 48,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.receiptEmptyTrayTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Text(
                  l10n.receiptEmptyTrayBody,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.separated(
      key: const Key('receipt_tray_list'),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: widget.receipts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _TrayReceiptCard(
        receipt: widget.receipts[index],
        busy: _busyIds.contains(widget.receipts[index].id),
        onConvert: () => _convert(widget.receipts[index]),
        onRetry: () => _retry(widget.receipts[index]),
        onDelete: () => _delete(widget.receipts[index]),
      ),
    );
  }
}

class _TrayReceiptCard extends StatelessWidget {
  const _TrayReceiptCard({
    required this.receipt,
    required this.busy,
    required this.onConvert,
    required this.onRetry,
    required this.onDelete,
  });

  final Receipt receipt;
  final bool busy;
  final VoidCallback onConvert;
  final VoidCallback onRetry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final store = receipt.detectedStore?.trim();
    final title = (store != null && store.isNotEmpty)
        ? cleanStoreName(store)
        : l10n.scanReceiptAction;

    final metaParts = <String>[
      l10n.receiptTrayPagesLabel(receipt.imagePaths.length),
      if (receipt.detectedAt != null) _formatDateTime(context, receipt.detectedAt!),
      if (receipt.detectedTotalMinorUnits != null)
        formatMoney(
          Money.fromMinorUnits(
            receipt.detectedTotalMinorUnits!,
            Currency.fromCode(receipt.detectedCurrency ?? 'TRY'),
          ),
          locale: formatLocaleCode(context),
        ),
    ];

    final canConvert =
        (receipt.queueState == 'ready' || receipt.queueState == 'duplicate') &&
        receipt.captureDataJson != null;
    final canRetry = receipt.queueState == 'failed';

    return Card(
      key: ValueKey('tray_receipt_${receipt.id}'),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (receipt.imagePaths.isNotEmpty) ...[
                  ReceiptPhotoThumbnail(
                    key: Key('tray_receipt_thumb_${receipt.id}'),
                    imagePath: receipt.imagePaths.first,
                    semanticLabel: l10n.receiptOpenPhotoHint,
                    onTap: () => showReceiptPhotoViewer(
                      context,
                      imagePath: receipt.imagePaths.first,
                      receiptId: receipt.id,
                      title: title,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metaParts.join(' · '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _QueueStatusChip(queueState: receipt.queueState),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (canConvert)
                  FilledButton.icon(
                    key: Key('tray_convert_${receipt.id}'),
                    onPressed: busy ? null : onConvert,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(48, 48),
                    ),
                    icon: const Icon(Icons.playlist_add_check),
                    label: Text(l10n.receiptConvertToListAction),
                  ),
                if (canRetry)
                  FilledButton.tonalIcon(
                    key: Key('tray_retry_${receipt.id}'),
                    onPressed: busy ? null : onRetry,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(48, 48),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.receiptRetryReadAction),
                  ),
                OutlinedButton.icon(
                  key: Key('tray_delete_${receipt.id}'),
                  onPressed: busy ? null : onDelete,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(48, 48),
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.receiptDeleteDraftAction),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(BuildContext context, DateTime dt) {
    final loc = MaterialLocalizations.of(context);
    final date = loc.formatShortDate(dt);
    final time = loc.formatTimeOfDay(
      TimeOfDay.fromDateTime(dt),
      alwaysUse24HourFormat:
          MediaQuery.maybeAlwaysUse24HourFormatOf(context) ?? false,
    );
    return '$date $time';
  }
}

class _QueueStatusChip extends StatelessWidget {
  const _QueueStatusChip({required this.queueState});

  final String queueState;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final (String label, Color bg, Color fg, Widget leading) = switch (
        queueState) {
      'processing' => (
        l10n.receiptStatusProcessing,
        colors.tertiaryContainer,
        colors.onTertiaryContainer,
        SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.onTertiaryContainer,
          ),
        ),
      ),
      'ready' => (
        l10n.receiptStatusReady,
        colors.primaryContainer,
        colors.onPrimaryContainer,
        Icon(
          Icons.check_circle_outline,
          size: 16,
          color: colors.onPrimaryContainer,
        ),
      ),
      'duplicate' => (
        l10n.receiptStatusDuplicate,
        colors.errorContainer,
        colors.onErrorContainer,
        Icon(
          Icons.warning_amber_rounded,
          size: 16,
          color: colors.onErrorContainer,
        ),
      ),
      'failed' => (
        l10n.receiptStatusFailed,
        colors.errorContainer,
        colors.onErrorContainer,
        Icon(Icons.error_outline, size: 16, color: colors.onErrorContainer),
      ),
      _ => (
        l10n.receiptStatusQueued,
        colors.secondaryContainer,
        colors.onSecondaryContainer,
        Icon(Icons.schedule, size: 16, color: colors.onSecondaryContainer),
      ),
    };

    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leading,
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(color: fg),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
