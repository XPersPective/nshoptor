import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';

class _StubOcr implements OcrTextSource {
  const _StubOcr(this.lines);
  final List<String> lines;

  @override
  Future<OcrScanResult> scan(String _) async =>
      OcrScanResult(lines: [for (final line in lines) OcrLine(text: line)]);
}

AiClient _failingAi(Map<String, dynamic> body, {int status = 502}) => AiClient(
  store: SettingsStore(),
  baseUrl: 'https://x',
  httpClient: MockClient(
    (_) async => http.Response(
      jsonEncode(body),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    ),
  ),
);

/// Exact OCR lines from real uploaded A101 receipt (media_1794660154049_e31c98fa).
const _a101RealLines = [
  'USKUDAR/9480...',
  'TARIH : 18.10.2026 16:56',
  'BELGE NO : 20543020261018165746',
  'ETTN:c41f1a703cbe46ee9c614e7f6f170209',
  '2 x20,00 TL/ad',
  'EKMEK %01 *40,00',
  'WINSTON SLIMS GRI %00 *130,00',
  'WINSTON SLIMS GRI %00 *130,00',
  'SIVI DET. ALOE VERA 1,5 L RINS%20 *89,50',
  'KOFTE PiLiC PARMAK 260 G ERPiL%01 *89,00',
  'GAZLI iCECEK KOLA 1.75 L COCA %10 *85,00',
  'ARA TOPLAM *563,50',
  'MAL/HIZMET TOPLAM TUTARI *539,57',
  'TOPKDV *23,93',
  'ODENECEK T ITAR *563,50',
  'KREDI KARTI 563,50',
  'KDV Orani KDV Dahil Tutar KDV',
  '%1 *129,00 *1,28',
  '%0 *260,00 *0,00',
  '%20 *89,50 *14,92',
  '%10 *85,00 *7,73',
  'KASIYER: C*** E*** E***',
  '20543/2/251',
  'Faturaniza asagidaki linkten erisebilirsiniz',
  'https://fatura.a101.com.tr',
  'KREDI KARTI *563,50',
  'YAPI KREDI Pesin (0)',
  'Provizyon No : 315790',
  'Puan:0,00',
  'YAPI KREDI',
  'I:2602731489 T:00D352B853560144****3078',
  '18.10.2026 16:57 B:000074 S:000038',
  'Rrn:2506315790 Ref.No:-',
];

/// Exact OCR lines from real uploaded ŞOK receipt (media_1794660213419_7f8850d4).
const _sokRealLines = [
  'ŞOK MARKETLER TİC.A.Ş',
  '13462 MAMAK GAMZE ÖZDEMİR',
  'ŞAHİNTEPE MH 637.SK NO 2',
  'MAMAK ANKARA',
  'TARİH : 01/02/2024',
  'SAAT : 20:51:41',
  'FİŞ NO : 0259',
  'OZMO FUN FİGÜRLÜ 23G %01 *13,50',
  '7-24 NAMET DANA MACA %01 *27,90',
  'OZMO FUN FİGÜRLÜ 23G %01 *13,50',
  '1,033Kg X 99,00',
  'TADPİ PİLİÇ BAGET KG %01 *102,27',
  'FINISH QUANTUM ÖZEL %20 *259,00',
  '25TLFINISH110TL *149,00-',
  'FINISH QUANTUM ÖZEL %20 *259,00',
  '25TLFINISH110TL *149,00-',
  'ARKO DEĞERLİ YAĞLAR %20 *104,50',
  '25TLARKO50TL *54,50-',
  'ALIŞVERİŞ POŞETİ 43 %20 *0,25',
  'TOPKDV *46,60',
  'TOPLAM *427,42',
];

