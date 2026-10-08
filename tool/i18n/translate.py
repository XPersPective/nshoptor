"""app_en.arb -> yeni dillerin ARB dosyalari (Qwen, toplu, dogrulamali).

  python tool/i18n/translate.py <kod> [<kod> ...]      # orn. af az be
  python tool/i18n/translate.py --all                  # eksik tum diller

Anahtar yayin kokunden okunur (repoya girmez): AI_ENV ortam degiskeni ya da
D:/AppPublishing/apps/nshoptor/credentials/ai/ai.env. Her yanit yer tutucu ve
bos deger acisindan dogrulanir; gecmeyen parca yeniden istenir.
"""
import concurrent.futures as cf
import json
import os
import pathlib
import re
import sys
import urllib.request

ROOT = pathlib.Path(__file__).resolve().parents[2]
ARB = ROOT / 'lib/core/l10n'
ENV = os.environ.get('AI_ENV', 'D:/AppPublishing/apps/nshoptor/credentials/ai/ai.env')

NAMES = {
    'af': 'Afrikaans', 'az': 'Azerbaijani (Latin)', 'be': 'Belarusian', 'bg': 'Bulgarian', 'bn': 'Bengali',
    'bs': 'Bosnian (Latin)', 'ca': 'Catalan', 'cs': 'Czech', 'da': 'Danish', 'el': 'Greek', 'et': 'Estonian',
    'eu': 'Basque', 'fa': 'Persian (Farsi)', 'fi': 'Finnish', 'fil': 'Filipino', 'gl': 'Galician',
    'gu': 'Gujarati', 'he': 'Hebrew', 'hi': 'Hindi', 'hr': 'Croatian', 'hu': 'Hungarian', 'hy': 'Armenian',
    'id': 'Indonesian', 'is': 'Icelandic', 'ja': 'Japanese', 'ka': 'Georgian', 'kk': 'Kazakh (Cyrillic)',
    'kn': 'Kannada', 'ko': 'Korean', 'ky': 'Kyrgyz', 'lo': 'Lao', 'lt': 'Lithuanian', 'lv': 'Latvian',
    'mk': 'Macedonian', 'ml': 'Malayalam', 'mn': 'Mongolian (Cyrillic)', 'mr': 'Marathi', 'ms': 'Malay',
    'my': 'Burmese', 'ne': 'Nepali', 'nl': 'Dutch', 'pa': 'Punjabi (Gurmukhi)', 'pl': 'Polish',
    'ps': 'Pashto', 'ro': 'Romanian', 'si': 'Sinhala', 'sk': 'Slovak', 'sl': 'Slovenian', 'sq': 'Albanian',
    'sr': 'Serbian (Cyrillic)', 'sv': 'Swedish', 'sw': 'Swahili', 'ta': 'Tamil', 'te': 'Telugu', 'th': 'Thai',
    'uk': 'Ukrainian', 'ur': 'Urdu', 'uz': 'Uzbek (Latin)', 'vi': 'Vietnamese', 'zh': 'Chinese (Simplified)',
    'zu': 'Zulu',
}
COPY = {'tl': 'fil'}  # Tagalog = Filipino metni
PH = re.compile(r'\{(\w+)\}')
CHUNK = 60

PROMPT = """You translate the UI strings of NShoptor, a grocery shopping planner Android app (plan a list with estimated prices, enter real prices in the store, scan receipts, compare planned vs real, spending charts, AI help, Pro/Max subscriptions, ads).
Translate from English into {lang}.
Rules:
- Natural, short, friendly app wording a native speaker would use; same tone for buttons and messages.
- Keep every {{placeholder}} exactly as is (same names, same count). Keep the product words NShoptor, Pro, Max unchanged. "AI" is written the way native speakers write it; latin "AI" is fine if that is normal in {lang}.
- Keep digits and symbols like the middle dot, arrows, % and units such as kg, L unless the language normally writes them differently.
- Do not add or drop sentences. No explanations.
Return ONE JSON object with exactly the same keys, values translated."""


def conf():
    lines = pathlib.Path(ENV).read_text(encoding='utf8').splitlines()
    c = dict(l.split('=', 1) for l in lines if '=' in l and not l.startswith('#'))
    return c['AI_URL'].strip(), c['AI_MODEL'].strip(), c['AI_KEY'].strip()


def ask(lang, part):
    url, model, k = conf()
    body = {
        'model': model,
        'messages': [
            {'role': 'system', 'content': PROMPT.format(lang=lang)},
            {'role': 'user', 'content': json.dumps(part, ensure_ascii=False)},
        ],
        'response_format': {'type': 'json_object'},
        'temperature': 0.2,
        'enable_thinking': False,
    }
    req = urllib.request.Request(url + '/chat/completions', json.dumps(body).encode(),
                                 {'content-type': 'application/json', 'authorization': 'Bearer ' + k})
    with urllib.request.urlopen(req, timeout=240) as r:
        txt = json.load(r)['choices'][0]['message']['content']
    return json.loads(txt)


def bad(src, out):
    """Parcada gecmeyen anahtarlar."""
    wrong = []
    for k, v in src.items():
        t = out.get(k)
        if not isinstance(t, str) or not t.strip() or sorted(PH.findall(t)) != sorted(PH.findall(v)):
            wrong.append(k)
    return wrong


def translate(code):
    lang = NAMES[code]
    en = json.loads((ARB / 'app_en.arb').read_text(encoding='utf8'))
    keys = [k for k in en if not k.startswith('@')]
    todo = {k: en[k] for k in keys}
    result = {}
    for _ in range(4):
        items = list(todo.items())
        for part in (dict(items[i:i + CHUNK]) for i in range(0, len(items), CHUNK)):
            try:
                out = ask(lang, part)
            except Exception as e:  # ag/JSON hatasi: parca bir sonraki turda yeniden
                print(code, 'hata', type(e).__name__, str(e)[:80], flush=True)
                continue
            wrong = set(bad(part, out))
            for k in part:
                if k not in wrong:
                    result[k] = out[k]
        todo = {k: en[k] for k in keys if k not in result}
        if not todo:
            break
    if todo:
        raise SystemExit(f'{code}: {len(todo)} anahtar cevrilemedi: {list(todo)[:5]}')
    doc = {'@@locale': code, **{k: result[k] for k in keys}}
    (ARB / f'app_{code}.arb').write_text(json.dumps(doc, ensure_ascii=False, indent=2) + '\n', encoding='utf8')
    return code


def main(args):
    codes = [c for c in NAMES if not (ARB / f'app_{c}.arb').exists()] if args == ['--all'] else args
    codes = [c for c in codes if c in NAMES]
    with cf.ThreadPoolExecutor(6) as ex:
        for f in cf.as_completed([ex.submit(translate, c) for c in codes]):
            try:
                print('tamam', f.result(), flush=True)
            except SystemExit as e:
                print('HATA', e, flush=True)
    for tl, src in COPY.items():
        s = ARB / f'app_{src}.arb'
        if s.exists():
            t = json.loads(s.read_text(encoding='utf8'))
            t['@@locale'] = tl
            (ARB / f'app_{tl}.arb').write_text(json.dumps(t, ensure_ascii=False, indent=2) + '\n', encoding='utf8')


if __name__ == '__main__':
    main(sys.argv[1:])
