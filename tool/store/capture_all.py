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
APPLE_MAP = {
    'ar': ['ar-SA'], 'bn': ['bn-BD'], 'ca': ['ca'], 'cs': ['cs'], 'da': ['da'],
    'de': ['de-DE'], 'el': ['el'], 'en': ['en-US', 'en-AU', 'en-CA', 'en-GB'],
    'es': ['es-ES', 'es-MX'], 'fi': ['fi'], 'fr': ['fr-FR', 'fr-CA'], 'gu': ['gu-IN'],
    'he': ['he'], 'hi': ['hi'], 'hr': ['hr'], 'hu': ['hu'], 'id': ['id'], 'it': ['it'],
    'ja': ['ja'], 'kn': ['kn-IN'], 'ko': ['ko'], 'ml': ['ml-IN'], 'mr': ['mr-IN'],
    'ms': ['ms'], 'nl': ['nl-NL'], 'nb': ['no'], 'or': ['or-IN'], 'pa': ['pa-IN'],
    'pl': ['pl'], 'pt': ['pt-PT', 'pt-BR'], 'ro': ['ro'], 'ru': ['ru'], 'sk': ['sk'],
    'sl': ['sl-SI'], 'sv': ['sv'], 'ta': ['ta-IN'], 'te': ['te-IN'], 'th': ['th'],
    'tr': ['tr'], 'uk': ['uk'], 'ur': ['ur-PK'], 'vi': ['vi'],
    'zh': ['zh-Hans', 'zh-Hant'],
}
FONT_GROUPS = {
    'th': 'leelaw', 'lo': 'leelaw',
    'hi': 'nirmala', 'bn': 'nirmala', 'gu': 'nirmala', 'kn': 'nirmala',
    'ml': 'nirmala', 'mr': 'nirmala', 'ne': 'nirmala', 'pa': 'nirmala',
    'si': 'nirmala', 'ta': 'nirmala', 'te': 'nirmala',
    'ja': 'ja', 'ko': 'ko', 'zh': 'zh', 'my': 'my',
    'ar': 'segoe', 'fa': 'segoe', 'ur': 'segoe', 'he': 'segoe',
    'ka': 'segoe', 'hy': 'segoe', 'ps': 'segoe',
}
TMP = pathlib.Path('build/store_tmp')


def flutter(tests, code, out, devices=None):
    defines = [
        f'--dart-define=STORE_LOCALE={code}',
        f'--dart-define=STORE_OUT={out}',
    ]
    if devices:
        defines.append(f'--dart-define=STORE_DEVICES={",".join(devices)}')
    exe = shutil.which('flutter') or 'flutter'
    r = subprocess.run(
        [exe, 'test', *[f'test/{test}' for test in tests], '--no-pub', '--concurrency=1', '--update-goldens', *defines],
        capture_output=True, text=True, encoding='utf8', errors='replace', shell=False)
    msg = ((r.stdout or '') + '\n' + (r.stderr or '')).strip()[-600:]
    return r.returncode == 0, (msg or f'exit={r.returncode}')


def flutter_batch(tests, codes, out_root, devices=None):
    defines = [
        f'--dart-define=STORE_LOCALES={",".join(codes)}',
        f'--dart-define=STORE_OUT={out_root}',
    ]
    if devices:
        defines.append(f'--dart-define=STORE_DEVICES={",".join(devices)}')
    exe = shutil.which('flutter') or 'flutter'
    r = subprocess.run(
        [exe, 'test', *[f'test/{test}' for test in tests], '--no-pub', '--concurrency=1', '--update-goldens', *defines],
        capture_output=True, text=True, encoding='utf8', errors='replace', shell=False)
    msg = ((r.stdout or '') + '\n' + (r.stderr or '')).strip()[-800:]
    return r.returncode == 0, (msg or f'exit={r.returncode}')


def _clear_and_copy(srcs, dst_dir, suffix):
    dst_dir.mkdir(parents=True, exist_ok=True)
    for old in dst_dir.glob('*.png'):
        old.unlink()
    for f in srcs:
        shutil.copy(f, dst_dir / f'{f.stem}_{suffix}.png')


def _verify_group(folder, expected_size, label):
    files = sorted(folder.glob('0*.png'))
    assert len(files) == 8, f'{label}: expected 8 screenshots, got {len(files)}'
    for f in files:
        with Image.open(f) as img:
            assert img.size == expected_size, f'{label}: wrong screenshot size {img.size}'
            img.verify()
    return files


