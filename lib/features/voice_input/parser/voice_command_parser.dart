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
    'bir': 1,
    'iki': 2,
    'üç': 3,
    'dört': 4,
    'beş': 5,
    'altı': 6,
    'yedi': 7,
    'sekiz': 8,
    'dokuz': 9,
  };
  static const Map<String, int> _trTens = {
    'on': 10,
    'yirmi': 20,
    'otuz': 30,
    'kırk': 40,
    'elli': 50,
    'altmış': 60,
    'yetmiş': 70,
    'seksen': 80,
    'doksan': 90,
  };
  static const Map<String, int> _enOnes = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
    'ten': 10,
    'eleven': 11,
    'twelve': 12,
  };
  static const Map<String, int> _enTens = {
    'twenty': 20,
    'thirty': 30,
    'forty': 40,
    'fifty': 50,
    'sixty': 60,
    'seventy': 70,
    'eighty': 80,
    'ninety': 90,
  };

  static const Map<String, UnitCode> _trUnits = {
    'kg': UnitCode.kilogram,
    'g': UnitCode.gram,
    'gr': UnitCode.gram,
    'l': UnitCode.litre,
    'lt': UnitCode.litre,
    'ml': UnitCode.mililitre,
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
    'kg': UnitCode.kilogram,
    'g': UnitCode.gram,
    'gr': UnitCode.gram,
    'l': UnitCode.litre,
    'lt': UnitCode.litre,
    'ml': UnitCode.mililitre,
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
    'item': UnitCode.adet,
    'unit': UnitCode.adet,
    'piece': UnitCode.adet,
    'pieces': UnitCode.adet,
    'meter': UnitCode.metre,
    'meters': UnitCode.metre,
  };

  ParsedItemCandidate parse(String text) {
    final raw = text.trim();
    var tokens = _withoutSpeechTail(raw)
        .replaceAll('İ', 'i')
        .toLowerCase()
        .replaceAllMapped(
          RegExp(r'(\d)(kg|gr|g|ml|lt|l|tl|try|eur|usd)\b'),
          (m) => '${m[1]} ${m[2]}',
        )
        .replaceAll(RegExp(r'[.!?]+$'), '')
        .split(RegExp(r'[\s;]+|(?<!\d),|,(?!\d)'))
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
    bool? isUnitPrice;
    UnitCode? priceUnit;

    final marketContext = RegExp(
      r'\b(market(?:te|ten)?|çarşı(?:da|dan)?|actual|store)\b',
    ).hasMatch(tokens.join(' '));
    tokens.removeWhere(
      (t) => const {
        'markette',
        'marketten',
        'market',
        'çarşı',
        'çarşıda',
        'çarşıdan',
        'actual',
        'store',
        'fiyatı',
        'fiyati',
        'fiyat',
        'price',
      }.contains(t),
    );

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

    // 2) BİTTEKİ birim fiyat kalıbı; yoksa satır tahmini ("1 kilo domates 20 TL").
    final priceContext = tokens.join(' ');
    final totalCue = RegExp(
      r'\b(toplam|toplamda|ikisi|hepsi|total|altogether)\b',
    ).hasMatch(priceContext);
    final explicitUnitCue = tokens.any(
      (t) =>
          const {'birim', 'each', 'per'}.contains(t) ||
          _trUnits.containsKey(_trPossessiveStem(t)),
    );
    final pair = _consumeUnitAndTotal(tokens, quantity, unit);
    final price = pair == null ? _consumeTrailingUnitPrice(tokens, unit) : null;
    if (pair != null) {
      unitPrice = pair.$1;
      currency = pair.$2;
      tokens = pair.$3;
      priceUnit = pair.$4;
      isUnitPrice = pair.$5;
    } else if (price != null) {
      unitPrice = price.$1;
      currency = price.$2;
      final pieceBasisConflict =
          price.$4 == UnitCode.adet && unit != null && unit != UnitCode.adet;
      isUnitPrice = totalCue && explicitUnitCue || pieceBasisConflict
          ? null
          : true;
      priceUnit = price.$4;
      tokens = price.$3;
    } else {
      final total = _consumeTrailingLineTotal(tokens);
      if (total != null) {
        unitPrice = total.$1;
        currency = total.$2;
        final context = total.$3.join(' ');
        final totalExplicit = RegExp(
          r'\b(toplam|toplamda|ikisi|hepsi|total|altogether)\b',
        ).hasMatch(context);
        final unitExplicit = RegExp(r'\b(tanesi|birim|paketi|each)\b')
            .hasMatch(context);
        isUnitPrice = totalExplicit && unitExplicit ? null : unitExplicit;
        if (unitExplicit) priceUnit = unit ?? UnitCode.adet;
        tokens = total.$3
            .where(
              (t) => !const {
                'toplam',
                'toplamda',
                'ikisi',
                'hepsi',
                'fiyatı',
                'fiyati',
                'fiyat',
                'birim',
                'tanesi',
                'paketi',
                'total',
                'altogether',
                'each',
                'price',
              }.contains(t),
            )
            .toList();
      }
    }

    if (unitPrice != null) {
      tokens.removeWhere(
        (t) => const {
          'toplam',
          'toplamda',
          'ikisi',
          'hepsi',
          'birim',
          'tanesi',
          'paketi',
          'total',
          'altogether',
          'each',
          'price',
        }.contains(t),
      );
    }
    // 3) Dolgu sözcükleri çıkar.
    final fillers = _isTr
        ? {'ekle', 'al', 'istiyorum', 'lazım'}
        : {'add', 'buy', 'at', 'please', 'of'};
    tokens = tokens.where((t) => !fillers.contains(t)).toList();
    if (tokens.every(_isCurrencyWord)) tokens.clear();

    var name = _stripPunctuation(tokens.join(' ')).trim();
    if (_isTr && unitPrice != null) {
      name = name.replaceFirst(RegExp(r'n[ıiuü]n$'), '');
    }
    final cleanName = name;

    // Miktar varsa ve birim yoksa adet: "1 ekmek" → 1 adet ekmek.
    if (quantity != null) unit ??= UnitCode.adet;

    return ParsedItemCandidate(
      name: cleanName,
      rawText: raw,
      quantity: quantity,
      unitCode: unit,
      unitPrice: unitPrice,
      currencyCode: currency,
      isUnitPrice: isUnitPrice,
      priceUnitCode: priceUnit,
      priceDestination: marketContext
          ? VoicePriceDestination.actual
          : VoicePriceDestination.planned,
    );
  }

  /// Bir cümledeki birden çok ürünü böler. Bir sayı, önündeki sözcük bir
  /// ad ise ve arkasında yeni bir ad/birim geliyorsa yeni ürünün miktarıdır:
  /// "1 kilo elma 1 ekmek" → ["1 kilo elma", "1 ekmek"].
  /// Sayıdan sonra para birimi (fiyat) ya da cümle sonunda birim varsa bölünmez:
  /// "elma kilosu 40 lira", "süt 1 litre".
  List<String> splitItems(String text) {
    final cleaned = _withoutSpeechTail(text);
    final clauses = cleaned.split(
      _isTr
          ? RegExp(r'(?<!\d),|,(?!\d)|[;\n]+|\s+ve\s+', caseSensitive: false)
          : RegExp(
              r'(?<!\d),|,(?!\d)|[;\n]+|\s+and\s+(?!a\s+half\b)',
              caseSensitive: false,
            ),
    );
    final grouped = <String>[];
    for (final clause in clauses) {
      final value = _withoutSpeechTail(clause).trim();
      if (value.isEmpty || _isCurrencyWord(_word(value))) continue;
      // Price-only clauses describe the preceding item, not a new product.
      final continuation = _isPriceContinuation(value);
      if (continuation && grouped.isNotEmpty) {
        grouped[grouped.length - 1] = '${grouped.last} $value';
      } else {
        grouped.add(value);
      }
    }
    final parts = <String>[];
    for (final clause in grouped) {
      final words = clause.split(RegExp(r'\s+'));
      var start = 0;
      for (var i = 1; i < words.length; i++) {
        if (_startsNewItem(words, i)) {
          parts.add(words.sublist(start, i).join(' '));
          start = i;
        }
      }
      parts.add(words.sublist(start).join(' '));
    }
    return parts;
  }

  String _word(String text) => text
      .replaceAll('İ', 'i')
      .toLowerCase()
      .replaceAll(RegExp(r'^[,;.!?]+|[,;.!?]+$'), '');

  bool _isPriceContinuation(String value) {
    if (!_isTr) return false;
    final words = value
        .replaceAll('İ', 'i')
        .toLowerCase()
        .replaceAllMapped(
          RegExp(r'(\d)(tl|try|eur|usd)\b'),
          (match) => '${match[1]} ${match[2]}',
        )
        .split(RegExp(r'\s+'))
        .map(_word)
        .toList();
    if (words.isNotEmpty && words.first == 'bir') words.removeAt(0);
    if (words.isEmpty ||
        !const {
          'tanesi',
          'adedi',
          'paketi',
          'kilosu',
          'kilogramı',
          'litresi',
          'birim',
          'toplam',
          'toplamda',
          'ikisi',
          'hepsi',
        }.contains(words.first)) {
      return false;
    }
    words.removeAt(0);
    if (words.isNotEmpty &&
        const {'fiyat', 'fiyatı', 'fiyati'}.contains(words.first)) {
      words.removeAt(0);
    }
    final totalIndex = words.indexWhere(
      (t) => t == 'toplam' || t == 'toplamda',
    );
    if (totalIndex >= 0) {
      return _readExplicitMoney(words.sublist(0, totalIndex)) != null &&
          _readExplicitMoney(words.sublist(totalIndex + 1)) != null;
    }
    // A cue alone is not enough: "ikisi bir arada kahve" is a product name.
    return _readExplicitMoney(words) != null;
  }

  // Remove only recognized spoken control tails, never arbitrary name words.
  String _withoutSpeechTail(String text) {
    if (!_isTr) return text.trim();
    var value = text.trim();
    final tail = RegExp(
      r'(?:^|[\s,;.!?]+)(?:listeye\s+dönüştür|bu\s+kadar)[\s,;.!?]*$',
      caseSensitive: false,
    );
    while (true) {
      final next = value.replaceFirst(tail, '').trim();
      if (next == value) break;
      value = next;
    }
    // "diyelim" after a price is conversational, but can be a name elsewhere.
    return value
        .replaceFirstMapped(
          RegExp(
            r'\b(tl|try|lira|euro|avro|eur|usd|dolar)\s+diyelim[\s,;.!?]*$',
            caseSensitive: false,
          ),
          (match) => match[1]!,
        )
        .trim();
  }

  bool _startsNewItem(List<String> words, int i) {
    if (!_isNumberWord(_word(words[i]))) return false;
    final prev = _word(words[i - 1]);
    if (const {
      'toplam',
      'toplamda',
      'fiyatı',
      'fiyati',
      'tanesi',
      'birim',
      'hepsi',
      'ikisi',
      'total',
      'each',
      'price',
    }.contains(prev)) {
      return false;
    }
    if (!_isNameWord(prev) && !_isCurrencyWord(prev)) return false;
    if (i + 1 >= words.length) return false;
    final next = _word(words[i + 1]);
    if (_isCurrencyWord(next)) return false;
    if (next == 'buçuk' || _isNameWord(next)) return true;
    if (_isUnitWord(next)) {
      return i + 2 < words.length && _isNameWord(_word(words[i + 2]));
    }
    return false;
  }

  bool _isNumberWord(String word) {
    if (RegExp(r'^\d{1,9}(?:[.,]\d{1,3})?$').hasMatch(word)) return true;
    if (_trOnes.containsKey(word) ||
        _trTens.containsKey(word) ||
        _enOnes.containsKey(word) ||
        _enTens.containsKey(word)) {
      return true;
    }
    return const {'yüz', 'hundred', 'yarım', 'half'}.contains(word);
  }

  bool _isUnitWord(String word) {
    final stem = _trPossessiveStem(word);
    return _trUnits.containsKey(word) ||
        _enUnits.containsKey(word) ||
        (stem != null && _trUnits.containsKey(stem));
  }

  bool _isCurrencyWord(String word) =>
      _trCurrency(word) != null || _enCurrency(word) != null;

  bool _isNameWord(String word) {
    if (word.isEmpty ||
        _isNumberWord(word) ||
        _isUnitWord(word) ||
        _isCurrencyWord(word)) {
      return false;
    }
    return !const {
      'ekle',
      'al',
      'istiyorum',
      'lazım',
      'add',
      'buy',
      'at',
      'please',
      'of',
      'market',
      'markette',
      'marketten',
      'çarşı',
      'çarşıda',
      'çarşıdan',
      'actual',
      'store',
      'per',
      've',
      'and',
      'a',
      'an',
      'buçuk',
      'half',
      'toplam',
      'toplamda',
      'fiyatı',
      'tanesi',
      'hepsi',
      'ikisi',
      'total',
      'each',
      'price',
    }.contains(word);
  }

  // ---- miktar ----

  (DecimalFixed, List<String>)? _consumeLeadingQuantity(List<String> tokens) {
    if (tokens.isEmpty) return null;

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
      if (rest.length >= 2 &&
          rest[0] == 'and' &&
          rest[1] == 'a' &&
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
    if (RegExp(
      _isTr ? r'^\d{1,9}(?:[.,]\d{1,3})?$' : r'^\d{1,9}(?:\.\d{1,3})?$',
    ).hasMatch(tokens.first)) {
      return (
        DecimalFixed.parse(tokens.first.replaceAll(',', '.')),
        tokens.sublist(1),
      );
    }
    final hundredIndex = tokens.indexOf(hundredWord);
    if (hundredIndex == 0 ||
        hundredIndex == 1 && ones.containsKey(tokens.first)) {
      final base = (hundredIndex == 0 ? 1 : ones[tokens.first]!) * 100;
      final rest = tokens.sublist(hundredIndex + 1);
      final tail = _takeNumberFromStart(rest, ones, tens, hundredWord);
      return (
        DecimalFixed.fromInt(base) + (tail?.$1 ?? DecimalFixed.zero()),
        tail?.$2 ?? rest,
      );
    }
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

  /// Two explicit amounts may corroborate each other: "tanesi 20 TL
  /// toplamda 40 TL" at quantity 2. Never silently reconcile a contradiction,
  /// different currencies, missing quantity or a different measurement basis.
  (DecimalFixed, String, List<String>, UnitCode, bool?)? _consumeUnitAndTotal(
    List<String> tokens,
    DecimalFixed? quantity,
    UnitCode? quantityUnit,
  ) {
    if (!_isTr) return null;
    final totalIndex = tokens.indexWhere(
      (t) => t == 'toplam' || t == 'toplamda',
    );
    if (totalIndex < 0) return null;
    for (var i = 0; i < totalIndex; i++) {
      final stem = _trPossessiveStem(tokens[i]);
      final explicitBasis = stem == null ? null : _trUnits[stem];
      if (explicitBasis == null) continue;
      final each = _readExplicitMoney(tokens.sublist(i + 1, totalIndex));
      final total = _readExplicitMoney(tokens.sublist(totalIndex + 1));
      if (each == null || total == null) continue;
      var nameEnd = i;
      if (i > 0 && tokens[i - 1] == 'bir') nameEnd--;
      // "tanesi" may refer to a counted package, but cannot turn a piece
      // price into a kilogram/litre/metre price just because numbers agree.
      final basis = explicitBasis == UnitCode.adet
          ? _piecePriceBasis(quantityUnit)
          : explicitBasis;
      final agrees =
          quantity != null &&
          quantity.isPositive &&
          basis == (quantityUnit ?? UnitCode.adet) &&
          each.$2 == total.$2 &&
          (quantity * each.$1).compareTo(total.$1) == 0;
      return (
        each.$1,
        each.$2,
        tokens.sublist(0, nameEnd),
        basis,
        agrees ? true : null,
      );
    }
    return null;
  }

  (DecimalFixed, String)? _readExplicitMoney(List<String> tokens) {
    if (tokens.length < 2) return null;
    final currency = _trCurrency(tokens.last) ?? _enCurrency(tokens.last);
    if (currency == null) return null;
    final amountTokens = tokens.sublist(0, tokens.length - 1);
    final compact = amountTokens.join(' ');
    if (RegExp(r'^\d{1,3}(?:\.\d{3})+,\d{1,3}$').hasMatch(compact)) {
      return (
        DecimalFixed.parse(compact.replaceAll('.', '').replaceAll(',', '.')),
        currency,
      );
    }
    final amount = _takeNumberFromStart(amountTokens, _trOnes, _trTens, 'yüz');
    return amount != null && amount.$2.isEmpty ? (amount.$1, currency) : null;
  }

  UnitCode _piecePriceBasis(UnitCode? quantityUnit) =>
      const {
        UnitCode.adet,
        UnitCode.paket,
        UnitCode.kutu,
        UnitCode.sise,
        UnitCode.kavanoz,
        UnitCode.demet,
        UnitCode.duzine,
      }.contains(quantityUnit)
      ? quantityUnit!
      : UnitCode.adet;

  /// tr: `... kilosu kırk beş lira` → iyelikli birim + sayı(lar) + para.
  /// en: `... three euros per kilo` → sayı + para + `per` + birim.
  /// Belirsiz fiyatta değer null döner (kullanıcı doldurur); ad korunur.
  (DecimalFixed?, String, List<String>, UnitCode?)? _consumeTrailingUnitPrice(
    List<String> tokens,
    UnitCode? quantityUnit,
  ) {
    if (!_isTr && tokens.isNotEmpty && tokens.last == 'each') {
      final price = _consumeTrailingLineTotal(
        tokens.sublist(0, tokens.length - 1),
      );
      if (price != null) {
        return (price.$1, price.$2, price.$3, _piecePriceBasis(quantityUnit));
      }
    }
    for (var i = 0; i < tokens.length; i++) {
      final token = tokens[i];

      if (_isTr) {
        final stem = _trPossessiveStem(token);
        if (stem == null || !_trUnits.containsKey(stem)) continue;
        final after = tokens.sublist(i + 1);
        if (after.isEmpty || _trCurrency(after.last) == null) {
          // Birim fiyat niyeti var ama sayı/para yok → belirsiz.
          return (null, 'TRY', _withoutAt(tokens, i), null);
        }
        final numberTake = _takeNumberFromStart(
          after.sublist(0, after.length - 1),
          _trOnes,
          _trTens,
          'yüz',
        );
        if (numberTake == null || numberTake.$2.isNotEmpty) {
          return (null, 'TRY', _withoutAt(tokens, i), null);
        }
        final rest = [...tokens.sublist(0, i), ...numberTake.$2];
        final basis = stem == 'tane' || stem == 'adet'
            ? _piecePriceBasis(quantityUnit)
            : _trUnits[stem];
        return (numberTake.$1, _trCurrency(after.last)!, rest, basis);
      }

      if (!_isTr &&
          token == 'per' &&
          i + 2 < tokens.length &&
          _enUnits[tokens[i + 1]] != null) {
        final after = tokens.sublist(i + 2);
        final currency = _enCurrency(after.last) ?? _trCurrency(after.last);
        final take = _takeNumberFromStart(
          after.sublist(0, after.length - 1),
          _enOnes,
          _enTens,
          'hundred',
        );
        if (currency != null && take != null && take.$2.isEmpty) {
          final basis = _enUnits[tokens[i + 1]]!;
          return (
            take.$1,
            currency,
            tokens.sublist(0, i),
            basis == UnitCode.adet ? _piecePriceBasis(quantityUnit) : basis,
          );
        }
      }
      if (!_isTr && token == 'per' && i >= 2 && i + 1 < tokens.length) {
        final unit = _enUnits[tokens[i + 1]];
        final currency = _enCurrency(tokens[i - 1]);
        if (unit == null || currency == null) continue;
        // sayı sözcükleri para biriminin solunda bitişik olmalı
        var start = i - 1;
        while (start > 0 &&
            (_enOnes.containsKey(tokens[start - 1]) ||
                _enTens.containsKey(tokens[start - 1]) ||
                RegExp(r'^\d{1,9}(?:\.\d{1,3})?$')
                    .hasMatch(tokens[start - 1]))) {
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
        return (
          numberTake.$1,
          currency,
          rest,
          unit == UnitCode.adet ? _piecePriceBasis(quantityUnit) : unit,
        );
      }
    }
    return null;
  }

  /// Satır tahmini: sondaki `<sayı> <para>` ("1 kilo domates 20 TL") → 20 TRY, birim değil.
  (DecimalFixed, String, List<String>)? _consumeTrailingLineTotal(
    List<String> tokens,
  ) {
    if (tokens.length < 3) return null;
    final currency = _trCurrency(tokens.last) ?? _enCurrency(tokens.last);
    if (currency == null) return null;
    for (var start = 1; start < tokens.length - 1; start++) {
      final moneyTokens = tokens.sublist(start, tokens.length - 1);
      final compact = moneyTokens.join(' ');
      DecimalFixed? amount;
      if (RegExp(r'^\d{1,3}(?:\.\d{3})+,\d{1,3}$').hasMatch(compact)) {
        amount = DecimalFixed.parse(
          compact.replaceAll('.', '').replaceAll(',', '.'),
        );
      } else {
        final take = _takeNumberFromStart(
          moneyTokens,
          _isTr ? _trOnes : _enOnes,
          _isTr ? _trTens : _enTens,
          _isTr ? 'yüz' : 'hundred',
        );
        if (take != null && take.$2.isEmpty) amount = take.$1;
      }
      if (amount != null) return (amount, currency, tokens.sublist(0, start));
    }
    return null;
  }

  /// [index]teki sözcüğü çıkarır.
  List<String> _withoutAt(List<String> tokens, int index) => [
    ...tokens.sublist(0, index),
    ...tokens.sublist(index + 1),
  ];

  /// "kilosu"→"kilo", "tanesi"→"tane", "litresi"→"litre" ...
  String? _trPossessiveStem(String word) {
    if (word == 'paketi') return 'paket';
    if (word == 'kavanozu') return 'kavanoz';
    if (word == 'demeti') return 'demet';
    if (word == 'gramı') return 'gram';
    if (word == 'kilogramı') return 'kilogram';
    if (word == 'adedi') return 'adet';
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
      case 'try':
      case 'tl':
      case '₺':
        return 'TRY';
      case 'eur':
      case 'euro':
      case 'avro':
        return 'EUR';
      case 'usd':
      case 'dolar':
      case 'dollar':
        return 'USD';
    }
    return null;
  }

  String? _enCurrency(String word) {
    switch (word) {
      case 'eur':
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
