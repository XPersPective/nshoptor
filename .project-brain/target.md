# Target Architecture
Status: CONFIRMED

## Goal

2026-10-29 kullanıcı: "bu bütün diller için geçerli ve onların kendi rakamlarıyla"; "bütün işleri bitir ve yayınla artık". Ülkeye uygun rakam/fiş biçimi giriş, hesap ve gösterimde doğrulanır; GitHub macOS üzerinden iOS kontrolleri yapılır; bütün site/mağaza açıklamaları ve gerçek görseller güncellenerek Android+iOS yayını tamamlanır (PB-204/205/206).

2026-10-26 son ek: "Önce ... Project Brain’e işle ... projenin içini temizle ... Store Automasyonun kalıntıları kaldır ... gizlilik ... açık kaynak ... kontrolünü yap ... contributor olarak cloud’u ... kaldır ... daha güzel [video] ... büyük fotoğraflar ... iOS linkini de koy ... Bir şey söylediğimde de yapacağın işi bırakma ... uygulama ... Site işi en son." PB-161 güvenlik/atıf, PB-162 hiyerarşi/temizlik, PB-163 görsel/video/çok dilli iki mağaza yayını olarak kaydedildi. Basit mekanik işler düşük modelde; mimari ve final doğrulama direktörde. Önce mevcut uygulama kabulü, sonra bu yayın hazırlıkları ve site; güvenlik denetimi hemen paralel yürür.

2026-10-26 kullanıcı: "devral isleri bitir hem play store hem app store ... tum dillerde yayimla". Son sıralama: "Bu faturaları doğru okuyor değil mi? Ve diğer yapılacakların hepsini yap. Site işi en son ... Eksiksiz, premium düzeyde". Önce Android+iOS uygulama/fiş/fatura doğruluğu ve bütün açık kabul ölçütleri; sonra mağaza sunumu/ASO ve site/SEO. Mevcut yayın yetkisi tekrar sorulmaz; doğrulanmamış sonuç tamamlandı sayılmaz.

"Bütün bu söylediklerimi hepsini önce Project Brain'e eklemen gerekiyor... Sonra her birini itinayla üretim seviyesinde premium düzeyde gerçekleştir... Android ve iOS'a yüklemeni istiyorum." (user eki,2026-10-24). Ayrıntılı onaylı kapsam: `.project-brain/intake-2026-10-24.md` N001–N074, PB-141..155. Özgün ek `.project-brain/sources/2026-10-24-user-request.txt`.
"Her şeyi, bütün her şeyi Project Brain'e taşımanı istiyorum... onları sileceksin... sadece senle çalışacağım." (user,2026-10-24). Önceki yarım değişiklikleri koruyarak sürdür; havuz kullanma, yalnız bounded native alt ajanlar. Eski takip artefaktları kapsam korunarak arşivlenip kaldırılır; uygulama/kanıt/yayın kimliği dosyaları korunur.
"Baştan sona her şeyi kullanıcı dostu, aynı zamanda profesyonel, eksiksiz çalışır hale üretim düzeyine getir. yayına hazır hale getir" (user 2026-10-18).
"Artık Project Brain üzerine yürüyecek işler." (user 2026-10-18).
Önceki onaylı kullanıcı hedefi: "Evdeki Hesap" planlanan/tahmini, "Çarşıdaki Hesap" gerçekleşen fiyat; slogan "Evdeki hesap çarşıya uyar."

"bu sohbette ginderdigim diger komutlaein herbirini madde madde ver kendine kapsamli bir promp yaz her maddeyi project brain skilini kullanarak once buraya ekle hedef ve asama yapilacaklara sinrada gerceklestir . senden sonraki yz dvralabilecek sekilde bitir." (user 2026-10-23).
Tam kapsam: `.project-brain/references/production-master-prompt-tr.md`, R01–R74; aşamalar ve görev eşleştirmesi bu belgededir. Son doğrudan talep: yeni satışta yalnız yıllık Pro (vergi hariç USD1/yıl,100YZ/ay; önceki aylık satış talebi geçersiz); isteğe bağlı alışveriş tarih+saat; varsayılan tarih ve seçilebilirA–Z; manuel doğal fiyat seçilen miktarın toplamı, açıkbirim fiyatı ve etiket/fiş bazları ayrı, tahmin/gerçek grafik ortakbirimde (PB-131..133).

## Users and Main Journey
Son kullanıcı eki (2026-10-24): "urunlerin tiklileri asagiya kaymali. urunlerde arama yapilabilmeli". PB-134: market fiyatı olanlar altta, fiyat silinince yeniden üstte; liste içi ürün araması toplamları değiştirmez. Yayın mevcut release-harbor ile dahili test; önceki açık işler korunur.

