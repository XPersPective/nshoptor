import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';
import 'parsed_item_candidate.dart';

/// Deterministik yerel ses komut ayrıştırıcı (spec §6.7).
///
/// Kurallar (locale'e göre):
/// - Türkçe sayı sözcükleri: `bir buçuk`=1.5, `yarım`=0.5, `kırk beş`=45,
///   `otuz iki`=32, `yüz`=100.
/// - İngilizce: `one and a half`=1.5, `half`=0.5, `forty five`=45.
/// - Birimler: kilo/kilogram, gram, litre, mililitre, paket, kutu, şişe,
///   kavanoz, demet, düzine, tane/adet, metre; en karşılıkları.
/// - Birim fiyat kalıpları: `kilosu kırk beş lira`, `tanesi otuz iki lira`
///   (tr iyelik + sayı + para birimi) ve `three euros per kilo` (en `per`).
/// - Para birimi: lira/tl→TRY, euro/avro→EUR, dolar→USD.
/// - Dolgu fiilleri (`ekle`, `add`, `at`, ...) addan çıkarılır.
/// - Sayı/birim/fiyat dışındaki tüm sözcükler ad olarak KORUNUR — tanınmayan
///   cümle veri kaybı olmadan manuel forma aktarılır.
class VoiceCommandParser {
  const VoiceCommandParser({required this.localeCode});

  /// `tr` veya `en`; desteklenmeyen locale en kurallarıyla düşer.
  final String localeCode;

  bool get _isTr => localeCode.toLowerCase().startsWith('tr');

  static const Map<String, int> _trOnes = {
    'bir': 1, 'iki': 2, 'üç': 3, 'dört': 4, 'beş': 5, 'altı': 6,
    'yedi': 7, 'sekiz': 8, 'dokuz': 9,
  };
  static const Map<String, int> _trTens = {
    'on': 10, 'yirmi': 20, 'otuz': 30, 'kırk': 40, 'elli': 50,
    'altmış': 60, 'yetmiş': 70, 'seksen': 80, 'doksan': 90,
  };
  static const Map<String, int> _enOnes = {
    'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6,
    'seven': 7, 'eight': 8, 'nine': 9, 'ten': 10, 'eleven': 11,
    'twelve': 12,
  };
  static const Map<String, int> _enTens = {
    'twenty': 20, 'thirty': 30, 'forty': 40, 'fifty': 50,
    'sixty': 60, 'seventy': 70, 'eighty': 80, 'ninety': 90,
  };

  static const Map<String, UnitCode> _trUnits = {
    'kilo': UnitCode.kilogram,
    'kilogram': UnitCode.kilogram,
    'gram': UnitCode.gram,
    'litre': UnitCode.litre,
    'mililitre': UnitCode.mililitre,
    'paket': UnitCode.paket,
    'kutu': UnitCode.kutu,
    'şişe': UnitCode.sise,
    'kavanoz': UnitCode.kavanoz,
    'demet': UnitCode.demet,
    'düzine': UnitCode.duzine,
    'tane': UnitCode.adet,
    'adet': UnitCode.adet,
    'metre': UnitCode.metre,
  };

  static const Map<String, UnitCode> _enUnits = {
    'kilo': UnitCode.kilogram,
    'kilos': UnitCode.kilogram,
    'kilogram': UnitCode.kilogram,
    'kilograms': UnitCode.kilogram,
    'gram': UnitCode.gram,
    'grams': UnitCode.gram,
    'litre': UnitCode.litre,
    'litres': UnitCode.litre,
    'liter': UnitCode.litre,
    'liters': UnitCode.litre,
    'millilitre': UnitCode.mililitre,
    'pack': UnitCode.paket,
    'packs': UnitCode.paket,
    'box': UnitCode.kutu,
    'bottle': UnitCode.sise,
    'bottles': UnitCode.sise,
    'jar': UnitCode.kavanoz,
    'jars': UnitCode.kavanoz,
    'bunch': UnitCode.demet,
    'dozen': UnitCode.duzine,
    'piece': UnitCode.adet,
    'pieces': UnitCode.adet,
    'meter': UnitCode.metre,
    'meters': UnitCode.metre,
  };

