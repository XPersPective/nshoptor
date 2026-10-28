import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';

import '../../ai/ai_client.dart';
import '../ocr_text_source.dart';
import '../ocr_currency.dart';
import 'ai_label_reader.dart';
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
    final capture = await captureImageText(
      context,
      title: l10n.scanPriceLabel,
      pickImage: pickImage,
      ocrSource: ocrSource,
    );
    if (capture is! CapturedImage) return null;
    final scan = capture.scan;
    if (!context.mounted) return null;
    final evidence = detectOcrCurrency(
      scan.lines.map((l) => l.text).join('\n'),
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
    final client = AiService.client;
    final lang = Localizations.localeOf(context).languageCode;
    final ocrText = scan.lines.map((l) => l.text).join(String.fromCharCode(10));
    final reader = client == null
        ? null
        : AiLabelReader(client, localeCode: lang);
    // The AI reading is primary whenever enabled; deterministic candidates
    // remain as offline/over-quota fallback and as extra choices.
    final fromAi =
        await reader?.read(ocrText, currencyCode: currencyCode) ??
        const <PriceCandidate>[];
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
    final candidates = [
      ...fromAi,
      ...local.where(
        (a) => !fromAi.any(
          (c) =>
              a.value == c.value &&
              a.isUnitPrice == c.isUnitPrice &&
              (c.unitCode == null || a.unitCode == c.unitCode) &&
              (c.priceQuantity == null || a.priceQuantity == c.priceQuantity),
        ),
      ),
    ];
    final picked = await showPriceCandidateSheet(context, candidates);
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
