# Oturum talepleri ve doğrulanmış durum — 23 Ekim 2026

Bu kayıt bütün işlerin tamamlandığı anlamına gelmez. **Düzeltildi/testli** yerel otomatik kontrolü; **kısmi** uygulama veya bazı kontroller mevcutken kabulün açık olduğunu; **açık** tamamlanmadığını belirtir. Önceki ayrıntılı kapsam: `docs/spec/production-master-prompt-tr.md` (R01–R61).

## Bütün talepler

| No | Talep | Mevcut durum / açık kontrol |
|---|---|---|
| R01 | Türkçe ilk harf büyütme | Düzeltildi/testli; İstanbul native örneği de gözlendi. |
| R02 | Dört duruma göre fiyat odağı ve sayısal klavye | Düzeltildi/testli; önceki native sürümde market odağı gözlendi. |
| R03 | Yalnız market fiyatıyla tik; silince kalkması; sıfır/null ayrımı | Düzeltildi/testli; önceki native sürümde market fiyatıyla tik doğrulandı. |
| R04 | Dairesel, net ve erişilebilir tik | Uygulandı; belirli ekran/tema örnekleri incelendi, tam native erişilebilirlik matrisi açık. |
| R05 | Ondalık, miktar, para birimi ve kalıcı hesap doğruluğu | Temel hesap düzeltildi/testli; bütün gerçek fiş biçimleri kabulü açık. |
| R06 | Uzun konuşma, kısa duraklama, kayıpsız oturum devamı | Android devam mantığı düzeltildi/testli; fiziksel uzun konuşma açık. |
| R07 | Tek mikrofon, iptal/izin/arka plan/hata | Yaşam döngüsü testleri mevcut; gerçek cihaz matrisi açık. |
| R08 | Çoklu ürün, Türkçe miktar ve birim | Parser düzeltildi/testli; bütün diller için gerçek konuşma kabulü açık. |
| R09 | Açık toplam/birim fiyat ifadeleri | Düzeltildi/testli. |
| R10 | Belirsizlikte kısa doğrulama | Çelişkilerde seçim mevcut. Son talebin doğrultusunda doğal manuel/sesli fiyat varsayılanı toplamdır. |
| R11 | Sesle market fiyatını doğru ürüne yazma | Kaynak/test düzeltmeleri var; fiziksel ses kabulü açık. |
| R12 | Hızlı ayrıştırma, durum ve gereksiz model çağrılarını azaltma | Yerel hızlı yol ve süre ölçümleri mevcut; gerçek uçtan uca gecikme kabulü açık. |
| R13 | YZ hatalı/eksik/çelişkili çıktı ve ağ/kota güvenliği | Otomatik sözleşme testleri var; tüm modeller/senaryolar hatasız diye doğrulanmadı. |
| R14 | Fiş/fatura ürün/miktar/indirim/toplam ayrıştırma | KARTON/FISTIK/vergi/ödeme ve para birimi hataları düzeltildi; gerçek görüntü korpusu açık. |
| R15 | Fişten liste oluşturma/eşleştirme/tekrar/iptal | Uygulama ve testler mevcut; kamera→kalıcı liste uçtan uca kabulü açık. |
| R16 | Raf etiketi fiyatı, kg/paket, indirim/sadakat ayrımı | Fiyat bazları düzeltildi; çoklu gerçek etiket kabulü açık. |
| R17 | Eğik/bulanık/uzun/düşük ışıklı gerçek OCR | Açık; metin testleri kamera başarısı olarak sunulmuyor. |
| R18 | Faturadan maliyet, tamamlama ve yeniden açma | Kod/testler mevcut; gerçek fatura yolculuğu açık. |
| R19 | YZ ayarlarını tehlikeli alandan çıkarma, nazik dil | Düzeltildi; tüm dil metinlerinin uzman incelemesi açık. |
| R20 | İlk açılış ve ayarlardan çok dilli basit rehber | Eklendi, 71 dil kaynakları ve belirli dil/ekran testleri mevcut. |
| R21 | İpuçları, semantik, pratik hareketler ve silmeyi geri alma | Kısmi; tüm uygulama parmak/ekran okuyucu kabulü açık. |
| R22 | Basit temel akış, isteğe bağlı detay, hata/boş/klavye durumları | Birçok akış iyileştirildi; bütün ekranların kabulü açık. |
| R23 | Premium tasarım, küçük/geniş ekran, tema/RTL/büyük yazı | Seçilmiş render ve etkileşim testleri var; tüm matris açık. |
| R24 | Bütün dillerde doğru, nazik ve taşmayan çeviri | 71 dil var; anahtar uyumu dil kalitesinin eksiksiz onayı değildir. |
| R25 | Geçmişin tek bakışta okunması ve ayrıntılar | Düzen/test iyileştirmeleri var; kapsamlı native kullanım kabulü açık. |
| R26 | Günlük/haftalık/aylık/yıllık rapor | Günlük görünüm ve dönem hesap/PDF testleri var; gerçek cihaz dönem matrisi açık. |
| R27 | Anlaşılır grafik, kategori/ürün detayları | Birim bazlı tahmin/gerçek serileri düzeltildi; tüm kullanıcı yolculuğu açık. |
| R28 | PDF oluşturma/kaydetme/paylaşma, RTL/çok sayfa | Otomatik testler var; gerçek dosya paylaşım/çıktı kabulü açık. |
| R29 | JSON/CSV yedek/aktar/geri yükle | Desteklenen kod/testler mevcut; tüm gerçek dosya/hata/tekrar kabulü açık. |
| R30 | Liste alarmı/bildirim, düzenleme/iptal/izin/yeniden başlama | Yerel bildirim ve hata/tıklama testleri var; gerçek cihaz teslimatı açık. |
| R31 | Ücretsiz bildirim altyapısı | Liste hatırlatması yerel, sunucu gerektirmiyor; yeni ücretli Firebase servisi açılmadı. |
| R32 | Cloudflare Workers/D1 ücretsiz sınırları | Yapı mevcut; hesap planı/üretim tüketimi ve sürekli ücretsiz olma doğrulanmadı. |
| R33 | Çevrimdışı ve bağlantının dönmesi | Yerel çalışma ve hata yolları mevcut; kapsamlı uçak modu/native kabulü açık. |
| R34 | Ön yüz/arka uç yetki/kota/veri sözleşmesi | Sunucu regresyonları var; yeni fiyat sözleşmesinin canlı dağıtımı açık. |
| R35 | Aylık satın alma/iptal/restore/iade/çevrimdışı | Android korumaları var; gerçek Play lisans testleri açık. iOS StoreKit eksik. |
| R36 | Rahatsız etmeyen banner/geçiş/ödül ve izinler | Politika/testler mevcut; canlı reklam, onay ve cihaz kabulü açık. |
| R37 | Keşfet otomatik katalog, platforma doğru mağaza | 24 saat önbellekli katalog/filtre mevcut; mağazaları taramıyor, iOS kayıtları eksik. |
| R38 | Nazik beğen/yorum teşviki | Yerel değerlendirme ve tekrar sınırları düzeltildi/testli; gerçek mağaza istemi açık. |
| R39 | Uygulama/liste/rapor paylaşımı | iPad konum/iptal/hata korumaları düzeltildi; bütün cihaz kabulü açık. |
| R40 | Rakip/eksik/fazla özellik incelemesi | Bring/AnyList/Listonic temel karşılaştırması yapıldı; ülke bazlı sıralama/arama hacmi araştırması tamamlanmadı. |
| R41 | Ücretsiz premium tek sayfa GitHub sitesi | TR/EN GitHub Pages yayımlandı/HTTP doğrulandı; gerçek iOS mağaza bağlantısı henüz yok. |
| R42 | Çok dilli SEO/ASO ve teknik SEO | Site kontrolleri ve mağaza kaynakları var; tüm ülke/dillerde nihai inceleme/yükleme açık. |
| R43 | Gerçek sürümden rafine ekranlar/banner/video | TR güncel fiyat ekranları var; EN/tüm diller güncellemesi ve nihai video/mağaza yüklemesi açık. |
| R44 | Android/iOS izin/gizlilik/reklam/mağaza şartları | Kısmi kaynak/politika incelemesi; nihai Console/App Privacy ve iOS kabulü açık. |
| R45 | Testten sonra mağazaya gönderim | Android1.2.8(16) dahili teste yüklendi; resmi API completed ve aynı SHA256 doğrulandı. Üretim ancak kullanıcı testinden sonra. iOS henüz gönderilebilir değil. |
| R46 | Ev→market→fiş→geçmiş→rapor→paylaş uçtan uca | Bazı kalıcı native fiyat yolları doğrulandı; bütün zincir açık. |
| R47 | Büyük liste, sıfır, kısmi, dil/para, izin/ağ/kapanma | Otomatik örnekler mevcut; tüm native senaryo matrisi açık. |
| R48 | Test/analyze/sunucu/Android build | Bu gönderimde yeniden: 539 Flutter testi geçti, 2 opt-in atlandı; 37 sunucu testi geçti; analiz temiz; imzalı release AAB başarılı. |
| R49 | Diğer hataları bulma ve kök neden düzeltme | Birçok ek hata düzeltildi; bütün olası hataların bulunması doğrulanabilir bir tamamlanma iddiası değildir. |
| R50 | Sonraki YZ için kapsam/karar/kanıt/devir | Ayrıntılı şartname, audit ve bu durum kaydı mevcut; açık işler korunuyor. |
| R51 | Uygulama/GitHub/site/diğer dillerde aylık abonelik | Kaynaklar güncellendi; canlı site doğrulandı, Play açıklaması yüklenmedi. Eski yıllık restore hakları korundu. |
| R52 | İsteğe bağlı alışveriş tarihi+saat | Eklendi/testli. |
| R53 | Varsayılan alışveriş tarihi sırası ve A–Z | Eklendi/testli; Türkçe harf ve tercih kalıcılığı dahil. |
| R54 | 400g/350 ve 2 paket/260 toplam hesabı | Düzeltildi/testli; 400g native önceki sürümde doğrulandı. |
| R55 | Bağımsız ev/market toplam/birim dönüşümü | Düzeltildi/testli; ekonomik tutar korunur. |
| R56 | 45/kg ve 400g paket fiyatını seçili miktara uyarlama | Baz birimi dönüşümleri düzeltildi/testli; gerçek etiket kabulü açık. |
| R57 | Fişte 2×130, tartılı ürün ve indirimi bir kez hesaplama | Sözleşme/testler mevcut; gerçek fiş kabulü açık. |
| R58 | Ses/metin toplam varsayılanı, açık birimi koruma | İstemci/sunucu kaynakları testli; yeni sunucu sözleşmesi canlı dağıtılmadı. |
| R59 | Tahmin/gerçek grafiğini ortak birimde karşılaştırma | Düzeltildi/testli; para/uyumsuz paketler karıştırılmaz. |
| R60 | Eski veriyi koruma, migration ve güncel materyal | Şema3/legacy testleri var; yeni buildin bütün materyalleri henüz tamamlanmadı. |
| R61 | Açılır menü yerine tek dokunuşlu belirgin fiyat seçimi | Dört akışta uygulandı/testli; varsayılan toplam, yeni ayar eklenmedi. |
| R62 | “Evdeki hesap çarşıya uyar.” sloganı bütün dillerde | Türkçe mevcut; İngilizce kanallarda farklılık var, tüm dil tutarlılığı açık. |
| R63 | Her ülkede kaliteli ASO, üst sıralara çıkma | Nihai ülke araştırması/metin incelemesi açık; sıralama garantisi verilemez. |
| R64 | Açık kaynakta sır olmaması ve dürüst açıklama | Anahtarlar dış yayın kökünde; ignore korumaları mevcut. Tüm Git geçmişi için tamamlanmış sır taraması iddiası yok. |
| R65 | Yapay zekâsız ömür boyu paket | Kullanıcı aynı mesajda iptal etti; yeni paket eklenmeyecek. |
| R66 | Silip yükleyerek 7 günlük denemeyi yenileyememe | Açık: yerel reklamsız ilk kullanım sayacı yeniden kurulumda sıfırlanabilir; mağaza abonelik denemesi ayrı doğrulanmalı. |
| R67 | Önce dahili test, kullanıcı kabulünden sonra iki mağaza yayını | Geçerli yayın sırası budur; üretime otomatik terfi yapılmayacak. |
| R68 | Yayın için release-harbor kullanılması | Okundu/uygulanıyor; Store Automation kaldırıldığı için kullanılmıyor, plan taşınmıyor. |

