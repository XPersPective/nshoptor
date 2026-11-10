import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/receipts/ai_image.dart';

/// Minimal JPEG with an APP1/Exif payload carrying [orientation].
Uint8List jpegWithExif(int? orientation, {bool bigEndian = true}) {
  final tiff = <int>[
    ...(!bigEndian ? [0x49, 0x49] : [0x4D, 0x4D]),
    ...(!bigEndian ? [0x2A, 0x00] : [0x00, 0x2A]),
    ...(!bigEndian ? [0x08, 0x00, 0x00, 0x00] : [0x00, 0x00, 0x00, 0x08]),
    ...(!bigEndian ? [0x01, 0x00] : [0x00, 0x01]),
    // Entry: tag 0x0112, type SHORT, count 1, value.
    ...(!bigEndian ? [0x12, 0x01] : [0x01, 0x12]),
    ...(!bigEndian ? [0x03, 0x00] : [0x00, 0x03]),
    ...(!bigEndian ? [0x01, 0x00, 0x00, 0x00] : [0x00, 0x00, 0x00, 0x01]),
    ...(!bigEndian
        ? [orientation ?? 1, 0x00, 0x00, 0x00]
        : [0x00, orientation ?? 1, 0x00, 0x00]),
  ];
  final exif = [...'Exif'.codeUnits, 0, 0, ...tiff];
  return Uint8List.fromList([
    0xFF, 0xD8, 0xFF, 0xE1,
    exif.length >> 8, exif.length & 0xFF,
    ...exif,
    0xFF, 0xD9,
  ]);
}

void main() {
  test('orientation 1 (or none) means pixels may go untouched', () {
    expect(jpegExifOrientation(jpegWithExif(1)), 1);
    final noExif = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0, 0, 16, 0xFF, 0xD9]);
    expect(jpegExifOrientation(noExif), 0);
    expect(jpegExifOrientation(Uint8List(0)), 0);
  });

  test('rotated files are detected in both endiannesses', () {
    expect(jpegExifOrientation(jpegWithExif(6)), 6);
    expect(jpegExifOrientation(jpegWithExif(6, bigEndian: false)), 6);
    expect(jpegExifOrientation(jpegWithExif(8)), 8);
  });
}
