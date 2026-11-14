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
           'short': 'Grocery list & budget: receipt scan, AI & 7-day free Pro (no card).',
           'full': 'Plan at home, check faster at checkout.\n'
                   '\n'
                   '7 DAYS OF PRO FREE — NO CARD NEEDED\n'
                   'Start with 100 AI receipt scans, ad-free shopping, and full backup for your '
                   'first 7 days — no credit card or auto-charge required.\n'
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
                    '• Try Pro free for 7 days: 100 AI receipt scans and no ads right from install (no card)\n'
                    '• Improved receipt reading reliability with clear loading overlay & done notifications\n'
                    '• Branded splash screen and refined light, dark & AMOLED themes across all palettes\n'
                    '• Batch capture in My receipts with duplicate detection & zoomable list photos\n'
                    '• Updated localizations across all 71 languages'},
 'tr-TR': {'title': 'NShoptor: Alışveriş Listesi',
           'short': 'Alışveriş listesi & bütçe: fiş okuma, YZ, 7 gün ücretsiz Pro (kartsız).',
           'full': 'Evde planla, kasada netleş.\n'
                   '\n'
                   '7 GÜN ÜCRETSİZ PRO — KART GEREKMEZ\n'
                   'İlk kurulumda 100 yapay zekâ fiş okuma, reklamsız deneyim ve tam yedekleme '
                   'ile 7 gün Pro özelliklerini kartsız ve otomatik ücret olmadan deneyin.\n'
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
           'notes': 'Sürüm 1.3.4 yenilikleri:\n'
                    '• 7 gün ücretsiz Pro karşılama kartı: kartsız 100 YZ fiş okuma ve reklamsız deneyim\n'
                    '• Güçlendirilen fiş okuma motoru, yükleme animasyonu ve yerel tamamlanma bildirimi\n'
                    '• İkonlu yeni açılış ekranı ve yerelleştirilmiş slogan\n'
                    '• Açık, koyu ve AMOLED ekranlarda cilalanan sakin tema tasarımları\n'
                    '• 71 dilde güncel yerelleştirmeler'}}

# Diger Play dilleri: listing_translate.py'nin urettigi JSON + bolgesel kopyalar.
_extra = pathlib.Path(__file__).with_name('listing_extra.json')
if _extra.exists():
    L.update(json.loads(_extra.read_text(encoding='utf8')))

