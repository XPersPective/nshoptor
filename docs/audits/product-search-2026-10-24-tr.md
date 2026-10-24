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
- `flutter analyze --no-pub`: **sorun yok**, `.pb134-final-analyze.log`.
- Fiyat0→tikli ürün altta; fiyatı kaldır→ürün üstte; yeniden açınca aynı satın alınma grubu; Türkçe sorgu, plansız eşleşme, sonuç yok/temizleme, değişmeyen toplam, salt okunur liste; geçerli sıralamanın bütün kimliklerle DB'ye yazılması ve gruplar arası hareketin reddi test edildi.
- Gerçek AppTheme ve yüklenmiş yazı tipleriyle6görüntü: `artifacts/qa/PB-134/` altında TR412açık/koyu ve AR320/2x, boş ve dolu. Root TRaçık dolu, ARkoyu büyük yazı dolu ve TRkoyu boş görüntülerini inceledi. Geniş yazıda içerik kaydırılabilir; sabit arama/ekleme eylemleri görünür.
- Bağımsız `review_search` ajanı kaynak, test, başarılı log ve dört görüntüyü inceledi: **PASS**, açık bulgu yok. İlk derleme/test kapsamı eksikleri giderildi. Sınırlar: gerçek parmak sürüklemesi yerine UIcallback→Drift readback kullanıldı; açık yazılım klavyesi ekran görüntüsü ve bu değişikliğin native cihaz testi yapılmadı. Bu bağımsız inceleme resmî PBReview kaydı değildir.

## Project Brain ve kalan işler

PBboot/scan/new/score/select kullanıldı, PB-134 açıldı; kullanıcı kapsamı hedefe ve şartnameye işlendi. Ancak `PB start --agent gpt-6` eski havuz onayı değiştiği için reddedildi; `PB check` görevi başlatılmamış bulduğu için çalışmadı. Resmî Evidence/Review/accept kayıtları uydurulmadı. Görevin Resume alanı bu engeli ve gerçek testleri taşır; resmî kabul için gerçek havuz onayının düzeltilmesi gerekir.

Önceki oturumun bütün talepleri tamamlanmış değildir. `session-status-2026-10-23-tr.md` içindeki gerçek OCR/uzun ses/ödeme/reklam/deneme koruması/bildirim/çok dil/mağaza materyalleri/iOS ve canlı sunucu kabul açıkları korunur. Bu iki özellik bunları kapatmaz. Yayın yalnız release-harbor ile Android dahili testtir; üretime terfi yetkisi kullanıcı testinden sonradır.

## Yayın sonucu

İmzalı aday derlemesi ve nihai tam test sürüyor. Yükleme/uzak sürüm/özet geri okuması olmadan burada gönderildi denmez.
