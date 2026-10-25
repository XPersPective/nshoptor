import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/receipts/image_capture_service.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';

class _RecordingSource implements OcrTextSource {
  _RecordingSource(this.recognize);

  final Future<OcrScanResult> Function(String) recognize;
  final paths = <String>[];

  @override
  Future<OcrScanResult> scan(String imagePath) {
    paths.add(imagePath);
    return recognize(imagePath);
  }
}

void main() {
  test('cancelling the picker never starts recognition', () async {
    final source = _RecordingSource((_) => throw StateError('must not scan'));

    final result = await scanImage(pickImage: () async => null, source: source);

    expect(result, isA<CaptureCancelled>());
    expect(source.paths, isEmpty);
  });

  test(
    'picker failure is a capture error and never starts recognition',
    () async {
      final source = _RecordingSource((_) => throw StateError('must not scan'));

      final result = await scanImage(
        pickImage: () async => throw PlatformException(
          code: 'camera_access_denied',
          message: 'sensitive user data',
        ),
        source: source,
      );

      expect(result, isA<CaptureFailed>());
      final failure = result as CaptureFailed;
      expect(failure.stage, CaptureStage.capture);
      expect(failure.errorCode, 'capture_failed');
      expect(source.paths, isEmpty);
    },
  );

  test(
    'a synchronous picker exception is also returned as a failure',
    () async {
      final source = _RecordingSource((_) => throw StateError('must not scan'));

      final result = await scanImage(
        pickImage: () => throw StateError('picker unavailable'),
        source: source,
      );

      expect((result as CaptureFailed).stage, CaptureStage.capture);
      expect(source.paths, isEmpty);
    },
  );

  test(
    'a blank image path fails before invoking the native recognizer',
    () async {
      final source = _RecordingSource((_) => throw StateError('must not scan'));

      final result = await scanImage(
        pickImage: () async => ' \n\t ',
        source: source,
      );

      final failure = result as CaptureFailed;
      expect(failure.stage, CaptureStage.capture);
      expect(failure.errorCode, 'invalid_image_path');
      expect(source.paths, isEmpty);
    },
  );

  test('native recognition failure is distinct from missing text', () async {
    final source = _RecordingSource(
      (_) async => throw PlatformException(
        code: 'process_image_failed',
        message: 'receipt text and a private image path',
      ),
    );

    final result = await scanImage(
      pickImage: () async => '/private/receipt.jpg',
      source: source,
    );

    final failure = result as CaptureFailed;
    expect(failure.stage, CaptureStage.recognition);
    expect(failure.errorCode, 'recognition_failed');
    expect(source.paths, ['/private/receipt.jpg']);
  });

  test('a synchronous recognizer exception does not escape', () async {
    final source = _RecordingSource((_) => throw StateError('native failure'));

    final result = await scanImage(
      pickImage: () async => '/image.jpg',
      source: source,
    );

    expect((result as CaptureFailed).stage, CaptureStage.recognition);
  });

  for (final lines in [
    const <OcrLine>[],
    const [OcrLine(text: ''), OcrLine(text: ' \n\t ')],
  ]) {
    test(
      'recognized ${lines.length} blank lines is an empty-text failure',
      () async {
        final source = _RecordingSource(
          (_) async => OcrScanResult(lines: lines),
        );

        final result = await scanImage(
          pickImage: () async => '/image.jpg',
          source: source,
        );

        final failure = result as CaptureFailed;
        expect(failure.stage, CaptureStage.emptyText);
        expect(failure.errorCode, 'empty_text');
        expect(source.paths, ['/image.jpg']);
      },
    );
  }

  test(
    'nonblank text preserves the image and unmodified recognition evidence',
    () async {
      const scan = OcrScanResult(
        lines: [
          OcrLine(text: ' '),
          OcrLine(text: '  MARKET  ', boundingBoxTop: 5, boundingBoxLeft: 10),
        ],
      );
      final source = _RecordingSource((_) async => scan);

      final result = await scanImage(
        pickImage: () async => '/image with spaces.jpg',
        source: source,
      );

      final captured = result as CapturedImage;
      expect(captured.path, '/image with spaces.jpg');
      expect(captured.scan, same(scan));
      expect(source.paths, ['/image with spaces.jpg']);
    },
  );
}
