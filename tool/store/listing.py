# Güncel Play mağaza metinleri → fastlane metadata klasörü.
#   python tool/store/listing.py <metadata-kökü> <versionCode>
# Uzunlukları Play sınırlarına göre doğrular (başlık 30, kısa 80, uzun 4000,
# sürüm notu 500); sınırı aşan dil yazılmaz.
import json
import pathlib
import sys
import unicodedata

REPO = 'https://github.com/XPersPective/nshoptor'

L = {'en-US': {'title': 'NShoptor: Smart Grocery List',
           'short': 'Grocery list & budget: planned vs actual prices, receipt scan and voice.',
           'full': 'Plan at home, match at checkout.\n'
                   '\n'
                   'ONE LIST, THROUGHOUT YOUR SHOPPING\n'
                   'Create one named list for home planning and store checkout. Add products with '
                   'planned quantities and estimated home prices, then enter optional market '
                   'prices on the same item when you shop. Swipe to delete, hold to reorder and '
                   'tap a row to edit. Unknown prices stay unknown; an unbought item is not '
                   'presented as savings.\n'
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
                   '71 interface languages. Language, number format and currency can be selected '
                   'independently.\n'
                   '\n'
                   'Open source (GPL-3.0): https://github.com/XPersPective/nshoptor',
           'notes': 'New in 1.2\n'
                    '• One checklist for planning, shopping and completed trips\n'
                    '• Separate planned and actual quantities and prices\n'
                    '• Editable local photo, receipt and voice input\n'
                    '• PDF summaries and clearer spending charts\n'
                    '• 71 languages, independent number format and currency'},
 'tr-TR': {'title': 'NShoptor: Alışveriş Listesi',
           'short': 'Alışveriş listesi ve bütçe: tahmini/gerçek fiyat, fiş ve sesli ekleme.',
           'full': 'Evdeki hesap çarşıya uyar.\n'
                   '\n'
                   'ALIŞVERİŞ BOYUNCA TEK LİSTE\n'
                   'Evdeki hazırlık ve marketteki alışveriş için tek bir liste oluştur. Ürünleri '
                   'planlanan miktar ve tahmini ev fiyatıyla ekle; alışverişte isteğe bağlı çarşı '
                   'fiyatını aynı satıra yaz. Satıra dokunarak düzenle, basılı tutarak sırala, '
                   'yana kaydırarak sil. Bilinmeyen fiyat bilinmeyen kalır; alınmayan ürün '
                   'tasarruf diye gösterilmez.\n'
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
                   '71 arayüz dili. Dil, sayı biçimi ve para birimi bağımsız seçilir.\n'
                   '\n'
                   'Açık kaynak (GPL-3.0): https://github.com/XPersPective/nshoptor',
           'notes': '1.2 ile gelenler\n'
                    '• Planlama, alışveriş ve geçmiş için tek tikli liste\n'
                    '• Planlanan ve gerçek miktar/fiyat ayrı\n'
                    '• Düzenlenebilir cihaz içi fotoğraf, fiş ve ses girdisi\n'
                    '• PDF özetleri ve daha anlaşılır harcama grafikleri\n'
                    '• 71 dil; bağımsız sayı biçimi ve para birimi'}}

# Diger Play dilleri: listing_translate.py'nin urettigi JSON + bolgesel kopyalar.
_extra = pathlib.Path(__file__).with_name('listing_extra.json')
if _extra.exists():
    L.update(json.loads(_extra.read_text(encoding='utf8')))

