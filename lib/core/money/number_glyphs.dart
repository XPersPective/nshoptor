/// Unicode17 decimal positional digit families (General_Category=Nd).
/// Derived from https://www.unicode.org/Public/17.0.0/ucd/UnicodeData.txt
/// Unicode data: https://www.unicode.org/license.txt . Source digest and
/// generation checks: .project-brain/references/numbering-data-2026-10-29.md.
/// This is a glyph boundary, never a floating-point or locale-guessing parser.
const _decimalZeroes = <int>[
  0x30,
  0x660,
  0x6F0,
  0x7C0,
  0x966,
  0x9E6,
  0xA66,
  0xAE6,
  0xB66,
  0xBE6,
  0xC66,
  0xCE6,
  0xD66,
  0xDE6,
  0xE50,
  0xED0,
  0xF20,
  0x1040,
  0x1090,
  0x17E0,
  0x1810,
  0x1946,
  0x19D0,
  0x1A80,
  0x1A90,
  0x1B50,
  0x1BB0,
  0x1C40,
  0x1C50,
  0xA620,
  0xA8D0,
  0xA900,
  0xA9D0,
  0xA9F0,
  0xAA50,
  0xABF0,
  0xFF10,
  0x104A0,
  0x10D30,
  0x10D40,
  0x11066,
  0x110F0,
  0x11136,
  0x111D0,
  0x112F0,
  0x11450,
  0x114D0,
  0x11650,
  0x116C0,
  0x116D0,
  0x116DA,
  0x11730,
  0x118E0,
  0x11950,
  0x11BF0,
  0x11C50,
  0x11D50,
  0x11DA0,
  0x11DE0,
  0x11F50,
  0x16130,
  0x16A60,
  0x16AC0,
  0x16B50,
  0x16D70,
  0x1CCF0,
  0x1D7CE,
  0x1D7D8,
  0x1D7E2,
  0x1D7EC,
  0x1D7F6,
  0x1E140,
  0x1E2F0,
  0x1E4F0,
  0x1E5F1,
  0x1E950,
  0x1FBF0,
];

int? _decimalValue(int rune) {
  if (rune >= 0x30 && rune <= 0x39) return rune - 0x30;
  var low = 0;
  var high = _decimalZeroes.length - 1;
  while (low <= high) {
    final mid = (low + high) ~/ 2;
    final zero = _decimalZeroes[mid];
    if (rune < zero) {
      high = mid - 1;
    } else if (rune >= zero + 10) {
      low = mid + 1;
    } else {
      return rune - zero;
    }
  }
  return null;
}

/// Accept decimal glyphs from native keypads, pasted values and OCR views.
/// Direction controls are retained: only the numeric parser may remove marks
/// at presentation boundaries, never between digits. Fractions and algorithmic
/// numeral words are not interpreted as decimal positional numbers.
String normalizeNumberGlyphs(String input) {
  final out = StringBuffer();
  for (final rune in input.runes) {
    final value = _decimalValue(rune);
    if (value != null) {
      out.writeCharCode(0x30 + value);
      continue;
    }
    switch (rune) {
      case 0x2212: // Unicode minus
      case 0xFF0D: // fullwidth minus
      case 0xFE63: // small minus
        out.write('-');
      case 0xFF0B:
        out.write('+');
      case 0xFF0E:
        out.write('.');
      case 0xFF0C:
        out.write(',');
      case 0xFF0F:
        out.write('/');
      case 0xFF1A:
        out.write(':');
      default:
        out.writeCharCode(rune);
    }
  }
  return out.toString();
}

/// Shape ASCII digits only; never change currency codes, names or arithmetic.
String localizeNumberDigits(String ascii, String zeroDigit) {
  final zero = zeroDigit.runes.single;
  if (zero == 0x30) return ascii;
  return String.fromCharCodes(
    ascii.runes.map(
      (rune) => rune >= 0x30 && rune <= 0x39 ? zero + rune - 0x30 : rune,
    ),
  );
}