# Ana mağaza dillerinde ürünün tek-liste zihinsel modeli ve sloganı doğrudan
# yerelleştirilir; diğer Play dilleri mevcut çeviri kataloğunu korur.
L.update({
    'de-DE': {
        'title': 'NShoptor: Einkaufsbudget',
        'short': 'Einkaufsliste & Budget: Bon-Scan, KI & 7 Tage Pro gratis (ohne Karte).',
        'full': "Zuhause planen, an der Kasse den Überblick behalten.\n\n"
                "7 TAGE PRO GRATIS — OHNE KREDITKARTE\n"
                "Starte ab der Installation mit 100 KI-Bon-Scans, werbefreiem Einkauf und vollständigem Backup für 7 Tage — ganz ohne Karte oder automatische Abbuchung.\n\n"
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
                 '• 7 Tage Pro gratis testen: 100 KI-Bon-Scans ohne Werbung und ohne Kreditkarte\n'
                 '• Verbesserte Bon-Erkennung mit klarer Ladeanzeige und lokaler Benachrichtigung\n'
                 '• Neuer Startbildschirm mit App-Icon, Slogan & verfeinertem Hell/Dunkel/AMOLED-Design\n'
                 '• Serien-Scan unter „Meine Belege“ mit Duplikatprüfung & zoombaren Listenfotos\n'
                 '• Aktualisierte Übersetzungen in 71 Sprachen',
    },
    'es-ES': {
        'title': 'NShoptor: Lista y presupuesto',
        'short': 'Lista y presupuesto: escáner de tickets, IA, 7 días Pro gratis (sin tarjeta).',
        'full': "Planifica en casa, comprueba en caja.\n\n"
                "7 DÍAS DE PRO GRATIS — SIN TARJETA\n"
                "Empieza con 100 escaneos de tickets por IA, sin anuncios y con copia de seguridad completa durante 7 días tras instalar, sin tarjeta ni cobro automático.\n\n"
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
                 '• Prueba Pro gratis 7 días: 100 lecturas de tickets con IA y sin anuncios (sin tarjeta)\n'
                 '• Lectura de tickets mejorada con indicador de carga y aviso local al terminar\n'
                 '• Pantalla de inicio con icono y eslogan localizados; temas claro, oscuro y AMOLED pulidos\n'
                 '• Escaneo por lotes en «Mis recibos» con detección de duplicados y fotos ampliables\n'
                 '• Traducciones revisadas en 71 idiomas',
    },
    'fr-FR': {
        'title': 'NShoptor : liste et budget',
        'short': 'Courses & budget : scan tickets, IA, 7 j Pro gratuits (sans carte).',
        'full': "Planifiez chez vous, vérifiez en caisse.\n\n"
                "7 JOURS PRO GRATUITS — SANS CARTE BANCAIRE\n"
                "Profitez dès l'installation de 100 scans de tickets par IA, sans publicité et avec sauvegarde complète pendant 7 jours, sans carte ni prélèvement.\n\n"
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
                 '• Essai Pro gratuit 7 jours : 100 scans IA et zéro pub dès l’installation (sans carte)\n'
                 '• Lecture de tickets renforcée avec indicateur de chargement et notification claire\n'
                 '• Écran de démarrage avec logo et slogan localisés ; thèmes clair, sombre et AMOLED affinés\n'
                 '• « Mes tickets » en rafale avec détection des doublons et photos zoomables\n'
                 '• Traductions vérifiées sur 71 langues',
    },
    'it-IT': {
        'title': 'NShoptor: lista e budget',
        'short': 'Lista spesa & budget: scontrini, IA, 7 giorni Pro gratis (senza carta).',
        'full': "Pianifica a casa, controlla alla cassa.\n\n"
                "7 GIORNI DI PRO GRATIS — SENZA CARTA\n"
                "Inizia subito con 100 scansioni scontrini con IA, esperienza senza pubblicità e backup completo per 7 giorni, senza carta né addebito automatico.\n\n"
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
                 '• Prova Pro gratis 7 giorni: 100 scansioni IA e zero pubblicità (senza carta)\n'
                 '• Lettura scontrini migliorata con indicatore di caricamento e avviso al termine\n'
                 '• Splash screen con icona e slogan localizzati; temi chiaro, scuro e AMOLED rifiniti\n'
                 '• Acquisizione in serie in «I miei scontrini» con controllo duplicati e foto ingrandibili\n'
                 '• Localizzazione completata per 71 lingue',
    },
    'pt-PT': {
        'title': 'NShoptor: Lista de Compras',
        'short': 'Lista e orçamento: talões, IA, 7 dias Pro grátis (sem cartão).',
        'full': "Planeje em casa, confira no caixa.\n\n"
                "7 DIAS PRO GRÁTIS — SEM CARTÃO\n"
                "Comece com 100 leituras de talões por IA, sem anúncios e com cópia de segurança completa durante 7 dias, sem cartão nem cobrança automática.\n\n"
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
                 '• Experimente Pro grátis por 7 dias: 100 leituras IA e zero anúncios (sem cartão)\n'
                 '• Leitura de talões melhorada com indicador de carregamento e notificação local\n'
                 '• Ecrã inicial com ícone e slogan localizados; temas claro, escuro e AMOLED refinados\n'
                 '• Separador «Meus recibos» em série com alerta de duplicados e fotos ampliáveis\n'
                 '• Traduções revistas em 71 idiomas',
    },
    'pt-BR': {
        'title': 'NShoptor: Lista de Compras',
        'short': 'Lista e orçamento: cupons, IA, 7 dias Pro grátis (sem cartão).',
        'full': "Planeje em casa, confira no caixa.\n\n"
                "7 DIAS PRO GRÁTIS — SEM CARTÃO\n"
                "Comece com 100 leituras de cupons com IA, experiência sem anúncios e backup completo por 7 dias após instalar — sem cartão nem cobrança automática.\n\n"
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
                 '• Teste Pro grátis por 7 dias: 100 leituras com IA e sem anúncios (sem cartão)\n'
                 '• Leitura de cupons reforçada com indicador de carregamento e aviso local ao concluir\n'
                 '• Tela inicial com ícone e slogan localizados; temas claro, escuro e AMOLED refinados\n'
                 '• Aba «Meus recibos» em lote com alerta de duplicados e fotos ampliáveis\n'
                 '• Traduções revisadas em 71 idiomas',
    },
    'ru-RU': {
        'title': 'NShoptor: список и бюджет',
        'short': 'Список покупок & бюджет: чеки, ИИ, 7 дней Pro бесплатно (без карты).',
        'full': "Планируйте дома, сверяйте на кассе.\n\n"
                "7 ДНЕЙ PRO БЕСПЛАТНО — БЕЗ КАРТЫ\n"
                "Начните со 100 ИИ-распознаваний чеков, работы без рекламы и полного резервного копирования на первые 7 дней — без привязки карты и автосписаний.\n\n"
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
                 '• Попробуйте Pro бесплатно 7 дней: 100 ИИ-сканов и никакой рекламы (без карты)\n'
                 '• Повышена точность чтения чеков, добавлена анимация загрузки и чёткое уведомление\n'
                 '• Новый экран запуска с иконкой и слоганом; доработаны светлая, тёмная и AMOLED темы\n'
                 '• Пакетное сканирование во вкладке «Мои чеки» с проверкой дубликатов и фото чека\n'
                 '• Обновлена локализация для 71 языка',
    },
    'ar': {
        'title': 'NShoptor: قائمة تسوق ذكية',
        'short': 'قائمة تسوق وميزانية: فواتير، ذكاء اصطناعي، 7 أيام Pro مجاناً بلا بطاقة.',
        'full': "خطّط في المنزل، وتحقّق عند الدفع.\n\n"
                "7 أيام Pro مجاناً — دون بطاقة بنكية\n"
                "ابدأ بـ 100 مسح إيصال بالذكاء الاصطناعي وتجربة خالية من الإعلانات مع نسخ احتياطي كامل خلال أول 7 أيام — دون بطاقة أو خصم تلقائي.\n\n"
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
                 '• جرّب Pro مجاناً لـ 7 أيام: 100 مسح بالذكاء الاصطناعي وبلا إعلانات (دون بطاقة)\n'
                 '• تحسين قراءة الإيصالات مع مؤشر تحميل أنيق وإشعار واضح عند الاكتمال\n'
                 '• شاشة بداية بهوية التطبيق وشعاره المترجم مع صقل السمات الفاتحة والداكنة وAMOLED\n'
                 '• مسح متتابع في تبويب «إيصالاتي» مع كشف التكرار وحفظ صور الإيصال القابلة للتكبير\n'
                 '• تحديث الترجمة في جميع اللغات الـ 71',
    },
})
for _to, _from in {'en-GB': 'en-US', 'es-419': 'es-ES', 'es-US': 'es-ES', 'fr-CA': 'fr-FR'}.items():
    L[_to] = dict(L[_from])