- Evde liste hazırlayan, markette fiyat giren, fiş ekleyen ve geçmiş harcamasını inceleyen kullanıcı.
- Liste oluştur → ürünleri yaz/söyle → fiyatları düzenle/fişten onayla → alışverişi bitir → raporu paylaş/PDF kaydet → yanlış bitirildiyse geri aç.

## Target State
### Lists and prices
- Türkçe i/ı dahil liste adının ilk harfi yazarken ve kaydederken doğru büyür (PB-120).
- Ürüne dokununca iki fiyat boşsa evdeki; diğer tüm durumlarda market fiyatı odaklanır; klavye açılır, mevcut değer korunur (PB-120).
- Market fiyatı var/0 ise tikli; silinince tiksiz; tüm sayaçlar/özetler/restart aynı kuralı kullanır (PB-120). Gösterge boş/dolu dairedir (PB-114).
- Yanlış bitirilen liste verileri kaybetmeden geri açılabilir; fiş onayı listede olmayan ürünleri ekler ve satın alınmış sayar; bitirme ayrı eylemdir (PB-121).
### Voice and receipt
- Uzun konuşma/kısa duraklamada kayıt ürün kaybetmez; kullanıcı kapatabilir; gerçek platform sınırları ölçülür (PB-122).
- Miktar/birim/ürün ve toplam-birim fiyat bağlamı ayrılır; belirsiz fiyat kısa doğrulamayla çözülür; market fiyatı ev fiyatından bağımsızdır (PB-122).
- Yerel ayrıştırma ve model çağrısı süreleri ölçülür; gereksiz çağrı/bekleme kaldırılır; fiş/fatura alışveriş tamamlanmadan veya tamamlandıktan sonra güvenle denenir (PB-121/PB-122).
### Brand and help
- Marka, ikon, slogan ve Pro vurgusu sabit yeşildir; yalnız yüzeyler temayı izler (PB-111/PB-112/PB-113).
- İkon açıklamaları, ilk kullanım rehberi ve Ayarlar'dan tekrar açılabilen kısa rehber yerelleştirilir (PB-110/PB-118/PB-130).
### Discover and engagement
- NAppKit platform/dil farkındalığı olan güncellenebilir uygulama kataloğu sağlar; Android Android'i, iOS iOS'u gösterir; çevrimdışı/hata/önbellek davranışı tanımlıdır (PB-123).
- Puanlama/paylaşım mevcut kit politikasını kullanır; hemen/sık çıkmaz, değerlendirdiğini bildiren kullanıcı tekrar zorlanmaz (PB-123).
### Spending and settings
- Genel bakış seçili haftanın/ayın/yılın harcaması ve alışveriş listelerini tutarlarıyla gösterir; dönem → alışveriş → satırlar hiyerarşisi (PB-115/PB-124).
- Grafiklerde para ölçeği/değerler dokunmadan okunur; kategori/ürün ayrıntısı isteğe bağlıdır; takvim ana içeriği sıkıştırmaz (PB-102/PB-115).
- Limitler Ayarlar'da belirlenir; genel bakışta gerçekleşen tutarlar ve belirlenmiş limitler görünür (PB-116/PB-124).
- Alışveriş ve dönem raporları hızlı dışa aktarılır; PDF kaydedilir/paylaşılır; mevcut veri içe aktarma biçimleri açıkça anlatılır (PB-117/PB-124).
- Ayarlar sade gruplar ve hafif kenarlıklarla düzenlenir; örnek veriler tek eylemle yalnız örnek kayıtları siler, kullanıcının verileri korunur (PB-124).
### Monetization and locales
- "Reklam ve abonelik ürün hedefinin parçası" (user 2026-10-16); Free ve yeni satışta yalnız yıllık Pro; yıllık 1 ABD doları vergi hariç temel fiyat, her ay 100 YZ isteği. Eski Pro/Max/lifetime satıştan kalkar, satın alınmış haklar korunur (PB-135/PB-137; eski PB-105/PB-107/PB-108 kanıtları tarihseldir).
- 71 dilin uygulama metinleri, açıklamaları ve mağaza materyalleri kendi dilinde; üretim hazırlığı bağımsız incelemeyle kanıtlanır (PB-118/PB-125).

