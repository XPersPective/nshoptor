# EnShop / NShoptor — üretim kalitesi ana görev metni

Kaynak: kullanıcının bu sohbetteki bütün talepleri, 2026-10-23.
Yetki: mevcut projeyi incele, düzelt, test et, üretim kalitesine getir ve yayınla.
Bu belge tamamlanma kanıtı değildir. İş durumu `.project-brain/tasks/` ve güncel kanıtlarla tutulur.

## Sonraki geliştiriciye görev

Project Brain becerisini yükle ve `boot` çalıştır. Current/Target/Constraints ve aktif görevin Resume bölümünü oku. Gerçek kodu ve kayıtlı dış işlem durumunu doğrula. Bu kapsamdaki her maddeyi ilgili görevle ilişkilendir. Çalışan özellikleri koruyarak kök nedeni düzelt; sırf yeniden yazmak için mimari değiştirme. Ön yüz, veri tabanı, native köprü ve sunucu sözleşmelerini birlikte izle. Üretim, mağaza veya gerçek cihaz kanıtı bulunmayan maddeyi tamamlandı diye raporlama. Sırları okuma/yazdırma, ücretli servis açma, kullanıcı verilerini silme. Kaynakta var olmayı çalışma kanıtıyla karıştırma. Kullanıcı yeni izin istemeden bu kapsamda uygulama, test ve yayın hazırlığına yetki vermiştir; gerçek dış işlem sonuçları geri okunmalıdır.

## A. Liste, fiyat ve satın alınma (PB-120, PB-114)

- R01: Liste adının ilk harfini yazarken ve kaydederken Türkçe i/ı dahil büyüt; baştaki boşluk, imleç ve yapıştırma davranışını koru. `istanbul` → `İstanbul`, `pazar alışverişi` → `Pazar alışverişi`.
- R02: Ürüne dokununca her iki fiyat boşsa ev fiyatına, diğer üç durumda market fiyatına odaklan. Sayısal klavye açılsın, mevcut değer silinmesin, elle alan değişsin.
- R03: Market fiyatının varlığı satın alınmayı belirlesin: null=tiksiz; açıkça girilmiş 0 veya pozitif=tikli. Ev fiyatı bağımsızdır. Market fiyatı silinince tik kalksın; tüm listeler, sayaçlar, hesaplar ve yeniden açılış aynı kuralı kullansın.
- R04: Dairesel boş/dolu gösterge, net tik, tema uyumu, 48dp Android/44pt iOS dokunma alanı; 320dp, koyu/açık ve büyük yazıda ovalleşme/taşma olmasın.
- R05: Fiyat/miktar hesapları fixed-point olsun; Türkçe ondalık/para biçimleri, birimler, para birimi ayrımı ve kalıcı kayıt tutarlı olsun.

## B. Ses, ayrıştırma ve yapay zekâ (PB-122)

- R06: Konuşma devam ederken oturum korunmalı; kısa duraklama bitirmemeli; platform sonlandırırsa kontrollü devam ettirme metin kaybetmemeli. Manuel durdurma kesin çalışmalı.
- R07: İlk/ikinci açılış, iptal, izin reddi, arka plana geçiş, tanıyıcı hatası ve yeniden başlatma tek mikrofon sahibiyle çalışmalı.
- R08: Tek cümlede birden fazla ürünü ürün/miktar/birim/fiyat bağlamıyla ayrıştır: `İki kilo domates, üç paket makarna, bir litre süt`.
- R09: `İki paket sigaranın toplam fiyatı 260 TL` → toplam260/birim130; `iki paket sigara tanesi130 TL` → birim130/toplam260.
- R10: `iki paket sigara260 TL` belirsizliğinde rastgele fiyat türü seçme; kısa aday doğrulaması sun. Toplam/ikisi/hepsi ve tanesi/birim fiyatı/paketi bağlamlarını sınırlarıyla işle.
- R11: Söylenen market/çarşı fiyatını ev fiyatı gerektirmeden doğru ürüne/alanına yaz; fiyat olmayan rakamları fiyat sayma.
- R12: Konuşma, yerel parser, model ve aday kaydı sürelerini/call sayısını ölç. Gereksiz tekrar/model çağrısı ve sabit beklemeleri kaldır; anlaşılır durum göster.
- R13: YZ görevleri farklı dil, bozuk/eksik çıktı, çelişkili miktar, kötü niyetli içerik, ağ kesintisi, kota ve zaman aşımında güvenli sonuç versin; onaylanmayan aday veri değiştirmesin.

