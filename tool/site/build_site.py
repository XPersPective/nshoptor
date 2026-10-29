from pathlib import Path
import html
import json
from locale_data import (LANGUAGES, RTL, canonical as locale_canonical, direction,
                         hreflang_links, language_chooser, relative_page, translation)

ROOT = Path(__file__).resolve().parents[2]
BASE = 'https://xperspective.github.io/nshoptor/'
PRIVACY = 'https://github.com/XPersPective/nshoptor/blob/main/docs/store/privacy-policy.md'
PLAY = 'https://play.google.com/store/apps/details?id=com.crazypenguin.nshoptor'
COPY = {
 'tr': {
  'title':'NShoptor — Alışveriş listesi ve fiyat takibi',
  'description':'Alışverişinizi hazırlayın, evdeki tahminle marketteki fiyatı karşılaştırın. NShoptor: çevrimdışı liste, sesli giriş ve alışveriş özeti. Kullanım rehberini keşfedin.',
  'skip':'İçeriğe geç','guide':'Nasıl kullanılır?','download':'Mağaza durumu','other':'English','other_lang':'en','other_path':'en/',
  'eyebrow':'Alışverişe biraz açıklık getirin',
  'headline':'Liste hazır.<br>Zihniniz <em>rahat.</em>',
  'lead':'Evde planlayın. Markette gerçek fiyatı yazın. NShoptor ile ne alacağınızı, ne aldığınızı ve aradaki farkı tek yerde görün.',
  'cta':'Nasıl çalıştığını görün','note':'Hesap açmadan başlayın. Temel listeler internet olmadan çalışır.',
  'demo_label':'ETKİLEŞİMLİ ÖRNEK','demo_date':'Haftalık alışveriş','demo_sub':'3 ürün · TRY / Türk lirası',
  'names':['Domates','Makarna','Süt'],'units':['2 kg · evdeki tahmin isteğe bağlı','1 paket · alındı','1 litre · alındı'],
  'input':'Domatesin market toplamını deneyin','hint':'Örn. 85,50. 0 yazmayı veya fiyatı silmeyi de deneyin.',
  'sum':'Girilen market tutarları','caption':'Tanıtım için örnek veriler; uygulamanın ekran görüntüsü değildir. Bu alana yazdıklarınız kaydedilmez veya gönderilmez.',
  'ribbon':['Önce cihazınızda saklanan listeler','Evdeki tahmin & market fiyatı','İhtiyacınız olduğunda yapay zeka yardımı'],
  'flow_title':'Evden kasaya,<br>üç sade adım.',
  'flow_intro':'Temel işiniz alışveriş yapmak. Fiyat karşılaştırması, sesli giriş ve raporlar gerektiğinde elinizin altında.',
  'steps':[
   ['Listenizi hazırlayın','Listeye bir ad verin, ürünleri ve miktarlarını ekleyin. Evde düşündüğünüz fiyatı isterseniz girin; başlangıç için zorunlu değildir.'],
   ['Markette fiyatı girin','Ürüne dokunun ve market fiyatını yazın. Market fiyatı olan ürün alındı olarak görünür. Evdeki fiyat boş kalabilir; 0 da geçerli bir fiyattır.'],
   ['Sonucu gözden geçirin','Alışveriş özetinde girilen tutarları ve fiyat farklarını inceleyin. Kullanılabilir rapor ve dışa aktarma seçeneklerini uygulamada görün; bazıları plana bağlıdır.']],
  'detail_eyebrow':'Daha az yazmak için','detail_title':'Söyleyin.<br>Kontrol edin.<br>Listenize ekleyin.',
  'detail_body':'“İki kilo domates, üç paket makarna, bir litre süt.” Sesli giriş, yazma yükünü azaltır. Kaydetmeden önce ürün, miktar ve fiyat adaylarını gözden geçirin.',
  'detail_items':['“İki paket, tanesi 130 lira” → birim 130, toplam 260 TL.','“İki paketin toplamı 260 lira” → toplam 260, birim 130 TL.','Fiyatın birim mi toplam mı olduğu açık değilse önce doğrulayın. Fiş ve raf etiketi sonuçlarını da kaydetmeden kontrol edin.'],
  'faq_title':'Aklınıza<br>takılanlar.',
  'faqs':[
   ['İnternet olmadan kullanabilir miyim?','Temel listeler ve kaydettiğiniz fiyatlar cihazınızda tutulur. Yapay zeka yardımı, satın alma ve mağaza bağlantıları internet ister. Ses tanıma ve metin okuma, cihazın desteklediği dil ve kurulu modellere bağlıdır; gerekirse elle giriş yapabilirsiniz.'],
   ['Evdeki fiyatı girmem gerekiyor mu?','Hayır. Doğrudan market fiyatını yazabilirsiniz. Market fiyatı doluysa ürün alındı olarak görünür; 0 geçerlidir. Alanı tamamen temizlerseniz otomatik alındı durumu kalkar. Evdeki fiyat tek başına ürünü alındı yapmaz.'],
   ['Fiş ve raf etiketi okumaya güvenebilir miyim?','Okunan metin ve yapay zekanın önerileri hatalı olabilir. Ürünleri, miktarları ve özellikle birim/toplam tutarları kaydetmeden doğrulayın. Işık, bulanıklık ve baskı düzeni sonucu etkiler.'],
   ['Yapay zekaya hangi bilgiler gönderiliyor?','Yapay zeka yardımı isteğe bağlıdır; Ayarlar bölümünden kapatabilirsiniz. Kullanıldığında küçültülmüş fiş/etiket fotoğrafları (JPEG) veya seçili görev metni ve dil sunucu üzerinden sağlayıcıya gönderilir; Worker bunları kalıcı kaydetmez. Sunucu kota ve satın alma doğrulaması için ek kayıtlar işler. Ayrıntılı veri akışı ve saklama bilgileri gizlilik politikasındadır.'],
   ['Rapor ve yedekleme ücretsiz mi?','Alışveriş özeti, PDF ve CSV raporları temel özelliklerdendir. JSON yedekleme ve geri yükleme Pro hakkına dahildir; mevcut Max hakları da korunur. Satın almadan önce uygulamadaki güncel özellikleri ve Google Play fiyatını inceleyin.'],
   ['Ücretli planlar nasıl çalışır?','Yeni ücretli teklif yalnız yıllık Pro aboneliğidir: geçerli yerel vergiler öncesi baz fiyat yılda 1 ABD dolarıdır. Pro, her ay 100 yapay zeka isteği, reklamsız kullanım ve JSON yedekleme/geri yükleme içerir. Ücretsiz plan ayda 10 istek sunar. Yerelleştirilmiş nihai fiyat ve geçerli vergiler satın almadan önce Google Play’de gösterilir; her ülkede ödenecek tutarın tam 1 ABD doları olması garanti edilmez. İptal edilene kadar her yıl otomatik yenilenir. Aboneliğinizi Google Play’den yönetebilir veya iptal edebilirsiniz. Mevcut Pro/Max hakları ve satın almaları geri yükleme desteği korunur.'],
   ['iPhone veya Android için nereden edinebilirim?','Android mağaza adresini aşağıdan kontrol edebilirsiniz. Herkese açık indirme durumu bu sitede henüz doğrulanmamıştır; erişim test hesabına veya ülkeye bağlı olabilir. Doğrulanmış bir App Store ürün bağlantısı bulunmadığından iOS indirme düğmesi sunulmuyor.']],
  'download_title':'Bir sonraki alışverişe hazır olun.',
  'download_body':'Android mağaza adresinden güncel durumu kontrol edin. Bir sorunuz veya öneriniz varsa bize yazın.',
  'play':'Google Play’de durumu kontrol et','ios':'iOS · henüz indirme bağlantısı yok','availability':'Genel mağaza yayını doğrulanmadı. Bu sayfa indirme veya iOS yayını sözü vermez.',
  'privacy':'Gizlilik politikası','contact':'İletişim','source':'Kaynak kodu','footer':'Crazy Penguin · NShoptor',
 },
 'en': {
  'title':'NShoptor — Shopping lists and price tracking',
  'description':'Plan your shopping and compare your estimate with the market price. NShoptor brings offline lists, voice input and shopping summaries together. Explore the guide.',
  'skip':'Skip to content','guide':'How it works','download':'Store availability','other':'Türkçe','other_lang':'tr','other_path':'',
  'eyebrow':'A little clarity for your shopping',
  'headline':'List ready.<br>Mind <em>at ease.</em>',
  'lead':'Plan at home. Record the price in store. Keep what you need, what you bought and the price difference together with NShoptor.',
  'cta':'See how it works','note':'Start without an account. Basic lists work without internet.',
  'demo_label':'INTERACTIVE EXAMPLE','demo_date':'Weekly groceries','demo_sub':'3 items · TRY / Turkish lira',
  'names':['Tomatoes','Pasta','Milk'],'units':['2 kg · home estimate optional','1 pack · purchased','1 litre · purchased'],
  'input':'Try entering the tomatoes’ market total','hint':'E.g. 85.50. Try entering 0 or clearing the price, too.',
  'sum':'Recorded market amounts','caption':'Illustrative data, not an app screenshot. Nothing you enter here is saved or sent.',
  'ribbon':['Lists stored on your device first','Home estimate & market price','Optional AI help when you need it'],
  'flow_title':'From home to checkout,<br>three simple steps.',
  'flow_intro':'Shopping is the main task. Price comparison, voice input and reports are there when you need them.',
  'steps':[
   ['Prepare your list','Name your list and add products with their quantities. Enter a home price estimate if you like; it is optional.'],
   ['Record the market price','Tap an item and enter its market price. An item with a market price is marked purchased. A home price is optional, and 0 is a valid price.'],
   ['Review your shopping','Check recorded amounts and price differences in the shopping summary. Explore available reports and exports in the app; some depend on your plan.']],
  'detail_eyebrow':'Less typing','detail_title':'Say it.<br>Review it.<br>Add it to your list.',
  'detail_body':'“Two kilos of tomatoes, three packs of pasta, one litre of milk.” Voice input helps with typing. Review suggested products, quantities and prices before saving.',
  'detail_items':['“Two packs, 130 lira each” → 130 per unit, 260 TRY total.','“Two packs, 260 lira in total” → 260 total, 130 TRY per unit.','If the price could mean either per unit or total, confirm it first. Review receipt and shelf-label results before saving, too.'],
  'faq_title':'A few<br>useful answers.',
  'faqs':[
   ['Can I use it offline?','Basic lists and recorded prices stay on your device. AI help, purchases and store links need internet. Speech recognition and text reading depend on your device’s supported languages and installed models. Manual entry remains available.'],
   ['Do I need to enter a home price?','No. You can enter a market price directly. Any recorded market price marks the item purchased, including 0. Clearing the field removes the automatic purchased state. A home price alone does not mark an item purchased.'],
   ['Can I rely on receipt and shelf-label reading?','Text recognition and AI suggestions can make mistakes. Check products, quantities and especially unit versus total amounts before saving. Lighting, blur and print layouts can affect the result.'],
   ['What is sent to AI?','AI help is optional and can be switched off in Settings. When used, reduced-size receipt/label photos (JPEG) or selected task text and language are sent through our server to the provider; our Worker never stores them. The server also processes quota and purchase-verification metadata. See the privacy policy for the full data flow and retention details.'],
   ['Are reports and backups free?','Shopping summaries, PDF and CSV reports are core features. JSON backup and restore are included in Pro; existing Max access is also preserved. Check the current features in the app and the Google Play price before purchasing.'],
   ['How do paid plans work?','The only new paid offer is an annual Pro subscription: USD 1 per year base price before applicable local taxes. Pro includes 100 AI requests each month, no ads, and JSON backup and restore. Free includes 10 requests each month. Google Play shows the final localized price and applicable taxes before purchase; the payable amount is not guaranteed to be exactly USD 1 in every country. It renews automatically each year until cancelled. Manage or cancel in Google Play. Existing Pro/Max rights and purchase restoration remain supported.'],
   ['Where can I get it for Android or iPhone?','Check the Android store address below. Public download availability has not been verified on this site; access may depend on a test account or country. No verified App Store product link is available, so an iOS download button is not offered.']],
  'download_title':'Make room for your next shopping trip.',
  'download_body':'Check the Android store address for current availability. Send us your questions or suggestions by email.',
  'play':'Check availability on Google Play','ios':'iOS · no download link yet','availability':'Public store release is unverified. This page does not promise download or iOS availability.',
  'privacy':'Privacy policy','contact':'Contact','source':'Source code','footer':'Crazy Penguin · NShoptor',
 }
}