L['fr-CA']['short'] = "Liste d'épicerie & budget : prix prévu/réel, scan de reçus, voix & IA."
L['es-US']['short'] = 'Lista y presupuesto: precio previsto vs real, escáner de recibos, voz e IA.'

def _arb_text(locale):
    code = locale.split('-')[0]
    code = {'iw': 'he'}.get(code, code)
    arb = pathlib.Path(__file__).resolve().parents[2] / 'lib/core/l10n' / f'app_{code}.arb'
    return json.loads(arb.read_text(encoding='utf8'))


# One localized annual Pro contract shared by the app and store.
# Existing ownership remains restorable; this module only generates local files.
def _annual_plan_text(locale):
    text = _arb_text(locale)
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


def _with_trial_lead(locale, full):
    text = _arb_text(locale)
    title = text['homeProPromoTitle']
    if title in full:
        return full
    lead = f"{title}\n{text['homeProPromoSubtitle']}"
    paragraphs = full.split('\n\n')
    if len(paragraphs) < 2:
        return lead + '\n\n' + full
    return '\n\n'.join([paragraphs[0], lead, *paragraphs[1:]])


_HAND_CRAFTED = {
    'en-US', 'en-GB', 'tr-TR', 'de-DE', 'fr-FR', 'fr-CA',
    'es-ES', 'es-419', 'es-US', 'it-IT', 'pt-PT', 'pt-BR', 'ru-RU', 'ar',
}

for _locale, _entry in L.items():
    _body = _without_plan_section(_entry['full'])
    if _locale not in _HAND_CRAFTED:
        _with_lead = _with_trial_lead(_locale, _body)
        _candidate = _with_lead + '\n\n' + _annual_plan_text(_locale)
        if len(_candidate) <= 4000:
            _body = _with_lead
    _entry['full'] = _body + '\n\n' + _annual_plan_text(_locale)
    if _locale not in _HAND_CRAFTED:
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
