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
from build_site import BASE, COPY, build


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

    for lang, rel in [('tr', 'index.html'), ('en', 'en/index.html')]:
        path = SITE / rel
        source = path.read_text(encoding='utf-8')
        p = Page()
        p.feed(source)
        require(source == build(lang, COPY[lang]), f'{rel}: stale generated output')
        require(any(t == 'html' and a.get('lang') == lang for t, a in p.tags), f'{rel}: language')
        require(sum(t == 'h1' for t, _ in p.tags) == 1, f'{rel}: one H1')
        require(not p.duplicates, f'{rel}: duplicate IDs {p.duplicates}')
        require(any(t == 'main' for t, _ in p.tags), f'{rel}: main landmark')
        require(sum(t == 'details' for t, _ in p.tags) >= 6, f'{rel}: FAQs')
        links = [a for t, a in p.tags if t == 'link']
        canonical = BASE + ('en/' if lang == 'en' else '')
        require(any(a.get('rel') == 'canonical' and a.get('href') == canonical for a in links), f'{rel}: canonical')
        for locale in ['tr', 'en', 'x-default']:
            require(any(a.get('hreflang') == locale for a in links), f'{rel}: hreflang {locale}')
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
        require('aria-live="polite"' in source and 'inputmode="decimal"' in source, f'{rel}: accessible demo')
        require(('aylık aboneliktir' if lang == 'tr' else 'monthly subscriptions') in source, f'{rel}: monthly-only paid offers')
        require(('Google Play’den' if lang == 'tr' else 'cancel in Google Play') in source, f'{rel}: cancellation information')
        require('7-day free trial' not in source and '7 gün ücretsiz' not in source, f'{rel}: no unverified fixed trial promise')
    sitemap = ET.parse(SITE / 'sitemap.xml')
    urls = {node.text for node in sitemap.findall('.//{*}loc')}
    require(urls == {BASE, BASE + 'en/'}, 'Sitemap canonical URLs')
    require(BASE + 'sitemap.xml' in (SITE / 'robots.txt').read_text(), 'robots sitemap URL')
    for file, dims in [('social.png', (1200, 630)), ('icon.png', (1024, 1024))]:
        data = (SITE / 'assets' / file).read_bytes()
        require(data[:8] == b'\x89PNG\r\n\x1a\n' and struct.unpack('>II', data[16:24]) == dims, f'{file}: PNG dimensions')
    css = (SITE / 'assets/site.css').read_text()
    require('prefers-reduced-motion' in css and ':focus-visible' in css, 'Motion and focus accessibility')
    require('@media(max-width:620px)' in css, 'Mobile layout')
    require((SITE / '.nojekyll').exists(), 'Static Pages marker')
    if failures:
        print('\n'.join(f'FAIL: {failure}' for failure in failures))
        raise SystemExit(1)
    print(f'PASS: {count} static checks; TR/EN generation, links, SEO, metadata, accessibility hooks and assets.')


if __name__ == '__main__':
    check()
