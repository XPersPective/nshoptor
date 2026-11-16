import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/format_locale.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
import '../../core/text/store_name.dart';
import '../../data/db/app_database.dart';
import '../ai/ai_client.dart';
import '../receipts/image_capture_sheet.dart';
import '../receipts/image_capture_service.dart';
import '../receipts/ocr_text_source.dart';
import '../receipts/receipt_capture_flow.dart';
import '../receipts/receipt_document.dart';
import '../receipts/receipt_image_store.dart';
import '../receipts/receipt_photo_viewer.dart';
import '../receipts/receipt_queue_service.dart';
import '../receipts/receipt_read_failure.dart';
import '../receipts/receipt_read_failure_text.dart';
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
    this.pickImage,
    this.imageStore,
  });

  final ListRepository repository;
  final List<Receipt> receipts;
  final bool loading;
  final ReceiptQueueService? queueService;
  final void Function(BuildContext context, int listId)? onOpenListDetail;
  final ReminderScheduler? reminderScheduler;
  final BannerAdController? bannerController;

  /// Overrides the camera/gallery picker; tests inject a fake.
  final Future<String?> Function()? pickImage;

  /// Overrides the media store the new photos are written to.
  final ReceiptImageStore? imageStore;

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

  /// Opens the reason sheet for a receipt the reader could not understand.
  ///
  /// The receipt keeps its place in the tray; the sheet explains what went
  /// wrong in one sentence and offers the single action that fixes it.
  Future<void> _explainFailure(Receipt receipt) async {
    final failure = receipt.queueState == 'failed'
        ? ReceiptReadFailure.fromCode(receipt.queueError)
        : await _service.failureOf(receipt.id);
    if (!mounted || failure == null) return;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => _ReceiptFailureSheet(
        failure: failure,
        onAction: () {
          Navigator.of(sheetContext).pop();
          _resolveFailure(receipt, failure);
        },
        onDelete: () {
          Navigator.of(sheetContext).pop();
          _delete(receipt);
        },
      ),
    );
  }

  /// Runs the one action that resolves [failure].
  ///
  /// A missing part of the receipt is fixed by adding a photo to the same
  /// receipt; a receipt that could not be read at all is fixed by replacing
  /// its photos; a service hiccup is fixed by reading the same photos again.
  Future<void> _resolveFailure(
    Receipt receipt,
    ReceiptReadFailure failure,
  ) async {
    if (_busyIds.contains(receipt.id)) return;
    if (failure.nextStep == ReceiptReadNextStep.retry) {
      setState(() => _busyIds.add(receipt.id));
      try {
        await _service.retryReceipt(receipt.id);
      } finally {
        if (mounted) setState(() => _busyIds.remove(receipt.id));
      }
      return;
    }
    final photo = await _captureReceiptPhoto();
    if (photo == null) return;
    setState(() => _busyIds.add(receipt.id));
    try {
      if (failure.nextStep == ReceiptReadNextStep.addMore) {
        final added = await _service.addPhotoAndRequeue(receipt.id, photo);
        if (!added && mounted) {
          _showMessage(
            AppLocalizations.of(
              context,
            ).receiptMaxPagesNote(kMaxReceiptPhotos),
          );
        }
      } else {
        await _service.replacePhotosAndRequeue(receipt.id, [photo]);
      }
    } finally {
      if (mounted) setState(() => _busyIds.remove(receipt.id));
    }
  }

  Future<void> _addContinuation(Receipt receipt) async {
    if (_busyIds.contains(receipt.id)) return;
    if (receipt.imagePaths.length >= kMaxReceiptPhotos) {
      _showMessage(
        AppLocalizations.of(context).receiptMaxPagesNote(kMaxReceiptPhotos),
      );
      return;
    }
    final photo = await _captureReceiptPhoto();
    if (photo == null || !mounted) return;
    setState(() => _busyIds.add(receipt.id));
    try {
      final added = await _service.addPhotoAndRequeue(receipt.id, photo);
      if (!added && mounted) {
        _showMessage(
          AppLocalizations.of(context).receiptMaxPagesNote(kMaxReceiptPhotos),
        );
      }
    } finally {
      if (mounted) setState(() => _busyIds.remove(receipt.id));
    }
  }

  Future<void> _removePhoto(Receipt receipt, int index) async {
    if (_busyIds.contains(receipt.id)) return;
    setState(() => _busyIds.add(receipt.id));
    try {
      await _service.removePhotoAndRequeue(receipt.id, index);
    } finally {
      if (mounted) setState(() => _busyIds.remove(receipt.id));
    }
  }

  /// Captures one photo, compresses it and stores it in app-owned media.
  ///
  /// Returns null when the user cancels or the photo cannot be stored.
  Future<String?> _captureReceiptPhoto() async {
    final l10n = AppLocalizations.of(context);
    final capture = await captureImageText(
      context,
      title: l10n.scanReceiptAction,
      pickImage: widget.pickImage,
      ocrSource: const NoOcrTextSource(),
      requireText: false,
    );
    if (!mounted || capture is! CapturedImage) return null;
    try {
      final stored = await withPhotoPreparingDialog(
        context,
        l10n,
        () async =>
            await (widget.imageStore ?? ReceiptImageStore()).keepCompressed(
              capture.path,
            ) ??
            capture.path,
      );
      return stored;
    } catch (_) {
      return null;
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message), showCloseIcon: true));
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
        onExplainFailure: () => _explainFailure(widget.receipts[index]),
        onAddContinuation: () => _addContinuation(widget.receipts[index]),
        onRemovePhoto: (photoIndex) =>
            _removePhoto(widget.receipts[index], photoIndex),
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
    required this.onExplainFailure,
    required this.onAddContinuation,
    required this.onRemovePhoto,
  });

  final Receipt receipt;
  final bool busy;
  final VoidCallback onConvert;
  final VoidCallback onRetry;
  final VoidCallback onDelete;
  final VoidCallback onExplainFailure;
  final VoidCallback onAddContinuation;
  final ValueChanged<int> onRemovePhoto;

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
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: receipt.imagePaths.length > 1 ||
                              (!canConvert &&
                                  receipt.imagePaths.length < kMaxReceiptPhotos)
                          ? 132
                          : 72,
                    ),
                    child: Container(
                      key: Key('tray_receipt_frame_${receipt.id}'),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colors.outlineVariant.withValues(alpha: 0.8),
                        ),
                      ),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (var i = 0; i < receipt.imagePaths.length; i++)
                            _FramedPageThumbnail(
                              thumbKey: Key(
                                i == 0
                                    ? 'tray_receipt_thumb_${receipt.id}'
                                    : 'tray_receipt_thumb_${receipt.id}_$i',
                              ),
                              pageNumber: i + 1,
                              imagePath: receipt.imagePaths[i],
                              semanticLabel: l10n.receiptOpenPhotoHint,
                              onTap: () => showReceiptPhotoViewer(
                                context,
                                imagePath: receipt.imagePaths[i],
                                receiptId: receipt.id,
                                title:
                                    '$title (${i + 1}/${receipt.imagePaths.length})',
                                onDeletePhoto: busy
                                    ? null
                                    : () => onRemovePhoto(i),
                              ),
                            ),
                          if (!canConvert &&
                              receipt.imagePaths.length < kMaxReceiptPhotos)
                            _AddContinuationTile(
                              key: Key('tray_add_page_${receipt.id}'),
                              tooltip: l10n.receiptContinueSame,
                              onTap: busy ? null : onAddContinuation,
                            ),
                        ],
                      ),
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
                      _QueueStatusChip(
                        queueState: receipt.queueState,
                        failure: receipt.queueState == 'failed'
                            ? ReceiptReadFailure.fromCode(receipt.queueError)
                            : null,
                        onTap: receipt.queueState == 'failed'
                            ? onExplainFailure
                            : null,
                      ),
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
  const _QueueStatusChip({
    required this.queueState,
    this.failure,
    this.onTap,
  });

  final String queueState;

  /// The canonical failure of a failed receipt, shown instead of the bare
  /// "could not read" label.
  final ReceiptReadFailure? failure;

  /// When set, the chip explains itself instead of being a static badge.
  final VoidCallback? onTap;

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
        failure?.label(l10n) ?? l10n.receiptStatusFailed,
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

    final badge = Semantics(
      label: label,
      button: onTap != null,
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
            if (onTap != null) ...[
              const SizedBox(width: 2),
              Icon(Icons.chevron_right, size: 16, color: fg),
            ],
          ],
        ),
      ),
    );

    if (onTap == null) return badge;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: badge,
      ),
    );
  }
}

