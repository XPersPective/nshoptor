/// Cihaz ülkesinden varsayılan para birimi (PB-061: 71 dil, herkese ₺ değil).
/// Tabloda olmayan ülke `null` döner; çağıran dil/USD'ye düşer.
const _byCountry = <String, String>{
  'TR': 'TRY', 'US': 'USD', 'GB': 'GBP', 'JP': 'JPY', 'CH': 'CHF', 'SE': 'SEK', 'NO': 'NOK', 'DK': 'DKK',
  'PL': 'PLN', 'CZ': 'CZK', 'HU': 'HUF', 'RO': 'RON', 'BG': 'BGN', 'RU': 'RUB', 'BY': 'RUB', 'UA': 'UAH',
  'AZ': 'AZN', 'KZ': 'KZT', 'CN': 'CNY', 'IN': 'INR', 'ID': 'IDR', 'MY': 'MYR', 'SG': 'SGD', 'KR': 'KRW',
  'TH': 'THB', 'VN': 'VND', 'PH': 'PHP', 'HK': 'HKD', 'TW': 'TWD', 'AU': 'AUD', 'NZ': 'NZD', 'CA': 'CAD',
  'MX': 'MXN', 'BR': 'BRL', 'AR': 'ARS', 'CL': 'CLP', 'CO': 'COP', 'PE': 'PEN', 'ZA': 'ZAR', 'EG': 'EGP',
  'SA': 'SAR', 'AE': 'AED', 'QA': 'QAR', 'KW': 'KWD', 'BH': 'BHD', 'OM': 'OMR', 'JO': 'JOD', 'IQ': 'IQD',
  'IL': 'ILS', 'MA': 'MAD', 'TN': 'TND', 'LY': 'LYD', 'DZ': 'DZD', 'NG': 'NGN', 'KE': 'KES', 'GH': 'GHS',
  'ET': 'ETB', 'UZ': 'UZS', 'KG': 'KGS', 'TJ': 'TJS', 'AF': 'AFN', 'PK': 'PKR', 'BD': 'BDT', 'LK': 'LKR',
  'MD': 'MDL', 'RS': 'RSD', 'MK': 'MKD', 'AL': 'ALL', 'BA': 'BAM', 'IS': 'ISK', 'PY': 'PYG', 'UY': 'UYU',
  'VE': 'VES', 'BO': 'BOB', 'CR': 'CRC', 'GT': 'GTQ', 'DO': 'DOP', 'SN': 'XOF', 'CI': 'XOF', 'CM': 'XAF',
  // Euro bölgesi
  'DE': 'EUR', 'FR': 'EUR', 'ES': 'EUR', 'IT': 'EUR', 'PT': 'EUR', 'NL': 'EUR', 'BE': 'EUR', 'AT': 'EUR',
  'IE': 'EUR', 'FI': 'EUR', 'GR': 'EUR', 'LU': 'EUR', 'SK': 'EUR', 'SI': 'EUR', 'EE': 'EUR', 'LV': 'EUR',
  'LT': 'EUR', 'MT': 'EUR', 'CY': 'EUR', 'HR': 'EUR',
};

String? currencyForCountry(String? countryCode) => _byCountry[countryCode?.toUpperCase()];
