import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show BytesBuilder, Uint8List;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Longest side and size budget of one photo sent to the image model. Receipt
/// print stays legible at this size while a photo stays well below the
/// server's per-image limit (≈750 KB).
// Live measurement (2026-10-28): 1280px reads the same receipt as 1600px
// about 25% faster; long narrow photos keep 1600px so small print survives.
const aiImageMaxSide = 1280;
const aiTallImageMaxSide = 1600;
const aiImageMaxBytes = 700 * 1024;

/// Downscales and re-encodes a captured photo as base64 JPEG for the AI
/// proxy. Returns null when the file cannot be decoded or stay in budget.
Future<String?> encodeImageForAi(String path) async {
  final file = File(path);
  if (!await file.exists()) return null;
  final bytes = await file.readAsBytes();
  // Picker output is already a native-downscaled JPEG: send it untouched.
  // Decoding and re-encoding in Dart took minutes on slow devices. Exception:
  // Android picker files can carry EXIF rotation as a tag with unrotated
  // pixels; a model that ignores the tag would read the receipt sideways
  // (PB-207), so oriented files always go through the baking path.
  if (bytes.length <= aiImageMaxBytes &&
      bytes.length > 3 &&
      bytes[0] == 0xFF &&
      bytes[1] == 0xD8 &&
      bytes[2] == 0xFF &&
      jpegExifOrientation(bytes) <= 1) {
    return base64Encode(stripJpegMetadata(bytes));
  }
  return compute(_encode, bytes);
}

/// Removes APP1 (Exif/GPS) and APP2 (color profiles) segments without
/// re-encoding: the pixels are already upright, and no capture metadata
/// should leave the device (ADR-004).
Uint8List stripJpegMetadata(Uint8List bytes) {
  if (bytes.length < 4 || bytes[0] != 0xFF || bytes[1] != 0xD8) return bytes;
  final out = BytesBuilder(copy: false)
    ..add([0xFF, 0xD8]);
  var i = 2;
  while (i + 4 <= bytes.length) {
    if (bytes[i] != 0xFF) return bytes; // malformed: send as-is
    final marker = bytes[i + 1];
    if (marker == 0xDA) {
      // Start of scan: everything from here is entropy-coded data.
      out.add(bytes.sublist(i));
      return out.toBytes();
    }
    final size = bytes[i + 2] << 8 | bytes[i + 3];
    if (size < 2 || i + 2 + size > bytes.length) return bytes;
    if (marker != 0xE1 && marker != 0xE2) {
      out.add(bytes.sublist(i, i + 2 + size));
    }
    i += 2 + size;
  }
  return bytes;
}

/// Orientation tag of a JPEG's Exif (1 = normal). 0 = unknown/not found;
/// anything above 1 means the pixels need rotating before upload.
int jpegExifOrientation(Uint8List bytes) {
  if (bytes.length < 12 || bytes[0] != 0xFF || bytes[1] != 0xD8) return 0;
  var i = 2;
  while (i + 4 <= bytes.length) {
    if (bytes[i] != 0xFF) return 0;
    final marker = bytes[i + 1];
    if (marker == 0xE1) {
      // APP1/Exif: expect the 4 bytes "Exif" then two zero bytes, then TIFF.
      final start = i + 4;
      if (start + 14 > bytes.length ||
          bytes[start] != 0x45 || bytes[start + 1] != 0x78 ||
          bytes[start + 2] != 0x69 || bytes[start + 3] != 0x66 ||
          bytes[start + 4] != 0 || bytes[start + 5] != 0) {
        return 0;
      }
      return _tiffOrientation(bytes, start + 6);
    }
    if (marker == 0xDA) return 0; // image data: no Exif ahead
    final size = bytes[i + 2] << 8 | bytes[i + 3];
    i += 2 + size;
  }
  return 0;
}

int _tiffOrientation(Uint8List b, int base) {
  if (base + 8 > b.length) return 0;
  final bigEndian = b[base] == 0x4D && b[base + 1] == 0x4D;
  final littleEndian = b[base] == 0x49 && b[base + 1] == 0x49;
  if (!bigEndian && !littleEndian) return 0;
  int u16(int o) => bigEndian
      ? b[base + o] << 8 | b[base + o + 1]
      : b[base + o + 1] << 8 | b[base + o];
  int u32(int o) => bigEndian
      ? b[base + o] << 24 |
            b[base + o + 1] << 16 |
            b[base + o + 2] << 8 |
            b[base + o + 3]
      : b[base + o + 3] << 24 |
            b[base + o + 2] << 16 |
            b[base + o + 1] << 8 |
            b[base + o];
  final dirOffset = u32(4);
  final dir = base + dirOffset;
  if (dir + 2 > b.length) return 0;
  final count = u16(dirOffset);
  for (var e = 0; e < count && dir + 2 + e * 12 + 12 <= b.length; e++) {
    final entry = dirOffset + 2 + e * 12;
    if (u16(entry) == 0x0112) return u16(entry + 8);
  }
  return 0;
}

String? _encode(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;
  final oriented = img.bakeOrientation(decoded);
  final longest = oriented.width > oriented.height
      ? oriented.width
      : oriented.height;
  final shortest = oriented.width > oriented.height
      ? oriented.height
      : oriented.width;
  final maxSide = longest > shortest * 2 ? aiTallImageMaxSide : aiImageMaxSide;
  final scaled = longest <= maxSide
      ? oriented
      : img.copyResize(
          oriented,
          width: oriented.width >= oriented.height ? maxSide : null,
          height: oriented.height > oriented.width ? maxSide : null,
          interpolation: img.Interpolation.average,
        );
  for (final quality in const [82, 70, 58]) {
    final jpeg = img.encodeJpg(scaled, quality: quality);
    if (jpeg.length <= aiImageMaxBytes) return base64Encode(jpeg);
  }
  return null;
}
