import 'package:flutter/material.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../ai/ai_client.dart';
import '../ocr_text_source.dart';
import 'ai_label_reader.dart';
import 'mlkit_text_source.dart';
import 'price_candidate_sheet.dart';
import 'price_candidates.dart';

/// Raf etiketini kamerayla okutup fiyat döndürür (DB biçimi, nokta ondalık);
/// iptalde ya da fiyat bulunamazsa null. Fotoğraf cihazda kalır: ML Kit yerelde
/// okur, AI açıksa yalnız metin gider (C-041). Hem ürün formu hem alışveriş
/// satırındaki kamera düğmesi bunu kullanır (PB-062).
Future<PriceCandidate?> readShelfCandidate(
  BuildContext context, {
  required String currencyCode,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
}) async {
  final l10n = AppLocalizations.of(context);
  try {
  final path = await (pickImage ?? _camera)();
  if (path == null) return null;
  final OcrScanResult scan;
  if (ocrSource != null) {
    scan = await ocrSource.scan(path);
  } else {
    final source = MlKitTextSource();
    try {
      scan = await source.scan(path);
    } finally {
      source.dispose();
    }
  }
  if (!context.mounted) return null;
  final local = ShelfPriceExtractor(defaultCurrency: currencyCode).extract(scan.lines);
  final client = AiService.client;
  final lang = Localizations.localeOf(context).languageCode;
  final ocrText = scan.lines.map((l) => l.text).join(String.fromCharCode(10));
  final reader = client == null ? null : AiLabelReader(client, localeCode: lang);
  final fromAi = await reader?.read(ocrText, currencyCode: currencyCode) ?? const <PriceCandidate>[];
  if (!context.mounted) return null;
  final problem = reader?.lastResult;
  final notice = switch (problem) {
    AiQuota(:final used, :final limit) => l10n.aiQuotaReached(used, limit),
    AiOffline() => l10n.aiOffline,
    AiFailed() => l10n.aiFailed,
    _ => null,
  };
  if (notice != null) { ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
    SnackBar(content: Text(notice), showCloseIcon: true)); }
  final candidates = [
    ...fromAi,
    ...local.where((c) => !fromAi.any((a) => a.value == c.value && a.unitCode == c.unitCode && a.isUnitPrice == c.isUnitPrice)),
  ];
  final picked = await showPriceCandidateSheet(context, candidates);
  return picked;
  } catch (_) {
    if (context.mounted) { ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
      SnackBar(content: Text(l10n.ocrNoText), showCloseIcon: true, duration: const Duration(days: 1))); }
    return null;
  }
}

Future<String?> readShelfPrice(BuildContext context, {required String currencyCode,
  Future<String?> Function()? pickImage, OcrTextSource? ocrSource}) async =>
  (await readShelfCandidate(context, currencyCode: currencyCode, pickImage: pickImage, ocrSource: ocrSource))?.value.toDbString();

Future<String?> _camera() async =>
    (await ImagePicker().pickImage(source: ImageSource.camera))?.path;