## C. Fiş/fatura ve raf etiketi (PB-121, PB-126)

- R14: Fiş/fatura OCR ürün, miktar, birim, indirim, satır toplamı ve genel toplamı doğru okusun; tarih/vergi/ödeme satırları ürün olmasın.
- R15: Fişten liste oluşturma ve var olan listeyle eşleştirme tutarlı olsun; yeni ürün ekleme, onay, iptal, tekrar işlem ve toplam uyuşmazlığı veri bozmasın.
- R16: Raf fiyat etiketi kamerası gerçek ürün fiyatını; çoklu fiyat, eski fiyat, sadakat fiyatı ve kg/litre fiyatından ayırsın; belirsizde seçim sunsun. Bu özellik, fiyatı sesle söylemekten ayrı test edilsin.
- R17: Eğik/uzun/bulanık/düşük ışıklı/Türkçe fiş ve etiket örnekleriyle ölç; yalnız metin fixture testi gerçek kamera başarısı sayılmasın.
- R18: Faturadan doğru alışveriş maliyeti ve kalıcı ürün satırları oluşsun; tamamlanma ayrı ve anlaşılır eylem olsun; yanlış biten liste geri açılabilsin.

## D. Dil, rehber, ayarlar ve kullanım (PB-130, PB-110, PB-118, PB-124)

- R19: YZ ayarlarını tehlikeli alan grubundan çıkar; kullanıcıyı ürküten başlıkları kaldır, uygulama genelinde nazik ve anlaşılır dil kullan. Silme gibi geri alınamaz işlemleri açıkça anlat.
- R20: İlk açılışta kısa, basit, çok dilli rehber göster; Ayarlar'dan tekrar erişilsin. Ses, fiş, fiyat/tik, rapor, bildirim, çevrimdışı ve plan sınırları anlaşılır olsun.
- R21: İkonlarda açıklayıcı uzun basma ipucu/semantik etiket; asıl eylemler kolay bulunur, az dokunmayla tamamlanır; parmak hareketleri keşfedilebilir ve yanlışlıkla silme geri alınabilir olsun.
- R22: Sade temel akış, isteyene profesyonel ayrıntılar; boş/yükleniyor/hata/başarı durumları, klavye, odak, geri dönme ve çift dokunma tutarlı olsun.
- R23: Premium görsel hiyerarşi, marka, okunaklı tipografi, 320/412dp ve geniş ekran, açık/koyu tema, RTL, %200 yazı ve erişilebilir kontrast doğrulansın.
- R24: Desteklenen bütün dillerde gerçek çeviri, nazik metin ve uzun metin uyumu kontrol edilsin; anahtar eşitliği tek başına çeviri doğruluğu sayılmasın.

## E. Geçmiş, rapor ve aktarım (PB-115, PB-116, PB-117, PB-124)

- R25: Alışverişlerim/geçmiş sayfası tek bakışta tarih, liste, toplam ve durum; dönem → alışveriş → satır ayrıntısı sağlasın.
- R26: Günlük, haftalık, aylık ve mevcut yıllık rapor/özet kolay erişilsin; dönem sınırları, saat dilimi, tamamlanan/geri açılan listeler ve farklı para birimleri doğru hesaplansın.
- R27: Harcama/limit/grafik tutarları dokunmadan anlaşılır olsun; gelişmiş kategori/ürün detayı isteğe bağlı olsun.
- R28: Alışveriş ve dönem PDF raporları oluşturma, kaydetme ve paylaşma; Türkçe/RTL/uzun satır/çok sayfa/para birimi doğru çalışsın.
- R29: JSON yedek içe/dışa aktarma, CSV ve desteklenen diğer biçimler doğru çalışsın; bozuk dosya, iptal, yinelenen içe aktarma ve geri yükleme kullanıcı verisini korusun. Desteklenmeyen PDF içe aktarımı vaat etme.