## Sonuç

Ürün **tamamlanmış/hatasız/iki mağazada üretime hazır** olarak kabul edilmedi. Android dahili test, mevcut düzeltmeleri kullanıcının deneyebilmesi içindir. iOS için StoreKit, native köprüler, mağaza kimliği ve macOS/Xcode derleme/cihaz kanıtları halen gereklidir. Dahili test yükleme sonucu ve güncel test sayıları ayrı yayın kanıtında kaydedilecektir.

## Güncel aday kontrolleri

- Uygulama kaynak checkpoint: `739b2fb`; bu rapor/araçlar: `eff35b4` ve devamı. Bu gönderimde `lib/`, `test/`, `server/`, `android/` ve pubspec için bekleyen kaynak değişikliği yok.
- Flutter: **539 geçti, 2 opt-in atlandı**, `.internal16-tests.log`. Analiz: **sorun yok**, `.internal16-analyze.log`. Sunucu: **37 geçti**, `.internal16-server.log`.
- `fastlane android build_release`: başarılı, 360 saniye; `.internal16-build.log`. `1.2.8+16`, paket `com.crazypenguin.nshoptor`, target SDK36.
- AAB: `build/app/outputs/bundle/release/app-release.aab`, 94.941.400 byte, SHA256 `40604ab2e1822c8046eef6389b004a55752a63d81b9f3c0b486432dda308bfe3`.
- JAR imzası doğrulandı; imzalayan sertifika dış yayın kökündeki uygulamaya özgü upload anahtarıyla eşleşti. 12 adet 64-bit native kütüphanenin LOAD hizalaması en az16KB. Ayrıca 6 adet32-bit kütüphane mevcut;64-bit cihaz şartı bunlara uygulanmış gibi raporlanmadı. Dayanak: https://developer.android.com/guide/practices/page-sizes
- Bunlar APK'nın bütün gerçek cihaz senaryolarını veya Google/App Store onayını kanıtlamaz. Canlı sunucunun yeni fiyat sözleşmesi dağıtımı ve listedeki açık işler halen açık.

