# Ürün araması ve tikli ürün sırası — 24 Ekim 2026

## Kullanıcı talebi ve değişiklik

“urunlerin tiklileri asagiya kaymali. urunlerde arama yapilabilmeli” — PB-134 / R69–R70.

- `item_list_view.dart`: market fiyatı varlığına göre kararlı, görünüm düzeyinde sıralama. Sıfır fiyat tiklidir; tahmin veya eski status değeri satın alınmayı belirlemez. Fiyat silinince orijinal kayıt sırasındaki alınmayanlara döner. Görüntülemek için veritabanı sırası değiştirilmez.
- `list_detail_screen.dart`: görünür arama, Türkçe/Azerice I/ı/İ/i eşleştirme, boşluk normalleştirme; planlı/plansız ürün adları aranır. Alanın arama ve temizleme etiketleri mevcut Material yerelleştirmelerinden gelir. Başlangıçta klavye kendiliğinden açılmaz.
- Sonuç yoksa görünür mesaj ve temizleme eylemi vardır. Liste toplamları ve bitirme işlemi tüm kayıtları kullanır; filtrelenen satırlar kaybolmaz. Tamamlanan/salt okunur liste aranabilir.
- Sürükleme her satın alınma grubu içinde çalışır; gruplar arası hareket reddedilir. Arama aktifken sürükleme kapalıdır; filtreli alt küme kalıcı sıraya yazılmaz. Mevcut repository tüm ürün kimliklerini doğrular ve transaction kullanır. Şema/arka uç değişmedi.
- Sürüm: `1.2.9+17`; eski dahili test16 üzerine güncelleme hazırlanır. Kaynak sürüm etiketi ve pubspec birlikte güncellendi.

## Gerçek kontroller

- İlk539testlik koşum başarılı/2opt-in atlandı (`.checked-search-baseline.log`); geliştirme sırasında eski testler korunmuştur. Nihai kaynak için ayrı tam koşum gerekir.
- `flutter test --no-pub --dart-define=CAPTURE_SEARCH=true test/features/lists/item_list_view_test.dart test/features/lists/item_search_test.dart test/features/lists/unified_list_test.dart`: **16geçti**, `.pb134-focused4.log`.
- `flutter analyze --no-pub`: son koşum **sorun yok**, `.pb134-release-analyze2.log` (86.3s). Aradaki koşumdaki yalnız test dosyasına ait gereksiz import uyarısı giderildi; uygulama davranışı değişmedi.
- Nihai tam `flutter test --no-pub`: **548geçti, 2opt-in atlandı**, 3m39s (`.pb134-full.log`).
- Gereksiz test importu temizlendikten sonra iki yeni test dosyası yeniden çalıştırıldı: **9geçti**, `.pb134-release-tests.log`, 17s. Uygulama kaynaklarında bu temizlikle değişiklik yok.
- Fiyat0→tikli ürün altta; fiyatı kaldır→ürün üstte; yeniden açınca aynı satın alınma grubu; Türkçe sorgu, plansız eşleşme, sonuç yok/temizleme, değişmeyen toplam, salt okunur liste; geçerli sıralamanın bütün kimliklerle DB'ye yazılması ve gruplar arası hareketin reddi test edildi.
- Gerçek AppTheme ve yüklenmiş yazı tipleriyle6görüntü: `artifacts/qa/PB-134/` altında TR412açık/koyu ve AR320/2x, boş ve dolu. Root TRaçık dolu, ARkoyu büyük yazı dolu ve TRkoyu boş görüntülerini inceledi. Geniş yazıda içerik kaydırılabilir; sabit arama/ekleme eylemleri görünür.
- Bağımsız `review_search` ajanı kaynak, test, başarılı log ve dört görüntüyü inceledi: **PASS**, açık bulgu yok. İlk derleme/test kapsamı eksikleri giderildi. Sınırlar: gerçek parmak sürüklemesi yerine UIcallback→Drift readback kullanıldı; açık yazılım klavyesi ekran görüntüsü ve bu değişikliğin native cihaz testi yapılmadı. Bu bağımsız inceleme resmî PBReview kaydı değildir.

## Project Brain ve kalan işler

PBboot/scan/new/score/select kullanıldı, PB-134 açıldı; kullanıcı kapsamı hedefe ve şartnameye işlendi. Ancak `PB start --agent gpt-6` eski havuz onayı değiştiği için reddedildi; `PB check` görevi başlatılmamış bulduğu için çalışmadı. Resmî Evidence/Review/accept kayıtları uydurulmadı. Görevin Resume alanı bu engeli ve gerçek testleri taşır; resmî kabul için gerçek havuz onayının düzeltilmesi gerekir.

Önceki oturumun bütün talepleri tamamlanmış değildir. `session-status-2026-10-23-tr.md` içindeki gerçek OCR/uzun ses/ödeme/reklam/deneme koruması/bildirim/çok dil/mağaza materyalleri/iOS ve canlı sunucu kabul açıkları korunur. Bu iki özellik bunları kapatmaz. Yayın yalnız release-harbor ile Android dahili testtir; üretime terfi yetkisi kullanıcı testinden sonradır.

## Yayın sonucu

`fastlane android build_release` başarılı:1138s, `.internal17-build.log`. AAB `build/app/outputs/bundle/release/app-release.aab`:94.986.324byte; sürüm1.2.9/17, paketcom.crazypenguin.nshoptor, targetSDK36. SHA256 `120abfb26ecb6827f65cbd33f0369768e224e0a2935f95f06a6c9834c7029659`. JAR imzası doğrulandı; dış yayın kökündeki uygulamaya özgü upload sertifikasıyla aynı. 12adet64-bit ELF LOAD>=16KB;6adet32-bit kütüphane ayrıca mevcut. Kaynak uygulama checkpoint48d6e6c; sonraki değişiklikler testin gereksiz importu ve belgelerdir.

Yüklemeden hemen önce resmi API'de17veya daha yeni bundle yoktu. release-harbor/mevcut Fastlane `deploy_internal` başarılı (160s, `.internal17-upload.log`, 24Ekim2026 07:26Türkiye saati).

Yükleme sonrası bağımsız resmi API okuması: `internal` → `name=1.2.9`, `versionCodes=[17]`, `status=completed`. Uzak bundle SHA256 yerelle eşit: `120abfb26ecb6827f65cbd33f0369768e224e0a2935f95f06a6c9834c7029659`. Üretim önce/sonra aynı:14/1.2.7draft ve1/1.0.0completed. Mağaza metin/görselleri değiştirilmedi; üretime terfi yok.

Özel makbuz seçili Git dışı yayın kökünde `apps/nshoptor/original-notes/internal-17-2026-10-24.json`, durumconfirmed. Yeniden yükleme yapmadan uzak sürümü oku;17artık kullanıldı. Katılım: https://play.google.com/apps/testing/com.crazypenguin.nshoptor . APIcompleted her test cihazına güncellemenin anında ulaştığını kanıtlamaz; test hesabıyla1.2.9sürümünü kontrol et.
