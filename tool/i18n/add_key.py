"""Yeni ARB anahtari ekler: tum dillere (el yazimi verilenler disinda Qwen).

  python tool/i18n/add_key.py scanPriceLabel "Scan price label" tr="Fiyat etiketini okut" de="..."

Mevcut anahtar varsa degistirmez. Yer tutucular korunur (translate.bad).
"""
import concurrent.futures as cf
import json
import sys

import translate as T

key, english = sys.argv[1], sys.argv[2]
hand = dict(a.split('=', 1) for a in sys.argv[3:])


def write(code, value):
    f = T.ARB / f'app_{code}.arb'
    d = json.loads(f.read_text(encoding='utf8'))
    if key in d:
        return
    d[key] = value
    f.write_text(json.dumps(d, ensure_ascii=False, indent=2) + '\n', encoding='utf8')


def tr(code):
    if code in hand:
        return code, hand[code]
    src = {key: english}
    for _ in range(4):
        try:
            out = T.ask(T.NAMES.get(code, code), src)
        except Exception as e:
            print(code, 'hata', str(e)[:60], flush=True)
            continue
        if not T.bad(src, out) and (out[key] != english or code in ('en',)):
            return code, out[key].strip()
    return code, english  # son care: Ingilizce (test/fix_untranslated yakalar)


codes = [p.stem[4:] for p in sorted(T.ARB.glob('app_*.arb'))]
en_codes = [c for c in codes if c != 'en']
write('en', english)
with cf.ThreadPoolExecutor(6) as ex:
    for code, value in ex.map(tr, [c for c in en_codes if c != 'tl']):
        write(code, value)
        if code == 'fil':
            write('tl', value)
print('tamam', len(codes))
