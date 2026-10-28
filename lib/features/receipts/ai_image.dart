import 'dart:convert';
import 'dart:io';

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
  return compute(_encode, bytes);
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
