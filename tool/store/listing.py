# Play mağaza metinleri (9 dil) → fastlane metadata klasörü.
#   python tool/store/listing.py <metadata-kökü> <versionCode>
# Uzunlukları Play sınırlarına göre doğrular (başlık 30, kısa 80, uzun 4000,
# sürüm notu 500); sınırı aşan dil yazılmaz.
import pathlib
import sys

REPO = 'https://github.com/XPersPective/nshoptor'

L = {
    'en-US': dict(
        title='NShoptor: Smart Grocery List',
        short='Grocery list & budget: real prices, receipt scan, AI. Plan at home, save more.',
        full=f'''Plan at home. Shop as planned.

NShoptor is a smart grocery list and shopping budget app. Write your list with estimated prices, enter the real prices in the store – by hand, from a shelf label photo or by scanning the receipt – and see at a glance what changed: "Apples 2.00 → 2.50, +0.50".

HOW IT WORKS
• Create a list – type it, or just say it: "1 kg apples, 2 breads, milk" becomes a list.
• Shop – tick items into the cart, enter the real price in a second or snap the shelf label.
• Scan the receipt – in the store or later at home. AI matches receipt lines to your items ("apples" vs "discount apples") and you confirm every match.
• Compare – planned vs. real for every item, the total and your budget in one simple table.

SPENDING UNDER CONTROL
• Calendar of your shopping days
• Weekly and monthly spending charts
• Monthly spending limit
• Price history: see where each item is cheapest

A LITTLE HELPER
A small assistant at the bottom right takes you to the most common actions. Turn it off any time in Settings.

PRIVACY FIRST
No account needed. Your lists, prices and photos stay on your phone. Receipt and label photos are read on the device and your voice is turned into text by your phone. Only that text is sent to our AI service when you use AI help; it is not stored, and you can switch AI off.

PLANS
• Free: every core feature, 15 AI requests a month, small ads – none in your first 7 days. Watch a short video for a whole day without ads.
• Pro: no ads, 200 AI requests a month, backup. 7-day free trial.
• Max: no ads, 1000 AI requests a month – for big family shopping.
• Ad-free for life: a one-time purchase.

Available in English, Turkish, German, French, Spanish, Italian, Portuguese, Russian and Arabic.

Open source (GPL-3.0): {REPO}''',
        notes='''New in 1.1
• AI matches receipt lines to your list – you confirm each one
• Read prices from shelf labels
• Say a sentence, get a list
• Simple planned vs. real table
• Spending calendar, weekly/monthly charts, monthly limit
• Assistant bubble (can be turned off)
• Pro and Max plans, 7 ad-free days to start
• 9 languages''',
    ),
    'tr-TR': dict(
        title='NShoptor: Alışveriş Listesi',
        short='Market listesi ve bütçe: gerçek fiyat, fiş okuma, yapay zeka. Evde planla.',
        full=f'''Evde planla. Planladığın gibi alışveriş yap.

NShoptor akıllı bir market listesi ve alışveriş bütçesi uygulamasıdır. Listeni tahmini fiyatlarla yaz, markette gerçek fiyatları gir – elle, raf etiketinin fotoğrafıyla ya da fişi okutarak – ve neyin değiştiğini tek bakışta gör: "Elma 20 → 30, +10".

NASIL ÇALIŞIR
• Liste oluştur – yaz ya da sadece söyle: "1 kilo elma, 2 ekmek, süt" listeye dönüşür.
• Alışveriş yap – ürünleri sepete işaretle, gerçek fiyatı bir saniyede gir ya da raf etiketini çek.
• Fişi okut – markette ya da sonra evde. Yapay zeka fiş satırlarını ürünlerinle eşleştirir ("elma" ile "indirimli elma") ve her eşleşmeyi sen onaylarsın.
• Karşılaştır – her ürün, toplam ve bütçen için planlanan ile gerçek tek bir sade tabloda.

HARCAMALAR KONTROLDE
• Alışveriş günlerinin takvimi
• Haftalık ve aylık harcama grafikleri
• Aylık harcama limiti
• Fiyat geçmişi: her ürünün en ucuz olduğu yeri gör

KÜÇÜK BİR YARDIMCI
Sağ alttaki küçük asistan seni en sık işlere götürür. Ayarlardan istediğin an kapatabilirsin.

ÖNCE GİZLİLİK
Hesap gerekmez. Listelerin, fiyatların ve fotoğrafların telefonunda kalır. Fiş ve etiket fotoğrafları cihazda okunur, sesin telefonunun konuşma tanımasıyla metne çevrilir. Yapay zeka yardımını kullandığında yalnızca bu metin yapay zeka servisimize gider; saklanmaz ve yapay zekayı kapatabilirsin.

PLANLAR
• Ücretsiz: tüm temel özellikler, ayda 15 yapay zeka isteği, küçük reklamlar – ilk 7 gün hiç yok. Kısa bir video izle, bir gün boyunca reklamsız kullan.
• Pro: reklamsız, ayda 200 yapay zeka isteği, yedekleme. 7 gün ücretsiz deneme.
• Max: reklamsız, ayda 1000 yapay zeka isteği – kalabalık aile alışverişi için.
• Ömür boyu reklamsız: tek seferlik satın alma.

Türkçe, İngilizce, Almanca, Fransızca, İspanyolca, İtalyanca, Portekizce, Rusça ve Arapça.

Açık kaynak (GPL-3.0): {REPO}''',
        notes='''1.1 ile gelenler
• Yapay zeka fiş satırlarını listenle eşleştirir – her birini sen onaylarsın
• Raf etiketinden fiyat okuma
• Bir cümle söyle, liste hazır
• Sade planlanan ↔ gerçek tablosu
• Harcama takvimi, haftalık/aylık grafikler, aylık limit
• Asistan balonu (kapatılabilir)
• Pro ve Max planları, başlangıçta 7 gün reklamsız
• 9 dil''',
    ),
    'de-DE': dict(
        title='NShoptor: Einkaufsliste',
        short='Einkaufsliste & Budget: echte Preise, Kassenbon-Scan, KI. Zu Hause planen.',
        full=f'''Zu Hause planen. Wie geplant einkaufen.

NShoptor ist eine smarte Einkaufsliste und Haushaltsbuch für den Einkauf. Schreib deine Liste mit geschätzten Preisen, trag im Laden die echten Preise ein – von Hand, per Foto vom Regaletikett oder per Kassenbon-Scan – und sieh auf einen Blick, was sich geändert hat: „Äpfel 2,00 → 2,50, +0,50“.

SO FUNKTIONIERT ES
• Liste erstellen – tippen oder einfach sagen: „1 kg Äpfel, 2 Brote, Milch“ wird zur Liste.
• Einkaufen – Artikel in den Wagen abhaken, echten Preis in einer Sekunde eingeben oder das Regaletikett fotografieren.
• Kassenbon scannen – im Laden oder später zu Hause. Die KI ordnet Bonzeilen deinen Artikeln zu („Äpfel“ und „Äpfel reduziert“), und du bestätigst jede Zuordnung.
• Vergleichen – geplant und tatsächlich für jeden Artikel, die Summe und dein Budget in einer einfachen Tabelle.

AUSGABEN IM GRIFF
• Kalender deiner Einkaufstage
• Wöchentliche und monatliche Ausgabendiagramme
• Monatliches Ausgabenlimit
• Preisverlauf: sieh, wo jeder Artikel am günstigsten ist

EIN KLEINER HELFER
Ein kleiner Assistent unten rechts bringt dich zu den häufigsten Aktionen. In den Einstellungen jederzeit abschaltbar.

DATENSCHUTZ ZUERST
Kein Konto nötig. Listen, Preise und Fotos bleiben auf deinem Handy. Bon- und Etikettenfotos werden auf dem Gerät gelesen, deine Stimme wird von deinem Handy in Text umgewandelt. Nur dieser Text geht an unseren KI-Dienst, wenn du die KI-Hilfe nutzt; er wird nicht gespeichert, und du kannst die KI abschalten.

PLÄNE
• Kostenlos: alle Kernfunktionen, 15 KI-Anfragen im Monat, kleine Werbung – in den ersten 7 Tagen keine. Ein kurzes Video schauen und einen ganzen Tag werbefrei nutzen.
• Pro: keine Werbung, 200 KI-Anfragen im Monat, Backup. 7 Tage kostenlos testen.
• Max: keine Werbung, 1000 KI-Anfragen im Monat – für den großen Familieneinkauf.
• Für immer werbefrei: einmaliger Kauf.

Auf Deutsch, Englisch, Türkisch, Französisch, Spanisch, Italienisch, Portugiesisch, Russisch und Arabisch.

Open Source (GPL-3.0): {REPO}''',
        notes='''Neu in 1.1
• KI ordnet Bonzeilen deiner Liste zu – du bestätigst jede
• Preise vom Regaletikett lesen
• Einen Satz sagen, Liste fertig
• Einfache Tabelle geplant ↔ tatsächlich
• Ausgabenkalender, Wochen-/Monatsdiagramme, Monatslimit
• Assistent (abschaltbar)
• Pro- und Max-Pläne, 7 werbefreie Tage zum Start
• 9 Sprachen''',
    ),
    'fr-FR': dict(
        title='NShoptor : Liste de courses',
        short='Liste de courses et budget : vrais prix, scan de ticket et IA. Économisez.',
        full=f'''Planifiez chez vous. Faites vos courses comme prévu.

NShoptor est une liste de courses intelligente et un suivi du budget courses. Écrivez votre liste avec des prix estimés, saisissez les vrais prix au magasin – à la main, en photographiant l’étiquette du rayon ou en scannant le ticket – et voyez d’un coup d’œil ce qui a changé : « Pommes 2,00 → 2,50, +0,50 ».

COMMENT ÇA MARCHE
• Créez une liste – tapez-la ou dites-la simplement : « 1 kg de pommes, 2 baguettes, du lait » devient une liste.
• Faites vos courses – cochez les articles dans le panier, saisissez le vrai prix en une seconde ou photographiez l’étiquette.
• Scannez le ticket – au magasin ou plus tard chez vous. L’IA associe les lignes du ticket à vos articles (« pommes » et « pommes en promo ») et vous confirmez chaque association.
• Comparez – prévu et réel pour chaque article, le total et votre budget dans un tableau simple.

VOS DÉPENSES SOUS CONTRÔLE
• Calendrier de vos jours de courses
• Graphiques de dépenses hebdomadaires et mensuels
• Limite de dépenses mensuelle
• Historique des prix : voyez où chaque article est le moins cher

UN PETIT ASSISTANT
Un petit assistant en bas à droite vous mène aux actions les plus courantes. Désactivable à tout moment dans les réglages.

LA CONFIDENTIALITÉ D’ABORD
Aucun compte nécessaire. Vos listes, prix et photos restent sur votre téléphone. Les photos de tickets et d’étiquettes sont lues sur l’appareil et votre voix est convertie en texte par votre téléphone. Seul ce texte est envoyé à notre service d’IA quand vous utilisez l’aide IA ; il n’est pas conservé et vous pouvez désactiver l’IA.

FORMULES
• Gratuit : toutes les fonctions essentielles, 15 requêtes IA par mois, petites publicités – aucune les 7 premiers jours. Regardez une courte vidéo pour une journée entière sans pub.
• Pro : sans pub, 200 requêtes IA par mois, sauvegarde. 7 jours d’essai gratuit.
• Max : sans pub, 1000 requêtes IA par mois – pour les grosses courses en famille.
• Sans pub à vie : achat unique.

Disponible en français, anglais, turc, allemand, espagnol, italien, portugais, russe et arabe.

Open source (GPL-3.0) : {REPO}''',
        notes='''Nouveautés 1.1
• L’IA associe les lignes du ticket à votre liste – vous confirmez chacune
• Lecture des prix sur les étiquettes
• Dites une phrase, la liste est prête
• Tableau simple prévu ↔ réel
• Calendrier des dépenses, graphiques, limite mensuelle
• Assistant (désactivable)
• Formules Pro et Max, 7 jours sans pub au départ
• 9 langues''',
    ),
    'es-ES': dict(
        title='NShoptor: Lista de la compra',
        short='Lista de la compra y presupuesto: precios reales, escáner de tickets e IA.',
        full=f'''Planifica en casa. Compra según lo previsto.

NShoptor es una lista de la compra inteligente y un control del presupuesto del súper. Escribe tu lista con precios estimados, introduce los precios reales en la tienda – a mano, con una foto de la etiqueta del estante o escaneando el ticket – y mira de un vistazo qué ha cambiado: «Manzanas 2,00 → 2,50, +0,50».

CÓMO FUNCIONA
• Crea una lista – escríbela o simplemente dila: «1 kg de manzanas, 2 panes, leche» se convierte en una lista.
• Compra – marca los productos en el carrito, introduce el precio real en un segundo o fotografía la etiqueta.
• Escanea el ticket – en la tienda o luego en casa. La IA empareja las líneas del ticket con tus productos («manzanas» y «manzanas en oferta») y tú confirmas cada emparejamiento.
• Compara – previsto y real de cada producto, el total y tu presupuesto en una tabla sencilla.

GASTOS BAJO CONTROL
• Calendario de tus días de compra
• Gráficos de gasto semanales y mensuales
• Límite de gasto mensual
• Historial de precios: descubre dónde es más barato cada producto

UN PEQUEÑO AYUDANTE
Un pequeño asistente abajo a la derecha te lleva a las acciones más habituales. Puedes desactivarlo en Ajustes cuando quieras.

PRIVACIDAD ANTE TODO
No necesitas cuenta. Tus listas, precios y fotos se quedan en tu teléfono. Las fotos de tickets y etiquetas se leen en el dispositivo y tu voz la convierte en texto tu teléfono. Solo ese texto se envía a nuestro servicio de IA cuando usas la ayuda de IA; no se guarda y puedes desactivar la IA.

PLANES
• Gratis: todas las funciones básicas, 15 solicitudes de IA al mes, anuncios pequeños – ninguno los primeros 7 días. Mira un vídeo corto y disfruta un día entero sin anuncios.
• Pro: sin anuncios, 200 solicitudes de IA al mes, copia de seguridad. 7 días de prueba gratis.
• Max: sin anuncios, 1000 solicitudes de IA al mes – para la gran compra familiar.
• Sin anuncios para siempre: pago único.

Disponible en español, inglés, turco, alemán, francés, italiano, portugués, ruso y árabe.

Código abierto (GPL-3.0): {REPO}''',
        notes='''Novedades de la 1.1
• La IA empareja las líneas del ticket con tu lista – tú confirmas cada una
• Lee precios de las etiquetas del estante
• Di una frase y tendrás la lista
• Tabla sencilla previsto ↔ real
• Calendario de gastos, gráficos semanales/mensuales, límite mensual
• Asistente (desactivable)
• Planes Pro y Max, 7 días sin anuncios al empezar
• 9 idiomas''',
    ),
    'it-IT': dict(
        title='NShoptor: Lista della spesa',
        short='Lista della spesa e budget: prezzi reali, scansione scontrino, IA. Risparmia.',
        full=f'''Pianifica a casa. Fai la spesa come previsto.

NShoptor è una lista della spesa intelligente e un controllo del budget per la spesa. Scrivi la lista con i prezzi stimati, inserisci i prezzi reali al negozio – a mano, con una foto dell’etichetta sullo scaffale o scansionando lo scontrino – e vedi a colpo d’occhio cosa è cambiato: «Mele 2,00 → 2,50, +0,50».

COME FUNZIONA
• Crea una lista – scrivila o dilla e basta: «1 kg di mele, 2 pani, latte» diventa una lista.
• Fai la spesa – spunta i prodotti nel carrello, inserisci il prezzo reale in un secondo o fotografa l’etichetta.
• Scansiona lo scontrino – al negozio o più tardi a casa. L’IA abbina le righe dello scontrino ai tuoi prodotti («mele» e «mele in offerta») e tu confermi ogni abbinamento.
• Confronta – previsto e reale per ogni prodotto, il totale e il budget in una tabella semplice.

SPESE SOTTO CONTROLLO
• Calendario dei giorni di spesa
• Grafici di spesa settimanali e mensili
• Limite di spesa mensile
• Storico prezzi: scopri dove ogni prodotto costa meno

UN PICCOLO AIUTANTE
Un piccolo assistente in basso a destra ti porta alle azioni più comuni. Puoi disattivarlo quando vuoi nelle Impostazioni.

PRIMA LA PRIVACY
Nessun account necessario. Liste, prezzi e foto restano sul tuo telefono. Le foto di scontrini ed etichette vengono lette sul dispositivo e la tua voce viene trasformata in testo dal telefono. Solo quel testo viene inviato al nostro servizio di IA quando usi l’aiuto IA; non viene conservato e puoi disattivare l’IA.

PIANI
• Gratis: tutte le funzioni principali, 15 richieste IA al mese, piccoli annunci – nessuno nei primi 7 giorni. Guarda un breve video per un giorno intero senza pubblicità.
• Pro: senza pubblicità, 200 richieste IA al mese, backup. 7 giorni di prova gratuita.
• Max: senza pubblicità, 1000 richieste IA al mese – per la grande spesa di famiglia.
• Senza pubblicità per sempre: acquisto unico.

Disponibile in italiano, inglese, turco, tedesco, francese, spagnolo, portoghese, russo e arabo.

Open source (GPL-3.0): {REPO}''',
        notes='''Novità della 1.1
• L’IA abbina le righe dello scontrino alla tua lista – confermi tu ognuna
• Lettura dei prezzi dalle etichette
• Di’ una frase, la lista è pronta
• Tabella semplice previsto ↔ reale
• Calendario delle spese, grafici, limite mensile
• Assistente (disattivabile)
• Piani Pro e Max, 7 giorni senza pubblicità all’inizio
• 9 lingue''',
    ),
    'pt-PT': dict(
        title='NShoptor: Lista de compras',
        short='Lista de compras e orçamento: preços reais, leitura de talões e IA. Poupe mais.',
        full=f'''Planeie em casa. Compre como planeou.

O NShoptor é uma lista de compras inteligente e um controlo do orçamento das compras. Escreva a lista com preços estimados, introduza os preços reais na loja – à mão, com uma foto da etiqueta da prateleira ou lendo o talão – e veja num relance o que mudou: «Maçãs 2,00 → 2,50, +0,50».

COMO FUNCIONA
• Crie uma lista – escreva-a ou simplesmente diga-a: «1 kg de maçãs, 2 pães, leite» passa a ser uma lista.
• Faça as compras – marque os produtos no carrinho, introduza o preço real num segundo ou fotografe a etiqueta.
• Leia o talão – na loja ou mais tarde em casa. A IA associa as linhas do talão aos seus produtos («maçãs» e «maçãs em promoção») e é você quem confirma cada associação.
• Compare – previsto e real de cada produto, o total e o seu orçamento numa tabela simples.

GASTOS SOB CONTROLO
• Calendário dos seus dias de compras
• Gráficos de gastos semanais e mensais
• Limite de gastos mensal
• Histórico de preços: veja onde cada produto é mais barato

UM PEQUENO AJUDANTE
Um pequeno assistente no canto inferior direito leva-o às ações mais comuns. Pode desativá-lo a qualquer momento nas Definições.

PRIVACIDADE EM PRIMEIRO LUGAR
Não precisa de conta. As suas listas, preços e fotos ficam no telemóvel. As fotos de talões e etiquetas são lidas no dispositivo e a sua voz é convertida em texto pelo telemóvel. Só esse texto é enviado ao nosso serviço de IA quando usa a ajuda de IA; não é guardado e pode desativar a IA.

PLANOS
• Grátis: todas as funções principais, 15 pedidos de IA por mês, anúncios pequenos – nenhum nos primeiros 7 dias. Veja um vídeo curto para um dia inteiro sem anúncios.
• Pro: sem anúncios, 200 pedidos de IA por mês, cópia de segurança. 7 dias de avaliação gratuita.
• Max: sem anúncios, 1000 pedidos de IA por mês – para as grandes compras da família.
• Sem anúncios para sempre: compra única.

Disponível em português, inglês, turco, alemão, francês, espanhol, italiano, russo e árabe.

Código aberto (GPL-3.0): {REPO}''',
        notes='''Novidades da 1.1
• A IA associa as linhas do talão à sua lista – confirma cada uma
• Leitura de preços nas etiquetas
• Diga uma frase e a lista fica pronta
• Tabela simples previsto ↔ real
• Calendário de gastos, gráficos semanais/mensais, limite mensal
• Assistente (pode ser desativado)
• Planos Pro e Max, 7 dias sem anúncios no início
• 9 idiomas''',
    ),
    'ru-RU': dict(
        title='NShoptor: Список покупок',
        short='Список покупок и бюджет: реальные цены, сканер чеков, ИИ. Планируйте дома.',
        full=f'''Планируйте дома. Покупайте по плану.

NShoptor — умный список покупок и учёт бюджета на продукты. Составьте список с примерными ценами, в магазине введите реальные цены — вручную, по фото ценника на полке или отсканировав чек — и сразу увидите, что изменилось: «Яблоки 120 → 150, +30».

КАК ЭТО РАБОТАЕТ
• Создайте список — напишите или просто скажите: «1 кг яблок, 2 батона, молоко» превратится в список.
• Покупайте — отмечайте товары в корзине, вводите реальную цену за секунду или сфотографируйте ценник.
• Сканируйте чек — в магазине или позже дома. ИИ сопоставит строки чека с вашими товарами («яблоки» и «яблоки по акции»), а вы подтверждаете каждое совпадение.
• Сравнивайте — план и факт по каждому товару, итог и бюджет в одной простой таблице.

РАСХОДЫ ПОД КОНТРОЛЕМ
• Календарь дней покупок
• Графики расходов по неделям и месяцам
• Месячный лимит расходов
• История цен: узнайте, где каждый товар дешевле

МАЛЕНЬКИЙ ПОМОЩНИК
Небольшой помощник в правом нижнем углу ведёт к самым частым действиям. Его можно отключить в настройках.

КОНФИДЕНЦИАЛЬНОСТЬ ПРЕЖДЕ ВСЕГО
Аккаунт не нужен. Списки, цены и фото остаются на телефоне. Фото чеков и ценников распознаются на устройстве, а голос превращает в текст ваш телефон. Только этот текст отправляется нашему ИИ-сервису, когда вы пользуетесь помощью ИИ; он не хранится, и ИИ можно отключить.

ТАРИФЫ
• Бесплатно: все основные функции, 15 запросов к ИИ в месяц, небольшая реклама — в первые 7 дней её нет. Посмотрите короткое видео — и целый день без рекламы.
• Pro: без рекламы, 200 запросов к ИИ в месяц, резервное копирование. 7 дней бесплатно.
• Max: без рекламы, 1000 запросов к ИИ в месяц — для больших семейных закупок.
• Навсегда без рекламы: разовая покупка.

На русском, английском, турецком, немецком, французском, испанском, итальянском, португальском и арабском.

Открытый исходный код (GPL-3.0): {REPO}''',
        notes='''Новое в 1.1
• ИИ сопоставляет строки чека с вашим списком — вы подтверждаете каждую
• Цены с ценников на полке
• Скажите фразу — список готов
• Простая таблица план ↔ факт
• Календарь расходов, графики, месячный лимит
• Помощник (можно отключить)
• Тарифы Pro и Max, 7 дней без рекламы на старте
• 9 языков''',
    ),
    'ar': dict(
        title='NShoptor: قائمة التسوق',
        short='قائمة تسوق وميزانية: أسعار حقيقية، مسح الإيصالات وذكاء اصطناعي. خطّط ووفّر.',
        full=f'''خطّط في البيت. تسوّق كما خطّطت.

NShoptor قائمة تسوق ذكية وأداة لمتابعة ميزانية المشتريات. اكتب قائمتك بأسعار تقديرية، ثم أدخل الأسعار الحقيقية في المتجر – يدويًا، أو بتصوير ملصق السعر على الرف، أو بمسح الإيصال – وشاهد بنظرة واحدة ما الذي تغيّر: «تفاح 2.00 ← 2.50، ‎+0.50».

كيف يعمل
• أنشئ قائمة – اكتبها أو قلها فقط: «1 كغ تفاح، 2 خبز، حليب» تصبح قائمة.
• تسوّق – ضع علامة على المنتجات في السلة، وأدخل السعر الحقيقي في ثانية أو صوّر ملصق السعر.
• امسح الإيصال – في المتجر أو لاحقًا في البيت. يطابق الذكاء الاصطناعي سطور الإيصال مع منتجاتك («تفاح» و«تفاح مخفّض») وأنت تؤكّد كل مطابقة.
• قارن – المخطّط والفعلي لكل منتج، والإجمالي وميزانيتك في جدول بسيط واحد.

مصروفاتك تحت السيطرة
• تقويم لأيام تسوّقك
• رسوم بيانية للإنفاق الأسبوعي والشهري
• حدّ شهري للإنفاق
• سجلّ الأسعار: اعرف أين يكون كل منتج أرخص

مساعد صغير
مساعد صغير في أسفل اليمين يأخذك إلى أكثر الإجراءات استخدامًا. يمكنك إيقافه في أي وقت من الإعدادات.

الخصوصية أولًا
لا حاجة إلى حساب. تبقى قوائمك وأسعارك وصورك على هاتفك. تُقرأ صور الإيصالات والملصقات على الجهاز، ويحوّل هاتفك صوتك إلى نص. يُرسل هذا النص فقط إلى خدمة الذكاء الاصطناعي لدينا عند استخدامك لمساعدة الذكاء الاصطناعي؛ ولا يُخزَّن، ويمكنك إيقاف الذكاء الاصطناعي.

الخطط
• مجاني: كل الميزات الأساسية، 15 طلب ذكاء اصطناعي شهريًا، إعلانات صغيرة – لا إعلانات في أول 7 أيام. شاهد فيديو قصيرًا واستمتع بيوم كامل بلا إعلانات.
• Pro: بلا إعلانات، 200 طلب ذكاء اصطناعي شهريًا، نسخ احتياطي. تجربة مجانية لمدة 7 أيام.
• Max: بلا إعلانات، 1000 طلب ذكاء اصطناعي شهريًا – لتسوّق العائلات الكبيرة.
• بلا إعلانات مدى الحياة: شراء لمرة واحدة.

متوفر بالعربية والإنجليزية والتركية والألمانية والفرنسية والإسبانية والإيطالية والبرتغالية والروسية.

مفتوح المصدر (GPL-3.0): {REPO}''',
        notes='''الجديد في 1.1
• يطابق الذكاء الاصطناعي سطور الإيصال مع قائمتك – وأنت تؤكّد كل سطر
• قراءة الأسعار من ملصقات الرف
• قل جملة، تجهز القائمة
• جدول بسيط للمخطّط ↔ الفعلي
• تقويم المصروفات، رسوم أسبوعية وشهرية، حدّ شهري
• مساعد (يمكن إيقافه)
• خطط Pro وMax، و7 أيام بلا إعلانات في البداية
• 9 لغات''',
    ),
}

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
