import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';

OcrScanResult _scan(List<String> lines) =>
    OcrScanResult(lines: [for (final text in lines) OcrLine(text: text)]);

ReceiptDocument _document(List<String> lines, {String currency = 'TRY'}) =>
    ReceiptDocument.fromScan(_scan(lines), currencyCode: currency);

List<String> _header({
  String store = 'A101 MARKET',
  String number = '000123',
}) => [store, 'TARİH: 24.10.2026', 'SAAT: 18:41:35', 'FİŞ NO: $number'];

void main() {
  test(
    'native split-total rows preserve fragments and replay conservatively',
    () {
      final scan = OcrScanResult(
        lines: [
          OcrLine(
            text: 'J.STB PROMO',
            boundingBoxTop: 669,
            boundingBoxLeft: 132,
          ),
          OcrLine(text: '17500', boundingBoxTop: 676, boundingBoxLeft: 686),
          OcrLine(text: 'Y.B.BAT', boundingBoxTop: 722, boundingBoxLeft: 133),
          OcrLine(text: '46000', boundingBoxTop: 726, boundingBoxLeft: 682),
          OcrLine(
            text: 'Y.BASO PROM',
            boundingBoxTop: 771,
            boundingBoxLeft: 130,
          ),
          OcrLine(text: '27500', boundingBoxTop: 775, boundingBoxLeft: 683),
          OcrLine(text: 'TOT AL', boundingBoxTop: 823, boundingBoxLeft: 106),
          OcrLine(text: '91000', boundingBoxTop: 826, boundingBoxLeft: 541),
          OcrLine(text: 'CASH', boundingBoxTop: 881, boundingBoxLeft: 128),
          OcrLine(text: '910O0', boundingBoxTop: 880, boundingBoxLeft: 542),
        ],
      );
      final readingRows = ReceiptParser(currency: 'IDR').readingRows(scan);
      expect(readingRows.map((line) => line.text), [
        'J.STB PROMO 17500',
        'Y.B.BAT 46000',
        'Y.BASO PROM 27500',
        'TOTAL 91000',
        'CASH 910O0',
      ]);

      final document = ReceiptDocument.fromScan(scan, currencyCode: 'IDR');
      expect(document.productLines.map((line) => line.name), [
        'J.STB PROMO',
        'Y.B.BAT',
        'Y.BASO PROM',
      ]);
      expect(document.productLines.map((line) => line.lineTotalMinor), [
        1750000,
        4600000,
        2750000,
      ]);
      expect(document.metadata.totalMinor, 9100000);
      expect(document.toParseResult().computedTotalMinor, 9100000);
      expect(document.toParseResult().withinReconciliationTolerance, isTrue);
      expect(document.state, ReceiptDocumentState.incompleteHeader);
      expect(document.identity, isNull);

      final originalFragments = scan.lines.map((line) => line.text).toList();
      expect(
        originalFragments,
        containsAll(['TOT AL', '91000', 'CASH', '910O0']),
      );
      final restored = ReceiptDocument.decode(document.encode());
      expect(
        restored.fragments.single.lines.map((line) => line.text),
        originalFragments,
      );
      expect(restored.metadata.totalMinor, 9100000);
      expect(restored.productLines.map((line) => line.lineTotalMinor), [
        1750000,
        4600000,
        2750000,
      ]);
      expect(restored.state, ReceiptDocumentState.incompleteHeader);
      expect(restored.identity, isNull);
      expect(restored.encode(), document.encode());
    },
  );

  test('split totals use observed currency before durable replay', () {
    for (final scenario in [
      (context: 'TRY', currency: 'IDR', amount: '91000', minor: 9100000),
      (context: 'JPY', currency: 'TRY', amount: '20,00', minor: 2000),
      (context: 'JPY', currency: 'KWD', amount: '20.123', minor: 20123),
    ]) {
      final rawLines = [
        ..._header(),
        'ITEM ${scenario.amount} ${scenario.currency}',
        'TOT AL ${scenario.amount} ${scenario.currency}',
      ];
      final document = ReceiptDocument.fromScan(
        _scan(rawLines),
        currencyCode: scenario.context,
      );
      expect(document.metadata.currencyCode, scenario.currency);
      expect(document.metadata.totalMinor, scenario.minor);
      expect(document.productLines, hasLength(1));
      expect(document.productLines.single.lineTotalMinor, scenario.minor);
      expect(document.toParseResult().computedTotalMinor, scenario.minor);
      expect(document.toParseResult().withinReconciliationTolerance, isTrue);
      expect(document.state, ReceiptDocumentState.complete);
      expect(document.identity, isNotNull);

      final restored = ReceiptDocument.decode(document.encode());
      expect(restored.metadata.currencyCode, scenario.currency);
      expect(restored.metadata.totalMinor, scenario.minor);
      expect(restored.productLines, hasLength(1));
      expect(restored.productLines.single.lineTotalMinor, scenario.minor);
      expect(restored.state, document.state);
      expect(restored.identity, document.identity);
      expect(
        restored.fragments.single.lines.map((line) => line.text),
        rawLines,
      );
      expect(restored.encode(), document.encode());
    }
  });

  test(
    'partial evidence survives a versioned restart and retains positions',
    () {
      final lines = [..._header(), 'ELMA 20,00'];
      final original = ReceiptDocument.fromScan(
        OcrScanResult(
          lines: [
            for (var index = 0; index < lines.length; index++)
              OcrLine(
                text: lines[index],
                boundingBoxTop: 20 + index * 20,
                boundingBoxLeft: 4,
                boundingBoxHeight: 10,
              ),
          ],
        ),
        currencyCode: 'TRY',
      );
      final restored = ReceiptDocument.decode(original.encode());
      expect(restored.state, ReceiptDocumentState.incompleteTail);
      expect(restored.identity, original.identity);
      expect(restored.fragments.single.lines.first.boundingBoxHeight, 10);
      expect(
        restored.fragments.single.lines.map((line) => line.boundingBoxTop),
        [20, 40, 60, 80, 100],
      );
      expect(restored.encode(), original.encode());
    },
  );

  test(
    'geometry reconstructs split metadata in visual order and survives restart',
    () {
      final scan = OcrScanResult(
        lines: [
          // The engine returns blocks out of order and splits each of these
          // physical rows into left/right fragments on one baseline.
          OcrLine(
            text: '40,00 TL',
            boundingBoxTop: 170,
            boundingBoxLeft: 300,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: '2026000123',
            boundingBoxTop: 50,
            boundingBoxLeft: 150,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: 'SÜT',
            boundingBoxTop: 200,
            boundingBoxLeft: 10,
            boundingBoxHeight: 20,
          ),
          OcrLine(
            text: 'MARKET',
            boundingBoxTop: 10,
            boundingBoxLeft: 150,
            boundingBoxHeight: 20,
          ),
          OcrLine(
            text: '90,00 TL',
            boundingBoxTop: 230,
            boundingBoxLeft: 300,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: '2 ADET X 20,00',
            boundingBoxTop: 170,
            boundingBoxLeft: 10,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: 'TARİH: 25.10.2026',
            boundingBoxTop: 30,
            boundingBoxLeft: 10,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: 'ÖRNEK',
            boundingBoxTop: 10,
            boundingBoxLeft: 10,
            boundingBoxHeight: 20,
          ),
          OcrLine(
            text: 'TOPLAM',
            boundingBoxTop: 230,
            boundingBoxLeft: 10,
            boundingBoxHeight: 20,
          ),
          OcrLine(
            text: '10:15:32',
            boundingBoxTop: 30,
            boundingBoxLeft: 250,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: 'ELMA',
            boundingBoxTop: 100,
            boundingBoxLeft: 10,
            boundingBoxHeight: 20,
          ),
          OcrLine(
            text: '1,000 KG X 20,00',
            boundingBoxTop: 120,
            boundingBoxLeft: 10,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: '20,00 TL',
            boundingBoxTop: 120,
            boundingBoxLeft: 300,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: 'FİŞ NO:',
            boundingBoxTop: 50,
            boundingBoxLeft: 10,
            boundingBoxHeight: 10,
          ),
          OcrLine(
            text: 'EKMEK',
            boundingBoxTop: 150,
            boundingBoxLeft: 10,
            boundingBoxHeight: 20,
          ),
          OcrLine(
            text: '30,00 TL',
            boundingBoxTop: 200,
            boundingBoxLeft: 300,
            boundingBoxHeight: 10,
          ),
        ],
      );
      final original = ReceiptDocument.fromScan(scan, currencyCode: 'TRY');
      final restored = ReceiptDocument.decode(original.encode());

      expect(restored.metadata.store, 'ÖRNEK MARKET');
      expect(restored.metadata.documentNumber, '2026000123');
      expect(restored.metadata.dateTime, DateTime(2026, 10, 25, 10, 15, 32));
      expect(restored.metadata.currencyCode, 'TRY');
      expect(restored.metadata.totalMinor, 9000);
      expect(restored.state, ReceiptDocumentState.complete);
      expect(restored.productLines.map((line) => line.name), [
        'ELMA',
        'EKMEK',
        'SÜT',
      ]);
      expect(restored.productLines.map((line) => line.lineTotalMinor), [
        2000,
        4000,
        3000,
      ]);
      expect(restored.toParseResult().computedTotalMinor, 9000);
      expect(restored.toParseResult().withinReconciliationTolerance, isTrue);
      expect(restored.identity, original.identity);
      expect(restored.encode(), original.encode());
    },
  );

  test(
    'continued evidence replays once and reconciles the full product order',
    () {
      final initial = _document([..._header(), 'ELMA 20,00', 'EKMEK 40,00']);
      final result = initial.append(
        _scan(['EKMEK 40,00', 'SÜT 30,00', 'TOPLAM 90,00 TL']),
      ) as ReceiptAppended;
      final restored = ReceiptDocument.decode(result.document.encode());
      expect(restored.productLines.map((l) => l.name), [
        'ELMA',
        'EKMEK',
        'SÜT',
      ]);
      expect(restored.fragments, hasLength(2));
      expect(restored.toParseResult().computedTotalMinor, 9000);
      expect(restored.toParseResult().withinReconciliationTolerance, isTrue);
    },
  );

  test('capture decoding rejects corrupt, unknown and oversized evidence', () {
    for (final input in [
      '{}',
      '{"version":2,"currency":"TRY","fragments":[]}',
      '{"version":1,"currency":"BAD","fragments":[[]]}',
      '{"version":1,"currency":"TRY","fragments":[[{"text":3}]]}',
      '{"version":1,"currency":"TRY","fragments":[[{"text":"a","top":"b"}]]}',
      'x' * 2000001,
    ]) {
      expect(() => ReceiptDocument.decode(input), throwsFormatException);
    }
  });

  test(
    'ordered overlap retains separate discounts and counts repeats once',
    () {
      final first = _document([
        ..._header(),
        'SÜT 10,00',
        'İNDİRİM 1,00',
        'EKMEK 10,00',
        'İNDİRİM 2,00',
      ]);
      final joined = first.append(
        _scan(['EKMEK 10,00', 'İNDİRİM 2,00', 'ELMA 10,00', 'TOPLAM 27,00']),
      ) as ReceiptAppended;
      final parsed = joined.document.toParseResult();
      expect(parsed.discountMinor, 300);
      expect(parsed.computedTotalMinor, 2700);
      expect(parsed.withinReconciliationTolerance, isTrue);
      expect(
        ReceiptDocument.decode(joined.document.encode())
            .toParseResult()
            .discountMinor,
        300,
      );
    },
  );

  test('missing header can be photographed above a known overlapping tail', () {
    final tail = _document(['EKMEK 40,00', 'SÜT 30,00', 'TOPLAM 90,00']);
    final joined = tail.prepend(
      _scan([..._header(), 'ELMA 20,00', 'EKMEK 40,00']),
    ) as ReceiptAppended;
    expect(joined.document.state, ReceiptDocumentState.complete);
    expect(joined.document.productLines.map((l) => l.name), [
      'ELMA',
      'EKMEK',
      'SÜT',
    ]);
    expect(
      joined.document.toParseResult().withinReconciliationTolerance,
      isTrue,
    );
    expect(
      ReceiptDocument.decode(joined.document.encode()).identity,
      joined.document.identity,
    );
  });

  test('Turkish printed header and total form explicit complete metadata', () {
    final document = _document([
      ..._header(),
      'ELMA 20,00',
      'EKMEK 40,00',
      'TOPLAM 60,00 TL',
    ]);

    expect(document.state, ReceiptDocumentState.complete);
    expect(document.metadata.store, 'A101 MARKET');
    expect(document.metadata.documentNumber, '000123');
    expect(document.metadata.dateTime, DateTime(2026, 10, 24, 18, 41, 35));
    expect(document.metadata.totalMinor, 6000);
    expect(document.identity, isNotNull);
  });

  test('missing header is explicit even when products and total exist', () {
    final document = _document(['ELMA 20,00', 'TOPLAM 20,00 TL']);

    expect(document.state, ReceiptDocumentState.incompleteHeader);
    expect(document.metadata.store, isNull);
    expect(document.metadata.documentNumber, isNull);
    expect(document.metadata.dateTime, isNull);
    expect(document.identity, isNull);
  });

  test('a valid header without final total remains incomplete', () {
    final document = _document([..._header(), 'ELMA 20,00']);

    expect(document.state, ReceiptDocumentState.incompleteTail);
    expect(document.metadata.totalMinor, isNull);
    expect(document.identity, isNotNull);
  });

  test('date without printed time does not invent midnight identity', () {
    final document = _document([
      'BİM MARKET',
      'TARİH: 24/10/2026',
      'FATURA NO: ABC2026000123',
      'ELMA 20,00',
      'GENEL TOPLAM 20,00',
    ]);

    expect(document.metadata.dateTime, isNull);
    expect(document.identity, isNull);
    expect(document.state, ReceiptDocumentState.incompleteHeader);
  });

  test('invoice number and inline ISO date/time retain explicit evidence', () {
    final document = _document([
      'MİGROS',
      '2026-10-24 18:41',
      'E-ARŞİV FATURA NO: ABC2026000123',
      'ELMA 20,00',
      'ÖDENECEK TUTAR: 20,00 TL',
    ]);

    expect(document.metadata.documentNumber, 'ABC2026000123');
    expect(document.metadata.dateTime, DateTime(2026, 10, 24, 18, 41));
    expect(document.metadata.totalMinor, 2000);
    expect(document.productLines.map((line) => line.name), ['ELMA']);
  });

  test('recognized metadata cannot contaminate a wrapped product name', () {
    final document = _document([
      'MİGROS',
      '2026-10-24 18:41',
      'E-ARŞİV FATURA NO: ABC2026000123',
      'ELMA',
      '20,00',
      'ÖDENECEK TUTAR: 20,00 TL',
    ]);

    expect(document.productLines.map((line) => line.name), ['ELMA']);
    expect(document.productLines.single.lineTotalMinor, 2000);
    expect(document.metadata.totalMinor, 2000);
    expect(document.fragments.single.lines, hasLength(6));
  });

  test('a printed date inside a priced product is not a metadata-only row', () {
    final document = _document([
      ..._header(),
      'SÜT SKT 25.10.2026 20,00',
      'TOPLAM 20,00',
    ]);

    expect(document.productLines.map((line) => line.name), [
      'SÜT SKT 25.10.2026',
    ]);
  });

  test(
    'cashier IDs are not merchants and receipt number may share a header row',
    () {
      final document = _document([
        'SATICI: 03 KASA: 02',
        'ATATÜRK CADDESİ',
        'TARİH: 24.10.2026 SAAT: 18:41 FİŞ NO: 00123',
        'ELMA 20,00',
        'TOPLAM 20,00',
      ]);

      expect(document.metadata.store, isNull);
      expect(document.metadata.documentNumber, '00123');
      expect(document.metadata.dateTime, DateTime(2026, 10, 24, 18, 41));
      expect(document.identity, isNull);
    },
  );

  for (final number in ['20,00', '20.00', '12.345,67', 'ABC']) {
    test('decimal or nonnumeric token $number is not a document ID', () {
      final document = _document([
        ..._header(number: number),
        'ELMA 20,00',
        'TOPLAM 20,00',
      ]);

      expect(document.metadata.documentNumber, isNull);
      expect(document.identity, isNull);
    });
  }

  test('invalid calendar date or clock does not roll into another day', () {
    for (final stamp in [
      '31.02.2026 18:41',
      '24.10.2026 25:41',
      '24.10.2026 18:41:99',
    ]) {
      final document = _document([
        'ŞOK MARKET',
        stamp,
        'BELGE NO: 123',
        'ELMA 20,00',
      ]);
      expect(document.metadata.dateTime, isNull);
    }
  });

  test(
    'tax, subtotal, and conflicting totals cannot masquerade as final total',
    () {
      for (final tail in [
        ['ARA TOPLAM 20,00', 'TOPLAM KDV 2,00'],
        ['TOPLAM 20,00', 'GENEL TOPLAM 21,00'],
      ]) {
        final document = _document([..._header(), 'ELMA 20,00', ...tail]);
        expect(document.metadata.totalMinor, isNull);
        expect(document.state, ReceiptDocumentState.incompleteTail);
      }
    },
  );

  test(
    'long receipt joins adjacent product overlap without mutating first part',
    () {
      final first = _document([
        ..._header(),
        'ELMA 20,00',
        'EKMEK 40,00',
        'SÜT 30,00',
      ]);
      final result = first.append(
        _scan(['EKMEK 40,00', 'SÜT 30,00', 'POŞET 1,00', 'TOPLAM 91,00 TL']),
      );

      final appended = result as ReceiptAppended;
      expect(appended.overlapLines, 2);
      expect(appended.document.productLines.map((line) => line.name), [
        'ELMA',
        'EKMEK',
        'SÜT',
        'POŞET',
      ]);
      expect(appended.document.state, ReceiptDocumentState.complete);
      expect(appended.document.fragments, hasLength(2));
      expect(first.fragments, hasLength(1));
      expect(first.metadata.totalMinor, isNull);
    },
  );

  test('equal product purchases remain repeated inside an ordered overlap', () {
    final first = _document([
      ..._header(),
      'ELMA 20,00',
      'EKMEK 10,00',
      'EKMEK 10,00',
      'SÜT 30,00',
    ]);
    final result = first.append(
      _scan(['EKMEK 10,00', 'SÜT 30,00', 'POŞET 1,00', 'TOPLAM 71,00']),
    ) as ReceiptAppended;

    expect(
      result.document.productLines.where((l) => l.name == 'EKMEK'),
      hasLength(2),
    );
    expect(result.document.productLines, hasLength(5));
  });

  test(
    'repeated-only ambiguous overlap is refused without losing a purchase',
    () {
      final first = _document([..._header(), 'EKMEK 10,00', 'EKMEK 10,00']);
      final result = first.append(
        _scan(['EKMEK 10,00', 'EKMEK 10,00', 'POŞET 1,00']),
      ) as ReceiptAppendRejected;

      expect(result.error, ReceiptAppendError.noOverlap);
      expect(first.productLines, hasLength(2));
    },
  );

  test('same amounts and nonadjacent products do not establish overlap', () {
    final first = _document([..._header(), 'ELMA 20,00', 'EKMEK 10,00']);
    for (final lines in [
      ['ARMUT 10,00', 'POŞET 1,00'],
      ['ELMA 20,00', 'POŞET 1,00'],
    ]) {
      final result = first.append(_scan(lines)) as ReceiptAppendRejected;
      expect(result.error, ReceiptAppendError.noOverlap);
    }
  });

  test(
    'another merchant or document cannot join even with identical products',
    () {
      final first = _document([..._header(), 'ELMA 20,00']);
      for (final header in [
        _header(store: 'ŞOK MARKET'),
        _header(number: '000124'),
      ]) {
        final result = first.append(
          _scan([...header, 'ELMA 20,00', 'TOPLAM 20,00']),
        ) as ReceiptAppendRejected;
        expect(result.error, ReceiptAppendError.conflictingDocument);
      }
    },
  );

  test('identity follows strong metadata, not equal basket or total', () {
    ReceiptDocument receipt({
      String store = 'A101 MARKET',
      String number = '000123',
    }) => _document([
      ..._header(store: store, number: number),
      'ELMA 20,00',
      'TOPLAM 20,00',
    ]);

    expect(receipt().identity, receipt(store: 'a101 market').identity);
    expect(receipt().identity, isNot(receipt(store: 'ŞOK MARKET').identity));
    expect(receipt().identity, isNot(receipt(number: '000124').identity));
    expect(_document(['ELMA 20,00', 'TOPLAM 20,00']).identity, isNull);
  });

  test('explicit different currency is preserved and cannot join original', () {
    final first = _document([..._header(), 'ELMA 20,00 TL']);
    final result =
        first.append(_scan(['ELMA 20,00 EUR'])) as ReceiptAppendRejected;

    expect(result.error, ReceiptAppendError.conflictingDocument);
    expect(
      _document([..._header(), 'ELMA 20,00 EUR']).metadata.currencyCode,
      'EUR',
    );
    expect(_document([..._header(), '20,00 TL 20,00 EUR']).identity, isNull);
  });

  test('currency-free header adopts EUR evidence from a photographed tail', () {
    final tail = _document([
      'EKMEK 40,00 EUR',
      'SÜT 30,00 EUR',
      'TOPLAM 90,00 EUR',
    ]);
    expect(tail.metadata.currencyCode, 'EUR');

    final joined = tail.prepend(
      _scan([..._header(), 'ELMA 20,00', 'EKMEK 40,00']),
    ) as ReceiptAppended;
    final restored = ReceiptDocument.decode(joined.document.encode());

    expect(restored.state, ReceiptDocumentState.complete);
    expect(restored.metadata.currencyCode, 'EUR');
    expect(restored.metadata.totalMinor, 9000);
    expect(restored.productLines.map((line) => line.name), [
      'ELMA',
      'EKMEK',
      'SÜT',
    ]);
    expect(restored.toParseResult().computedTotalMinor, 9000);
    expect(restored.toParseResult().withinReconciliationTolerance, isTrue);
  });

  test('normal append adopts EUR evidence from a photographed tail', () {
    final header = _document([..._header(), 'ELMA 20,00', 'EKMEK 40,00']);
    final joined = header.append(
      _scan(['EKMEK 40,00 EUR', 'SÜT 30,00 EUR', 'TOPLAM 90,00 EUR']),
    ) as ReceiptAppended;
    final restored = ReceiptDocument.decode(joined.document.encode());

    expect(restored.state, ReceiptDocumentState.complete);
    expect(restored.metadata.currencyCode, 'EUR');
    expect(restored.metadata.totalMinor, 9000);
    expect(restored.productLines.map((line) => line.name), [
      'ELMA',
      'EKMEK',
      'SÜT',
    ]);
    expect(restored.toParseResult().computedTotalMinor, 9000);
    expect(restored.toParseResult().withinReconciliationTolerance, isTrue);
  });

  test('explicit TRY header conflicts with EUR evidence on the tail', () {
    final tryHeader = _document([..._header(), 'ELMA 20,00 TRY']);
    expect(tryHeader.metadata.currencyCode, 'TRY');
    final result = tryHeader.append(
      _scan(['ELMA 20,00 EUR', 'TOPLAM 20,00 EUR']),
    ) as ReceiptAppendRejected;

    expect(result.error, ReceiptAppendError.conflictingDocument);
  });

  test('document owns immutable snapshots of caller OCR lists', () {
    final lines = [
      for (final text in [..._header(), 'ELMA 20,00']) OcrLine(text: text),
    ];
    final document = ReceiptDocument.fromScan(
      OcrScanResult(lines: lines),
      currencyCode: 'TRY',
    );
    lines.clear();

    expect(document.fragments.single.lines, isNotEmpty);
    expect(() => document.productLines.clear(), throwsUnsupportedError);
    expect(() => document.fragments.clear(), throwsUnsupportedError);
    expect(
      () => document.fragments.single.lines.clear(),
      throwsUnsupportedError,
    );
  });
}