void main() {
  test('real uploaded A101 receipt parses cleanly with cropped header and footer tables', () {
    final scan = OcrScanResult(
      lines: [for (final line in _a101RealLines) OcrLine(text: line)],
    );
    final doc = ReceiptDocument.fromScan(scan, currencyCode: 'TRY');
    final parsed = doc.toParseResult();

    expect(doc.metadata.store, 'A101');
    expect(doc.metadata.documentNumber, '20543020261018165746');
    expect(doc.metadata.dateTime, DateTime(2026, 10, 18, 16, 56));
    expect(doc.metadata.totalMinor, 56350);
    expect(doc.state, ReceiptDocumentState.complete);

    expect(parsed.lines.length, 6);
    expect(parsed.lines.first.normalizedName, 'ekmek');
    expect(parsed.lines.first.quantity?.toDbString(), '2');
    expect(parsed.lines.first.unitPriceMinor, 2000);
    expect(parsed.lines.first.lineTotalMinor, 4000);
    expect(parsed.computedTotalMinor, 56350);
    expect(parsed.withinReconciliationTolerance, isTrue);
  });

  test('real uploaded ŞOK receipt parses cleanly with weighed chicken & campaign discounts', () {
    final scan = OcrScanResult(
      lines: [for (final line in _sokRealLines) OcrLine(text: line)],
    );
    final doc = ReceiptDocument.fromScan(scan, currencyCode: 'TRY');
    final parsed = doc.toParseResult();

    expect(doc.metadata.store, contains('ŞOK'));
    expect(doc.metadata.documentNumber, '0259');
    expect(doc.metadata.dateTime, DateTime(2024, 2, 1, 20, 51, 41));
    expect(doc.metadata.totalMinor, 42742);
    expect(doc.state, ReceiptDocumentState.complete);

    expect(parsed.lines.length, 8);
    expect(parsed.lines[3].quantity?.toDbString(), '1.033');
    expect(parsed.lines[3].unitPriceMinor, 9900);
    expect(parsed.lines[3].lineTotalMinor, 10227);
    expect(parsed.discountMinor, 35250);
    expect(parsed.computedTotalMinor, 42742);
    expect(parsed.withinReconciliationTolerance, isTrue);
  });

  test('ŞOK campaign discounts survive even when OCR drops trailing minus sign', () {
    final droppedMinus = _sokRealLines
        .map((l) => l.endsWith('-') ? l.substring(0, l.length - 1) : l)
        .toList();
    final parsed = ReceiptParser(currency: 'TRY').parse(
      OcrScanResult(lines: [for (final line in droppedMinus) OcrLine(text: line)]),
    );
    expect(parsed.lines.length, 8);
    expect(parsed.discountMinor, 35250);
    expect(parsed.computedTotalMinor, 42742);
    expect(parsed.withinReconciliationTolerance, isTrue);
  });

  test('parseReceiptImages recovers via offline OCR when AI returns top_missing or 502 rejected', () async {
    final topMissing = await parseReceiptImages(
      photoPaths: const ['a101.jpg'],
      currencyCode: 'TRY',
      ai: _failingAi({'schema': 2, 'status': 'top_missing'}, status: 200),
      encode: (p) async => '/9j/$p',
      ocrFallback: const _StubOcr(_a101RealLines),
    );
    expect(topMissing, isA<ReceiptParsedDocument>());
    expect((topMissing as ReceiptParsedDocument).usedAi, isFalse);
    expect(topMissing.document.metadata.totalMinor, 56350);

    final rejected = await parseReceiptImages(
      photoPaths: const ['sok.jpg'],
      currencyCode: 'TRY',
      ai: _failingAi({'error': 'bad_model_output', 'reason': 'not_reconciled'}),
      encode: (p) async => '/9j/$p',
      ocrFallback: const _StubOcr(_sokRealLines),
    );
    expect(rejected, isA<ReceiptParsedDocument>());
    expect((rejected as ReceiptParsedDocument).usedAi, isFalse);
    expect(rejected.document.metadata.totalMinor, 42742);
  });
}