## F. Bildirim, bağlantı ve ücretsiz altyapı (PB-127)

- R30: Alışveriş listesine alarm/hatırlatma kurulabilsin; düzenleme/iptal, izin reddi, saat dilimi, uygulama arka planı ve yeniden başlatma senaryoları doğrulansın.
- R31: Gereken bildirim altyapısı ücretsiz olsun. Yerel liste hatırlatmaları sunucu gerektirmiyorsa mevcut yerel servis korunsun; uzaktan bildirim gerekirse Firebase FCM ücretsiz sınırları doğrulansın.
- R32: Sunucu Cloudflare Workers/D1 ücretsiz katmanda çalışacak biçimde bütçelensin; kota/boyut/sorgu sınırları ve ücretli sürprizleri engelleyen korumalar belgelenip doğrulansın. Gelecekteki sağlayıcı fiyatı için kalıcı ücretsiz garantisi verme.
- R33: İnternet yokken liste/fiyat/yerel OCR/rapor ve yerel hatırlatma çalışsın; YZ/katalog/mağaza gerektiren akışlar açıklayıcı, veri koruyan davranış versin. Bağlantı dönerken yinelenen yazım olmasın.
- R34: Ön yüz ve arka uç veri/hata sözleşmesi; giriş doğrulama, abonelik yetkisi, kota, eşzamanlılık, tekrar deneme ve sır gizliliği birlikte test edilsin.

## G. Abonelik, reklam, Keşfet ve paylaşım (PB-105, PB-107, PB-108, PB-123)

- R35: Free/Pro/Max satın alma, iptal, bekleyen ödeme, geri yükleme, süre bitimi, iade, çevrimdışı ve yükseltme hesabı doğru olsun; reklam kaldırma hakkı tutarlı yansısın.
- R36: Reklamlar doğru noktada/frekansla, onay/izin ve çocuk politikaları dahil platform kurallarına uygun çalışsın; başarısız/no-fill reklam alışverişi engellemesin, ödül bir kez verilsin.
- R37: Keşfet kataloğu otomatik güncellensin; Android Play Store, iOS App Store uygulamalarını ve doğru dilde bağlantıları göstersin; önbellek/çevrimdışı/boş/hata halleri olsun.
- R38: Beğen/değerlendir/yorum isteği nazik, uygun zamanda ve sıkıştırmadan sunulsun; platformun yerel değerlendirme kuralları ve tekrar politikası doğrulansın.
- R39: Uygulama/liste/rapor paylaşımı doğru içerik, bağlantı, dosya ve iptal davranışıyla çalışsın.

## H. Rakipler, SEO, site ve mağaza yayını (PB-128, PB-129)

- R40: Güncel rakipleri birincil mağaza/ürün kaynaklarından karşılaştır; eksik/fazla işlevleri, kullanım yükünü ve amaca katkıyı kanıtla. Her öneriyi otomatik eklemek yerine sade temel deneyim ilkesine göre önceliklendir.
- R41: GitHub üzerinde ücretsiz, premium tek sayfalık tanıtım sitesi var mı doğrula; yoksa repo ile sürdürülebilen GitHub Pages sitesi oluştur. Play/App Store için gerçek ürün bağlantıları, gizlilik, yardım ve dil seçimi olsun; doğrulanmamış iOS ürün bağlantısı uydurma.
- R42: Çok dilli başlık/açıklama, semantik HTML, canonical/hreflang, sitemap, robots, sosyal kart ve mobil erişilebilirlik dahil SEO/ASO incele. Uygulama içi metni arama anahtar kelimesiyle doldurma.
- R43: Android/iOS mağaza ekran görüntüleri, özellik görseli, video/önizleme ve çok dilli metinler mevcut sürümü dürüstçe göstersin; ölçüler, haklar ve güncel mağaza kuralları doğrulansın.
- R44: Android/iOS izinler, gizlilik beyanları, abonelik/reklam politikaları, platform görgüsü ve minimum hedefler güncel resmi kurallara göre denetlensin.
- R45: Test/derleme/mağaza hazırlığı tamamlandıktan sonra yetkili yayın akışını uygula; dahili test, TestFlight, incelemeye gönderim ve genel yayını ayrı gerçek durumlarıyla kaydet. iOS için gereken macOS/Xcode ve hesap eksikliği açık kalsın.

