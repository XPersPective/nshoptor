import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';

import '../../ai/ai_client.dart';
import '../ocr_text_source.dart';
import '../ocr_currency.dart';
import 'ai_label_reader.dart';
import 'mlkit_text_source.dart';
import '../image_capture_service.dart';
import '../image_capture_sheet.dart';
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
    final client = AiService.client;
    final aiOn = client != null && client.enabled;
    final capture = await captureImageText(
      context,
      title: l10n.scanPriceLabel,
      pickImage: pickImage,
      // The image model reads any script; device OCR runs only when it is
      // needed as a fallback (it is slow on weak devices).
      ocrSource: aiOn ? const _NoOcr() : ocrSource,
      requireText: !aiOn,
    );
    if (capture is! CapturedImage) return null;
    if (!context.mounted) return null;
    final lang = Localizations.localeOf(context).languageCode;
    final reader = client == null
        ? null
        : AiLabelReader(client, localeCode: lang);
    var fromAi = await reader?.readImage(
      capture.path,
      currencyCode: currencyCode,
    );
    var scan = capture.scan;
    if (aiOn && (fromAi == null || fromAi.isEmpty)) {
      final owned = ocrSource == null ? MlKitTextSource() : null;
      try {
        scan = await (ocrSource ?? owned!).scan(capture.path);
      } catch (_) {
        scan = const OcrScanResult(lines: []);
      } finally {
        try {
          await owned?.dispose();
        } catch (_) {}
      }
    }
    if (!context.mounted) return null;
    final evidence = detectOcrCurrency(
      scan.lines.map((l) => l.text).join(String.fromCharCode(10)),
      fallback: currencyCode,
    );
    if (evidence.conflictsWith(currencyCode)) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              '${l10n.currencyLabel}: ${evidence.code ?? '?'} → $currencyCode. ${l10n.invalidAmountError}',
            ),
            showCloseIcon: true,
          ),
        );
      return null;
    }
    final local = ShelfPriceExtractor(defaultCurrency: currencyCode)
        .extract(scan.lines);
    final ocrText = scan.lines.map((l) => l.text).join(String.fromCharCode(10));
    if (fromAi == null && reader != null && ocrText.trim().isNotEmpty) {
      fromAi = await reader.read(ocrText, currencyCode: currencyCode);
    }
    fromAi ??= const <PriceCandidate>[];
    if (fromAi.isEmpty && local.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.imageRecognitionFailed),
              showCloseIcon: true,
            ),
          );
      }
      return null;
    }
    if (!context.mounted) return null;
    final problem = reader?.lastResult;
    final notice = switch (problem) {
      AiQuota(:final used, :final limit) => l10n.aiQuotaReached(used, limit),
      AiOffline() => l10n.aiOffline,
      AiFailed() => l10n.aiFailed,
      _ => null,
    };
    if (notice != null) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(notice),
            showCloseIcon: true,
            duration: const Duration(seconds: 5),
          ),
        );
    }
    final aiCandidates = fromAi;
    final candidates = [
      ...aiCandidates,
      ...local.where(
        (a) => !aiCandidates.any(
          (c) =>
              a.value == c.value &&
              a.isUnitPrice == c.isUnitPrice &&
              (c.unitCode == null || a.unitCode == c.unitCode) &&
              (c.priceQuantity == null || a.priceQuantity == c.priceQuantity),
        ),
      ),
    ];
    final picked = await showPriceCandidateSheet(
      context,
      candidates,
      imagePath: capture.path,
    );
    return picked;
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.imageRecognitionFailed),
            showCloseIcon: true,
          ),
        );
    }
    return null;
  }
}

Future<String?> readShelfPrice(
  BuildContext context, {
  required String currencyCode,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
}) async => (await readShelfCandidate(
  context,
  currencyCode: currencyCode,
  pickImage: pickImage,
  ocrSource: ocrSource,
))?.value.toDbString();

final class _NoOcr implements OcrTextSource {
  const _NoOcr();
  @override
  Future<OcrScanResult> scan(String imagePath) async =>
      const OcrScanResult(lines: []);
}
