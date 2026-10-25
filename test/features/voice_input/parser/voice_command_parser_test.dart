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

  group('v2 natural prices use selected-quantity totals', () {
    const tr = VoiceCommandParser(localeCode: 'tr');
    const en = VoiceCommandParser(localeCode: 'en');
    test('400g kıyma 350 TL is a total; kg basis is explicit only', () {
      final total = tr.parse('400g kıyma 350 TL');
      expect(total.name, 'kıyma');
      expect(total.quantity!.toDbString(), '400');
      expect(total.unitCode, UnitCode.gram);
      expect(total.unitPrice!.toDbString(), '350');
      expect(total.isUnitPrice, false);
      expect(total.priceUnitCode, null);
      final kilo = tr.parse('400 gram kıyma kilosu 875 TL');
      expect(kilo.quantity!.toDbString(), '400');
      expect(kilo.unitCode, UnitCode.gram);
      expect(kilo.unitPrice!.toDbString(), '875');
      expect(kilo.isUnitPrice, true);
      expect(kilo.priceUnitCode, UnitCode.kilogram);
    });
    test('two packages default total, tanesi keeps product packaging basis', () {
      final total = tr.parse('İki paket sigara 260 TL');
      expect(total.isUnitPrice, false);
      expect(total.requiresPriceConfirmation, false);
      final unit = tr.parse('İki paket sigara tanesi 130 TL');
      expect(unit.isUnitPrice, true);
      expect(unit.priceUnitCode, UnitCode.paket);
      final contradictory = tr.parse('İki paket sigara toplam tanesi 130 TL');
      expect(contradictory.name, 'sigara');
      expect(contradictory.requiresPriceConfirmation, true);
    });
    test('English per kilo, each, and plain totals preserve their basis', () {
      final kilo = en.parse('400 grams mince 875 euros per kilo');
      expect(kilo.name, 'mince');
      expect(kilo.unitCode, UnitCode.gram);
      expect(kilo.priceUnitCode, UnitCode.kilogram);
      expect(kilo.isUnitPrice, true);
      final beforeAmount = en.parse('400 grams mince per kilo 875 euros');
      expect(beforeAmount.priceUnitCode, UnitCode.kilogram);
      expect(beforeAmount.unitPrice!.toDbString(), '875');
      final each = en.parse('two packs cigarettes 130 euros each');
      expect(each.priceUnitCode, UnitCode.paket);
      expect(each.isUnitPrice, true);
      final total = en.parse('two packs cigarettes 260 euros');
      expect(total.isUnitPrice, false);
    });
  });

  group('birden çok ürün (bölme)', () {
    final tr = VoiceCommandParser(localeCode: 'tr');

    test('"1 kilo elma 1 ekmek" iki ürün: elma 1 kg, ekmek 1 adet', () {
      expect(tr.splitItems('1 kilo elma 1 ekmek'), ['1 kilo elma', '1 ekmek']);
      final apple = tr.parse('1 kilo elma');
      expect(apple.name, 'elma');
      expect(apple.quantity!.toDbString(), '1');
      expect(apple.unitCode, UnitCode.kilogram);
      final bread = tr.parse('1 ekmek');
      expect(bread.name, 'ekmek');
      expect(bread.quantity!.toDbString(), '1');
      expect(bread.unitCode, UnitCode.adet);
    });

    test('fiyat ve cümle sonundaki birim bölünmez', () {
      expect(tr.splitItems('1 kilo elma kilosu 40 lira'), ['1 kilo elma kilosu 40 lira']);
      expect(tr.splitItems('elma 20 lira'), ['elma 20 lira']);
      expect(tr.splitItems('süt 1 litre'), ['süt 1 litre']);
      expect(tr.splitItems('Coca Cola 2 litre'), ['Coca Cola 2 litre']);
    });

    test('fiyattan sonra gelen yeni ürün ayrılır', () {
      expect(tr.splitItems('elma 20 lira 2 ekmek'), ['elma 20 lira', '2 ekmek']);
      expect(tr.splitItems('1 kilo elma 2 kilo domates'), ['1 kilo elma', '2 kilo domates']);
    });
  });

  group('natural Turkish price continuation and spoken commands', () {
    const tr = VoiceCommandParser(localeCode: 'tr');

    test('user utterance keeps two products and consistent unit/total prices', () {
      final parts = tr.splitItems(
        'Bir kilo elma 20 lira, iki ekmek, bir tanesi 20 TL '
        'toplamda 40 TL diyelim, bu kadar, listeye dönüştür',
      );
      final items = parts.map(tr.parse).toList();
      expect(items.map((item) => item.name), ['elma', 'ekmek']);
      expect(items[0].quantity!.toDbString(), '1');
      expect(items[0].unitCode, UnitCode.kilogram);
      expect(items[0].unitPrice!.toDbString(), '20');
      expect(items[0].isUnitPrice, false);
      expect(items[1].quantity!.toDbString(), '2');
      expect(items[1].unitCode, UnitCode.adet);
      expect(items[1].unitPrice!.toDbString(), '20');
      expect(items[1].priceUnitCode, UnitCode.adet);
      expect(items[1].isUnitPrice, true);
      expect((items[1].quantity! * items[1].unitPrice!).toDbString(), '40');
      expect(items.every((item) => item.currencyCode == 'TRY'), true);
    });

    test('same price continuation works for other products and decimal values', () {
      final items = tr.splitItems(
        'üç paket makarna; paketi 12,50 TL toplamda 37,50 TL diyelim',
      ).map(tr.parse).toList();
      expect(items, hasLength(1));
      expect(items.single.name, 'makarna');
      expect(items.single.unitCode, UnitCode.paket);
      expect(items.single.priceUnitCode, UnitCode.paket);
      expect(items.single.isUnitPrice, true);
      expect(items.single.unitPrice!.toDbString(), '12.50');
      expect((items.single.quantity! * items.single.unitPrice!).toDbString(), '37.50');
    });

    test('contradictory unit/total evidence requires confirmation', () {
      final c = tr.parse('iki ekmek bir tanesi 20 TL toplamda 45 TL');
      expect(c.name, 'ekmek');
      expect(c.unitPrice!.toDbString(), '20');
      expect(c.requiresPriceConfirmation, true);
      expect(c.rawText, contains('45 TL'));
    });

    test('different currency or incompatible quantity basis is not reconciled', () {
      for (final raw in [
        'iki ekmek tanesi 20 TL toplamda 40 euro',
        '400 gram peynir kilosu 20 TL toplamda 8000 TL',
      ]) {
        expect(tr.parse(raw).requiresPriceConfirmation, true, reason: raw);
      }
    });

    test('price cue words without amounts do not merge distinct products', () {
      for (final name in [
        'ikisi bir arada kahve',
        'toplam karışık kuruyemiş',
        'birim ambalaj',
        'ikisi bir arada kahve 50 TL',
      ]) {
        final parts = tr.splitItems('iki ekmek, $name');
        expect(parts, ['iki ekmek', name], reason: name);
      }
      final items = tr.splitItems('iki ekmek, ikisi bir arada kahve')
          .map(tr.parse).toList();
      expect(items.map((item) => item.name),
          ['ekmek', 'ikisi bir arada kahve']);
    });

    test('valid total-only and unit-only clauses still attach to prior item', () {
      expect(tr.splitItems('iki ekmek, ikisi 40 TL'),
          ['iki ekmek ikisi 40 TL']);
      expect(tr.splitItems('iki ekmek, bir tanesi 20 TL'),
          ['iki ekmek bir tanesi 20 TL']);
      expect(tr.splitItems('iki ekmek, birim fiyatı 20 TL'),
          ['iki ekmek birim fiyatı 20 TL']);
    });

    test('matching arithmetic never changes piece price into weight price', () {
      for (final cue in ['tanesi', 'adedi']) {
        final c = tr.parse('iki kilo elma $cue 20 TL toplamda 40 TL');
        expect(c.name, 'elma');
        expect(c.unitCode, UnitCode.kilogram);
        expect(c.priceUnitCode, UnitCode.adet);
        expect(c.requiresPriceConfirmation, true, reason: cue);
      }
    });

    test('counted package unit and total can still corroborate each other', () {
      final c = tr.parse('iki paket makarna tanesi 20 TL toplamda 40 TL');
      expect(c.name, 'makarna');
      expect(c.unitCode, UnitCode.paket);
      expect(c.priceUnitCode, UnitCode.paket);
      expect(c.isUnitPrice, true);
      expect(c.requiresPriceConfirmation, false);
    });

    test('single piece price never inherits weight volume or length units', () {
      for (final raw in [
        'iki kilo elma tanesi 20 TL',
        '400 gram peynir adedi 20 TL',
        'iki litre süt tanesi 20 TL',
        '500 mililitre yağ adedi 20 TL',
        'iki metre kumaş tanesi 20 TL',
      ]) {
        final c = tr.parse(raw);
        expect(c.unitPrice!.toDbString(), '20', reason: raw);
        expect(c.priceUnitCode, UnitCode.adet, reason: raw);
        expect(c.requiresPriceConfirmation, true, reason: raw);
        expect(c.rawText, raw);
      }
    });

    test('single counted package price and explicit kg basis stay certain', () {
      final package = tr.parse('iki paket makarna tanesi 130 TL');
      expect(package.name, 'makarna');
      expect(package.priceUnitCode, UnitCode.paket);
      expect(package.isUnitPrice, true);
      expect(package.requiresPriceConfirmation, false);
      final weight = tr.parse('400 gram elma kilosu 20 TL');
      expect(weight.priceUnitCode, UnitCode.kilogram);
      expect(weight.isUnitPrice, true);
      expect(weight.requiresPriceConfirmation, false);
    });

    test('English each also preserves piece versus measured-unit conflict', () {
      const en = VoiceCommandParser(localeCode: 'en');
      final weight = en.parse('two kilos apples 20 euros each');
      expect(weight.priceUnitCode, UnitCode.adet);
      expect(weight.requiresPriceConfirmation, true);
      final package = en.parse('two packs pasta 20 euros each');
      expect(package.priceUnitCode, UnitCode.paket);
      expect(package.isUnitPrice, true);
      expect(package.requiresPriceConfirmation, false);
    });

    test('speech controls and currency-only clauses do not create products', () {
      expect(tr.splitItems('bu kadar, listeye dönüştür'), isEmpty);
      expect(tr.splitItems('iki ekmek, TL, bu kadar'), ['iki ekmek']);
      expect(tr.parse('listeye dönüştür').name, isEmpty);
      expect(tr.parse('TL').name, isEmpty);
      expect(tr.parse('bir kilo').name, isEmpty);
    });

    test('filler removal preserves product names and unrecognized content', () {
      final items = tr.splitItems('iki ekmek, Dönüş çikolata, kadar baharat')
          .map(tr.parse).toList();
      expect(items.map((item) => item.name),
          ['ekmek', 'dönüş çikolata', 'kadar baharat']);
      expect(tr.parse('hafta sonu misafir geliyor').name,
          'hafta sonu misafir geliyor');
    });

    test('trailing command does not erase the preceding product', () {
      final items = tr.splitItems('iki ekmek yirmi lira bu kadar listeye dönüştür')
          .map(tr.parse).toList();
      expect(items, hasLength(1));
      expect(items.single.name, 'ekmek');
      expect(items.single.unitPrice!.toDbString(), '20');
      expect(items.single.isUnitPrice, false);
    });
  });

  group('satır tahmini (sondaki para)', () {
    final tr = VoiceCommandParser(localeCode: 'tr');

    test('"1 kilo domates 20 TL": isim domates, tahmin 20 TRY, birim fiyat değil', () {
      final c = tr.parse('1 kilo domates 20 TL');
      expect(c.name, 'domates');
      expect(c.quantity!.toDbString(), '1');
      expect(c.unitCode, UnitCode.kilogram);
      expect(c.unitPrice!.toDbString(), '20');
      expect(c.currencyCode, 'TRY');
      expect(c.isUnitPrice, isFalse);
    });

    test('birim fiyat kalıbı (kilosu 40 lira) hâlâ birim fiyat', () {
      final c = tr.parse('1 kilo elma kilosu 40 lira');
      expect(c.name, 'elma');
      expect(c.isUnitPrice, isTrue);
    });

    test('"elma 20 lira 2 ekmek": iki ürün, ilkinin tahmini 20', () {
      final parts = tr.splitItems('elma 20 lira 2 ekmek');
      expect(parts, ['elma 20 lira', '2 ekmek']);
      expect(tr.parse(parts.first).name, 'elma');
      expect(tr.parse(parts.first).unitPrice!.toDbString(), '20');
    });
  });
}