## Gerçek mağaza sonucu

- `fastlane android deploy_internal`: exit0, supply111s, 23 Ekim2026 yaklaşık21:51 Türkiye saati.
- Sonraki bağımsız resmi API okuması: `internal` → `name=1.2.8`, `versionCodes=[16]`, `status=completed`.
- API'nin16numaralı bundle SHA256 değeri yerel AAB ile aynı: `40604ab2e1822c8046eef6389b004a55752a63d81b9f3c0b486432dda308bfe3`.
- `production` aynı kaldı:14/1.2.7draft ve1/1.0.0completed. Üretime terfi yapılmadı; mağaza metin/görselleri bu yüklemede değiştirilmedi.
- Katılım bağlantısı: https://play.google.com/apps/testing/com.crazypenguin.nshoptor . Mevcut test hesabının yetkisi ve mağaza yayılımı cihazda ayrıca görülmelidir; APIcompleted her cihazın güncellemeyi aldığı anlamına gelmez.
- Özel yayın makbuzu Git dışındaki seçili yayın kökünde `apps/nshoptor/original-notes/internal-16-2026-10-23.json`; durumconfirmed. Anahtar içerikleri kaydedilmedi.
- Sonraki geliştirici yeni yükleme öncesi uzak sürümü tekrar okumalı;16artık kullanıldı. Sıradaki iş kullanıcı dahili test geri bildirimi ve yukarıdaki açık kabul maddeleridir. Aynı16paketini körlemesine yeniden yükleme.
