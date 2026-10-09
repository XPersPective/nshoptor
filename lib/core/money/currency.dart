/// ISO 4217 para birimi tanımı.
///
/// Para birimi yalnızca [code] ile kimliklenir; sembol tek başına kimlik
/// değildir. [minorUnitDigits] JPY için 0, TRY için 2, KWD için 3'tür.
/// Kanonik değerler kod olarak saklanır; görünen adlar l10n katmanından gelir.
class Currency {
  const Currency._(
    this.code,
    this.minorUnitDigits,
    this.symbol, {
    required this.ambiguousSymbol,
  });

  /// ISO 4217 alfabetik kodu (ör. `TRY`).
  final String code;

  /// Minor unit (kuruş gibi) basamak sayısı: 0, 2 veya 3.
  final int minorUnitDigits;

  /// Yerleşik sembol; yoksa veya belirsizse [displaySymbol] ISO kodunu verir.
  final String? symbol;

  /// `$`, `¥` gibi birden çok para biriminde kullanılan semboller için doğrudur;
  /// biçimlemede sembol yerine ISO kodu gösterilir (spec §7.1).
  final bool ambiguousSymbol;

  /// Sembol güvenliyse sembolü, değilse ISO kodunu döndürür.
  String get displaySymbol =>
      symbol == null || ambiguousSymbol ? code : symbol!;

  static const Currency try_ = Currency._('TRY', 2, '₺', ambiguousSymbol: false);
  static const Currency usd = Currency._('USD', 2, r'$', ambiguousSymbol: true);
  static const Currency eur = Currency._('EUR', 2, '€', ambiguousSymbol: false);
  static const Currency gbp = Currency._('GBP', 2, '£', ambiguousSymbol: false);
  static const Currency jpy = Currency._('JPY', 0, '¥', ambiguousSymbol: true);
  static const Currency kwd = Currency._('KWD', 3, null, ambiguousSymbol: false);

