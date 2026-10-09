import 'package:flutter/widgets.dart';
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
Future<String?> readShelfPrice(
  BuildContext context, {
  required String currencyCode,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
}) async {
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
  final fromAi = client == null
      ? const <PriceCandidate>[]
      : await AiLabelReader(client, localeCode: lang).read(ocrText, currencyCode: currencyCode);
  if (!context.mounted) return null;
  final candidates = [
    ...fromAi,
    ...local.where((c) => !fromAi.any((a) => a.value == c.value)),
  ];
  final picked = await showPriceCandidateSheet(context, candidates);
  return picked?.value.toDbString();
}

Future<String?> _camera() async =>
    (await ImagePicker().pickImage(source: ImageSource.camera))?.path;
