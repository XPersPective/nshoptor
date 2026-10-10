"""en-US magaza metnini diger Play dillerine cevirir -> tool/store/listing_extra.json

  python tool/store/listing_translate.py --all     # eksik tum diller
  python tool/store/listing_translate.py --refresh-all # aciklama/notlari yenile
  python tool/store/listing_translate.py de-AT ... # belirli Play kodlari

Kaynak: listing.py icindeki L['en-US']. Ayni anahtar/yontem tool/i18n/translate.py
ile (AI_ENV). Play sinirlari (baslik 30, kisa 80, uzun 4000, notlar 500)
asildiginda model kisaltmasi icin geri bildirimle yeniden sorulur.
"""
import concurrent.futures as cf
import json
import pathlib
import re
import unicodedata
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1] / 'i18n'))
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import translate as T  # noqa: E402
import listing as LST  # noqa: E402

OUT = pathlib.Path(__file__).resolve().parent / 'listing_extra.json'

# Play kodu -> dil adi; kaynak en/tr, mevcut baslik/kisa metin korunur.
PLAY = {
    'de-DE': 'German', 'fr-FR': 'French', 'es-ES': 'Spanish', 'it-IT': 'Italian',
    'pt-PT': 'Portuguese', 'ru-RU': 'Russian', 'ar': 'Arabic',
    'af': 'Afrikaans', 'az-AZ': 'Azerbaijani (Latin)', 'be': 'Belarusian', 'bg': 'Bulgarian',
    'bn-BD': 'Bengali', 'ca': 'Catalan', 'cs-CZ': 'Czech', 'da-DK': 'Danish', 'el-GR': 'Greek',
    'et': 'Estonian', 'eu-ES': 'Basque', 'fa': 'Persian (Farsi)', 'fi-FI': 'Finnish', 'fil': 'Filipino',
    'gl-ES': 'Galician', 'gu': 'Gujarati', 'hi-IN': 'Hindi', 'hr': 'Croatian', 'hu-HU': 'Hungarian',
    'hy-AM': 'Armenian', 'id': 'Indonesian', 'is-IS': 'Icelandic', 'iw-IL': 'Hebrew', 'ja-JP': 'Japanese',
    'ka-GE': 'Georgian', 'kk': 'Kazakh (Cyrillic)', 'kn-IN': 'Kannada', 'ko-KR': 'Korean',
    'ky-KG': 'Kyrgyz (Cyrillic)', 'lo-LA': 'Lao', 'lt': 'Lithuanian', 'lv': 'Latvian',
    'mk-MK': 'Macedonian', 'ml-IN': 'Malayalam', 'mn-MN': 'Mongolian (Cyrillic)', 'mr-IN': 'Marathi',
    'ms': 'Malay', 'my-MM': 'Burmese', 'ne-NP': 'Nepali', 'nl-NL': 'Dutch', 'pa': 'Punjabi (Gurmukhi)',
    'pl-PL': 'Polish', 'ro': 'Romanian', 'si-LK': 'Sinhala', 'sk': 'Slovak', 'sl': 'Slovenian',
    'sq': 'Albanian', 'sr': 'Serbian (Cyrillic)', 'sv-SE': 'Swedish', 'sw': 'Swahili', 'ta-IN': 'Tamil',
    'te-IN': 'Telugu', 'th': 'Thai', 'uk': 'Ukrainian', 'ur': 'Urdu', 'vi': 'Vietnamese',
    'zh-CN': 'Chinese (Simplified)', 'zh-TW': 'Chinese (Traditional, Taiwan)', 'zu': 'Zulu',
    'pt-BR': 'Brazilian Portuguese',
}
# Ayni metni paylasan bolgesel Play kodlari (kopya).
COPY = {'en-GB': 'en-US', 'es-419': 'es-ES', 'es-US': 'es-ES', 'fr-CA': 'fr-FR'}

SYSTEM = """You localize Google Play store listing text for NShoptor, a grocery list and shopping budget app.
Translate the JSON values from English into {lang}. Write natural marketing copy a native speaker would write (not word for word).
Rules:
- Keep product words NShoptor, Pro, Max, GPL-3.0 and the URL unchanged. Keep bullet characters and line breaks and the section headings (translate headings, keep them short, UPPERCASE if the script has case).
- Hard length limits in characters: title <= 30, short <= 80, full <= 4000, notes <= 500. Be concise: the short text must fit 80 characters including spaces.
- Preserve every ASCII number in full/notes, including 10, 100, 300, 200, 1000, 71 and 7. Never change quotas.
- Keep the meaning of every feature and the privacy claims exactly; do not invent features.
Return ONE JSON object with exactly the input keys."""

