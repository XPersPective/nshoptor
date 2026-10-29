"""Dependency-free structural checks for the committed GitHub Pages artifact."""
from html.parser import HTMLParser
import json
from pathlib import Path
import struct
import sys
from urllib.parse import urlsplit, unquote
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[2]
SITE = ROOT / 'website'
sys.path.insert(0, str(Path(__file__).parent))
from build_site import BASE, build_page, build_sitemap
from locale_data import LANGUAGES, RTL, REQUIRED, canonical as locale_canonical, relative_page, translation


class Page(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.tags = []
        self.ids = set()
        self.duplicates = []
        self.json_scripts = []
        self.in_json = False

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        self.tags.append((tag, attrs))
        if 'id' in attrs:
            if attrs['id'] in self.ids:
                self.duplicates.append(attrs['id'])
            self.ids.add(attrs['id'])
        if tag == 'script' and attrs.get('type') == 'application/ld+json':
            self.in_json = True

    def handle_endtag(self, tag):
        if tag == 'script':
            self.in_json = False

    def handle_data(self, data):
        if self.in_json:
            self.json_scripts.append(data)


def check():
    failures = []
    count = 0

    def require(condition, message):
        nonlocal count
        count += 1
        if not condition:
            failures.append(message)

    expected_pages = {relative_page(lang) for lang in LANGUAGES}
    actual_pages = {path.relative_to(SITE).as_posix() for path in SITE.rglob('index.html')}
    require(actual_pages == expected_pages and len(actual_pages) == 71, 'Exactly 71 unique language pages; no stale/extra pages')
    english = translation('en')
    for lang in LANGUAGES:
        rel = relative_page(lang)
        path = SITE / rel
        source = path.read_text(encoding='utf-8')
        p = Page()
        p.feed(source)
        require(source == build_page(lang), f'{rel}: stale generated output from current ARB/language inventory')
        require(any(t == 'html' and a.get('lang') == lang and a.get('dir') == ('rtl' if lang in RTL else 'ltr') for t, a in p.tags), f'{rel}: language and direction')
        require(sum(t == 'h1' for t, _ in p.tags) == 1, f'{rel}: one H1')
        require(not p.duplicates, f'{rel}: duplicate IDs {p.duplicates}')
        require(any(t == 'main' for t, _ in p.tags), f'{rel}: main landmark')
        if lang in ('tr','en'):
            require(sum(t == 'details' for t, _ in p.tags) >= 7, f'{rel}: FAQs and language directory preserved')
        require(any(t == 'details' and a.get('class') == 'locale-picker' for t,a in p.tags), f'{rel}: native no-JS language disclosure')
        language_links = [a for t,a in p.tags if t == 'a' and a.get('hreflang') in LANGUAGES]
        require({a['hreflang'] for a in language_links} == set(LANGUAGES), f'{rel}: all 71 language links')
        for code, name in LANGUAGES.items():
            require(name in source, f'{rel}: native language self-name {code}')
        require(any(a.get('hreflang') == lang and a.get('aria-current') == 'page' for a in language_links), f'{rel}: current language indication')
        links = [a for t, a in p.tags if t == 'link']
        canonical = locale_canonical(lang)
        require(any(a.get('rel') == 'canonical' and a.get('href') == canonical for a in links), f'{rel}: canonical')
        alternate = [a for a in links if a.get('rel') == 'alternate']
        expected_alternates = {code:locale_canonical(code) for code in LANGUAGES} | {'x-default':BASE}
        require(len(alternate) == 72 and {a.get('hreflang'):a.get('href') for a in alternate} == expected_alternates, f'{rel}: exactly reciprocal 71 + x-default hreflang URLs')
        for meta in ['description', 'viewport']:
            require(any(t == 'meta' and a.get('name') == meta and a.get('content') for t, a in p.tags), f'{rel}: meta {meta}')
        for prop in ['og:title', 'og:description', 'og:image', 'og:url']:
            require(any(t == 'meta' and a.get('property') == prop and a.get('content') for t, a in p.tags), f'{rel}: {prop}')
        require(len(p.json_scripts) == 1, f'{rel}: JSON-LD count')
        for data in p.json_scripts:
            schema = json.loads(data)
            require(schema['@type'] == 'WebSite' and schema['url'] == canonical, f'{rel}: truthful schema')
            require('aggregateRating' not in data and 'offers' not in data, f'{rel}: no invented ratings/pricing')
        for tag, attrs in p.tags:
            if tag == 'img':
                require(all(a in attrs for a in ['alt', 'width', 'height']), f'{rel}: image accessibility/dimensions')
            for attribute in ['href', 'src']:
                value = attrs.get(attribute)
                if not value:
                    continue
                require(not value.lower().startswith('javascript:'), f'{rel}: unsafe URL')
                parsed = urlsplit(value)
                if parsed.scheme or parsed.netloc:
                    continue
                require(not value.startswith('/'), f'{rel}: project Pages relative path required: {value}')
                target = (path.parent / unquote(parsed.path)).resolve() if parsed.path else path
                if target.is_dir():
                    target /= 'index.html'
                require(target.is_relative_to(SITE.resolve()) and target.is_file(), f'{rel}: broken local URL {value}')
                if parsed.fragment and target == path:
                    require(parsed.fragment in p.ids, f'{rel}: missing anchor {value}')
            for description in attrs.get('aria-describedby', '').split():
                require(description in p.ids, f'{rel}: missing description {description}')
        require('apps.apple.com' not in source, f'{rel}: no unverified iOS product URL')
        require('com.crazypenguin.nshoptor' in source and 'docs/store/privacy-policy.md' in source, f'{rel}: store/privacy links')
        require(not any(t == 'script' and a.get('src','').startswith(('https:', '//')) for t,a in p.tags), f'{rel}: no external scripts')
        if lang in ('tr','en'):
            require('aria-live="polite"' in source and 'inputmode="decimal"' in source, f'{rel}: accessible demo')
            require(('yıllık Pro aboneliğidir' if lang == 'tr' else 'annual Pro subscription') in source, f'{rel}: annual Pro paid offer')
            require(('vergiler öncesi' if lang == 'tr' else 'before applicable local taxes') in source, f'{rel}: base price before tax')
            require(('nihai fiyat' if lang == 'tr' else 'final localized price') in source, f'{rel}: final store price')
            require(('yılda 1 ABD doları' if lang == 'tr' else 'USD 1 per year') in source, f'{rel}: annual base price')
            require('monthly subscriptions' not in source and 'aylık aboneliktir' not in source, f'{rel}: no obsolete paid offer')
            require(('Google Play’den' if lang == 'tr' else 'cancel in Google Play') in source, f'{rel}: cancellation information')
        else:
            from html import unescape
            data = translation(lang)
            rendered = unescape(source)
            for key in REQUIRED:
                require(data[key] in rendered, f'{rel}: exact localized source content {key}')
            for key in ('slogan','aboutBody','guideAddBody','guideVoiceBody','guidePricesBody','guideReceiptBody','plansLegal'):
                require(data[key] != english[key], f'{rel}: {key} is not an English fallback copy')
            require(not any(t == 'script' and a.get('src') for t,a in p.tags), f'{rel}: compact pages need no JavaScript')
            require('data-market-price' not in source, f'{rel}: no untranslated interactive demo')
            require(data['privacyInfoBody'] not in rendered, f'{rel}: omit simplified privacy storage statement')
        require('7-day free trial' not in source and '7 gün ücretsiz' not in source, f'{rel}: no unverified fixed trial promise')
    sitemap = ET.parse(SITE / 'sitemap.xml')
    urls = {node.text for node in sitemap.findall('.//{*}loc')}
    require(urls == {locale_canonical(code) for code in LANGUAGES} and len(sitemap.findall('.//{*}loc')) == 71, 'Sitemap exactly71 canonical URLs')
    require((SITE/'sitemap.xml').read_text(encoding='utf-8') == build_sitemap(), 'Sitemap current generated output')
    require(BASE + 'sitemap.xml' in (SITE / 'robots.txt').read_text(), 'robots sitemap URL')
    for file, dims in [('social.png', (1200, 630)), ('icon.png', (1024, 1024))]:
        data = (SITE / 'assets' / file).read_bytes()
        require(data[:8] == b'\x89PNG\r\n\x1a\n' and struct.unpack('>II', data[16:24]) == dims, f'{file}: PNG dimensions')
    css = (SITE / 'assets/site.css').read_text()
    require('prefers-reduced-motion' in css and ':focus-visible' in css, 'Motion and focus accessibility')
    require('@media(max-width:620px)' in css, 'Mobile layout')
    require('min-height:44px' in css and 'overflow-wrap:anywhere' in css and '[dir=rtl]' in css, 'Localized target size, long text and RTL layout')
    require(sum(path.stat().st_size for path in (SITE/'assets').iterdir() if path.suffix in ('.css','.js')) <= 200_000, 'CSS+JS budget <=200KB')
    require('@import' not in css and 'fonts.googleapis.com' not in css, 'No external font dependency')
    require((SITE / '.nojekyll').exists(), 'Static Pages marker')
    if failures:
        print('\n'.join(f'FAIL: {failure}' for failure in failures))
        raise SystemExit(1)
    print(f'PASS: {count} static checks; exact71 pages, current localized content, reciprocal SEO, local links, TR/EN interaction hooks and assets.')


if __name__ == '__main__':
    check()