  /// Depoya gömülü ISO 4217 tablosu. Eksik kod eklenerek genişletilir; kod
  /// listesi kullanıcıya asla çevrilmiş metin olarak gösterilmez.
  static const Map<String, Currency> _byCode = {
    'TRY': try_,
    'USD': usd,
    'EUR': eur,
    'GBP': gbp,
    'JPY': jpy,
    'KWD': kwd,
    'BHD': Currency._('BHD', 3, null, ambiguousSymbol: false),
    'OMR': Currency._('OMR', 3, null, ambiguousSymbol: false),
    'TND': Currency._('TND', 3, null, ambiguousSymbol: false),
    'JOD': Currency._('JOD', 3, null, ambiguousSymbol: false),
    'IQD': Currency._('IQD', 3, null, ambiguousSymbol: false),
    'LYD': Currency._('LYD', 3, null, ambiguousSymbol: false),
    'CHF': Currency._('CHF', 2, 'CHF', ambiguousSymbol: false),
    'SEK': Currency._('SEK', 2, 'kr', ambiguousSymbol: false),
    'NOK': Currency._('NOK', 2, 'kr', ambiguousSymbol: false),
    'DKK': Currency._('DKK', 2, 'kr', ambiguousSymbol: false),
    'PLN': Currency._('PLN', 2, 'zł', ambiguousSymbol: false),
    'CZK': Currency._('CZK', 2, 'Kč', ambiguousSymbol: false),
    'HUF': Currency._('HUF', 2, 'Ft', ambiguousSymbol: false),
    'RON': Currency._('RON', 2, 'lei', ambiguousSymbol: false),
    'BYN': Currency._('BYN', 2, null, ambiguousSymbol: false),
    'BGN': Currency._('BGN', 2, 'лв', ambiguousSymbol: false),
    'RUB': Currency._('RUB', 2, '₽', ambiguousSymbol: false),
    'UAH': Currency._('UAH', 2, '₴', ambiguousSymbol: false),
    'AZN': Currency._('AZN', 2, '₼', ambiguousSymbol: false),
    'KZT': Currency._('KZT', 2, '₸', ambiguousSymbol: false),
    'CNY': Currency._('CNY', 2, '¥', ambiguousSymbol: true),
    'INR': Currency._('INR', 2, '₹', ambiguousSymbol: false),
    'IDR': Currency._('IDR', 2, 'Rp', ambiguousSymbol: false),
    'MYR': Currency._('MYR', 2, 'RM', ambiguousSymbol: false),
    'SGD': Currency._('SGD', 2, r'$', ambiguousSymbol: true),
    'KRW': Currency._('KRW', 0, '₩', ambiguousSymbol: false),
    'THB': Currency._('THB', 2, '฿', ambiguousSymbol: false),
    'VND': Currency._('VND', 0, '₫', ambiguousSymbol: false),
    'PHP': Currency._('PHP', 2, '₱', ambiguousSymbol: false),
    'HKD': Currency._('HKD', 2, r'$', ambiguousSymbol: true),
    'TWD': Currency._('TWD', 2, r'$', ambiguousSymbol: true),
    'AUD': Currency._('AUD', 2, r'$', ambiguousSymbol: true),
    'NZD': Currency._('NZD', 2, r'$', ambiguousSymbol: true),
    'CAD': Currency._('CAD', 2, r'$', ambiguousSymbol: true),
    'MXN': Currency._('MXN', 2, r'$', ambiguousSymbol: true),
    'BRL': Currency._('BRL', 2, 'R\$', ambiguousSymbol: false),
    'ARS': Currency._('ARS', 2, r'$', ambiguousSymbol: true),
    'CLP': Currency._('CLP', 0, r'$', ambiguousSymbol: true),
    'COP': Currency._('COP', 2, r'$', ambiguousSymbol: true),
    'PEN': Currency._('PEN', 2, 'S/', ambiguousSymbol: false),
    'ZAR': Currency._('ZAR', 2, 'R', ambiguousSymbol: false),
    'EGP': Currency._('EGP', 2, 'E£', ambiguousSymbol: false),
    'SAR': Currency._('SAR', 2, '﷼', ambiguousSymbol: false),
    'AED': Currency._('AED', 2, 'د.إ', ambiguousSymbol: false),
    'QAR': Currency._('QAR', 2, 'ر.ق', ambiguousSymbol: false),
    'ILS': Currency._('ILS', 2, '₪', ambiguousSymbol: false),
    'MAD': Currency._('MAD', 2, 'د.م.', ambiguousSymbol: false),
    'NGN': Currency._('NGN', 2, '₦', ambiguousSymbol: false),
    'KES': Currency._('KES', 2, 'KSh', ambiguousSymbol: false),
    'GHS': Currency._('GHS', 2, '₵', ambiguousSymbol: false),
    'ETB': Currency._('ETB', 2, 'Br', ambiguousSymbol: false),
    'UZS': Currency._('UZS', 2, "so'm", ambiguousSymbol: false),
    'KGS': Currency._('KGS', 2, 'с', ambiguousSymbol: false),
    'TJS': Currency._('TJS', 2, 'смн', ambiguousSymbol: false),
    'AFN': Currency._('AFN', 2, '؋', ambiguousSymbol: false),
    'PKR': Currency._('PKR', 2, '₨', ambiguousSymbol: true),
    'BDT': Currency._('BDT', 2, '৳', ambiguousSymbol: false),
    'LKR': Currency._('LKR', 2, 'Rs', ambiguousSymbol: false),
    'MDL': Currency._('MDL', 2, 'L', ambiguousSymbol: false),
    'RSD': Currency._('RSD', 2, 'дин', ambiguousSymbol: false),
    'MKD': Currency._('MKD', 2, 'ден', ambiguousSymbol: false),
    'ALL': Currency._('ALL', 2, 'L', ambiguousSymbol: false),
    'BAM': Currency._('BAM', 2, 'KM', ambiguousSymbol: false),
    'ISK': Currency._('ISK', 0, 'kr', ambiguousSymbol: false),
    'DZD': Currency._('DZD', 2, 'د.ج', ambiguousSymbol: false),
    'PYG': Currency._('PYG', 0, '₲', ambiguousSymbol: false),
    'UYU': Currency._('UYU', 2, r'$', ambiguousSymbol: true),
    'VES': Currency._('VES', 2, 'Bs', ambiguousSymbol: false),
    'BOB': Currency._('BOB', 2, 'Bs', ambiguousSymbol: true),
    'CRC': Currency._('CRC', 2, '₡', ambiguousSymbol: false),
    'GTQ': Currency._('GTQ', 2, 'Q', ambiguousSymbol: false),
    'DOP': Currency._('DOP', 2, r'$', ambiguousSymbol: true),
    'XOF': Currency._('XOF', 0, 'CFA', ambiguousSymbol: false),
    'XAF': Currency._('XAF', 0, 'FCFA', ambiguousSymbol: false),
  };

  /// Bilinen kodu döndürür; bilinmeyen kodda [ArgumentError] fırlatır.
  static Currency fromCode(String code) {
    final c = _byCode[code.toUpperCase()];
    if (c == null) {
      throw ArgumentError.value(code, 'code', 'bilinmeyen ISO 4217 kodu');
    }
    return c;
  }

  static bool isKnownCode(String code) => _byCode.containsKey(code.toUpperCase());

  /// Tüm desteklenen kodlar (Ayarlar'daki seçim listeleri için).
  static List<Currency> get all =>
      (_byCode.values.toList()..sort((a, b) => a.code.compareTo(b.code)));

  @override
  bool operator ==(Object other) => other is Currency && other.code == code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => code;
}