/// Explains why a receipt could not be read and offers the one action that
/// fixes it.
///
/// The sheet stays short on purpose: the reason, one sentence of guidance
/// and a single button. The user never has to guess which of several
/// similar buttons is the right one.
class _ReceiptFailureSheet extends StatelessWidget {
  const _ReceiptFailureSheet({
    required this.failure,
    required this.onAction,
    required this.onDelete,
  });

  final ReceiptReadFailure failure;
  final VoidCallback onAction;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          key: const Key('receipt_failure_sheet'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: colors.error),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.receiptFailureSheetTitle,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              failure.label(l10n),
              key: const Key('receipt_failure_label'),
              style: theme.textTheme.titleSmall?.copyWith(color: colors.error),
            ),
            const SizedBox(height: 6),
            Text(
              failure.guidance(l10n),
              key: const Key('receipt_failure_guidance'),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              key: const Key('receipt_failure_action'),
              onPressed: onAction,
              style: FilledButton.styleFrom(
                minimumSize: const Size(48, 52),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              icon: Icon(
                switch (failure.nextStep) {
                  ReceiptReadNextStep.addMore => Icons.add_a_photo_outlined,
                  ReceiptReadNextStep.retake => Icons.photo_camera_outlined,
                  ReceiptReadNextStep.retry => Icons.refresh,
                },
              ),
              label: Text(failure.actionLabel(l10n)),
            ),
            const SizedBox(height: 4),
            TextButton.icon(
              key: const Key('receipt_failure_delete'),
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
              label: Text(l10n.receiptDeleteDraftAction),
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 48),
                foregroundColor: colors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FramedPageThumbnail extends StatelessWidget {
  const _FramedPageThumbnail({
    required this.thumbKey,
    required this.pageNumber,
    required this.imagePath,
    required this.semanticLabel,
    required this.onTap,
  });

  final Key thumbKey;
  final int pageNumber;
  final String imagePath;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Stack(
      children: [
        ReceiptPhotoThumbnail(
          key: thumbKey,
          imagePath: imagePath,
          semanticLabel: semanticLabel,
          onTap: onTap,
        ),
        Positioned(
          bottom: 4,
          left: 4,
          child: IgnorePointer(
            child: ExcludeSemantics(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: colors.scrim.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$pageNumber',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.onPrimary,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddContinuationTile extends StatelessWidget {
  const _AddContinuationTile({
    super.key,
    required this.tooltip,
    required this.onTap,
  });

  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 56,
            height: 72,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colors.primary.withValues(alpha: 0.5),
              ),
            ),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: onTap == null
                  ? colors.onSurfaceVariant.withValues(alpha: 0.4)
                  : colors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
