import 'ocr_text_source.dart';

/// Result of selecting an image and recognizing its text. Parsing and native
/// recognizer disposal belong to the caller.
sealed class CaptureOutcome {
  const CaptureOutcome();
}

final class CapturedImage extends CaptureOutcome {
  const CapturedImage({required this.path, required this.scan});

  final String path;
  final OcrScanResult scan;
}

final class CaptureCancelled extends CaptureOutcome {
  const CaptureCancelled();
}

enum CaptureStage { capture, recognition, emptyText }

final class CaptureFailed extends CaptureOutcome {
  const CaptureFailed({required this.stage, this.errorCode});

  final CaptureStage stage;

  /// A fixed diagnostic code, never exception messages, paths or OCR text.
  final String? errorCode;
}

/// Camera and gallery share this boundary so cancellation, recognition errors
/// and genuinely empty text do not become the same user-facing failure.
///
/// With [requireText] false (image-model readers), on-device OCR is only a
/// best-effort side channel: scripts it cannot read yield an empty scan
/// instead of a failure.
Future<CaptureOutcome> scanImage({
  required Future<String?> Function() pickImage,
  required OcrTextSource source,
  bool requireText = true,
}) async {
  final String? path;
  try {
    path = await pickImage();
  } catch (_) {
    return const CaptureFailed(
      stage: CaptureStage.capture,
      errorCode: 'capture_failed',
    );
  }
  if (path == null) return const CaptureCancelled();
  if (path.trim().isEmpty) {
    return const CaptureFailed(
      stage: CaptureStage.capture,
      errorCode: 'invalid_image_path',
    );
  }

  final OcrScanResult scan;
  try {
    scan = await source.scan(path);
  } catch (_) {
    if (!requireText) {
      return CapturedImage(
        path: path,
        scan: const OcrScanResult(lines: []),
      );
    }
    return const CaptureFailed(
      stage: CaptureStage.recognition,
      errorCode: 'recognition_failed',
    );
  }
  if (requireText && !scan.lines.any((line) => line.text.trim().isNotEmpty)) {
    return const CaptureFailed(
      stage: CaptureStage.emptyText,
      errorCode: 'empty_text',
    );
  }
  return CapturedImage(path: path, scan: scan);
}
