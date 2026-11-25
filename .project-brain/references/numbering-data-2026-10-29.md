# Numeric data source — 2026-10-29
- Existing intl/CLDR symbols and grouping remain the locale source. No floating-point parser/library added.
- Decimal digit zero code points derived from Unicode17 General_Category=Nd / Decimal_Digit_Value=0; every family validated as ten contiguous decimal values. 77 digit families, 770 digits.
- Source: https://www.unicode.org/Public/17.0.0/ucd/UnicodeData.txt
- Original data SHA-256: 2e1efc1dcb59c575eedf5ccae60f95229f706ee6d031835247d843c11d96470c
- Unicode data license: https://www.unicode.org/license.txt . Derived table consists of numeric code-point facts, not a country/locale convention table.
- Algorithmic/historic numeral text is not inferred as an amount. CLDR's actual country/default numbering governs output; all Unicode17 positional decimal glyphs can be accepted at numeric input boundaries.
