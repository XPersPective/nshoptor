"""Read the app's actual language inventory and existing translations, without fallback."""
import html
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
BASE = 'https://xperspective.github.io/nshoptor/'
RTL = frozenset(('ar', 'fa', 'he', 'ps', 'ur'))
REQUIRED = ('slogan', 'aboutBody', 'languageLabel', 'howToUseLabel', 'itemFormTitle',
            'voiceInputTitle', 'priceCandidatesTitle', 'receiptReviewTitle',
            'guideAddBody', 'guideVoiceBody', 'guidePricesBody', 'guideReceiptBody',
            'plansTitle', 'planFree', 'planFreeAi', 'planProAi', 'planNoAds',
            'planBackup', 'plansLegal', 'planLegacyRights', 'privacyInfoLabel',
            'supportEmailLabel')


def languages():
    source = (ROOT/'lib/core/l10n/language_names.dart').read_text(encoding='utf-8')
    match = re.search(r'appLanguages\s*=\s*\{(.*?)\};', source, re.S)
    if not match:
        raise ValueError('Missing appLanguages map')
    pairs = re.findall(r"^\s*'([a-z]+)':\s*'([^']+)'", match.group(1), re.M)
    result = dict(pairs)
    if len(pairs) != 71 or len(result) != 71:
        raise ValueError('Expected exactly 71 unique appLanguages')
    return result


LANGUAGES = languages()


def translation(code):
    data = json.loads((ROOT/'lib/core/l10n'/f'app_{code}.arb').read_text(encoding='utf-8'))
    for key in REQUIRED:
        if not isinstance(data.get(key), str) or not data[key].strip():
            raise ValueError(f'{code}: missing localized {key}; no fallback permitted')
        if '{' in data[key] or '}' in data[key]:
            raise ValueError(f'{code}: unresolved placeholder in {key}')
    return data


def relative_page(code):
    return 'index.html' if code == 'tr' else f'{code}/index.html'


def canonical(code):
    return BASE if code == 'tr' else f'{BASE}{code}/'


def direction(code):
    return 'rtl' if code in RTL else 'ltr'


def hreflang_links():
    return '\n'.join(f'<link rel="alternate" hreflang="{code}" href="{canonical(code)}">'
                     for code in LANGUAGES) + f'\n<link rel="alternate" hreflang="x-default" href="{BASE}">'


def language_chooser(code):
    prefix = '' if code == 'tr' else '../'
    links = []
    for target, name in LANGUAGES.items():
        href = (prefix or './') if target == 'tr' else f'{prefix}{target}/'
        current = ' aria-current="page"' if target == code else ''
        links.append(f'<li><a href="{href}" lang="{target}" hreflang="{target}" dir="{direction(target)}"{current}>{html.escape(name)}</a></li>')
    label = html.escape(translation(code)['languageLabel'])
    return f'<details class="locale-picker"><summary>{label} · <bdi>{html.escape(LANGUAGES[code])}</bdi></summary><ul class="locale-list">' + ''.join(links) + '</ul></details>'
