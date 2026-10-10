"""Tum Play dilleri icin ekran goruntuleri + tanitim gorseli uretir ve metadata
klasorune koyar.

  python tool/store/capture_all.py <metadata-koku> [<uygulama-kodu> ...]

Gereksinim: build/feature_bg.png (tanitim arka plani, bkz. store_feature_test).
Uygulama dil kodu -> Play yerel ayari eslemesi asagida; Play'de karsiligi olmayan
diller (bs, ps, tl, uz) atlanir. Bolgesel kopyalar (en-GB, es-419, ...) ayni
gorselleri alir.
"""
import pathlib
import shutil
import subprocess
import sys

from PIL import Image

PLAY = {
    'af': 'af', 'az': 'az-AZ', 'be': 'be', 'bg': 'bg', 'bn': 'bn-BD', 'ca': 'ca', 'cs': 'cs-CZ', 'da': 'da-DK',
    'de': 'de-DE', 'el': 'el-GR', 'en': 'en-US', 'es': 'es-ES', 'et': 'et', 'eu': 'eu-ES', 'fa': 'fa', 'fi': 'fi-FI',
    'fil': 'fil', 'fr': 'fr-FR', 'gl': 'gl-ES', 'gu': 'gu', 'he': 'iw-IL', 'hi': 'hi-IN', 'hr': 'hr', 'hu': 'hu-HU',
    'hy': 'hy-AM', 'id': 'id', 'is': 'is-IS', 'it': 'it-IT', 'ja': 'ja-JP', 'ka': 'ka-GE', 'kk': 'kk', 'kn': 'kn-IN',
    'ko': 'ko-KR', 'ky': 'ky-KG', 'lo': 'lo-LA', 'lt': 'lt', 'lv': 'lv', 'mk': 'mk-MK', 'ml': 'ml-IN', 'mn': 'mn-MN',
    'mr': 'mr-IN', 'ms': 'ms', 'my': 'my-MM', 'ne': 'ne-NP', 'nl': 'nl-NL', 'pa': 'pa', 'pl': 'pl-PL', 'pt': 'pt-PT',
    'ro': 'ro', 'ru': 'ru-RU', 'si': 'si-LK', 'sk': 'sk', 'sl': 'sl', 'sq': 'sq', 'sr': 'sr', 'sv': 'sv-SE', 'sw': 'sw',
    'ta': 'ta-IN', 'te': 'te-IN', 'th': 'th', 'tr': 'tr-TR', 'uk': 'uk', 'ur': 'ur', 'vi': 'vi', 'zh': 'zh-CN',
    'zu': 'zu', 'ar': 'ar',
}
COPIES = {'en': ['en-GB'], 'es': ['es-419', 'es-US'], 'fr': ['fr-CA'], 'pt': ['pt-BR'], 'zh': ['zh-TW']}
TMP = pathlib.Path('build/store_tmp')


def flutter(tests, code, out):
    r = subprocess.run(
        ['flutter', 'test', *[f'test/{test}' for test in tests], '--no-pub', '--concurrency=1', '--update-goldens', f'--dart-define=STORE_LOCALE={code}',
         f'--dart-define=STORE_OUT={out}'],
        capture_output=True, text=True, encoding='utf8', errors='replace', shell=True)
    return r.returncode == 0, r.stdout[-600:]


def main(meta, codes):
    meta = pathlib.Path(meta)
    failed = []
    for code in codes or PLAY:
        shots = fg = TMP / code / 'current'
        # golden yolu test/ dizinine goredir
        ok, log = flutter(['store_capture_test.dart', 'store_feature_test.dart'], code,
                          str(shots.resolve()).replace('\\', '/'))
        if not ok:
            print('HATA', code, log, flush=True)
            failed.append(code)
            continue
        files = sorted(shots.glob('0*.png'))
        assert len(files) == 8, f'{code}: expected 8 screenshots'
        for f in files:
            with Image.open(f) as img:
                assert img.size == (1080, 1920), f'{code}: wrong screenshot size'
                img.verify()
        with Image.open(fg / 'featureGraphic.png') as img:
            assert img.size == (1024, 500), f'{code}: wrong feature size'
            img.verify()
        for loc in [PLAY[code]] + COPIES.get(code, []):
            d = meta / loc / 'images'
            (d / 'phoneScreenshots').mkdir(parents=True, exist_ok=True)
            for old in (d / 'phoneScreenshots').glob('*.png'):
                old.unlink()
            for f in files:
                shutil.copy(f, d / 'phoneScreenshots' / f'{f.stem}_{code}.png')
            Image.open(fg / 'featureGraphic.png').convert('RGB').save(d / 'featureGraphic.jpg', quality=92)
            icon = meta / 'en-US' / 'images' / 'icon.png'
            if not (d / 'icon.png').exists() and icon.exists():
                shutil.copy(icon, d / 'icon.png')
        print('tamam', code, flush=True)
    if failed:
        raise SystemExit('Failed captures: ' + ', '.join(failed))


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2:])
