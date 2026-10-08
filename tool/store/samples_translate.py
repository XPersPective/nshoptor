"""Magaza ekran goruntuleri icin ornek liste adi + 6 urun adi -> test/store_samples.json
  python tool/store/samples_translate.py --all
"""
import concurrent.futures as cf
import json
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1] / 'i18n'))
import translate as T  # noqa: E402

OUT = pathlib.Path(__file__).resolve().parents[2] / 'test/store_samples.json'
SRC = {'list': 'Weekly groceries', 'i0': 'Tomatoes', 'i1': 'Bread', 'i2': 'Milk 1 L',
       'i3': 'Eggs (10)', 'i4': 'Olive oil', 'i5': 'Rice 1 kg'}
HAND = {'tr', 'en', 'de', 'fr', 'es', 'it', 'pt', 'ru', 'ar'}
T.PROMPT = ('Translate these grocery shopping list names into {lang} as short everyday labels a native '
            'shopper would write (keep the numbers and units like 1 L / 1 kg / (10) in the local style). '
            'Return ONE JSON object with the same keys.')


def one(code):
    for _ in range(4):
        try:
            out = T.ask(T.NAMES[code], SRC)
        except Exception as e:
            print(code, 'hata', str(e)[:60], flush=True)
            continue
        if all(isinstance(out.get(k), str) and out[k].strip() for k in SRC):
            return code, {k: out[k].strip() for k in SRC}
    raise SystemExit(code + ' cevrilemedi')


def main():
    data = json.loads(OUT.read_text(encoding='utf8')) if OUT.exists() else {}
    codes = [c for c in list(T.NAMES) + ['tl'] if c not in data and c not in HAND]
    names = dict(T.NAMES, tl='Filipino')
    T.NAMES.update(names)
    with cf.ThreadPoolExecutor(6) as ex:
        for f in cf.as_completed([ex.submit(one, c) for c in codes]):
            try:
                c, v = f.result()
                data[c] = v
                OUT.write_text(json.dumps(data, ensure_ascii=False, indent=1) + '\n', encoding='utf8')
            except SystemExit as e:
                print('HATA', e, flush=True)
    print(len(data), 'dil')


main()
