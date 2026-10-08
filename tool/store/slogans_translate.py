"""Tanitim gorseli sloganlari -> test/store_slogans.json (elle yazilan 9 dil haric)."""
import concurrent.futures as cf
import json
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1] / 'i18n'))
import translate as T  # noqa: E402

OUT = pathlib.Path(__file__).resolve().parents[2] / 'test/store_slogans.json'
SRC = {'a': 'Plan it. Shop it. Compare it.', 'b': 'AI matches your receipt.'}
HAND = {'tr', 'en', 'de', 'fr', 'es', 'it', 'pt', 'ru', 'ar'}
T.NAMES['tl'] = 'Filipino'
T.PROMPT = ('Translate this two-line slogan of a grocery shopping app into {lang}: short, punchy, natural for a native speaker; '
            'line a has three very short imperative sentences (max 36 characters in total), line b max 36 characters. '
            'Return ONE JSON object with keys a and b.')


def one(code):
    for _ in range(5):
        try:
            out = T.ask(T.NAMES[code], SRC)
        except Exception as e:
            print(code, 'hata', str(e)[:60], flush=True)
            continue
        if all(isinstance(out.get(k), str) and 0 < len(out[k].strip()) <= 44 for k in SRC):
            return code, {k: out[k].strip() for k in SRC}
    raise SystemExit(code + ' cevrilemedi')


data = json.loads(OUT.read_text(encoding='utf8')) if OUT.exists() else {}
codes = [c for c in T.NAMES if c not in data and c not in HAND]
with cf.ThreadPoolExecutor(6) as ex:
    for f in cf.as_completed([ex.submit(one, c) for c in codes]):
        try:
            c, v = f.result()
            data[c] = v
            OUT.write_text(json.dumps(data, ensure_ascii=False, indent=1) + '\n', encoding='utf8')
        except SystemExit as e:
            print('HATA', e, flush=True)
print(len(data), 'dil')
