import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show BytesBuilder, Uint8List;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Longest side and compact size budget of one photo stored/sent to the
/// image model so batch receipt scans upload quickly and cheaply without
/// losing receipt print legibility.
const aiImageMaxSide = 1280;
const aiTallImageMaxSide = 1280;
const aiImageMaxBytes = 350 * 1024;

/// Downscales, strips metadata, and compresses a captured photo as JPEG bytes
/// within [aiImageMaxSide] and [aiImageMaxBytes]. Returns null if unreadable.
Future<Uint8List?> compressImageForAi(String path) async {
  final file = File(path);
  if (!await file.exists()) return null;
  final bytes = await file.readAsBytes();
  // Fast path: when a native picker already produced an upright JPEG within
  // both byte and dimension budgets, strip metadata without Dart decode/re-encode.
  if (bytes.length <= aiImageMaxBytes &&
      bytes.length > 3 &&
      bytes[0] == 0xFF &&
      bytes[1] == 0xD8 &&
      bytes[2] == 0xFF &&
      jpegExifOrientation(bytes) <= 1) {
    final dims = jpegDimensions(bytes);
    if (dims != null &&
        dims.$1 <= aiImageMaxSide &&
        dims.$2 <= aiImageMaxSide) {
      return stripJpegMetadata(bytes);
    }
  }
  return compute(_encodeBytes, bytes);
}

/// Downscales and re-encodes a captured photo as base64 JPEG for the AI
/// proxy. Returns null when the file cannot be decoded or stay in budget.
Future<String?> encodeImageForAi(String path) async {
  final compressed = await compressImageForAi(path);
  return compressed == null ? null : base64Encode(compressed);
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

/// Reads `(width, height)` from a JPEG's SOF header without decoding pixels,
/// or null if the marker cannot be located.
(int, int)? jpegDimensions(Uint8List bytes) {
  if (bytes.length < 4 || bytes[0] != 0xFF || bytes[1] != 0xD8) return null;
  var i = 2;
  while (i + 4 <= bytes.length) {
    if (bytes[i] != 0xFF) return null;
    while (i < bytes.length && bytes[i] == 0xFF) {
      i++;
    }
    if (i >= bytes.length) return null;
    final marker = bytes[i++];
    if (marker == 0xD8 || marker == 0xD9 || marker == 0x00 ||
        (marker >= 0xD0 && marker <= 0xD7)) {
      continue;
    }
    if (marker == 0xDA) return null;
    if (i + 2 > bytes.length) return null;
    final size = (bytes[i] << 8) | bytes[i + 1];
    if (size < 2 || i + size > bytes.length) return null;
    // SOF0..SOF3, SOF5..SOF7, SOF9..SOF11, SOF13..SOF15 contain image size.
    final isSof = (marker >= 0xC0 && marker <= 0xC3) ||
        (marker >= 0xC5 && marker <= 0xC7) ||
        (marker >= 0xC9 && marker <= 0xCB) ||
        (marker >= 0xCD && marker <= 0xCF);
    if (isSof && size >= 7 && i + 7 <= bytes.length) {
      final height = (bytes[i + 3] << 8) | bytes[i + 4];
      final width = (bytes[i + 5] << 8) | bytes[i + 6];
      if (width > 0 && height > 0) return (width, height);
      return null;
    }
    i += size;
  }
  return null;
}

Uint8List? _encodeBytes(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;
  final oriented = img.bakeOrientation(decoded);
  for (final targetSide in const [aiImageMaxSide, 960]) {
    final longest = oriented.width > oriented.height
        ? oriented.width
        : oriented.height;
    final scaled = longest <= targetSide
        ? oriented
        : img.copyResize(
            oriented,
            width: oriented.width >= oriented.height ? targetSide : null,
            height: oriented.height > oriented.width ? targetSide : null,
            interpolation: img.Interpolation.average,
          );
    final qualities = targetSide == aiImageMaxSide
        ? const [78, 66, 54, 44]
        : const [66, 54, 44];
    for (final quality in qualities) {
      final jpeg = Uint8List.fromList(img.encodeJpg(scaled, quality: quality));
      if (jpeg.length <= aiImageMaxBytes) return jpeg;
    }
  }
  return null;
}