## I. Kalite, tamamlama ve devir (PB-125)

- R46: Uçtan uca evde hazırlık → markette yalnız market fiyatı → fiş → tamamlama → geçmiş → rapor → paylaşım → yeniden açma yolculuğunu gerçek kalıcı veriyle doğrula.
- R47: Birden fazla alışveriş senaryosu: büyük liste, sıfır fiyat, kısmi alışveriş, ondalık miktar, farklı para/dil, izin reddi, düşük bağlantı, uygulama kapanması ve hızlı tekrar dokunma.
- R48: Regresyon testleri, Flutter analiz/test, sunucu testi ve Android derlemesi; mevcut başarısızlıkları önce ayırt et. Gerçek cihaz/mikrofon/mağaza testleri simülasyondan ayrı raporlansın.
- R49: Diğer olası hataları kanıta dayalı bul ve düzelt; erişilebilirlik, performans ve kullanıcı verisini koruma öncelikli olsun. Kök neden, değişen dosyalar, test sonuçları ve açık riskleri raporla.
- R50: Her aşamada sonraki YZ için hedef, görev, bağımlılık, karar, komut, kanıt, dış işlem readback ve Resume/Next/Failing/Dirty güncel kalsın. Doğrulanmamış maddeyi kapatma.

## Aşamalar ve kabul kapıları

1. Devralma: boot, dirty sınıflandırma, mevcut regresyon özeti, kaynak haritası ve bu kapsamın görevlerle eşleştirilmesi.
2. Temel yolculuk: PB-120/114/121/122; veri kalıcılığı ve fiyat/ses/fiş kök nedenleri, bir gerçek alışveriş örneği.
3. Kullanım ve rapor: PB-110/118/124/115/116/117; nazik YZ ayarı, çok dilli rehber, geçmiş ve dışa aktarım.
4. Servisler: PB-105/107/108/123/126/127; OCR, hatırlatma, bağlantı kesilmesi, sunucu, mağaza ve reklam sözleşmeleri.
5. Tanıtım ve platform: PB-128/129; rakipler, site, SEO/ASO, materyaller ve güncel Android/iOS koşulları.
6. Üretim kapısı: PB-125; güncel test/derleme, görüntülü/etkileşim/erişilebilirlik kanıtı, bağımsız inceleme ve gerçek yayın readback.

## İlk devralma gerçekleri (tamamlanma değildir)

- Boot: 2026-10-23, önceki plan 25 açık görev; `.store-automation/` yok; `legacy` önizlemesi yabancı plan bulmadı.
- Önceden değişmiş: pubspec.yaml sürüm +14 → +15 (kullanıcı/bilinmeyen); `--help/` ve altı `build-sa*` klasörü korunacak. Ürün kaynakları başlangıçta temiz.
- Rehber, yerel bildirim ve Cloudflare D1 kodu mevcut; gerçek davranışın yeniden doğrulanması gerekiyor.
- Önceki `target.md` yayınlamayı kapsam dışı tutuyordu; bu sohbetin açık yayın talebiyle güncellenecek. Project Brain yayın durumunu izler; mağaza işlemi ilgili yayın araçlarıyla yürütülür.

## Kullanıcının 2026-10-23 son düzeltmesi — R51–R60

Bu bölüm önceki varsayımları değiştirir. Yeni teklifler aylık aboneliktir. Kullanıcı toplam tutar düşünür: manuel ev/market fiyatı varsayılanı seçilen miktarın toplamıdır; birim fiyatına her alan için bağımsız, görünür ve kayıpsız geçilir. Açık birim/etiket bağlamı dışındaki doğal sesli tutar toplam sayılır. Gerçek çelişki, para/birim veya ambalaj belirsizliği kısa doğrulama gerektirir.

