import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../onboarding/first_run_guide.dart';
import 'image_capture_service.dart';
import 'ocr_text_source.dart';
import 'shelf_label/mlkit_text_source.dart';

/// Both receipt and shelf-label entry points use the same acquisition path.
/// The injected picker bypasses native UI for callers that provide their own.
Future<CaptureOutcome> captureImageText(
  BuildContext context, {
  required String title,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
  ImageSource? preferredSource,
  bool requireText = true,
}) async {
  final l10n = AppLocalizations.of(context);
  Future<String?> Function() picker;
  if (pickImage != null) {
    picker = pickImage;
  } else {
    final source =
        preferredSource ?? await showImageSourceSheet(context, title: title);
    if (source == null || !context.mounted) return const CaptureCancelled();
    // Gallery originals can be HEIC/HEIF or tens of megapixels, which the
    // native recognizer rejects. Re-encoding to a bounded JPEG keeps fine
    // receipt print legible while making recognition reliable.
    // On-device OCR needs ~13px per character on 48-column receipts:
    // 2560px keeps small print readable; the image model keeps the measured
    // 1600px so its upload still needs no slow re-encode (PB-207).
    final longSide = requireText ? 2560.0 : 1600.0;
    picker = () async => (await ImagePicker().pickImage(
      source: source,
      maxWidth: longSide,
      maxHeight: longSide,
      imageQuality: requireText ? 88 : 85,
    ))?.path;
  }
  final ownedSource = ocrSource == null ? _OwnedTextSource() : null;
  final source = ocrSource ?? ownedSource!;
  final CaptureOutcome outcome;
  try {
    outcome = await scanImage(
      pickImage: picker,
      source: source,
      requireText: requireText,
    );
  } finally {
    // Cancellation never creates a native recognizer. A cleanup failure must
    // not replace the original typed outcome (including an unavailable plugin).
    if (ownedSource != null) {
      try {
        await ownedSource.close();
      } catch (_) {
        // The scan outcome already describes recognition failure when relevant.
      }
    }
  }
  if (context.mounted && outcome is CaptureFailed) {
    // iOS never re-asks after a camera denial: without a way to Settings the
    // camera flow is a dead end, so that case gets a dialog (PB-207).
    if (outcome.errorCode == 'camera_access_denied') {
      final openSettings = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          key: const Key('camera_access_denied'),
          content: Text(l10n.cameraAccessDenied),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.cancelButton),
            ),
            FilledButton(
              key: const Key('camera_open_settings'),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(l10n.openSettingsAction),
            ),
          ],
        ),
      );
      if (openSettings == true) {
        try {
          await launchUrl(
            Uri.parse('app-settings:'),
            mode: LaunchMode.externalApplication,
          );
        } catch (_) {
          // Settings deep link unavailable: the dialog already told the user
          // what to change.
        }
      }
      return outcome;
    }
    final message = switch (outcome.stage) {
      CaptureStage.capture => l10n.imageCaptureFailed,
      CaptureStage.recognition => l10n.imageRecognitionFailed,
      CaptureStage.emptyText => l10n.ocrNoText,
    };
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message), showCloseIcon: true));
  }
  return outcome;
}

Future<ImageSource?> showImageSourceSheet(
  BuildContext context, {
  required String title,
}) {
  final l10n = AppLocalizations.of(context);
  final isReceipt = title == l10n.scanReceiptAction;
  var showTip = isReceipt && AppDefaults.captureTipsEnabled();
  return showModalBottomSheet<ImageSource>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetContext) => StatefulBuilder(
      builder: (sheetContext, setSheetState) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(sheetContext).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    key: const Key('image_source_help'),
                    tooltip: l10n.howToUseLabel,
                    onPressed: () => showScanHelpDialog(
                      sheetContext,
                      isReceipt: isReceipt,
                    ),
                    icon: const Icon(Icons.help_outline),
                  ),
                ],
              ),
              if (showTip) ...[
                const SizedBox(height: 8),
                Container(
                  key: const Key('capture_tip_first'),
                  padding: const EdgeInsets.fromLTRB(12, 10, 8, 4),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      sheetContext,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.captureTipFirst,
                        style: Theme.of(sheetContext).textTheme.bodyMedium,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          key: const Key('capture_tip_never'),
                          onPressed: () {
                            AppDefaults.setCaptureTipsEnabled(false);
                            setSheetState(() => showTip = false);
                          },
                          child: Text(l10n.captureTipNeverShow),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              FilledButton.icon(
                key: const Key('image_source_camera'),
                onPressed: () =>
                    Navigator.pop(sheetContext, ImageSource.camera),
                icon: const Icon(Icons.photo_camera_outlined),
                label: Text(l10n.imageCameraAction),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(48, 56),
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton.tonalIcon(
                key: const Key('image_source_gallery'),
                onPressed: () =>
                    Navigator.pop(sheetContext, ImageSource.gallery),
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(l10n.imageGalleryAction),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(48, 56),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _OwnedTextSource implements OcrTextSource {
  MlKitTextSource? _source;

  @override
  Future<OcrScanResult> scan(String imagePath) =>
      (_source ??= MlKitTextSource()).scan(imagePath);

  Future<void> close() async => _source?.dispose();
}
