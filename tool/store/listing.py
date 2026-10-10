# Güncel Play mağaza metinleri → fastlane metadata klasörü.
#   python tool/store/listing.py <metadata-kökü> <versionCode>
# Uzunlukları Play sınırlarına göre doğrular (başlık 30, kısa 80, uzun 4000,
# sürüm notu 500); sınırı aşan dil yazılmaz.
import json
import pathlib
import sys

REPO = 'https://github.com/XPersPective/nshoptor'

L = {'en-US': {'title': 'NShoptor: Smart Grocery List',
           'short': 'Grocery list & budget: real prices, receipt scan, AI. Plan at home, save '
                    'more.',
           'full': 'Plan at home. Shop as planned.\n'
                   '\n'
                   'ONE LIST, THROUGHOUT YOUR SHOPPING\n'
                   'Create a named list and add products with planned quantities and estimated '
                   'prices. Tick items while shopping and enter actual quantities and prices on '
                   'the same screen. Edit completed lists without restarting the trip. Unknown '
                   'prices stay unknown; an unbought item is not presented as savings.\n'
                   '\n'
                   'LOCAL INPUT, YOUR APPROVAL\n'
                   'Type or use on-device speech where supported. Read shelf labels and receipts '
                   'on your device, review editable results and approve before saving. Optional AI '
                   'helps turn text into a list and match receipt lines. Camera, microphone, '
                   'language and network limitations always allow manual entry.\n'
                   '\n'
                   'REPORTS THAT EXPLAIN YOUR SPENDING\n'
                   'Compare planned and actual costs, save a PDF shopping summary, browse spending '
                   'calendars and price history. Charts show purchased quantities and shopping '
                   'frequency, separately by currency and unit. The PDF is not a tax invoice; '
                   'unknown tax rates are not invented.\n'
                   '\n'
                   'PRIVACY\n'
                   'No account needed. Lists, photos and audio remain on your device. Core '
                   'shopping and receipt OCR work offline. Optional AI sends only the text you '
                   'choose to our service and its model provider. Backups are under your control.\n'
                   '\n'
                   'PLANS\n'
                   'Free: 10 AI requests per month and the core shopping features, with ads.\n'
                   'Pro: 100 AI requests per month, no ads and backup. Eligible new subscribers '
                   'can try the monthly plan free for 7 days.\n'
                   'Max: 300 AI requests per month, no ads and backup.\n'
                   'Annual subscriptions keep the same monthly quota. Existing legacy Pro and Max '
                   'subscriptions retain 200 and 1000 monthly requests respectively. Prices and '
                   'eligibility are shown by Google Play.\n'
                   'Ad-free for life: a one-time purchase; includes backup and the free AI quota, '
                   'not a subscription AI quota.\n'
                   '\n'
                   '71 interface languages. Language, number format and currency can be selected '
                   'independently.\n'
                   '\n'
                   'Open source (GPL-3.0): https://github.com/XPersPective/nshoptor',
           'notes': 'New in 1.2\n'
                    '• One checklist for planning, shopping and completed trips\n'
                    '• Separate planned and actual quantities and prices\n'
                    '• Editable local photo, receipt and voice input\n'
                    '• PDF summaries and clearer spending charts\n'
                    '• 71 languages, independent number format and currency\n'
                    '• New AI plans: 10/100/300 monthly requests; legacy rights preserved'},
 'tr-TR': {'title': 'NShoptor: Alışveriş Listesi',
           'short': 'Market listesi ve bütçe: gerçek fiyat, fiş okuma, yapay zeka. Evde planla.',
           'full': 'Evde planla. Planladığın gibi alışveriş yap.\n'
                   '\n'
                   'ALIŞVERİŞ BOYUNCA TEK LİSTE\n'
                   'İsimli bir liste oluştur, ürünleri planlanan miktar ve tahmini fiyatlarıyla '
                   'ekle. Marketten aldıklarını işaretle, gerçek miktar ve fiyatı aynı ekranda '
                   'gir. Tamamlanan listeyi alışverişi yeniden başlatmadan düzenle. Bilinmeyen '
                   'fiyat bilinmeyen kalır; alınmayan ürün tasarruf diye gösterilmez.\n'
                   '\n'
                   'CİHAZDA GİRDİ, SENİN ONAYIN\n'
                   'Yaz veya desteklenen cihazlarda cihaz içi konuşma tanımayı kullan. Raf '
                   'etiketlerini ve fişleri cihazda oku; düzenlenebilir sonuçları inceleyip '
                   'kaydetmeden önce onayla. İsteğe bağlı yapay zeka metinden liste oluşturmayı ve '
                   'fiş satırlarını eşleştirmeyi kolaylaştırır. Kamera, mikrofon, dil veya ağ '
                   'sınırlamasında elle giriş açıktır.\n'
                   '\n'
                   'HARCAMANI ANLATAN RAPORLAR\n'
                   'Planlanan ve gerçek tutarları karşılaştır, PDF alışveriş özeti kaydet; harcama '
                   'takvimini ve fiyat geçmişini incele. Grafikler satın alınan miktarı ve '
                   'alışveriş sıklığını para ve birime göre ayrı gösterir. PDF vergi faturası '
                   'değildir; bilinmeyen vergi oranı uydurulmaz.\n'
                   '\n'
                   'GİZLİLİK\n'
                   'Hesap gerekmez. Liste, fotoğraf ve ses cihazında kalır. Temel alışveriş ve fiş '
                   'okuma çevrimdışı çalışır. İsteğe bağlı yapay zeka yalnız seçtiğin metni '
                   'servisimize ve model sağlayıcısına gönderir. Yedeklerin senin kontrolündedir.\n'
                   '\n'
                   'PLANLAR\n'
                   'Ücretsiz: ayda 10 yapay zeka isteği, temel alışveriş özellikleri ve '
                   'reklamlar.\n'
                   'Pro: ayda 100 yapay zeka isteği, reklamsız kullanım ve yedekleme. Uygun yeni '
                   'aboneler aylık planı 7 gün ücretsiz deneyebilir.\n'
                   'Max: ayda 300 yapay zeka isteği, reklamsız kullanım ve yedekleme.\n'
                   'Yıllık aboneliklerde aylık kota aynıdır. Eski Pro ve Max abonelerinin '
                   'sırasıyla 200 ve 1000 aylık istek hakları korunur. Fiyat ve uygunluk Google '
                   "Play'de gösterilir.\n"
                   'Ömür boyu reklamsız: tek seferlik satın alma; yedekleme ve ücretsiz yapay zeka '
                   'kotası içerir, abonelik yapay zeka kotası vermez.\n'
                   '\n'
                   '71 arayüz dili. Dil, sayı biçimi ve para birimi bağımsız seçilir.\n'
                   '\n'
                   'Açık kaynak (GPL-3.0): https://github.com/XPersPective/nshoptor',
           'notes': '1.2 ile gelenler\n'
                    '• Planlama, alışveriş ve geçmiş için tek tikli liste\n'
                    '• Planlanan ve gerçek miktar/fiyat ayrı\n'
                    '• Düzenlenebilir cihaz içi fotoğraf, fiş ve ses girdisi\n'
                    '• PDF özetleri ve daha anlaşılır harcama grafikleri\n'
                    '• 71 dil; bağımsız sayı biçimi ve para birimi\n'
                    '• Yeni aylık yapay zeka kotaları 10/100/300; eski haklar korunur'}}