- R51/PB-132: uygulama/GitHub/site/mağaza kaynakları ve71dilde aylık abonelik metni doğrulanmış mağaza sözleşmesine uygun; yeni P1Y teklifi sunma. Eski yıllık satın alma/restore haklarını bozma, uzak ürünleri izinsiz silme. Fiyat mağazadan gelir; tahmini tutar/deneme vaadi yazma.
- R52/PB-133: liste girişinde oluşturulma tarihi mevcut otomatik damga; ayrı alışveriş tarihi+saat isteğe bağlı, düzenlenebilir/silinebilir; hatırlatma tarihiyle karıştırılmaz.
- R53/PB-133: varsayılan alışveriş tarihine göre artan sıralama; tarihsizler ayrı sonda, geçmiş tarihler görünür. A–Z ve mevcut elle sıralama açık seçim; TürkçeI/İ ve kalıcılık doğrulanır.
- R54/PB-131: 400g kıyma350TL toplam→350TL;2paket260TL toplam→260TL/130TLpaket; miktar fiyatı tekrar çarpmamalı.
- R55/PB-131: ev ve market için bağımsız toplam/birim giriş anahtarı, uygun etiket ve hesaplanan karşı taraf; geçiş tutarı değiştirmez. Miktar değişince hangi tarafın sabit kalacağı seçilen moda bağlıdır; yeniden açılınca anlam korunur.
- R56/PB-131: 2kg elma ev100toplam→50/kg;45TL/kg etiket→90market toplam.400g kıyma350TLpaket→350;800g seçiliyse iki400g paket→700. Uyumsuz/bilinmeyen ambalajı tahmin etme.
- R57/PB-131: fişte2×130→260 ve ağırlıklı miktar×kg fiyatı doğru; brüt/net/indirim toplamı yalnız bir kez uygulanır. Orijinal miktar/birim/baz fiyat bilgisi kaybolmaz.
- R58/PB-131: ses/metin doğal toplam varsayılanı; tanesi/kilosu/toplam açık ifadeler korunur. Eski istemciler yeni anlam sözleşmesiyle yanlış fiyat yazmaz.
- R59/PB-131: tahmin ve gerçek fiyat karşılaştırmaları/grafikleri uyumlu ortak birim üzerinden; miktar değişmesi fiyat artışı sanılmaz, farklı para/uyumsuz paket karıştırılmaz.
- R60/PB-131..133: mevcut verileri körlemesine yeniden yorumlama; gerekirse sürümlü migration, yedek/geri-yükleme ve eski kayıt testi. Yeni davranıştan önce üretilen APK/görsel/video son sürüm kanıtı sayılmaz; tekrar üret ve doğrula.

Sonraki aşama: PB-131 hesap sözleşmesi +regresyonlar → PB-132 aylık metin/teklif uyumu → PB-133 tarih/sıralama → birleşik test/analyze/migration → yeni görsel/native/build → mağaza readback. Önceki25açık görev ve fiziksel OCR/iOS/gerçek ödeme açıkları korunur.

## R61 — Tek dokunuşlu fiyat anlamı seçimi

Kullanıcının UX devam talebi: varsayılan toplam fiyat kalsın; ayrıca Ayarlar'da birim/toplam varsayılanı ekleyerek günlük akışı karmaşıklaştırma. Açılır fiyat menüsü yerine iki görünür seçenekten birine tek dokunmayla geçilsin; seçili anlam anlaşılır olsun. Ürün formu ve sesli önizlemeler aynı kontrolü kullansın. Ekonomik tutar, ev/market bağımsızlığı ve klavye odağı korunsun. Yeni kontrol320px/2x TR/DE/AR ve ekran okuyucuda denensin. Bu ilke diğer akışların da minimum gereksiz dokunma açısından incelenmesini gerektirir; küçük kontrol değişikliği tüm uygulama UX kabulü diye raporlanmaz. PB-131/C-018 altında takip edilir.

## R62–R68 — Son kullanıcı kararları (önceki yayın varsayımlarının yerine geçer)

