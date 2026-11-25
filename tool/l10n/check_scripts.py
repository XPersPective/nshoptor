"""Catch mixed-script ARB corruption, not semantic translation errors.

Latin branding/AI identifiers and inherited combining marks are permitted.
Named script letters AND marks must fit the locale. Intentional quotations in
another script need a reviewed, key-specific exception rather than a blanket rule.
"""
import json
from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parents[2]
NON_LATIN = {
    "ar": "ARABIC", "be": "CYRILLIC", "bg": "CYRILLIC", "bn": "BENGALI",
    "el": "GREEK", "fa": "ARABIC", "gu": "GUJARATI", "he": "HEBREW",
    "hi": "DEVANAGARI", "hy": "ARMENIAN", "ja": "CJK HIRAGANA KATAKANA",
    "ka": "GEORGIAN", "kk": "CYRILLIC", "km": "KHMER", "kn": "KANNADA",
    "ko": "HANGUL CJK", "ky": "CYRILLIC", "lo": "LAO", "mk": "CYRILLIC",
    "ml": "MALAYALAM", "mn": "CYRILLIC", "mr": "DEVANAGARI", "my": "MYANMAR",
    "ne": "DEVANAGARI", "pa": "GURMUKHI", "ps": "ARABIC", "ru": "CYRILLIC",
    "si": "SINHALA", "sr": "CYRILLIC", "ta": "TAMIL", "te": "TELUGU",
    "th": "THAI", "uk": "CYRILLIC", "ur": "ARABIC", "zh": "CJK",
}
SCRIPTS = {"LATIN"} | {s for value in NON_LATIN.values() for s in value.split()}


def unexpected(text, locale):
    allowed = {"LATIN", *NON_LATIN.get(locale, "LATIN").split()}
    found = set()
    for char in text:
        if unicodedata.category(char)[0] not in {"L", "M"}:
            continue
        name = unicodedata.name(char, "UNKNOWN")
        named_scripts = SCRIPTS.intersection(name.replace("-", " ").split())
        if named_scripts - allowed:
            found.add(f"U+{ord(char):04X} {name}")
        elif not named_scripts and not name.startswith((
            "COMBINING", "MODIFIER", "VARIATION", "FEMININE", "MASCULINE",
            "MICRO", "SUPERSCRIPT", "SUBSCRIPT", "MATHEMATICAL",
        )):
            found.add(f"U+{ord(char):04X} {name} (unclassified)")
    return sorted(found)


def main():
    files = sorted((ROOT / "lib/core/l10n").glob("app_*.arb"))
    if not files:
        raise SystemExit("No ARB source files found")
    failures = []
    for path in files:
        locale = path.stem.removeprefix("app_")
        for key, value in json.loads(path.read_text(encoding="utf-8")).items():
            if key.startswith("@") or not isinstance(value, str):
                continue
            bad = unexpected(value, locale)
            if bad:
                failures.append(f"{locale}:{key}: {', '.join(bad)}")
    if failures:
        raise SystemExit("Unexpected localization script(s):\n" + "\n".join(failures))
    print(f"Localization script check: {len(files)} locales pass (not linguistic certification)")


if __name__ == "__main__":
    main()