def _finalize_one(meta, code, devices, app_store_root=None):
    base = TMP / code / 'current'
    phone_files = _verify_group(base / 'phone', (1080, 1920), f'{code}/phone')
    land_files = _verify_group(base / 'phone_land', (1920, 1080), f'{code}/phone_land') if 'phone_land' in devices else []
    tab7_files = _verify_group(base / 'tablet7', (1920, 1200), f'{code}/tablet7') if 'tablet7' in devices else []
    tab10_files = _verify_group(base / 'tablet10', (2560, 1600), f'{code}/tablet10') if 'tablet10' in devices else []
    with Image.open(base / 'featureGraphic.png') as img:
        assert img.size == (1024, 500), f'{code}: wrong feature size'
        img.verify()
    for loc in [PLAY[code]] + COPIES.get(code, []):
        d = meta / loc / 'images'
        # Play phoneScreenshots: 6 portrait (01..06) + 2 landscape (07=01_land, 08=05_land) when phone_land enabled.
        if land_files:
            chosen_phone = phone_files[:6]
            _clear_and_copy(chosen_phone, d / 'phoneScreenshots', code)
            shutil.copy(land_files[0], d / 'phoneScreenshots' / f'07_{code}.png')
            shutil.copy(land_files[4], d / 'phoneScreenshots' / f'08_{code}.png')
        else:
            _clear_and_copy(phone_files, d / 'phoneScreenshots', code)
        if tab7_files:
            _clear_and_copy([tab7_files[0], tab7_files[1], tab7_files[4], tab7_files[5]], d / 'sevenInchScreenshots', code)
        if tab10_files:
            _clear_and_copy([tab10_files[0], tab10_files[1], tab10_files[4], tab10_files[5]], d / 'tenInchScreenshots', code)
        Image.open(base / 'featureGraphic.png').convert('RGB').save(d / 'featureGraphic.jpg', quality=92)
        icon = meta / 'en-US' / 'images' / 'icon.png'
        if not (d / 'icon.png').exists() and icon.exists():
            shutil.copy(icon, d / 'icon.png')
    if app_store_root is not None:
        iphone_files = _verify_group(base / 'iphone', (1290, 2796), f'{code}/iphone') if 'iphone' in devices else []
        ipad_files = _verify_group(base / 'ipad', (2048, 2732), f'{code}/ipad') if 'ipad' in devices else []
        ipad_land = _verify_group(base / 'ipad_land', (2732, 2048), f'{code}/ipad_land') if 'ipad_land' in devices else []
        picks = [0, 1, 3, 4, 5]  # 01, 02, 04, 05, 06
        land_picks = [0, 1, 4, 5]  # 01, 02, 05, 06
        for aloc in APPLE_MAP.get(code, []):
            ad = app_store_root / aloc
            ad.mkdir(parents=True, exist_ok=True)
            for idx, src_idx in enumerate(picks, start=1):
                if iphone_files:
                    shutil.copy(iphone_files[src_idx], ad / f'0{idx}_iphone.png')
                if ipad_files:
                    shutil.copy(ipad_files[src_idx], ad / f'0{idx}_ipad.png')
            for idx, src_idx in enumerate(land_picks, start=1):
                if ipad_land:
                    shutil.copy(ipad_land[src_idx], ad / f'0{idx}_ipad_land.png')
    return code, None


def _capture_one(meta, code, devices, app_store_root=None):
    base = TMP / code / 'current'
    ok, log = flutter(
        ['store_capture_test.dart', 'store_feature_test.dart'],
        code,
        str(base.resolve()).replace('\\', '/'),
        devices=devices,
    )
    if not ok:
        return code, log
    return _finalize_one(meta, code, devices, app_store_root)


def main(meta, codes, devices=None, workers=1, app_store_root=None):
    meta = pathlib.Path(meta)
    as_root = pathlib.Path(app_store_root) if app_store_root else None
    devices = devices or ['phone', 'phone_land', 'tablet7', 'tablet10']
    targets = codes or list(PLAY)
    failed = []
    if len(targets) == 1:
        _, err = _capture_one(meta, targets[0], devices, as_root)
        if err is not None:
            print('HATA', targets[0], err, flush=True)
            failed.append(targets[0])
        else:
            print('tamam', targets[0], flush=True)
    else:
        buckets = {}
        for code in targets:
            buckets.setdefault(FONT_GROUPS.get(code, 'default'), []).append(code)
        tmp_root = str(TMP.resolve()).replace('\\', '/')
        for _, group_codes in buckets.items():
            for i in range(0, len(group_codes), 12):
                chunk = group_codes[i:i + 12]
                ok, err = flutter_batch(
                    ['store_capture_test.dart', 'store_feature_test.dart'],
                    chunk,
                    tmp_root,
                    devices=devices,
                )
                if not ok:
                    print('BATCH HATA', chunk, err, flush=True)
                    failed.extend(chunk)
                    continue
                for code in chunk:
                    _finalize_one(meta, code, devices, as_root)
                    print('tamam', code, flush=True)
    if failed:
        raise SystemExit('Failed captures: ' + ', '.join(failed))


if __name__ == '__main__':
    import argparse
    p = argparse.ArgumentParser()
    p.add_argument('meta')
    p.add_argument('codes', nargs='*')
    p.add_argument('--devices', default='phone,phone_land,tablet7,tablet10')
    p.add_argument('--workers', type=int, default=1)
    p.add_argument('--app-store', default='')
    args = p.parse_args()
    main(
        args.meta,
        args.codes,
        [d.strip() for d in args.devices.split(',') if d.strip()],
        args.workers,
        args.app_store or None,
    )
