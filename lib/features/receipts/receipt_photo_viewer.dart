import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';

/// Shows a full-screen pinch-zoom dialog for a local compressed receipt JPEG.
Future<void> showReceiptPhotoViewer(
  BuildContext context, {
  required String imagePath,
  required int receiptId,
  String? title,
}) => showDialog<void>(
  context: context,
  builder: (dialogContext) {
    final l10n = AppLocalizations.of(dialogContext);
    final theme = Theme.of(dialogContext);
    final file = File(imagePath);
    return Dialog.fullscreen(
      key: Key('receipt_photo_viewer_$receiptId'),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            key: const Key('receipt_photo_viewer_close'),
            icon: const Icon(Icons.close),
            tooltip: MaterialLocalizations.of(dialogContext).closeButtonTooltip,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          title: Text(
            title ?? l10n.receiptPhotosSectionTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Center(
          child: file.existsSync()
              ? InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Image.file(
                    file,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.receiptPhotosSectionTitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  },
);

/// Calm 48x48+ thumbnail preview of a compressed receipt image with an
/// accessible fallback icon when synthetic test paths have no backing file.
class ReceiptPhotoThumbnail extends StatelessWidget {
  const ReceiptPhotoThumbnail({
    super.key,
    required this.imagePath,
    this.size = const Size(56, 72),
    this.onTap,
    this.semanticLabel,
  });

  final String imagePath;
  final Size size;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final file = File(imagePath);
    final content = Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: file.existsSync()
          ? Image.file(
              file,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _fallback(theme),
            )
          : _fallback(theme),
    );
    if (onTap == null) return content;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: content,
      ),
    );
  }

  Widget _fallback(ThemeData theme) => Center(
    child: Icon(
      Icons.receipt_long_outlined,
      color: theme.colorScheme.onSurfaceVariant,
    ),
  );
}