### Expanded scope 2026-10-23
- YZ ayarı yardım bölümünde, kullanıcıyı ürkütmeyen nazik dil; Ayarlar’dan tekrar açılan çok dilli rehber (PB-110/PB-124).
- Günlük/haftalık/aylık rapor, anlaşılır alışveriş geçmişi, PDF/CSV/JSON ve geri yükleme (PB-115/PB-117/PB-124).
- Fiş/fatura maliyeti ve raf etiketi gerçek görüntüleriyle doğruluk (PB-121/PB-126).
- Yerel hatırlatma, Android/iOS izinleri, çevrimdışı ve ücretsiz Cloudflare Workers/D1 sınırları; gerektiğinde ücretsiz FCM (PB-127).
- Ön/arka uç, YZ sınırları, abonelik/reklam/keşfet/değerlendirme/paylaşım birlikte doğrulanır (PB-105/PB-108/PB-122/PB-123/PB-127).
- Ücretsiz GitHub Pages tanıtım sitesi, gerçek mağaza bağlantıları, çok dilli SEO ve güncel rakip analizi (PB-128/PB-129).
- Android/iOS materyalleri/video, platform koşulları ve gerçek yayın süreci; doğrulanmamış cihaz/mağaza sonucu açık tutulur (PB-125/PB-129).

## Non-Goals
- Yeni hesap/bulut senkronizasyonu, döviz dönüşümü veya tam mimari yeniden yazımı.
- Project Brain yayın durumunu izler; gerçek mağaza yükleme/yayınlama ilgili yayın araçlarıyla yürütülür ve yalnız geri okunan sonuç raporlanır (kullanıcı 2026-10-23 yayını açıkça istedi).
- Kullanıcı onayı olmadan ücretli API, yeni model rotası veya kimlik bilgisi değişikliği yok.

## Riskiest Assumptions
- Cihazdaki ses servisi emülatörde kesintisiz oturum için yeterli mi? Önce mevcut native sınırları ölç; emülatör desteği eksikse gerçek cihaz kanıtını açık bırak.
- NAppKit'in mevcut katalog/prompt API'si gereksinimi karşılıyor mu? Önce yerel paket ve kit deposunu incele; yeni servis eklemeden mevcut yolu kullan.

## Success Conditions
- [machine] Flutter test/analyze ve server test geçer; Android derleme tekrarlanabilir; atlanan testler açıklanır.
- [interaction] Liste → fiyat/fiş → tamamla → rapor → geri aç yolculuğu emülatörde kalıcı veri okumasıyla kanıtlanır.
- [visual] 320/412dp, açık/koyu, 2x yazı ve RTL'de temel ekranlar taşmaz; marka her temada yeşil kalır.
- [accessibility] Etiketler, odak sırası, okunur kontrast ve Android 48dp hedefler doğrulanır.
- [integration] Kit katalog güncellemesi, puanlama politikası, satın alma ve PDF gerçek sınırda kanıtlanır; eksik mağaza/cihaz kanıtı tamamlandı sayılmaz.

## Open Decisions
- Model havuzu ANSWERED 2026-10-18: "Z kod, Beammax ... Bunları kullanacaksın ... OpenCode'un free modellerini kullanacaksın ... Argon dışındakileri kullanabilirsin Anti Gravity'de ... Cloud'un yüksek modelleri kullan ... sonnet'i kullanabilirsin ... doğruluğunu kanıtlayamasan bile kullanabiliyorsan kullanırsın ... Ücretli çağrı yok." Mevcut abonelik/ücretsiz rotaları bounded dene; Astra yasak; kota bilinmiyorsa tekrar onay isteme.

## Latest request 2026-10-24
- R71–R74 / PB-135..137: Y ekseni her ekran/yazı boyutunda okunur; uzun sayılar kısaltılmış eksen ve tam değerlerle gösterilir. Yeni ücretli satış yalnız yıllık Pro, USD1 vergi hariç temel fiyat, her ay 100 YZ hakkı. Önceki aylık-only talebi geçersizdir. 71 uygulama dili, 73 mağaza yereli, GitHub ve site aynı sözleşmeyi anlatır. Önce dahili test 1.3.0+18; üretime geçiş kullanıcı denemesinden sonradır.

## 2026-10-24 — Kapsamın tamamına devam

Kullanıcı: "ürün sıralama ve daha birçok ek özellik; yapılacakların hepsini bitirmeni istemiştim". Son fiyat/grafik sürümü bütün ürünün tamamlandığı anlamına gelmez. PB-138 ürün sıralama; PB-139 iOS native/CI; PB-140 bütün R01–R74 açıklarının somut kontrollerle kapanmasını takip eder. Üretim terfisi yine kullanıcı dahili test kabulünden sonradır.

## Latest user direction 2026-10-29
- User: "bu bütün diller için geçerli ve onların kendi rakamlarıyla"; native country/receipt number conventions must work throughout entry, calculation and display, using existing supported packages where safe. Latin-only restriction is a fallback to report explicitly, not an assumed audience limit (PB-204/206, ADR-010).
- User: "bütün işleri bitir ve yayınla artık"; finish actual Android/iOS correctness, use the public repository's GitHub macOS runners for iOS verification, make all site/store descriptions and real media current and publish. This explicitly continues existing publishing authority; app checks precede site work (PB-205, existing PB-163/176).