# Ana mağaza dillerinde ürünün tek-liste zihinsel modeli ve sloganı doğrudan
# yerelleştirilir; diğer Play dilleri mevcut çeviri kataloğunu korur.
L.update({
    'de-DE': {
        'title': 'NShoptor: Einkaufsbudget',
        'short': 'Einkaufsliste & Budget: Planpreis, Kassenpreis, Beleg und Sprache.',
        'full': "Zuhause geplant, im Laden bewährt.\n\n"
                "EINE LISTE VON DER PLANUNG BIS ZUR KASSE\n"
                "Plane Produkte mit Menge und geschätztem Preis zu Hause. Trage beim Einkauf den optionalen Preis an der Kasse in derselben Liste ein. Tippe zum Bearbeiten, halte zum Sortieren und wische zum Löschen. Unbekannte Preise bleiben unbekannt.\n\n"
                "KLARE VERGLEICHE\n"
                "Vergleiche Planpreis und tatsächlichen Ladenpreis. Die Preisentwicklung wird pro Einheit wie kg, Liter oder Stück normalisiert, damit unterschiedliche Mengen fair vergleichbar bleiben.\n\n"
                "SCHNELLE EINGABE\n"
                "Text und eine einzige, gut erreichbare Spracheingabe helfen beim Hinzufügen. Ergebnisse bleiben bearbeitbar; die manuelle Eingabe bleibt jederzeit verfügbar.\n\n"
                "PRIVATSPHÄRE UND BERICHTE\n"
                "Listen, Fotos und Audio bleiben auf dem Gerät. Nutze PDF-Zusammenfassungen, Ausgabenübersichten und Preisverläufe ohne Konto.\n\n"
                "71 Benutzeroberflächensprachen. Sprache, Zahlenformat und Währung sind unabhängig wählbar.\n\n"
                "Open Source (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Neu: eine Liste für Planung und Einkauf; Einheiten-Preisverlauf; neue Sprach- und Gestenführung.'
    },
    'es-ES': {
        'title': 'NShoptor: Lista y presupuesto',
        'short': 'Lista y presupuesto: precio previsto, precio real, recibos y voz.',
        'full': "Planifica en casa, acierta en el súper.\n\n"
                "UNA SOLA LISTA, DE CASA A LA CAJA\n"
                "Añade productos con cantidad y precio estimado en casa. En la tienda introduce el precio real opcional en la misma lista. Toca para editar, mantén pulsado para ordenar y desliza para borrar. Los precios desconocidos siguen sin inventarse.\n\n"
                "COMPARA CON UNIDADES JUSTAS\n"
                "Compara lo previsto con lo pagado. El historial normaliza el precio por kg, litro o unidad para que los tamaños distintos se puedan comparar.\n\n"
                "AÑADE RÁPIDO\n"
                "Escribe o usa una única entrada de voz accesible desde abajo. Todo resultado se puede editar y la entrada manual siempre está disponible.\n\n"
                "PRIVACIDAD Y RESÚMENES\n"
                "Tus listas, fotos y audio permanecen en el dispositivo. Consulta resúmenes PDF, gastos e historial sin crear una cuenta.\n\n"
                "71 idiomas de interfaz. Idioma, formato numérico y moneda se eligen por separado.\n\n"
                "Código abierto (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Nuevo: una lista para planificar y comprar; historial por unidad; gestos y entrada de voz más claros.'
    },
    'fr-FR': {
        'title': 'NShoptor : liste et budget',
        'short': 'Liste et budget : prix prévu, prix réel, tickets et voix.',
        'full': "Prévu à la maison, validé en magasin.\n\n"
                "UNE SEULE LISTE, DE LA PRÉPARATION À LA CAISSE\n"
                "Ajoutez les produits avec quantité et prix estimé à la maison. En magasin, saisissez le prix réel facultatif dans la même liste. Touchez pour modifier, maintenez pour trier et balayez pour supprimer. Les prix inconnus restent inconnus.\n\n"
                "DES PRIX COMPARABLES\n"
                "Comparez le prévu et le payé. L’historique normalise le prix à l’unité, au kg ou au litre pour comparer des quantités différentes.\n\n"
                "AJOUT RAPIDE\n"
                "Saisissez du texte ou utilisez une seule commande vocale accessible en bas. Chaque résultat reste modifiable et la saisie manuelle est toujours possible.\n\n"
                "CONFIDENTIALITÉ ET RAPPORTS\n"
                "Listes, photos et audio restent sur l’appareil. Consultez PDF, dépenses et historique sans compte.\n\n"
                "71 langues d’interface. Langue, format des nombres et devise sont indépendants.\n\n"
                "Open source (GPL-3.0) : https://github.com/XPersPective/nshoptor",
        'notes': 'Nouveau : une liste pour prévoir et acheter ; historique au prix unitaire ; gestes et voix simplifiés.'
    },
    'it-IT': {
        'title': 'NShoptor: lista e budget',
        'short': 'Lista e budget: prezzo previsto, reale, scontrini e voce.',
        'full': "I conti di casa tornano alla cassa.\n\n"
                "UNA LISTA, DALLA PREPARAZIONE ALLA SPESA\n"
                "Aggiungi prodotti con quantità e prezzo stimato a casa. Al supermercato inserisci il prezzo reale facoltativo nella stessa lista. Tocca per modificare, tieni premuto per riordinare e scorri per eliminare. I prezzi sconosciuti restano tali.\n\n"
                "PREZZI NORMALIZZATI\n"
                "Confronta il previsto con il pagato. La cronologia usa il prezzo per kg, litro o pezzo per confrontare quantità diverse.\n\n"
                "AGGIUNTA RAPIDA\n"
                "Scrivi oppure usa un solo comando vocale, sempre a portata di pollice. Ogni risultato è modificabile e l’inserimento manuale resta disponibile.\n\n"
                "PRIVACY E REPORT\n"
                "Liste, foto e audio restano sul dispositivo. Consulta PDF, spese e storico dei prezzi senza account.\n\n"
                "71 lingue dell’interfaccia. Lingua, formato numerico e valuta sono indipendenti.\n\n"
                "Open source (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Novità: una lista per pianificare e fare la spesa; storico per unità; gesti e voce più semplici.'
    },
    'ru-RU': {
        'title': 'NShoptor: список и бюджет',
        'short': 'Список и бюджет: план, цена в магазине, чеки и голос.',
        'full': "Посчитано дома — сходится на кассе.\n\n"
                "ОДИН СПИСОК ОТ ПЛАНА ДО ПОКУПКИ\n"
                "Добавляйте товары с количеством и примерной ценой дома. В магазине при желании внесите фактическую цену в тот же список. Нажмите для редактирования, удерживайте для сортировки, смахните для удаления. Неизвестные цены не выдумываются.\n\n"
                "ЧЕСТНАЯ ЦЕНА ЗА ЕДИНИЦУ\n"
                "Сравнивайте план и оплату. История нормализует цену за кг, литр или штуку, чтобы разные объёмы сравнивались корректно.\n\n"
                "БЫСТРЫЙ ВВОД\n"
                "Печатайте или используйте один голосовой ввод внизу экрана. Результат можно исправить, а ручной ввод доступен всегда.\n\n"
                "КОНФИДЕНЦИАЛЬНОСТЬ И ОТЧЁТЫ\n"
                "Списки, фото и аудио остаются на устройстве. Смотрите PDF, расходы и историю цен без аккаунта.\n\n"
                "71 язык интерфейса. Язык, формат чисел и валюта выбираются независимо.\n\n"
                "Открытый код (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Новое: один список для плана и покупки; история цены за единицу; понятные жесты и голосовой ввод.'
    },
})
for _to, _from in {'en-GB': 'en-US', 'es-419': 'es-ES', 'es-US': 'es-ES', 'fr-CA': 'fr-FR'}.items():
    L[_to] = dict(L[_from])

