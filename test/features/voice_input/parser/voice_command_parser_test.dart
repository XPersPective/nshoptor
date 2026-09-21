import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/features/voice_input/parser/voice_command_parser.dart';

void main() {
  group('spec §6.7 örnek cümleleri — Türkçe', () {
    final parser = VoiceCommandParser(localeCode: 'tr');

    test('"Bir buçuk kilo domates, kilosu kırk beş lira"', () {
      final c = parser.parse('Bir buçuk kilo domates, kilosu kırk beş lira');
      expect(c.name, 'domates');
      expect(c.quantity!.toDbString(), '1.5');
      expect(c.unitCode, UnitCode.kilogram);
      expect(c.unitPrice!.toDbString(), '45');
      expect(c.currencyCode, 'TRY');
      expect(c.isUnitPrice, isTrue);
    });

    test('"Üç tane süt, tanesi otuz iki lira"', () {
      final c = parser.parse('Üç tane süt, tanesi otuz iki lira');
      expect(c.name, 'süt');
      expect(c.quantity!.toDbString(), '3');
      expect(c.unitCode, UnitCode.adet);
      expect(c.unitPrice!.toDbString(), '32');
      expect(c.currencyCode, 'TRY');
    });

    test('"İki paket makarna ekle" — fiyatsız', () {
      final c = parser.parse('İki paket makarna ekle');
      expect(c.name, 'makarna');
      expect(c.quantity!.toDbString(), '2');
      expect(c.unitCode, UnitCode.paket);
      expect(c.unitPrice, isNull);
      expect(c.fullyParsed, isTrue);
    });

    test('"Yarım kilo elma"', () {
      final c = parser.parse('Yarım kilo elma');
      expect(c.name, 'elma');
      expect(c.quantity!.toDbString(), '0.5');
      expect(c.unitCode, UnitCode.kilogram);
    });
  });

  group('spec §6.7 örnek cümleleri — İngilizce', () {
    final parser = VoiceCommandParser(localeCode: 'en');

    test('"Add one and a half kilograms of tomatoes at three euros per kilo"',
        () {
      final c = parser.parse(
          'Add one and a half kilograms of tomatoes at three euros per kilo');
      expect(c.name, 'tomatoes');
      expect(c.quantity!.toDbString(), '1.5');
      expect(c.unitCode, UnitCode.kilogram);
      expect(c.unitPrice!.toDbString(), '3');
      expect(c.currencyCode, 'EUR');
      expect(c.isUnitPrice, isTrue);
    });

    test('"Add three bottles of milk"', () {
      final c = parser.parse('Add three bottles of milk');
      expect(c.name, 'milk');
      expect(c.quantity!.toDbString(), '3');
      expect(c.unitCode, UnitCode.sise);
      expect(c.unitPrice, isNull);
    });

    test('"Two packs of pasta"', () {
      final c = parser.parse('Two packs of pasta');
      expect(c.name, 'pasta');
      expect(c.quantity!.toDbString(), '2');
      expect(c.unitCode, UnitCode.paket);
    });
  });

  group('belirsizlik ve fallback (spec §6.7)', () {
    final tr = VoiceCommandParser(localeCode: 'tr');

    test('belirsiz fiyat: aday fiyatsız kurulur, kullanıcı doldurur', () {
      final c = tr.parse('Domates kilosu neyse');
      expect(c.name, contains('domates'));
      expect(c.unitPrice, isNull);
      // "kilosu" çıkarıldı ama fiyat bulunamadı → aday boş fiyatla
      expect(c.rawText, contains('kilosu'));
    });

    test('tanınmayan cümle: veri kaybı yok, tüm metin ad olarak korunur',
        () {
      final c = tr.parse('hafta sonu misafir geliyor');
      expect(c.name, 'hafta sonu misafir geliyor');
      expect(c.quantity, isNull);
      expect(c.unitCode, isNull);
      expect(c.unitPrice, isNull);
      expect(c.rawText, 'hafta sonu misafir geliyor');
    });

    test('dijital miktar da desteklenir', () {
      final c = tr.parse('3 adet süt');
      expect(c.quantity!.toDbString(), '3');
      expect(c.unitCode, UnitCode.adet);
      expect(c.name, 'süt');
    });

    test('en desteklenmeyen locale en kurallarıyla düşer', () {
      final de = VoiceCommandParser(localeCode: 'de');
      final c = de.parse('Add three bottles of milk');
      expect(c.quantity!.toDbString(), '3');
      expect(c.unitCode, UnitCode.sise);
    });
  });
}
