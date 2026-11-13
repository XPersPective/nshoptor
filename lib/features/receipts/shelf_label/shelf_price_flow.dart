import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';

import '../../ai/ai_client.dart';
import '../ai_image.dart';
import '../ocr_text_source.dart';
import '../ocr_currency.dart';
import 'ai_label_reader.dart';
import 'mlkit_text_source.dart';
import '../image_capture_service.dart';
import '../image_capture_sheet.dart';
import 'price_candidate_sheet.dart';
import 'price_candidates.dart';

/// Parsed outcome for one shelf-label photo.
typedef ShelfLabelParseResult = ({
  List<PriceCandidate> candidates,
  AiResult? aiProblem,
});

/// Parses one shelf-label photo with Server Vision AI (`read_label_image`) as
/// primary parser, invoking on-device ML Kit (`MlKitTextSource` or
/// [ocrFallback]) **only** when AI is disabled, offline, or unavailable.
Future<ShelfLabelParseResult> parseShelfLabelImage(
  String imagePath, {
  required String currencyCode,
  required String localeCode,
  AiClient? ai,
  OcrTextSource? ocrFallback,
  OcrScanResult? initialScan,
  Future<String?> Function(String path) encode = encodeImageForAi,
}) async {
  final aiOn = ai != null && ai.enabled;
  AiLabelReader? reader;
  List<PriceCandidate>? fromAi;
  if (aiOn) {
    reader = AiLabelReader(ai, localeCode: localeCode);
    fromAi = await reader.readImage(
      imagePath,
      currencyCode: currencyCode,
      encode: encode,
    );
  }

  // When Server Vision AI succeeded (returned non-null list), do not invoke
  // on-device ML Kit at all.
  if (aiOn && fromAi != null) {
    return (candidates: fromAi, aiProblem: reader?.lastResult);
  }

  // Explicit offline / AI-disabled / AI-unavailable fallback.
  var scan = initialScan;
  if (scan == null || !scan.lines.any((l) => l.text.trim().isNotEmpty)) {
    final owned = ocrFallback == null ? MlKitTextSource() : null;
    try {
      scan = await (ocrFallback ?? owned!).scan(imagePath);
    } catch (_) {
      scan = const OcrScanResult(lines: []);
    } finally {
      try {
        await owned?.dispose();
      } catch (_) {}
    }
  }

  final rawText = scan.lines.map((l) => l.text).join(String.fromCharCode(10));
  final evidence = detectOcrCurrency(rawText, fallback: currencyCode);
  final local = evidence.conflictsWith(currencyCode)
      ? const <PriceCandidate>[]
      : ShelfPriceExtractor(defaultCurrency: currencyCode).extract(scan.lines);
  return (candidates: local, aiProblem: reader?.lastResult);
}

/// Captures one shelf-label photo and IMMEDIATELY returns its path without
/// blocking on AI or OCR so the user can move straight to the next product.
///
/// Parsing proceeds asynchronously via [parseShelfLabelImage] (Server Vision AI
/// primary, ML Kit offline-only fallback). Read errors or unparseable labels
/// are discarded quietly.
Future<String?> captureShelfLabelNonBlocking(
  BuildContext context, {
  required String currencyCode,
  AiClient? ai,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
  @visibleForTesting Future<String?> Function(String path)? encodeAiImage,
  void Function(List<PriceCandidate> candidates, String imagePath)? onParsed,
}) async {
  final l10n = AppLocalizations.of(context);
  final lang = Localizations.localeOf(context).languageCode;
  final client = ai ?? AiService.client;
  final capture = await captureImageText(
    context,
    title: l10n.scanPriceLabel,
    pickImage: pickImage,
    // Capture-first: never block shutter return on ML Kit.
    ocrSource: const _NoOcr(),
    requireText: false,
  );
  if (capture is! CapturedImage) return null;

  if (context.mounted) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.shelfLabelQueuedNotice),
          showCloseIcon: true,
        ),
      );
  }

  unawaited(() async {
    try {
      final result = await parseShelfLabelImage(
        capture.path,
        currencyCode: currencyCode,
        localeCode: lang,
        ai: client,
        ocrFallback: ocrSource,
        encode: encodeAiImage ?? encodeImageForAi,
      );
      if (result.candidates.isNotEmpty) {
        onParsed?.call(result.candidates, capture.path);
      }
    } catch (_) {
      // Unparseable labels in quick scan mode never disturb the shopper.
    }
  }());

  return capture.path;
}