# One localized annual Pro contract shared by the app and store.
# Existing ownership remains restorable; this module only generates local files.
def _annual_plan_text(locale):
    code = locale.split('-')[0]
    code = {'iw': 'he'}.get(code, code)
    arb = pathlib.Path(__file__).resolve().parents[2] / 'lib/core/l10n' / f'app_{code}.arb'
    text = json.loads(arb.read_text(encoding='utf8'))
    return '\n'.join([
        text['plansTitle'],
        f"{text['planFree']}: {text['planFreeAi']}. {text['planFreeAds']}.",
        f"Pro: {text['planProAi']}. {text['planNoAds']}. {text['planBackup']}.",
        text['plansLegal'], text['planLegacyRights'],
    ])


def _without_plan_section(full):
    # Plan paragraphs are a single block in the translated source catalog.
    # Recognize both the old Max contract and an already generated annual block.
    paragraphs = []
    for paragraph in full.split('\n\n'):
        numbers = ''.join(str(unicodedata.decimal(c)) if c.isdecimal() else c for c in paragraph)
        if 'Pro:' in paragraph and '100' in numbers:
            continue
        paragraphs.append(paragraph)
    return '\n\n'.join(paragraphs)


for _locale, _entry in L.items():
    _entry['full'] = _without_plan_section(_entry['full']) + '\n\n' + _annual_plan_text(_locale)


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