def esc(value):
 return html.escape(value, quote=True)

def build(lang,c):
 prefix = '../' if lang == 'en' else ''
 canonical = BASE + ('en/' if lang == 'en' else '')
 schema = {'@context':'https://schema.org','@type':'WebSite','name':'NShoptor','url':canonical,'inLanguage':lang,'description':c['description'],'publisher':{'@type':'Organization','name':'Crazy Penguin','email':'devcrazypenguin@gmail.com'}}
 steps = ''.join(f'<article class="step"><span class="number">0{i}</span><h3>{esc(title)}</h3><p>{esc(body)}</p></article>' for i,(title,body) in enumerate(c['steps'],1))
 faqs = ''.join(f'<details><summary>{esc(q)}</summary><p>{esc(a)}</p></details>' for q,a in c['faqs'])
 rows = ''.join(f'<div class="demo-row"><span class="circle checked" aria-hidden="true">✓</span><div class="product"><strong>{esc(c["names"][i])}</strong><small>{esc(c["units"][i])}</small></div><span class="price">{amount}</span></div>' for i,amount in [(1,'40,00 ₺' if lang=='tr' else 'TRY 40.00'),(2,'34,50 ₺' if lang=='tr' else 'TRY 34.50')])
 return f'''<!doctype html>
<html lang="{lang}" dir="ltr">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>{esc(c['title'])}</title>
<meta name="description" content="{esc(c['description'])}">
<meta name="theme-color" content="#17392e">
<link rel="canonical" href="{canonical}">
{hreflang_links()}
<meta property="og:type" content="website"><meta property="og:site_name" content="NShoptor">
<meta property="og:title" content="{esc(c['title'])}"><meta property="og:description" content="{esc(c['description'])}">
<meta property="og:url" content="{canonical}"><meta property="og:locale" content="{'tr_TR' if lang=='tr' else 'en_GB'}">
<meta property="og:image" content="{BASE}assets/social.png"><meta property="og:image:width" content="1200"><meta property="og:image:height" content="630"><meta property="og:image:alt" content="NShoptor — {'Alışveriş listesi ve fiyat takibi' if lang=='tr' else 'Shopping lists and price tracking'}">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" href="{prefix}assets/icon.png"><link rel="stylesheet" href="{prefix}assets/site.css">
<script type="application/ld+json">{json.dumps(schema,ensure_ascii=False)}</script>
<script src="{prefix}assets/site.js" defer></script>
</head>
<body>
<a class="skip" href="#main">{esc(c['skip'])}</a>
<div class="wrap">
<header><a class="brand" href="{prefix or './'}" aria-label="NShoptor"><img src="{prefix}assets/icon.png" width="34" height="34" alt="">NShoptor</a><nav aria-label="{'Ana gezinme' if lang=='tr' else 'Main navigation'}"><a class="guide-link" href="#guide">{esc(c['guide'])}</a><a href="#download">{esc(c['download'])}</a><a class="language" lang="{c['other_lang']}" hreflang="{c['other_lang']}" href="{prefix + c['other_path'] or './'}">{esc(c['other'])}</a></nav></header>
{language_chooser(lang)}
<main id="main">
<section class="hero" aria-labelledby="hero-title"><div><p class="eyebrow">{esc(c['eyebrow'])}</p><h1 id="hero-title">{c['headline']}</h1><p class="lead">{esc(c['lead'])}</p><a class="button" href="#guide">{esc(c['cta'])}<span aria-hidden="true">↗</span></a><p class="micro">{esc(c['note'])}</p></div>
<div class="demo-stage"><div class="demo"><div class="demo-top"><span>{esc(c['demo_label'])}</span><span aria-hidden="true">↗</span></div><h2>{esc(c['demo_date'])}</h2><p class="demo-sub">{esc(c['demo_sub'])}</p><div class="demo-row"><span class="circle" data-circle role="img" aria-label="{'Alınmadı' if lang=='tr' else 'Not purchased'}"></span><div class="product"><strong>{esc(c['names'][0])}</strong><small>{esc(c['units'][0])}</small></div><span class="price" data-price>—</span></div>{rows}<label for="market-price">{esc(c['input'])}</label><div class="price-input"><input id="market-price" data-market-price type="text" inputmode="decimal" autocomplete="off" maxlength="9" aria-describedby="price-hint price-status" placeholder="{'85,50' if lang=='tr' else '85.50'}"><span aria-hidden="true">₺</span></div><p id="price-hint" class="micro">{esc(c['hint'])}</p><p id="price-status" class="demo-status" data-status aria-live="polite">{'Market fiyatı henüz yok. Ürün tiksiz.' if lang=='tr' else 'No market price yet. The item is not checked.'}</p><div class="demo-total"><span>{esc(c['sum'])}</span><strong data-total>{'74,50 ₺' if lang=='tr' else 'TRY 74.50'}</strong></div><noscript><p class="micro">{'Bu örneği etkileşimli kullanmak için JavaScript gerekir.' if lang=='tr' else 'JavaScript is needed for the interactive example.'}</p></noscript></div><p class="demo-caption">{esc(c['caption'])}</p></div></section>
<div class="ribbon">{''.join(f'<span>{esc(t)}</span>' for t in c['ribbon'])}</div>
<section class="section" id="guide" aria-labelledby="guide-title"><div class="section-head"><h2 id="guide-title">{c['flow_title']}</h2><p>{esc(c['flow_intro'])}</p></div><div class="steps">{steps}</div></section>
<section class="detail" aria-labelledby="voice-title"><div><p class="eyebrow">{esc(c['detail_eyebrow'])}</p><h2 id="voice-title">{c['detail_title']}</h2></div><div><p>{esc(c['detail_body'])}</p><ul>{''.join(f'<li>{esc(t)}</li>' for t in c['detail_items'])}</ul></div></section>
<section class="section faq" aria-labelledby="faq-title"><h2 id="faq-title">{c['faq_title']}</h2><div>{faqs}</div></section>
<section class="download" id="download" aria-labelledby="download-title"><h2 id="download-title">{esc(c['download_title'])}</h2><p>{esc(c['download_body'])}</p><div class="buttons"><a class="button" href="{PLAY}">{esc(c['play'])}<span aria-hidden="true">↗</span></a><span class="badge">{esc(c['ios'])}</span></div><p class="availability">{esc(c['availability'])}</p></section>
</main>
<footer><span>{esc(c['footer'])}</span><div><a href="{PRIVACY}">{esc(c['privacy'])}</a><a href="mailto:devcrazypenguin@gmail.com">{esc(c['contact'])}</a><a href="https://github.com/XPersPective/nshoptor">{esc(c['source'])}</a></div></footer>
</div></body></html>'''