NONLATIN = {'be', 'bg', 'bn-BD', 'el-GR', 'fa', 'gu', 'hi-IN', 'hy-AM', 'iw-IL', 'ja-JP', 'ka-GE', 'kk', 'kn-IN', 'ko-KR',
            'ky-KG', 'lo-LA', 'mk-MK', 'ml-IN', 'mn-MN', 'mr-IN', 'my-MM', 'ne-NP', 'pa', 'si-LK', 'sr', 'ta-IN', 'te-IN',
            'th', 'uk', 'ur', 'zh-CN', 'zh-TW', 'ar', 'ru-RU'}
# Model sinirin 1-2 karakter uzerinde kalan baslik/kisa metinler icin elle yazilmis hali.
OVERRIDE = {
    'mr-IN': {'title': 'NShoptor: खरेदी यादी'},
    'hi-IN': {'title': 'NShoptor: खरीदारी सूची',
              'short': 'खरीदारी सूची और बजट: असली दाम, रसीद स्कैन, AI। घर पर प्लान करें।'},
    'bn-BD': {'title': 'NShoptor: বাজারের তালিকা',
              'short': 'বাজারের তালিকা ও বাজেট: আসল দাম, রসিদ স্ক্যান, AI। বাসায় পরিকল্পনা করুন।'},
    'ne-NP': {'title': 'NShoptor: किनमेल सूची',
              'short': 'किनमेल सूची र बजेट: साँचो मूल्य, रसिद स्क्यान, AI। घरमै योजना बनाउनुहोस्।'},
}
LIM = {'title': 30, 'short': 80, 'full': 4000, 'notes': 500}


def one(code):
    lang = PLAY[code]
    src = {k: LST.L['en-US'][k] for k in ('full', 'notes')}
    feedback = ''
    best = None
    for _ in range(9):
        try:
            translated = T.ask(lang, src, prompt=SYSTEM + feedback)
            out = {**LST.L[code], **{k: translated[k] for k in src}}
        except Exception as e:
            print(code, 'hata', type(e).__name__, flush=True)
            continue
        if not all(isinstance(out.get(k), str) and out[k].strip() for k in LIM):
            continue
        if code in NONLATIN and any(sum(c.isascii() and c.isalpha() for c in out[k].replace('NShoptor', '')) / max(1, sum(c.isalpha() for c in out[k].replace('NShoptor', ''))) > 0.8 for k in ('title', 'short')):
            feedback = '\nPREVIOUS ATTEMPT LEFT TEXT IN ENGLISH. Write title and short fully in the target language script (only the word NShoptor stays Latin).'
            continue
        over = {k: len(out[k]) for k in LIM if len(out[k]) > LIM[k]}
        normalized = ''.join(str(unicodedata.decimal(c)) if c.isdecimal() else c for c in out['full'])
        missing = {'10', '100', '300', '200', '1000', '71', '7'} - set(re.findall(r'\d+', normalized))
        if missing:
            feedback = '\nPREVIOUS ATTEMPT OMITTED REQUIRED NUMBERS/RIGHTS: ' + ', '.join(sorted(missing)) + '. Translate every source sentence without omission.'
            continue
        best = out
        if not over:
            return code, {k: out[k].strip() for k in LIM}
        feedback = '\nPREVIOUS ATTEMPT TOO LONG: ' + ', '.join(f'{k} was {n} chars (max {LIM[k]})' for k, n in over.items()) + '. Shorten those fields (title: NShoptor plus at most two short words; short: aim for 65 characters).'
    if best and code in OVERRIDE and len(best['full']) <= 4000 and len(best['notes']) <= 500:
        return code, {**{k: best[k].strip() for k in LIM}, **OVERRIDE[code]}
    raise SystemExit(f'{code}: sinir asildi/cevrilemedi ({ {k: len(best[k]) for k in LIM} if best else None })')


def main(args):
    data = json.loads(OUT.read_text(encoding='utf8')) if OUT.exists() else {}
    codes = [c for c in PLAY if c not in data] if args == ['--all'] else [c for c in args if c in PLAY]
    # PROMPT.format({lang}) kullanir; JSON suslu parantezleri kacirilmali degil -> SYSTEM'de yok
    if args == ['--refresh-all']:
        codes = list(PLAY)
    failed = []
    with cf.ThreadPoolExecutor(6) as ex:
        futs = [ex.submit(one, c) for c in codes]
        for f in cf.as_completed(futs):
            try:
                c, v = f.result()
                data[c] = v
                OUT.write_text(json.dumps(data, ensure_ascii=False, indent=1) + '\n', encoding='utf8')
                print('tamam', c, flush=True)
            except SystemExit as e:
                print('HATA', e, flush=True)
                failed.append(str(e))
    if failed:
        raise SystemExit('Failed translations: ' + '; '.join(failed))


if __name__ == '__main__':
    main(sys.argv[1:])
