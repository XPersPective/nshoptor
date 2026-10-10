"""Store source/asset validation and the capture failure regression check."""
from pathlib import Path
import re
import sys
import unicodedata
from tempfile import TemporaryDirectory
from unittest.mock import patch
from PIL import Image
import capture_all as capture
import listing


def main():
    # A failed render must not silently succeed or delete existing store images.
    with TemporaryDirectory() as tmp:
        original = Path(tmp, 'en-US/images/phoneScreenshots/old.png')
        original.parent.mkdir(parents=True)
        original.write_bytes(b'owned regression sentinel')
        with patch.object(capture, 'flutter', return_value=(False, 'expected failure')):
            try:
                capture.main(tmp, ['en'])
            except SystemExit:
                pass
            else:
                raise AssertionError('capture failure was swallowed')
        assert original.read_bytes() == b'owned regression sentinel'
    expected = {v for v in capture.PLAY.values()} | {v for vs in capture.COPIES.values() for v in vs}
    assert set(listing.L) == expected, 'store locales missing or extra'
    for loc, values in listing.L.items():
        assert set(values) == set(listing.LIMITS)
        for key, limit in listing.LIMITS.items():
            assert values[key].strip() and len(values[key]) <= limit, (loc, key)
        normalized = ''.join(str(unicodedata.decimal(c)) if c.isdecimal() else c for c in values['full'])
        numbers = set(re.findall(r'\d+', normalized))
        assert {'10', '100', '300', '200', '1000', '71', '7'} <= numbers, (loc, 'quota/language/trial numbers')
        assert listing.REPO in values['full'], (loc, 'source link')
    if len(sys.argv) > 1:
        root = Path(sys.argv[1])
        for loc in expected:
            d = root / loc
            for key, name in [('title','title.txt'),('short','short_description.txt'),('full','full_description.txt')]:
                assert (d / name).read_text(encoding='utf-8').strip() == listing.L[loc][key].strip(), (loc,name)
            files = list((d / 'images/phoneScreenshots').glob('*.png'))
            assert len(files) == 8, loc
            for f in files:
                with Image.open(f) as img:
                    assert img.size == (1080,1920), f
                    img.verify()
            with Image.open(d / 'images/featureGraphic.jpg') as img:
                assert img.size == (1024,500), loc
                img.verify()
    print(f'PASS: {len(expected)} locales; quotas/limits/assets and capture failure preservation')


if __name__ == '__main__':
    main()
