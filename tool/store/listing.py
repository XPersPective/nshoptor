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
           'short': 'Grocery list & budget: planned vs actual prices, batch receipt scan & voice.',
           'full': 'Plan at home, check faster at checkout.\n'
                   '\n'
                   'ONE LIST, THROUGHOUT YOUR SHOPPING\n'
                   'Create one named list for home planning and store checkout. Add items with '
                   'planned quantities and estimated home prices, then enter optional actual prices '
                   'as you shop. Sort by shopping date, name or manual order, swipe to delete, hold '
                   'to reorder and tap a row to edit. Unknown prices stay unknown; an unbought item '
                   'is not presented as savings.\n'
                   '\n'
                   'BATCH RECEIPTS, LOCAL INPUT & YOUR APPROVAL\n'
                   'Capture single or multi-page receipts back-to-back without waiting: saved '
                   'drafts prepare in the background under My receipts, warn on matching store/time '
                   'duplicates, and attach zoomable receipt photos directly beneath your shopping '
                   'list after you review and convert them. Type or use on-device speech where '
                   'supported, read shelf labels offline, and edit every line before saving. '
                   'Optional AI helps turn text into lists and match receipt items. Camera, '
                   'microphone, language and network limitations always allow manual entry.\n'
                   '\n'
                   'REPORTS, CALENDAR & CALM THEMES\n'
                   'Compare planned vs actual totals, browse spending calendars and unit-normalized '
                   'price history, export or print a clean PDF shopping summary, and pick calm Forest '
                   'or Ocean themes in light or dark mode. The PDF is not a tax invoice; unknown '
                   'tax rates are not invented.\n'
                   '\n'
                   'PRIVACY\n'
                   'No account needed. Lists, receipt drafts, photos and audio stay on your device. '
                   'Core shopping and receipt OCR work offline. Optional AI sends only the text you '
                   'choose or reduced-size receipt/label photos for transient reading (never '
                   'stored) to our service and its model provider. Backups stay under your control.\n'
                   '\n'
                   '71 interface languages. Language, number format and currency can be selected '
                   'independently.\n'
                   '\n'
                   'Open source (GPL-3.0): https://github.com/XPersPective/nshoptor',
           'notes': 'New in 1.3.4:\n'
                    '• Capture-first batch receipt scanning: snap single or multi-page receipts fast without waiting\n'
                    '• New My receipts queue processes drafts in the background and alerts on duplicate receipts\n'
                    '• Zoomable receipt photos stay attached directly below converted shopping lists\n'
                    '• Refreshed Home AppBar, sort controls, shopping calendar polish & calm Forest/Ocean themes\n'
                    '• Updated localization across all 71 languages'},
 'tr-TR': {'title': 'NShoptor: Alışveriş Listesi',
           'short': 'Alışveriş listesi & bütçe: tahmini/gerçek fiyat, toplu fiş, sesli ekleme.',
           'full': 'Evde planla, kasada netleş.\n'
                   '\n'
                   'BAŞTAN SONA TEK LİSTE\n'
                   'Evdeki planlama ve market alışverişi için tek liste açın. Ürünleri beklenen '
                   'miktar ve tahmini ev fiyatıyla ekleyin; markette aldığınızda isteğe bağlı gerçek '
                   'fiyatı aynı satıra işleyin. Alışveriş tarihi, ad (A–Z) veya el sırasına göre '
                   'sıralayın; sürükleyip düzenleyin. Bilinmeyen fiyatlar sıfır veya tasarruf diye '
                   'gösterilmez.\n'
                   '\n'
                   'TOPLU FİŞ OKUMA, YEREL GİRİŞ VE ONAYINIZ\n'
                   'Tek ya da çok sayfalı fişleri beklemeden arka arkaya çekin: Fişlerim tepsisi '
                   'taslakları arka planda hazırlar, aynı market/saat için mükerrer uyarısı verir ve '
                   'dönüştürdüğünüz fişlerin yakınlaştırılabilir fotoğraflarını listenin altında '
                   'saklar. Desteklenen cihazlarda sesle veya raf etiketi okuyucusuyla ürün ekleyin; '
                   'tüm satırları kaydetmeden önce düzenleyin. İsteğe bağlı yapay zeka metni listeye '
                   'dönüştürür ve fiş satırlarını eşleştirir; kamera, mikrofon veya ağ olmadığında '
                   'elle giriş her zaman açıktır.\n'
                   '\n'
                   'RAPORLAR, TAKVİM VE SAKİN TEMALAR\n'
                   'Tahmini ve gerçek toplamı karşılaştırın, harcama takvimini ve birim başına '
                   '(kg, L, adet) normalize fiyat geçmişini inceleyin, PDF alışveriş özeti alın, '
                   'açık/koyu Orman ve Okyanus temalarıyla rahat çalışın. PDF vergi faturası '
                   'değildir; bilinmeyen KDV/vergi oranları uydurulmaz.\n'
                   '\n'
                   'GİZLİLİK\n'
                   'Hesap gerekmez. Listeler, fiş taslakları, fotoğraflar ve ses cihazınızda kalır. '
                   'Temel alışveriş ve yerel fiş/etiket okuma internetsiz çalışır. İsteğe bağlı YZ '
                   'yalnız seçtiğiniz metni ya da boyutu küçültülmüş fiş/etiket fotoğrafını kalıcı '
                   'olarak saklanmadan geçici okuma için hizmetimize ve model sağlayıcısına '
                   'gönderir. Yedekler tamamen sizin kontrolünüzdedir.\n'
                   '\n'
                   '71 arayüz dili. Dil, sayı biçimi ve para birimi bağımsız seçilir.\n'
                   '\n'
                   'Açık kaynak (GPL-3.0): https://github.com/XPersPective/nshoptor',
           'notes': 'Sürüm 1.3.4 ile neler yeni:\n'
                    '• Hızlı toplu fiş okuma: tek veya çok sayfalı fişleri beklemeden arka arkaya çekin\n'
                    '• Yeni Fişlerim sekmesi taslakları arka planda işler ve mükerrer fişlerde uyarı verir\n'
                    '• Dönüştürülen fiş fotoğrafları listenin altında yakınlaştırılabilir şekilde saklanır\n'
                    '• Yenilenen üst çubuk, sıralama denetimleri, alışveriş takvimi ve sakin Orman/Okyanus temaları\n'
                    '• 71 dilde yerelleştirme iyileştirmeleri'}}

