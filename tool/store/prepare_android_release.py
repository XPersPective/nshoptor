"""Prepare private runner-temporary inputs for a verified Android release build."""
import argparse
import base64
import binascii
import json
import os
from pathlib import Path
import re
import shutil
import sys


TEMP_NAME = 'nshoptor-android-release'
ADS_KEYS = {
    'ADMOB_APP_ID_ANDROID',
    'ADMOB_BANNER_ANDROID',
    'ADMOB_INTERSTITIAL_ANDROID',
    'ADMOB_APP_OPEN_ANDROID',
    'ADMOB_REWARDED_ANDROID',
}
REQUIRED_ADS = ADS_KEYS - {'ADMOB_REWARDED_ANDROID'}
TEST_PUBLISHER = '3940256099942544'


def private_temp_dir():
    runner_temp = Path(os.environ['RUNNER_TEMP']).resolve(strict=True)
    target = runner_temp / TEMP_NAME
    if target.exists() and target.is_symlink():
        raise ValueError('Refusing a symlinked temporary directory')
    if target.parent != runner_temp:
        raise ValueError('Temporary path escaped runner temp')
    return runner_temp, target


def decode_secret(name):
    value = os.environ.get(name, '')
    if not value:
        raise ValueError(f'Missing required secret: {name}')
    try:
        return base64.b64decode(value, validate=True)
    except (binascii.Error, ValueError):
        raise ValueError(f'Invalid base64 secret: {name}') from None


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError('Duplicate key in AdMob configuration')
        result[key] = value
    return result


def load_ads():
    try:
        ads = json.loads(os.environ['NSHOPTOR_ANDROID_ADS_JSON'], object_pairs_hook=unique_object)
    except (KeyError, json.JSONDecodeError):
        raise ValueError('AdMob configuration is missing or invalid JSON') from None
    if not isinstance(ads, dict) or set(ads) - ADS_KEYS or not REQUIRED_ADS <= set(ads):
        raise ValueError('AdMob configuration must contain the required Android IDs only')
    for key, value in ads.items():
        if not isinstance(value, str):
            raise ValueError(f'AdMob value must be text: {key}')
        pattern = r'ca-app-pub-\d{16}~\d{10}' if key == 'ADMOB_APP_ID_ANDROID' else r'ca-app-pub-\d{16}/\d{10}'
        if not re.fullmatch(pattern, value) or TEST_PUBLISHER in value:
            raise ValueError(f'AdMob value is not a production-format identifier: {key}')
    return ads


def rewrite_store_file(properties, keystore_path):
    lines = properties.splitlines(keepends=True)
    matches = []
    for index, line in enumerate(lines):
        content = line.rstrip(b'\r\n')
        if content.startswith(b'storeFile='):
            matches.append((index, content[len(b'storeFile='):], line[len(content):]))
    if len(matches) != 1:
        raise ValueError('Signing properties must contain exactly one storeFile entry')
    index, _, ending = matches[0]
    lines[index] = b'storeFile=' + str(keystore_path).encode('utf-8') + ending
    return b''.join(lines)


def write_private(path, data):
    descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    with os.fdopen(descriptor, 'wb') as output:
        output.write(data)


def prepare():
    runner_temp, target = private_temp_dir()
    if target.exists():
        raise ValueError('Temporary release directory already exists')
    ads = load_ads()
    keystore = decode_secret('NSHOPTOR_ANDROID_KEYSTORE_BASE64')
    properties = decode_secret('NSHOPTOR_ANDROID_PROPERTIES_BASE64')
    target.mkdir(mode=0o700)
    try:
        os.chmod(target, 0o700)
        keystore_path = target / 'upload.jks'
        props_path = target / 'key.properties'
        ads_path = target / 'ads.json'
        write_private(keystore_path, keystore)
        write_private(props_path, rewrite_store_file(properties, keystore_path))
        define_keys = ADS_KEYS - {'ADMOB_APP_ID_ANDROID'}
        defines = {key: ads[key] for key in sorted(define_keys) if key in ads}
        write_private(ads_path, json.dumps(defines, separators=(',', ':')).encode('utf-8'))
        github_env = Path(os.environ['GITHUB_ENV'])
        print(f'::add-mask::{ads["ADMOB_APP_ID_ANDROID"]}')
        with github_env.open('a', encoding='utf-8') as output:
            output.write(f'NSHOPTOR_SIGNING={props_path}\n')
            output.write(f'ADMOB_APP_ID_ANDROID={ads["ADMOB_APP_ID_ANDROID"]}\n')
        print('Android signing and AdMob inputs prepared in runner temp.')
    except Exception:
        shutil.rmtree(target)
        raise


def cleanup():
    runner_temp, target = private_temp_dir()
    if target.exists():
        if target.is_symlink() or target.resolve().parent != runner_temp:
            raise ValueError('Refusing unsafe temporary cleanup path')
        shutil.rmtree(target)
    print('Android temporary inputs removed.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=('prepare', 'cleanup'))
    args = parser.parse_args()
    try:
        prepare() if args.command == 'prepare' else cleanup()
    except (KeyError, OSError, ValueError) as exc:
        print(f'Android release preparation failed: {exc}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
