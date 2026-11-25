import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show BytesBuilder, Uint8List;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Longest side and size budget of one photo stored on the phone and sent to
/// the image model. Thermal receipt print is small: a tall full receipt keeps
/// up to 2400px on its long side so each character stays legible, while the
/// byte budget keeps four photos inside the proxy's request limit.
const aiImageMaxSide = 1600;
const aiTallImageMaxSide = 2400;
const aiImageMaxBytes = 700 * 1024;

/// A photo whose height exceeds its width by this ratio is a tall receipt.
const _tallRatio = 1.35;

int _maxSideFor(int width, int height) =>
    height > width * _tallRatio || width > height * _tallRatio
    ? aiTallImageMaxSide
    : aiImageMaxSide;

/// Whether [bytes] are already an upright JPEG inside the size and byte
/// budget, i.e. a photo this app compressed before. Such a photo is never
/// decoded and re-encoded again.
bool isCompressedForAi(Uint8List bytes) {
  if (bytes.length > aiImageMaxBytes ||
      bytes.length <= 3 ||
      bytes[0] != 0xFF ||
      bytes[1] != 0xD8 ||
      bytes[2] != 0xFF ||
      jpegExifOrientation(bytes) > 1) {
    return false;
  }
  final dims = jpegDimensions(bytes);
  if (dims == null) return false;
  final limit = _maxSideFor(dims.$1, dims.$2);
  return dims.$1 <= limit && dims.$2 <= limit;
}

/// Downscales, strips metadata, and compresses a captured photo as JPEG bytes
/// within the size and byte budget. Returns null if unreadable.
Future<Uint8List?> compressImageForAi(String path) async {
  final file = File(path);
  if (!await file.exists()) return null;
  final bytes = await file.readAsBytes();
  // Fast path: a photo that is already within budget (for example one this
  // app compressed when it was taken) is only stripped, never re-encoded.
  if (isCompressedForAi(bytes)) return stripJpegMetadata(bytes);
  return compute(_encodeBytes, bytes);
}

/// Base64 JPEG for the AI proxy. Returns null when the file cannot be decoded
/// or stay in budget.
///
/// A receipt photo in app-owned storage that was not compressed yet (older
/// captures) is compressed once and written back, so retries and later
/// continuations never compress the same photo a second time.
Future<String?> encodeImageForAi(String path) async {
  final file = File(path);
  if (!await file.exists()) return null;
  final original = await file.readAsBytes();
  final compressed = isCompressedForAi(original)
      ? stripJpegMetadata(original)
      : await compute(_encodeBytes, original);
  if (compressed == null) return null;
  if (!identical(compressed, original) &&
      compressed.length < original.length &&
      RegExp(r'[\\/]receipt_media[\\/]\d{13,20}-\d+\.img$').hasMatch(path)) {
    try {
      await file.writeAsBytes(compressed, flush: true);
    } catch (_) {
      // The upload still uses the compressed bytes; write-back is best effort.
    }
  }
  return base64Encode(compressed);
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
  final first = _maxSideFor(oriented.width, oriented.height);
  // Legibility first: high quality at full budget size, then a smaller side
  // before quality ever drops low enough to blur small receipt print.
  for (final (targetSide, qualities) in [
    (first, const [88, 82, 76, 70]),
    ((first * 3) ~/ 4, const [82, 74, 66]),
  ]) {
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
    for (final quality in qualities) {
      final jpeg = Uint8List.fromList(img.encodeJpg(scaled, quality: quality));
      if (jpeg.length <= aiImageMaxBytes) return jpeg;
    }
  }
  return null;
}
