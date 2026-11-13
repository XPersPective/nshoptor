import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:nshoptor/features/receipts/ai_image.dart';

img.Image _noisyTexturedReceipt(int width, int height) {
  final image = img.Image(width: width, height: height);
  final rng = Random(42);
  for (var y = 0; y < height; y++) {
    final stripe = (y ~/ 18) % 2 == 0;
    for (var x = 0; x < width; x++) {
      final n = rng.nextInt(40);
      final ink = stripe && (x % 11 < 4) ? 40 + n : 210 + (n ~/ 2);
      image.setPixelRgb(x, y, ink, ink, ink);
    }
  }
  return image;
}

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('nshoptor_ai_img_');
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('large noisy receipt image compresses to <= 1280px and <= 350 KB', () async {
    final raw = _noisyTexturedReceipt(2400, 1800);
    final file = File('${tempDir.path}/large_receipt.png');
    await file.writeAsBytes(img.encodePng(raw));

    final encoded = await encodeImageForAi(file.path);
    expect(encoded, isNotNull);
    final outBytes = base64Decode(encoded!);
    expect(outBytes.length, lessThanOrEqualTo(350 * 1024));

    final decoded = img.decodeJpg(outBytes);
    expect(decoded, isNotNull);
    final longest =
        decoded!.width > decoded.height ? decoded.width : decoded.height;
    expect(longest, lessThanOrEqualTo(1280));
  });

  test('tall receipt image caps longest edge at 1280px and <= 350 KB', () async {
    final raw = _noisyTexturedReceipt(900, 3200);
    final file = File('${tempDir.path}/tall_receipt.jpg');
    await file.writeAsBytes(img.encodeJpg(raw, quality: 92));

    final outBytes = await compressImageForAi(file.path);
    expect(outBytes, isNotNull);
    expect(outBytes!.length, lessThanOrEqualTo(350 * 1024));

    final decoded = img.decodeJpg(outBytes)!;
    expect(decoded.height, lessThanOrEqualTo(1280));
    expect(decoded.width, lessThanOrEqualTo(1280));
  });

  test('oversized dimension JPEG (> 1280px) even under 350 KB still downscales', () async {
    // Solid light image compresses tiny in bytes while keeping >1280px size.
    final raw = img.Image(width: 1920, height: 1440);
    img.fill(raw, color: img.ColorRgb8(245, 245, 245));
    final jpgBytes = img.encodeJpg(raw, quality: 75);
    expect(jpgBytes.length, lessThan(aiImageMaxBytes));

    final file = File('${tempDir.path}/wide_light.jpg');
    await file.writeAsBytes(jpgBytes);

    final outBytes = await compressImageForAi(file.path);
    expect(outBytes, isNotNull);
    final decoded = img.decodeJpg(outBytes!)!;
    expect(decoded.width, 1280);
    expect(decoded.height, 960);
  });

  test('small upright JPEG skips decode and strips EXIF metadata cleanly', () async {
    final raw = img.Image(width: 800, height: 600);
    img.fill(raw, color: img.ColorRgb8(240, 240, 240));
    final cleanJpg = img.encodeJpg(raw, quality: 75);
    // Inject a synthetic APP1 Exif segment with orientation 1 right after SOI.
    final exifSegment = <int>[
      0xFF, 0xE1, 0x00, 0x20,
      ...'Exif'.codeUnits, 0, 0,
      0x4D, 0x4D, 0x00, 0x2A, 0x00, 0x00, 0x00, 0x08,
      0x00, 0x01, 0x01, 0x12, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00,
    ];
    final withExif = [0xFF, 0xD8, ...exifSegment, ...cleanJpg.sublist(2)];
    final file = File('${tempDir.path}/small_exif.jpg');
    await file.writeAsBytes(withExif);

    final outBytes = await compressImageForAi(file.path);
    expect(outBytes, isNotNull);
    expect(jpegExifOrientation(outBytes!), 0);
    expect(jpegDimensions(outBytes), (800, 600));
  });
}
