"""Modelin Ingilizce birakip dondurdugu uzun/anlamli metinleri yeniden cevirir.
  python tool/i18n/fix_untranslated.py          # tum yeni diller
"""
import concurrent.futures as cf
import json
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import translate as T  # noqa: E402

EN = json.loads((T.ARB / 'app_en.arb').read_text(encoding='utf8'))
KEYS = [k for k in EN if not k.startswith('@')]
LATIN = {'af', 'az', 'bs', 'ca', 'cs', 'da', 'et', 'eu', 'fi', 'fil', 'gl', 'hr', 'hu', 'id', 'is', 'lt', 'lv', 'ms', 'nl',
         'pl', 'ro', 'sk', 'sl', 'sq', 'sv', 'sw', 'uz', 'vi', 'zu', 'tl'}
SKIP = {'appTitle', 'proBuyLabel', 'aiSourceLabel'}


def stale(code, d):
    out = {}
    for k in KEYS:
        v = EN[k]
        if d.get(k) != v or k in SKIP:
            continue
        letters = sum(c.isalpha() for c in v)
        if letters >= (25 if code in LATIN else 8) and not v.replace('.', '').isdigit():
            out[k] = v
    return out


def fix(code):
    f = T.ARB / f'app_{code}.arb'
    d = json.loads(f.read_text(encoding='utf8'))
    todo = stale(code, d)
    for _ in range(4):
        if not todo:
            break
        items = list(todo.items())
        for part in (dict(items[i:i + 30]) for i in range(0, len(items), 30)):
            try:
                out = T.ask(T.NAMES[code], part)
            except Exception as e:
                print(code, 'hata', str(e)[:60], flush=True)
                continue
            for k in set(part) - set(T.bad(part, out)):
                if out[k] != EN[k] or code in LATIN:
                    d[k] = out[k]
        todo = stale(code, d)
    f.write_text(json.dumps(d, ensure_ascii=False, indent=2) + '\n', encoding='utf8')
    return code, len(todo)


codes = [c for c in T.NAMES]
with cf.ThreadPoolExecutor(6) as ex:
    for fut in cf.as_completed([ex.submit(fix, c) for c in codes]):
        c, left = fut.result()
        if left:
            print('kalan', c, left, flush=True)
src = T.ARB / 'app_fil.arb'
t = json.loads(src.read_text(encoding='utf8'))
t['@@locale'] = 'tl'
(T.ARB / 'app_tl.arb').write_text(json.dumps(t, ensure_ascii=False, indent=2) + '\n', encoding='utf8')
print('bitti')