/// Raf etiketini kamerayla okutup fiyat döndürür (DB biçimi, nokta ondalık);
/// iptalde ya da fiyat bulunamazsa null. Server Vision AI birincil ayrıştırıcıdır;
/// yerel ML Kit yalnızca çevrimdışı/AI kapalıyken yedek olarak çalışır.
Future<PriceCandidate?> readShelfCandidate(
  BuildContext context, {
  required String currencyCode,
  AiClient? ai,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
  @visibleForTesting Future<String?> Function(String path)? encodeAiImage,
  void Function(List<PriceCandidate> candidates)? onBackgroundResolved,
}) async {
  final l10n = AppLocalizations.of(context);
  try {
    const maxAttempts = 3;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      final canRetry = attempt < maxAttempts;
      if (!context.mounted) return null;
      final client = ai ?? AiService.client;
      final aiOn = client != null && client.enabled;
      final capture = await captureImageText(
        context,
        title: l10n.scanPriceLabel,
        pickImage: pickImage,
        // Server Vision AI is primary; never run on-device OCR eagerly.
        ocrSource: aiOn ? const _NoOcr() : ocrSource,
        requireText: !aiOn,
      );
      if (capture is! CapturedImage) return null;
      if (!context.mounted) return null;
      final lang = Localizations.localeOf(context).languageCode;

      final scanText = capture.scan.lines
          .map((l) => l.text)
          .join(String.fromCharCode(10));
      final initialEvidence = detectOcrCurrency(
        scanText,
        fallback: currencyCode,
      );
      final currencyConflict = !aiOn && initialEvidence.conflictsWith(currencyCode);
      if (currencyConflict) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(
                '${l10n.currencyLabel}: ${initialEvidence.code ?? '?'} → $currencyCode. ${l10n.invalidAmountError}',
              ),
              showCloseIcon: true,
            ),
          );
      }

      final parseFuture = parseShelfLabelImage(
        capture.path,
        currencyCode: currencyCode,
        localeCode: lang,
        ai: client,
        ocrFallback: ocrSource,
        initialScan: aiOn ? null : capture.scan,
        encode: encodeAiImage ?? encodeImageForAi,
      );

      final ShelfLabelParseResult parsed;
      if (aiOn && onBackgroundResolved != null) {
        final step = await _waitForLabelOrMoveOn(context, parseFuture);
        if (step == null) {
          // User tapped "Scan another item" — let parsing finish silently
          // and forward any parsed price without holding the UI.
          unawaited(
            parseFuture.then((res) {
              if (res.candidates.isNotEmpty) {
                onBackgroundResolved(res.candidates);
              }
            }).catchError((_) {}),
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.shelfLabelQueuedNotice),
                  showCloseIcon: true,
                ),
              );
          }
          return null;
        }
        parsed = step;
      } else {
        parsed = await parseFuture;
      }

      if (!context.mounted) return null;
      final candidates = parsed.candidates;
      final problem = parsed.aiProblem;
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
      final picked = await showPriceCandidateSheet(
        context,
        candidates,
        imagePath: capture.path,
        currencyCode: currencyCode,
        allowRetake: canRetry,
      );
      if (picked == null) return null;
      if (picked.retake) continue; // loop back to capture
      return picked.candidate; // picked tile or manual entry
    }
    return null;
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

Future<ShelfLabelParseResult?> _waitForLabelOrMoveOn(
  BuildContext context,
  Future<ShelfLabelParseResult> work,
) async {
  final l10n = AppLocalizations.of(context);
  final navigator = Navigator.of(context, rootNavigator: true);
  final done = Completer<ShelfLabelParseResult?>();
  var open = true;
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        key: const Key('shelf_label_reading_progress'),
        content: Row(
          children: [
            const SizedBox.square(
              dimension: 28,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Semantics(
                liveRegion: true,
                child: Text(l10n.shelfLabelReading),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            key: const Key('shelf_label_continue_other'),
            onPressed: () {
              if (!done.isCompleted) done.complete(null);
            },
            child: Text(l10n.shelfLabelContinueOther),
          ),
        ],
      ),
    ).whenComplete(() {
      open = false;
      if (!done.isCompleted) done.complete(null);
    }),
  );
  unawaited(
    work.then(
      (res) {
        if (!done.isCompleted) done.complete(res);
      },
      onError: (Object e, StackTrace st) {
        if (!done.isCompleted) done.completeError(e, st);
      },
    ),
  );
  try {
    return await done.future;
  } finally {
    if (open && navigator.mounted) navigator.pop();
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