# Diger Play dilleri: listing_translate.py'nin urettigi JSON + bolgesel kopyalar.
_extra = pathlib.Path(__file__).with_name('listing_extra.json')
if _extra.exists():
    L.update(json.loads(_extra.read_text(encoding='utf8')))
for _to, _from in {'en-GB': 'en-US', 'es-419': 'es-ES', 'es-US': 'es-ES', 'fr-CA': 'fr-FR'}.items():
    L[_to] = L[_from]

LIMITS = {'title': 30, 'short': 80, 'full': 4000, 'notes': 500}


def main(root: str, code: str) -> int:
    bad = 0
    for loc, t in L.items():
        over = [f'{k} {len(t[k])}/{n}' for k, n in LIMITS.items() if len(t[k]) > n]
        if over:
            print(loc, 'SINIR AŞILDI:', ', '.join(over))
            bad += 1
            continue
        d = pathlib.Path(root, loc)
        (d / 'changelogs').mkdir(parents=True, exist_ok=True)
        for k, f in [('title', 'title.txt'), ('short', 'short_description.txt'), ('full', 'full_description.txt')]:
            (d / f).write_text(t[k] + '\n', encoding='utf-8')
        (d / 'changelogs' / f'{code}.txt').write_text(t['notes'] + '\n', encoding='utf-8')
        print(loc, {k: len(t[k]) for k in LIMITS})
    return bad


if __name__ == '__main__':
    sys.exit(main(sys.argv[1], sys.argv[2]))