# Diger Play dilleri: listing_translate.py'nin urettigi JSON + bolgesel kopyalar.
_extra = pathlib.Path(__file__).with_name('listing_extra.json')
if _extra.exists():
    L.update(json.loads(_extra.read_text(encoding='utf8')))

# Ana mağaza dillerinde ürünün tek-liste zihinsel modeli ve sloganı doğrudan
# yerelleştirilir; diğer Play dilleri mevcut çeviri kataloğunu korur.
L.update({
    'de-DE': {
        'title': 'NShoptor: Einkaufsbudget',
        'short': 'Einkaufsliste & Budget: Plan- vs Kassenpreis, Beleg-Scan & Spracheingabe.',
        'full': "Zuhause planen, an der Kasse den Überblick behalten.\n\n"
                "EINE LISTE VON DER PLANUNG BIS ZUR KASSE\n"
                "Erstelle eine benannte Liste für Einkaufsplanung und Kassencheck. Füge Artikel mit geplanter Menge und Schätzpreis hinzu und trage im Laden den tatsächlichen Kassenpreis direkt am selben Eintrag nach. Sortiere nach Einkaufsdatum, Name oder eigener Reihenfolge. Unbekannte Preise bleiben unbekannt; nicht gekaufte Artikel zählen nicht als Ersparnis.\n\n"
                "SERIEN-BELEGSCAN, LOKALE EINGABE & DEINE FREIGABE\n"
                "Fotografiere ein- oder mehrseitige Kassenbons direkt hintereinander ohne Wartezeit: Entwürfe werden im Hintergrund unter „Meine Belege“ vorbereitet, warnen vor möglichen Duplikaten (Markt/Uhrzeit) und heften zoombare Belegfotos nach dem Umwandeln direkt unter deine Liste. Nutze Spracheingabe (wo unterstützt) oder lies Preisschilder lokal. Optionale KI hilft bei Textlisten und Bon-Abgleich; manuelle Eingabe funktioniert immer.\n\n"
                "BERICHTE, KALENDER & RUHIGE FARBWELTEN\n"
                "Vergleiche Plan- mit Ist-Kosten, durchsuche Ausgabenkalender sowie normalisierte Stückpreisverläufe (kg, L, Stk.), speichere eine PDF-Einkaufsübersicht und wähle ruhige Wald- oder Ozean-Designs in Hell oder Dunkel. Das PDF ist keine Steuerrechnung; unbekannte Steuersätze werden nicht erfunden.\n\n"
                "DATENSCHUTZ\n"
                "Kein Konto nötig. Listen, Fotos und Audio bleiben auf deinem Gerät. Kernfunktionen und lokaler Bon-/Etikettenscan funktionieren offline. Optionale KI sendet nur den gewählten Text oder verkleinerte Beleg-/Etikettfotos zur vorübergehenden Erkennung (ohne dauerhafte Speicherung) an unseren Dienst und Modellanbieter. Backups bleiben unter deiner Kontrolle.\n\n"
                "71 Oberflächensprachen. Sprache, Zahlenformat und Währung frei wählbar.\n\n"
                "Open Source (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Neu in 1.3.4:\n'
                 '• Serien-Belegscan: Ein- und mehrseitige Kassenbons ohne Wartezeit direkt nacheinander erfassen\n'
                 '• Neuer Tab „Meine Belege“ mit Hintergrund-Verarbeitung und Duplikatprüfung\n'
                 '• Zoombare Belegfotos bleiben nach der Umwandlung unter der Einkaufsliste angeheftet\n'
                 '• Überarbeitete Startleiste, Sortiersteuerung, Einkaufskalender & ruhige Wald/Ozean-Designs\n'
                 '• Vervollständigte Übersetzungen in 71 Sprachen',
    },
    'es-ES': {
        'title': 'NShoptor: Lista y presupuesto',
        'short': 'Lista y presupuesto: precio previsto vs real, escáner de tickets, voz e IA.',
        'full': "Planifica en casa, comprueba en caja.\n\n"
                "UNA SOLA LISTA DE PRINCIPIO A FIN\n"
                "Crea una lista con nombre para planificar en casa y anotar el precio real en el súper sobre el mismo artículo. Ordena por fecha de compra, nombre u orden manual. Los precios desconocidos no se inventan y lo no comprado no cuenta como ahorro.\n\n"
                "ESCANEO DE TICKETS POR LOTES Y TU APROBACIÓN\n"
                "Fotografía tickets simples o largos seguidos sin esperar: «Mis recibos» procesa borradores en segundo plano, avisa ante duplicados (tienda/hora) y guarda las fotos con zoom debajo de tu lista al convertirlos. Añade por voz local o lee etiquetas de estante sin conexión, y revisa cada línea antes de guardar. La IA opcional ayuda a convertir texto y emparejar tickets.\n\n"
                "INFORMES, CALENDARIO Y TEMAS SERENOS\n"
                "Compara gasto previsto y real, explora el calendario y el historial de precios normalizado (kg, L, ud.), guarda un resumen en PDF y elige temas Bosque u Océano en modo claro u oscuro. El PDF no es una factura fiscal ni inventa impuestos.\n\n"
                "PRIVACIDAD\n"
                "Sin cuenta. Listas, fotos y audio permanecen en tu dispositivo. Las listas y el OCR local funcionan sin internet. La IA opcional envía solo el texto elegido o fotos reducidas de tickets/etiquetas para lectura transitoria (nunca almacenadas) a nuestro servicio y su proveedor de modelos.\n\n"
                "71 idiomas de interfaz. Idioma, números y moneda independientes.\n\n"
                "Código abierto (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Novedades 1.3.4:\n'
                 '• Escaneo por lotes: fotografía tickets simples o largos seguidos sin esperar\n'
                 '• Nueva pestaña «Mis recibos» en segundo plano con aviso de tickets duplicados\n'
                 '• Fotos ampliables de cada ticket adjuntas debajo de su lista tras convertirlo\n'
                 '• Barra superior, controles de orden, calendario y temas serenos Bosque y Océano\n'
                 '• Traducciones revisadas en 71 idiomas',
    },
    'fr-FR': {
        'title': 'NShoptor : liste et budget',
        'short': 'Liste de courses & budget : prix prévu/réel, scan de tickets, voix & IA.',
        'full': "Planifiez chez vous, vérifiez en caisse.\n\n"
                "UNE SEULE LISTE DU DÉBUT À LA FIN\n"
                "Créez une liste nommée pour planifier vos courses et pointer en magasin. Ajoutez quantité et prix estimé à la maison, puis saisissez le prix réel en rayon sur la même ligne. Triez par date d'achat, nom ou ordre manuel. Les prix inconnus restent inconnus ; un article non acheté n'est pas compté comme une économie.\n\n"
                "SCAN DE TICKETS EN SÉRIE & VALIDATION MANUELLE\n"
                "Photographiez des tickets simples ou longs à la suite sans attendre : « Mes tickets » prépare vos brouillons en arrière-plan, signale les doublons (enseigne/heure) et conserve les photos zoomables sous votre liste après conversion. Dictez à la voix (si disponible) ou lisez les étiquettes de rayon hors ligne ; chaque ligne reste modifiable avant enregistrement. L'IA optionnelle aide à structurer vos listes et tickets.\n\n"
                "RAPPORTS, CALENDRIER & THÈMES APAISANTS\n"
                "Comparez coût prévu et réel, consultez le calendrier des dépenses et l'historique des prix par unité (kg, L, pièce), exportez un récapitulatif PDF et choisissez des thèmes Forêt ou Océan en mode clair ou sombre. Le PDF n'est pas une facture fiscale ; aucune taxe inconnue n'est inventée.\n\n"
                "CONFIDENTIALITÉ\n"
                "Aucun compte requis. Listes, tickets, photos et audio restent sur votre appareil. Les listes et la lecture locale fonctionnent hors ligne. L'IA optionnelle envoie uniquement le texte choisi ou des photos réduites pour lecture transitoire (jamais stockées) à notre service et son fournisseur de modèle.\n\n"
                "71 langues d'interface. Langue, format numérique et devise indépendants.\n\n"
                "Open source (GPL-3.0) : https://github.com/XPersPective/nshoptor",
        'notes': 'Nouveautés 1.3.4 :\n'
                 '• Scan de tickets en rafale : capturez des tickets simples ou longs sans attendre\n'
                 '• Nouvel onglet « Mes tickets » avec traitement en arrière-plan et détection des doublons\n'
                 '• Photos de tickets zoomables conservées sous la liste après conversion\n'
                 '• Barre supérieure affinée, tri amélioré, calendrier & thèmes calmes Forêt/Océan\n'
                 '• Traductions vérifiées sur 71 langues',
    },
    'it-IT': {
        'title': 'NShoptor: lista e budget',
        'short': 'Lista spesa e budget: prezzi reali, scansione scontrini, voce e grafici.',
        'full': "Pianifica a casa, controlla alla cassa.\n\n"
                "UN'UNICA LISTA DALLA PIANIFICAZIONE AL CARRELLO\n"
                "Crea una lista con nome per pianificare la spesa e inserire il prezzo reale in negozio sulla stessa riga. Ordina per data di spesa, nome o ordine manuale. I prezzi sconosciuti restano tali e gli articoli non acquistati non risultano come risparmio.\n\n"
                "SCANSIONE SCONTRINI IN SERIE E TUA APPROVAZIONE\n"
                "Scatta scontrini singoli o multi-pagina in sequenza senza attesa: la scheda «I miei scontrini» li elabora in background, segnala eventuali duplicati (negozio/ora) e allega le foto ingrandibili sotto la lista dopo la conversione. Usa la voce sul dispositivo o leggi le etichette a scaffale offline e modifica ogni riga prima di salvare. L'IA opzionale aiuta a convertire testi e scontrini.\n\n"
                "REPORT, CALENDARIO E TEMI RILASSANTI\n"
                "Confronta costi previsti e reali, esplora calendario spese e storico prezzi per unità (kg, L, pz), esporta un riepilogo PDF e scegli i temi Foresta o Oceano chiari o scuri. Il PDF non è una fattura fiscale.\n\n"
                "PRIVACY\n"
                "Nessun account richiesto. Liste, foto e audio restano sul dispositivo. Funzioni base e OCR locale lavorano offline. L'IA opzionale invia solo il testo scelto o foto ridotte di scontrini/etichette per lettura transitoria (mai archiviate) al nostro servizio e fornitore di modelli.\n\n"
                "71 lingue di interfaccia. Lingua, formato numeri e valuta indipendenti.\n\n"
                "Open source (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Novità in 1.3.4:\n'
                 '• Acquisizione scontrini in serie: scatta scontrini singoli o multi-pagina senza attesa\n'
                 '• Nuova scheda «I miei scontrini» con elaborazione in background e controllo duplicati\n'
                 '• Foto degli scontrini ingrandibili allegate sotto la lista dopo la conversione\n'
                 '• Barra iniziale, ordinamento, calendario spese e temi rilassanti Foresta/Oceano migliorati\n'
                 '• Localizzazione completata per 71 lingue',
    },
    'pt-PT': {
        'title': 'NShoptor: Lista de Compras',
        'short': 'Lista e orçamento: preços reais, cupons em lote, IA e comparação.',
        'full': "Planeje em casa, confira no caixa.\n\n"
                "UMA ÚNICA LISTA DO INÍCIO AO FIM\n"
                "Crie uma lista para planejar em casa e anotar o preço real no mercado no mesmo item. Ordene por data da compra, nome ou ordem manual. Preços desconhecidos continuam desconhecidos; itens não comprados não aparecem como economia.\n\n"
                "CUPONS EM LOTE, ENTRADA LOCAL E SUA APROVAÇÃO\n"
                "Fotografe cupons simples ou longos em sequência sem esperar: a aba «Meus recibos» prepara tudo em segundo plano, alerta sobre cupons duplicados (loja/hora) e anexa as fotos com zoom abaixo da lista após a revisão. Fale por voz no aparelho ou leia etiquetas offline e edite antes de salvar. A IA opcional ajuda a converter listas e ler cupons.\n\n"
                "RELATÓRIOS, CALENDÁRIO E TEMAS SUAVES\n"
                "Compare valor planejado e real, veja o calendário de gastos e histórico normalizado por unidade (kg, L, un.), gere um resumo em PDF e escolha temas Floresta ou Oceano em modo claro ou escuro. O PDF não é nota fiscal; impostos desconhecidos não são inventados.\n\n"
                "PRIVACIDADE\n"
                "Sem conta. Listas, fotos e áudio ficam no seu aparelho. Compras e OCR local funcionam offline. A IA opcional envia apenas o texto escolhido ou fotos reduzidas de cupons/etiquetas para leitura transitória (nunca armazenadas) ao nosso serviço e provedor de modelo.\n\n"
                "71 idiomas de interface. Idioma, números e moeda independentes.\n\n"
                "Código aberto (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Novidades 1.3.4:\n'
                 '• Leitura de talões em série: fotografe talões simples ou longos sem esperar\n'
                 '• Novo separador «Meus recibos» com processamento em segundo plano e alerta de duplicados\n'
                 '• Fotos ampliáveis do talão anexadas abaixo da lista após a conversão\n'
                 '• Barra superior, ordenação, calendário de compras e temas suaves Floresta/Oceano\n'
                 '• Traduções revistas em 71 idiomas',
    },
    'pt-BR': {
        'title': 'NShoptor: Lista de Compras',
        'short': 'Lista e orçamento: preços reais, cupons em lote, IA e comparação.',
        'full': "Planeje em casa, confira no caixa.\n\n"
                "UMA ÚNICA LISTA DO INÍCIO AO FIM\n"
                "Crie uma lista para planejar em casa e anotar o preço real no mercado no mesmo item. Ordene por data da compra, nome ou ordem manual. Preços desconhecidos continuam desconhecidos; itens não comprados não aparecem como economia.\n\n"
                "CUPONS EM LOTE, ENTRADA LOCAL E SUA APROVAÇÃO\n"
                "Fotografe cupons simples ou longos em sequência sem esperar: a aba «Meus recibos» prepara tudo em segundo plano, alerta sobre cupons duplicados (loja/hora) e anexa as fotos com zoom abaixo da lista após a revisão. Fale por voz no aparelho ou leia etiquetas offline e edite antes de salvar. A IA opcional ajuda a converter listas e ler cupons.\n\n"
                "RELATÓRIOS, CALENDÁRIO E TEMAS SUAVES\n"
                "Compare valor planejado e real, veja o calendário de gastos e histórico normalizado por unidade (kg, L, un.), gere um resumo em PDF e escolha temas Floresta ou Oceano em modo claro ou escuro. O PDF não é nota fiscal; impostos desconhecidos não são inventados.\n\n"
                "PRIVACIDADE\n"
                "Sem conta. Listas, fotos e áudio ficam no seu aparelho. Compras e OCR local funcionam offline. A IA opcional envia apenas o texto escolhido ou fotos reduzidas de cupons/etiquetas para leitura transitória (nunca armazenadas) ao nosso serviço e provedor de modelo.\n\n"
                "71 idiomas de interface. Idioma, números e moeda independentes.\n\n"
                "Código aberto (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Novidades 1.3.4:\n'
                 '• Leitura de cupons em lote: fotografe cupons simples ou longos sem esperar\n'
                 '• Nova aba «Meus recibos» em segundo plano com alerta de cupons duplicados\n'
                 '• Fotos ampliáveis do cupom anexadas abaixo da lista após a conversão\n'
                 '• Barra superior, ordenação, calendário de compras e temas suaves Floresta/Oceano\n'
                 '• Traduções revisadas em 71 idiomas',
    },
    'ru-RU': {
        'title': 'NShoptor: список и бюджет',
        'short': 'Список покупок и бюджет: план/факт цен, сканер чеков, голосовой ввод, ИИ.',
        'full': "Планируйте дома, сверяйте на кассе.\n\n"
                "ОДИН СПИСОК НА ВСЮ ПОКУПКУ\n"
                "Создайте список с планируемым количеством и ценой дома, а в магазине укажите фактическую цену прямо в той же строке. Сортируйте по дате покупок, названию или вручную. Неизвестные цены остаются неизвестными, а некупленные товары не считаются экономией.\n\n"
                "ПАКЕТНОЕ СКАНИРОВАНИЕ ЧЕКОВ И ВАШ КОНТРОЛЬ\n"
                "Снимайте длинные или отдельные чеки подряд без ожидания: вкладка «Мои чеки» готовит черновики в фоне, предупреждает о дубликатах (магазин/время) и прикрепляет масштабируемые фото чека под списком. Используйте локальный голосовой ввод или сканер ценников офлайн; любую строку можно поправить до сохранения. Опциональный ИИ помогает распознавать текст и чеки.\n\n"
                "ОТЧЁТЫ, КАЛЕНДАРЬ И СПОКОЙНЫЕ ТЕМЫ\n"
                "Сравнивайте план и факт, просматривайте календарь трат и нормализованную историю цен (кг, л, шт.), сохраняйте PDF-отчёт и выбирайте светлые или тёмные темы «Лес» и «Океан». PDF не является фискальным чеком.\n\n"
                "КОНФИДЕНЦИАЛЬНОСТЬ\n"
                "Аккаунт не нужен. Списки, фото и аудио хранятся на устройстве. Базовые функции и локальное распознавание работают офлайн. Опциональный ИИ передаёт только выбранный текст или уменьшенные фото чеков/ценников для временного чтения (без сохранения) нашему сервису и провайдеру модели.\n\n"
                "71 язык интерфейса. Язык, числа и валюта настраиваются независимо.\n\n"
                "Открытый исходный код (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'Новое в 1.3.4:\n'
                 '• Пакетное сканирование: снимайте длинные и отдельные чеки подряд без ожидания\n'
                 '• Вкладка «Мои чеки» с фоновой обработкой и проверкой дубликатов\n'
                 '• Масштабируемые фото чеков прикрепляются под списком после конвертации\n'
                 '• Обновлённая шапка, сортировка, календарь покупок и спокойные темы «Лес» и «Океан»\n'
                 '• Обновлена локализация для 71 языка',
    },
    'ar': {
        'title': 'NShoptor: قائمة تسوق ذكية',
        'short': 'قائمة تسوق وميزانية: أسعار حقيقية، مسح فواتير متتابع، صوت وذكاء اصطناعي.',
        'full': "خطّط في المنزل، وتحقّق عند الدفع.\n\n"
                "قائمة واحدة من البداية إلى الكاشير\n"
                "أنشئ قائمة للتخطيط بالكميات والأسعار التقديرية في المنزل، ثم سجّل السعر الفعلي في المتجر على السطر نفسه. رتّب حسب تاريخ التسوّق أو الاسم أو الترتيب اليدوي. الأسعار المجهولة لا تُقدّر جزافاً، والسلع غير المشتراة لا تُحسب كتوفير.\n\n"
                "مسح الإيصالات دفعة واحدة وبموافقتك\n"
                "صوّر الإيصالات الطويلة أو المتعددة تباعاً دون انتظار: يجهّز تبويب «إيصالاتي» المسودات في الخلفية، وينبّه عند التكرار (المتجر/الوقت)، ويحفظ صور الإيصال القابلة للتكبير أسفل القائمة بعد التحويل. استخدم الإدخال الصوتي المحلي أو قارئ ملصقات الرفوف دون اتصال، وراجع كل سطر قبل الحفظ. يساعد الذكاء الاصطناعي الاختياري في قراءة النصوص والإيصالات.\n\n"
                "تقارير وتقويم وسمات هادئة\n"
                "قارن التقدير بالإنفاق الفعلي، وتصفّح تقويم المصاريف وسجل الأسعار الموحّد بالوحدة، واحفظ ملخصاً بصيغة PDF، واختر سمات الغابة أو المحيط الفاتحة والداكنة. ملف PDF ليس فاتورة ضريبية.\n\n"
                "الخصوصية\n"
                "لا حاجة لحساب. تبقى القوائم والصور والصوت على جهازك. يعمل التسوق والقراءة المحلية دون إنترنت. يرسل الذكاء الاصطناعي الاختياري النص الذي تختاره فقط أو صوراً مصغّرة للقراءة المؤقتة (دون تخزين) إلى خدمتنا ومزوّد النموذج.\n\n"
                "71 لغة واجهة مع اختيار مستقل للغة والأرقام والعملة.\n\n"
                "مفتوح المصدر (GPL-3.0): https://github.com/XPersPective/nshoptor",
        'notes': 'الجديد في 1.3.4:\n'
                 '• تصوير الإيصالات المتعددة أو الطويلة تباعاً دون انتظار\n'
                 '• تبويب «إيصالاتي» الجديد يعالج المسودات بالخلفية وينبّه عند التكرار\n'
                 '• حفظ صور الإيصال القابلة للتكبير أسفل قائمة التسوق بعد التحويل\n'
                 '• تحسين الشريط العلوي والترتيب والتقويم وسمات الغابة والمحيط الهادئة\n'
                 '• تحديث الترجمة في جميع اللغات الـ 71',
    },
})
for _to, _from in {'en-GB': 'en-US', 'es-419': 'es-ES', 'es-US': 'es-ES', 'fr-CA': 'fr-FR'}.items():
    L[_to] = dict(L[_from])
L['fr-CA']['short'] = "Liste d'épicerie & budget : prix prévu/réel, scan de reçus, voix & IA."
L['es-US']['short'] = 'Lista y presupuesto: precio previsto vs real, escáner de recibos, voz e IA.'

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
    if _locale not in {
        'en-US', 'en-GB', 'tr-TR', 'de-DE', 'fr-FR', 'fr-CA',
        'es-ES', 'es-419', 'es-US', 'it-IT', 'pt-PT', 'pt-BR', 'ru-RU', 'ar',
    }:
        _entry['notes'] = L['en-US']['notes']


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