  ParsedItemCandidate parse(String text) {
    final raw = text.trim();
    var tokens = raw
        .toLowerCase()
        .split(RegExp(r'[\s,;]+'))
        .where((t) => t.isNotEmpty)
        .toList();

    // BAŞTAKİ dolgu fiilleri önce atılır ("add three bottles", "ekle iki paket").
    final leadFillers = _isTr
        ? {'ekle', 'al', 'istiyorum', 'lazım'}
        : {'add', 'buy', 'please'};
    while (tokens.isNotEmpty && leadFillers.contains(tokens.first)) {
      tokens = tokens.sublist(1);
    }

    DecimalFixed? quantity;
    UnitCode? unit;
    DecimalFixed? unitPrice;
    String? currency;
    var isUnitPrice = false;

    // 1) BAŞTAKİ miktar (+ buçuk / and a half / yarım / half a) ve birim.
    final lead = _consumeLeadingQuantity(tokens);
    if (lead != null) {
      quantity = lead.$1;
      tokens = lead.$2;
      final unitTake = _consumeUnit(tokens);
      if (unitTake != null) {
        unit = unitTake.$1;
        tokens = unitTake.$2;
      }
    }

    // 2) BİTTEKİ birim fiyat kalıbı.
    final price = _consumeTrailingUnitPrice(tokens);
    if (price != null) {
      unitPrice = price.$1;
      currency = price.$2;
      isUnitPrice = true;
      tokens = price.$3;
    }

    // 3) Dolgu sözcükleri çıkar.
    final fillers = _isTr
        ? {'ekle', 'al', 'istiyorum', 'lazım'}
        : {'add', 'buy', 'at', 'please', 'of'};
    tokens = tokens.where((t) => !fillers.contains(t)).toList();

    final name = _stripPunctuation(tokens.join(' ')).trim();
    final cleanName = name.isEmpty ? _stripPunctuation(raw) : name;

    return ParsedItemCandidate(
      name: cleanName,
      rawText: raw,
      quantity: quantity,
      unitCode: unit,
      unitPrice: unitPrice,
      currencyCode: currency,
      isUnitPrice: isUnitPrice ? true : null,
    );
  }

  // ---- miktar ----

  (DecimalFixed, List<String>)? _consumeLeadingQuantity(List<String> tokens) {
    if (tokens.isEmpty) return null;

    final digit = int.tryParse(tokens.first);
    if (digit != null) {
      return (DecimalFixed.fromInt(digit), tokens.sublist(1));
    }

    if (_isTr && tokens.first == 'yarım') {
      return (DecimalFixed.parse('0.5'), tokens.sublist(1));
    }

    if (_isTr) {
      final take = _takeNumberFromStart(tokens, _trOnes, _trTens, 'yüz');
      if (take != null) {
        var value = take.$1;
        var rest = take.$2;
        if (rest.isNotEmpty && rest.first == 'buçuk') {
          value = value + DecimalFixed.parse('0.5');
          rest = rest.sublist(1);
        }
        return (value, rest);
      }
      return null;
    }

    // en
    final take = _takeNumberFromStart(tokens, _enOnes, _enTens, 'hundred');
    if (take != null) {
      var value = take.$1;
      var rest = take.$2;
      if (rest.length >= 2 && rest[0] == 'and' && rest[1] == 'a' &&
          rest.length > 2 &&
          rest[2] == 'half') {
        value = value + DecimalFixed.parse('0.5');
        rest = rest.sublist(3);
      }
      return (value, rest);
    }
    if (tokens.first == 'half') {
      var rest = tokens.sublist(1);
      if (rest.isNotEmpty && (rest.first == 'a' || rest.first == 'an')) {
        rest = rest.sublist(1);
      }
      return (DecimalFixed.parse('0.5'), rest);
    }
    return null;
  }

  /// Baştan sayı okur: onlar+birler (ör. kırk beş=45), yüz de destekli.
  (DecimalFixed, List<String>)? _takeNumberFromStart(
    List<String> tokens,
    Map<String, int> ones,
    Map<String, int> tens,
    String hundredWord,
  ) {
    if (tokens.isEmpty) return null;
    if (tens.containsKey(tokens.first)) {
      var value = DecimalFixed.fromInt(tens[tokens.first]!);
      var consumed = 1;
      if (tokens.length > 1 && ones.containsKey(tokens[1])) {
        value = value + DecimalFixed.fromInt(ones[tokens[1]]!);
        consumed = 2;
      }
      return (value, tokens.sublist(consumed));
    }
    if (ones.containsKey(tokens.first)) {
      var value = DecimalFixed.fromInt(ones[tokens.first]!);
      var consumed = 1;
      if (tokens.length > 1 && tokens[1] == hundredWord) {
        value = value * DecimalFixed.fromInt(100);
        consumed = 2;
      }
      return (value, tokens.sublist(consumed));
    }
    if (tokens.first == hundredWord) {
      return (DecimalFixed.fromInt(100), tokens.sublist(1));
    }
    return null;
  }