- R62: Slogan Türkçe “Evdeki hesap çarşıya uyar.”; diğer dillerde doğal ve aynı anlamda, uygulama/site/GitHub/mağaza arasında tutarlı olmalı.
- R63: Ülke/dil bazında dürüst ve kaliteli ASO, güncel rakip incelemesi ve gerçek sürümden premium materyaller. Arama sırası garantisi veya doğrulanmamış işlev iddiası yok.
- R64: Açık kaynak depoya anahtar/özel kimlik gitmemeli; açıklamalarda samimi ve doğru biçimde anlatılmalı. Ignore dosyası tek başına geçmişin temizliği kanıtı değildir.
- R65: Kullanıcı yapay zekâsız/lifetime yeni paket fikrini aynı mesajında iptal etti. Bu fikir uygulanmayacak; eski satın alanların mevcut hakları korunacak.
- R66: Silip yeniden kurarak yedi günlük deneme yeniden kazanılamamalı. Yerel reklamsız başlangıç sayacı ile mağazanın abonelik denemesi ayrıdır; ikisi ayrı doğrulanmalı.
- R67: Önce mevcut doğrulanmış Android düzeltmeleri Google Play **dahili test** kanalına gönderilecek. Kullanıcı deneyecek; genel Google Play ve App Store yayını kullanıcının sorunsuz test kabulünden sonra yapılacak. iOS eksikleri gizlenmeyecek.
- R68: Kullanıcının açık seçimi `release-harbor` becerisidir (`C:/Users/rubicon/.skills-manager/skills/release-harbor/SKILL.md`). Kaldırılmış Store Automation'ın önbelleği kullanılmayacak, buna geçiş yapılmayacak. Mevcut dış yayın kökü README ve Fastlane kayıtları korunacak.

Oturumun bütün maddeleri ve durum ayrımı: `docs/audits/session-status-2026-10-23-tr.md`. Kodda bulunma, yerel test, native cihaz gözlemi, yükleme ve genel yayın ayrı durumlardır.

## R69–R70 — 24 Ekim 2026 liste kullanımı (PB-134)

- R69: Tikli, yani market fiyatı girilmiş ürünler listenin altında; alınmayanlar üstte gösterilsin. Sıfır fiyat satın alınmış sayılır; market fiyatı silinince ürün yeniden alınmayanlara döner. Her grupta mevcut sıra korunur, salt görünüm için kalıcı sıra yeniden yazılmaz. Elle sıralama gruplar arasında tik kuralını bozamaz.
- R70: Liste içindeki planlı ve sonradan alınan ürünlerde anlık çevrimdışı arama olsun. Türkçe I/ı ve İ/i doğru eşleşsin; temizleme ve sonuç bulunamadığında geri dönüş anlaşılır olsun. Arama hesap/rapor/tamamlama toplamlarını veya gizlenen kayıtları değiştirmez. Salt okunur eski listeler de aranabilir. Yeni sürüm doğrulandıktan sonra dahili teste gönderilsin; genel üretim kabulü ve diğer açık talepler korunur.

## 2026-10-24 — Son fiyatlandırma ve grafik talebi (önceki aylık talebini değiştirir)

- R71: Grafik Y ekseni tutarları dar ekran, 2x metin, açık/koyu ve RTL için okunur; tam tutar dokunmadan erişilir (PB-136).
- R72: Yeni satışta tek Pro: vergi hariç yıllık 1 ABD doları temel fiyat; mevcut Pro özellikleri ve her takvim ayında 100 YZ isteği. Ücretsiz 10/ay korunur (PB-135).
- R73: Aylık, Max ve lifetime yeni satıştan kaldırılır; mevcut satınalmaların hakları/restore ve mevcut yenileme sözleşmeleri iptal edilmez. Nihai yerel mağaza fiyatı kullanılır, vergi tekrar eklenmez (PB-135).
- R74: Uygulamanın 71 dili, mağazanın 73 yereli, GitHub ve site güncellenir; doğrulanmış sonuçlarla dahili test sürümü gönderilir. Üretime geçiş kullanıcı testinden sonra (PB-137).
