# Product
Status: CONFIRMED

## Goal
Uygulamanın zihinsel modelini tek alışveriş listesinde birleştir: “Evdeki Hesap” planlanan/tahmini, “Çarşıdaki Hesap” rafta/kasada gerçekleşen fiyat olsun; slogan “Evdeki hesap çarşıya uyar.” olsun. Ana ekran yatay kaydırılan Liste, Tamamlananlar ve Arşiv ekranlarından oluşsun; gereksiz durum etiketleri, ara onaylar ve kalabalık düğmeler kaldırılsın. Satıra dokunma düzenlemeyi, basılı tutma sıralamayı, yana kaydırma silmeyi ve kısa geri alma bildirimini sağlasın. Alt hızlı ekleme ve tek mikrofon sabit kalsın; ses/miktar ayrıştırması ve ürün bazlı normalize birim fiyat geçmişi güvenilir çalışsın.

## Users
- Evde alışveriş planlayan ve markette gerçekleşen tutarı aynı listede karşılaştırmak isteyen kişiler.

## Core Journeys
- Liste: ana ekran -> ürün ekle/düzenle -> tahmini fiyat -> markette işaretle ve çarşı fiyatını gir -> tamamlananlara geç.
- Geçmiş: tamamlananlar -> listeyi aç -> ürün fiyat geçmişini incele -> arşive al.
- Hızlı giriş: alt alan/mikrofon -> tek düzenlenebilir aday -> kullanıcı onayıyla liste satırı.

## Platforms
- android: internal/release; iOS mevcut Android hattını bloklamaz.

## Success Conditions
- [interaction] Aynı ürün satırında ad, miktar, tahmini fiyat ve çarşı fiyatı düzenlenebilir; satıra dokunma doğrudan editörü açar.
- [interaction] Ana ekranda Liste, Tamamlananlar ve Arşiv yatay kaydırmayla erişilir; silme geri alınabilir ve kısa bildirim yana kaydırılarak kapatılabilir.
- [accessibility] 320dp, büyük yazı, klavye ve RTL düzenlerinde liste ekleme/düzenleme/tikleme yolculuğu tamamlanır.
- [machine] Çarşı fiyatı olmayan ürün fiili toplamı artırmaz; normalize birim fiyat gözlemi miktar değişiminden bağımsız saklanır.
- [machine] Ses oturumu ilk ve ikinci açılışta tek mikrofon sahibiyle çalışır; miktar ve birim ayrıştırması testlidir.

## Riskiest Assumptions
- RA-1: Mevcut Drift modeli ve ListDetail akışı tek listeyi üç yatay ekrana dönüştürmek için yeterli -> mevcut controller/repository ve widget testleri üzerinde küçük UI probe.
- RA-2: Çarşı fiyatı geçmişi mevcut price observation kayıtlarından normalize edilebilir -> veri akışı ve birim dönüşümleriyle domain test probe.

## Target State
### Navigation and list UI
- Tek kanonik liste; üç yatay sayfa Liste/Tamamlananlar/Arşiv; üst alan sade; alt hızlı ekleme ve tek mikrofon sabit.
### Item and price model
- Her satır ad, miktar/birim, Evdeki Fiyat ve isteğe bağlı Çarşı Fiyatı taşır; eksik çarşı fiyatı toplamı etkilemez.
### Gestures and feedback
- Satıra dokunma editör, basılı tutma sıralama, yana kaydırma silme, kısa kapatılabilir Undo snackbar.
### Price history and voice
- Gerçek fiyatlar ürün/birim bazında normalize edilir; cihaz içi tek ses yaşam döngüsü aday miktarları doğru ayırır.

## Non-Goals
- Hesap/bulut senkronizasyonu, döviz kuru dönüşümü, yeni OCR/AI servisi veya tam DB/state-management yeniden yazımı.
- Kullanıcı istemediği “Bulunamadı/İptal”, “Devam Et”, “Taslak/Alışverişte” ara durumları.

## Open Decisions
- OD-001 OPEN: Arşivleme hareketi liste kartında mı yoksa sade taşma menüsünde mi görünmeli? -> interaction polish; varsayılan taşma menüsü.