def build_localized(lang):
 c = translation(lang)
 canonical = locale_canonical(lang)
 title = f'NShoptor — {c["slogan"]}'
 description = c['aboutBody']
 schema = {'@context':'https://schema.org','@type':'WebSite','name':'NShoptor',
           'url':canonical,'inLanguage':lang,'description':description,
           'publisher':{'@type':'Organization','name':'Crazy Penguin'}}
 guides = [('itemFormTitle','guideAddBody'), ('voiceInputTitle','guideVoiceBody'),
           ('priceCandidatesTitle','guidePricesBody'), ('receiptReviewTitle','guideReceiptBody')]
 steps = ''.join(f'<article class="step"><span class="number" aria-hidden="true">0{i}</span><h3>{esc(c[heading])}</h3><p data-source="{body}">{esc(c[body])}</p></article>'
                 for i,(heading,body) in enumerate(guides,1))
 plans = ''.join(f'<p data-source="{key}">{esc(c[key])}</p>' for key in ('plansLegal','planLegacyRights'))
 schema_json = json.dumps(schema, ensure_ascii=False).replace('<','\\u003c')
 return f'''<!doctype html>
<html lang="{lang}" dir="{direction(lang)}">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>{esc(title)}</title><meta name="description" content="{esc(description)}">
<meta name="theme-color" content="#17392e"><link rel="canonical" href="{canonical}">
{hreflang_links()}
<meta property="og:type" content="website"><meta property="og:site_name" content="NShoptor">
<meta property="og:title" content="{esc(title)}"><meta property="og:description" content="{esc(description)}"><meta property="og:url" content="{canonical}">
<meta property="og:locale" content="{lang}"><meta property="og:image" content="{BASE}assets/social.png">
<meta property="og:image:width" content="1200"><meta property="og:image:height" content="630"><meta property="og:image:alt" content="NShoptor">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" href="../assets/icon.png"><link rel="stylesheet" href="../assets/site.css">
<script type="application/ld+json">{schema_json}</script>
</head><body class="localized-page">
<a class="skip" href="#main">{esc(c['howToUseLabel'])}</a>
<div class="wrap">
<header><a class="brand" href="./" aria-label="NShoptor"><img src="../assets/icon.png" width="34" height="34" alt=""><bdi>NShoptor</bdi></a><nav aria-label="{esc(c['howToUseLabel'])}"><a href="#guide">{esc(c['howToUseLabel'])}</a><a href="#plans">{esc(c['plansTitle'])}</a></nav></header>
{language_chooser(lang)}
<main id="main">
<section class="localized-hero" aria-labelledby="hero-title"><p class="eyebrow"><bdi>NShoptor · Crazy Penguin</bdi></p><h1 id="hero-title" data-source="slogan">{esc(c['slogan'])}</h1><p class="lead" data-source="aboutBody">{esc(description)}</p><a class="button" href="#guide">{esc(c['howToUseLabel'])}<span aria-hidden="true">↓</span></a></section>
<section class="section" id="guide" aria-labelledby="guide-title"><h2 id="guide-title">{esc(c['howToUseLabel'])}</h2><div class="steps localized-steps">{steps}</div></section>
<section class="localized-plans" id="plans" aria-labelledby="plans-title"><h2 id="plans-title">{esc(c['plansTitle'])}</h2><div class="plan-grid"><article><h3>{esc(c['planFree'])}</h3><p data-source="planFreeAi">{esc(c['planFreeAi'])}</p></article><article><h3><bdi>Pro</bdi></h3><p data-source="planProAi">{esc(c['planProAi'])}</p><p data-source="planNoAds">{esc(c['planNoAds'])}</p><p data-source="planBackup">{esc(c['planBackup'])}</p></article></div>{plans}<a class="button" href="{PLAY}"><bdi>Google Play</bdi><span aria-hidden="true">↗</span></a></section>
</main><footer><span><bdi>Crazy Penguin · NShoptor</bdi></span><div><a href="{PRIVACY}">{esc(c['privacyInfoLabel'])}</a><a href="mailto:devcrazypenguin@gmail.com">{esc(c['supportEmailLabel'])}</a></div></footer>
</div></body></html>'''


def build_page(language):
 return build(language, COPY[language]) if language in COPY else build_localized(language)


def build_sitemap():
 import xml.etree.ElementTree as ET
 namespace = 'http://www.sitemaps.org/schemas/sitemap/0.9'
 ET.register_namespace('', namespace)
 root = ET.Element(f'{{{namespace}}}urlset')
 for language in LANGUAGES:
  entry = ET.SubElement(root, f'{{{namespace}}}url')
  ET.SubElement(entry, f'{{{namespace}}}loc').text = locale_canonical(language)
 return '<?xml version="1.0" encoding="UTF-8"?>\n' + ET.tostring(root, encoding='unicode') + '\n'


if __name__ == '__main__':
 for language in LANGUAGES:
  output = ROOT / 'website' / relative_page(language)
  output.parent.mkdir(parents=True, exist_ok=True)
  output.write_text(build_page(language), encoding='utf-8')
 (ROOT/'website/sitemap.xml').write_text(build_sitemap(), encoding='utf-8')
 print(f'Generated {len(LANGUAGES)} app-language pages and sitemap; TR/EN interactive pages preserved.')