  // ---- birim ----

  (UnitCode, List<String>)? _consumeUnit(List<String> tokens) {
    if (tokens.isEmpty) return null;
    final map = _isTr ? _trUnits : _enUnits;
    final unit = map[tokens.first];
    if (unit != null) {
      var rest = tokens.sublist(1);
      if (!_isTr && rest.isNotEmpty && rest.first == 'of') {
        rest = rest.sublist(1);
      }
      return (unit, rest);
    }
    return null;
  }

  // ---- birim fiyat ----

  /// tr: `... kilosu kırk beş lira` → iyelikli birim + sayı(lar) + para.
  /// en: `... three euros per kilo` → sayı + para + `per` + birim.
  /// Belirsiz fiyatta değer null döner (kullanıcı doldurur); ad korunur.
  (DecimalFixed?, String, List<String>)? _consumeTrailingUnitPrice(
      List<String> tokens) {
    for (var i = 0; i < tokens.length; i++) {
      final token = tokens[i];

      if (_isTr) {
        final stem = _trPossessiveStem(token);
        if (stem == null || !_trUnits.containsKey(stem)) continue;
        final after = tokens.sublist(i + 1);
        if (after.isEmpty || _trCurrency(after.last) == null) {
          // Birim fiyat niyeti var ama sayı/para yok → belirsiz.
          return (null, 'TRY', _withoutAt(tokens, i));
        }
        final numberTake = _takeNumberFromStart(
          after.sublist(0, after.length - 1),
          _trOnes,
          _trTens,
          'yüz',
        );
        if (numberTake == null || numberTake.$2.isNotEmpty) {
          return (null, 'TRY', _withoutAt(tokens, i));
        }
        final rest = [...tokens.sublist(0, i), ...numberTake.$2];
        return (numberTake.$1, _trCurrency(after.last)!, rest);
      }

      if (!_isTr && token == 'per' && i >= 2 && i + 1 < tokens.length) {
        final unit = _enUnits[tokens[i + 1]];
        final currency = _enCurrency(tokens[i - 1]);
        if (unit == null || currency == null) continue;
        // sayı sözcükleri para biriminin solunda bitişik olmalı
        var start = i - 1;
        while (start > 0 &&
            (_enOnes.containsKey(tokens[start - 1]) ||
                _enTens.containsKey(tokens[start - 1]))) {
          start--;
        }
        if (start == i - 1) continue; // sayı yok → bu kalıp değil
        final numberTake = _takeNumberFromStart(
          tokens.sublist(start, i - 1),
          _enOnes,
          _enTens,
          'hundred',
        );
        if (numberTake == null) continue;
        final rest = [...tokens.sublist(0, start), ...tokens.sublist(i + 2)];
        return (numberTake.$1, currency, rest);
      }
    }
    return null;
  }

  /// [index]teki sözcüğü çıkarır.
  List<String> _withoutAt(List<String> tokens, int index) =>
      [...tokens.sublist(0, index), ...tokens.sublist(index + 1)];

  /// "kilosu"→"kilo", "tanesi"→"tane", "litresi"→"litre" ...
  String? _trPossessiveStem(String word) {
    const suffixes = ['sı', 'si', 'su', 'sü'];
    for (final suffix in suffixes) {
      if (word.length > suffix.length && word.endsWith(suffix)) {
        return word.substring(0, word.length - suffix.length);
      }
    }
    return null;
  }

  String? _trCurrency(String word) {
    switch (word) {
      case 'lira':
      case 'tl':
      case '₺':
        return 'TRY';
      case 'euro':
      case 'avro':
        return 'EUR';
      case 'dolar':
      case 'dollar':
        return 'USD';
    }
    return null;
  }

  String? _enCurrency(String word) {
    switch (word) {
      case 'euro':
      case 'euros':
        return 'EUR';
      case 'dollar':
      case 'dollars':
        return 'USD';
      case 'lira':
        return 'TRY';
    }
    return null;
  }

  String _stripPunctuation(String text) =>
      text.replaceAll(RegExp(r'[.,;:!?]+$'), '').trim();
}
