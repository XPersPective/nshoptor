"""Verify the existing Android release without displaying signing secrets."""
import argparse
import base64
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import zipfile


def fields(data):
    def varint(pos):
        result = shift = 0
        while True:
            value = data[pos]
            pos += 1
            result |= (value & 127) << shift
            if value < 128:
                return result, pos
            shift += 7
    pos = 0
    while pos < len(data):
        tag, pos = varint(pos)
        kind = tag & 7
        if kind == 2:
            length, pos = varint(pos)
            value = data[pos:pos + length]
            pos += length
        elif kind == 0:
            value, pos = varint(pos)
        elif kind in (1, 5):
            size = 8 if kind == 1 else 4
            value = data[pos:pos + size]
            pos += size
        else:
            raise ValueError('Unsupported protobuf wire type')
        yield tag >> 3, value


def elements(node):
    for number, data in fields(node):
        if number != 2 or not isinstance(data, bytes):
            continue
        name = ''
        attrs = {}
        children = []
        for key, value in fields(data):
            if key == 2:
                name = value.decode()
            elif key == 4:
                attr = dict(fields(value))
                attrs[attr[2].decode()] = attr.get(3, b'').decode()
            elif key == 5:
                children.append(value)
        yield name, attrs
        for child in children:
            yield from elements(child)


def run(command, password=None):
    result = subprocess.run(command, input=password, capture_output=True)
    if result.returncode:
        raise RuntimeError('Release verification command failed; output withheld')
    return result.stdout


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--aab', required=True)
    parser.add_argument('--signing-properties', required=True)
    parser.add_argument('--java-bin', required=True)
    parser.add_argument('--version-code', required=True)
    args = parser.parse_args()
    aab = Path(args.aab).resolve()
    signing = Path(args.signing_properties).resolve()
    props = dict(line.strip().split('=', 1) for line in signing.read_text().splitlines()
                 if '=' in line and not line.lstrip().startswith('#'))
    java = Path(args.java_bin)
    run([str(java / 'jarsigner.exe'), '-verify', str(aab)])
    expected = run([str(java / 'keytool.exe'), '-exportcert', '-keystore',
                    str(signing.parent / props['storeFile']), '-alias', props['keyAlias']],
                   (props['storePassword'] + '\n').encode())
    actual = run([str(java / 'keytool.exe'), '-printcert', '-jarfile', str(aab), '-rfc'])
    match = re.search(rb'-----BEGIN CERTIFICATE-----\s*(.*?)\s*-----END CERTIFICATE-----',
                      actual, re.S)
    assert match and base64.b64decode(match[1]) == expected, 'Upload certificate mismatch'
    native_count = 0
    with zipfile.ZipFile(aab) as bundle:
        manifest = dict(elements(bundle.read('base/manifest/AndroidManifest.xml')))
        app = manifest['manifest']
        assert app['package'] == 'com.crazypenguin.nshoptor', 'Package mismatch'
        assert app['versionCode'] == args.version_code, 'Version mismatch'
        assert manifest['application'].get('debuggable', 'false') != 'true', 'Debug build'
        for name in bundle.namelist():
            if not name.endswith('.so'):
                continue
            data = bundle.read(name)
            assert data[:4] == b'\x7fELF', 'Invalid native library'
            endian = '<' if data[5] == 1 else '>'
            is64 = data[4] == 2
            offset = struct.unpack_from(endian + ('Q' if is64 else 'I'), data, 32 if is64 else 28)[0]
            size, count = struct.unpack_from(endian + 'HH', data, 54 if is64 else 42)
            for index in range(count):
                pos = offset + index * size
                if struct.unpack_from(endian + 'I', data, pos)[0] == 1:
                    alignment = struct.unpack_from(endian + ('Q' if is64 else 'I'), data, pos + (48 if is64 else 28))[0]
                    assert alignment >= 16384, 'Native LOAD alignment below 16KB'
            native_count += 1
    print(json.dumps({'package': app['package'], 'version_name': app['versionName'],
                      'version_code': app['versionCode'], 'target_sdk': manifest['uses-sdk']['targetSdkVersion'],
                      'bytes': aab.stat().st_size, 'sha256': hashlib.sha256(aab.read_bytes()).hexdigest(),
                      'upload_certificate_sha256': hashlib.sha256(expected).hexdigest(),
                      'signature_matches_upload_key': True, 'native_16kb_libraries_checked': native_count}))


if __name__ == '__main__':
    main()
