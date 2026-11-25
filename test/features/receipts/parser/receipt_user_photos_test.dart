import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';

OcrScanResult scan(List<String> lines) => OcrScanResult(
      lines: [for (final text in lines) OcrLine(text: text)],
    );

void main() {
  late ReceiptParser parser;

  setUp(() => parser = ReceiptParser());

  group('kullanıcı fiş fotoğrafları', () {
    test('ŞOK: tartılı ürün, kampanya indirimi ve yıldızlı tutarlar', () {
      final result = parser.parse(scan([
        'ŞOK MARKETLER TİC.A.Ş',
        '13462 MAMAK GAMZE ÖZDEMİR',
        'ŞAHİNTEPE MH 637.SK',
        'NO 2',
        'MAMAK ANKARA',
        '8140131899',
        'ANADOLU KURUMLAR V.D',
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
      ]));

      expect(result.totalMinor, 42742);
      expect(result.taxMinor, 4660);
      expect(result.discountMinor, 35250);
      expect(result.computedTotalMinor, 42742);
      expect(result.withinReconciliationTolerance, isTrue);
      expect(result.lines, hasLength(8));
      final baget = result.lines.firstWhere((l) => l.name.contains('BAGET'));
      expect(baget.lineTotalMinor, 10227);
      expect(
        result.lines.where((l) => l.name.contains('FINISH')),
        hasLength(2),
      );
    });

    test('ÖRNEK İŞLETME: adet satırları ve para üstü toplamı etkilemez', () {
      final result = parser.parse(scan([
        'ÖRNEK İŞLETME',
        'DEMİRCİKARA MAH. 1431 SOK. NO:12',
        '0242 311 41 21',
        'ANTALYA',
        'TARİH : 07.05.2019 SAAT : 12:30',
        'SATIŞ NO : 2 SATIŞ : NAKİT',
        'KASİYER : AHMET',
        '69236555 (1 ADET X 15,00)',
        'ÖRNEK ÜRÜN 1 15,00',
        '48640991 (1 ADET X 5,75)',
        'ÖRNEK ÜRÜN 2 5,75',
        '8691573002575 (2 ADET X 12,00)',
        'ÖRNEK ÜRÜN 3 24,00',
        '8691728000108 (1 ADET X 19,95)',
        'ÖRNEK ÜRÜN 4 19,95',
        '8693891805254 (3 ADET X 8,50)',
        'ÖRNEK ÜRÜN 5 25,50',
        'ALINAN PARA 100,00',
        'PARA ÜSTÜ 9,80',
        'GENEL TOPLAM 90,20',
        'KDV FİŞİ DEĞİLDİR',
      ]));

      expect(result.totalMinor, 9020);
      expect(result.lines, hasLength(5));
      expect(result.computedTotalMinor, 9020);
      expect(result.withinReconciliationTolerance, isTrue);
      expect(
        result.lines.map((l) => l.lineTotalMinor),
        [1500, 575, 2400, 1995, 2550],
      );
    });
  });
}
