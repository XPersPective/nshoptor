# Uygulayıcı yapay zekâ için devir

## Başlangıç durumu
- Kullanıcı son mesajında yalnız plan istedi. Bu oturumdaki uygulama denemeleri geri alındı; kod tabanı önceki çalışan sürümdedir.
- Başlangıç `flutter test`: 295 test geçti. Bu, yeni kabul ölçütlerini kanıtlamaz.
- Deneme kodunun sonuçlarını tamamlanmış görev sayma. Yeni görevlerin hiçbiri uygulanmadı.
- Önce `python C:/Users/rubicon/.skills-manager/skills/project-brain/scripts/brain.py boot`.
- Ardından target → ADR-005 → seçilen görev → yalnız Areas dosyaları. Depoyu baştan tarama, bu sohbeti isteme.
- PB-061 eski 71 dil/yayın işi olarak korundu. Mevcut sürüm 1.1.4+6; eski versionCode 3 yeniden yayımlanmaz. Yeni akıştan ayrı tut.

## Sıra
| Faz | Görev | Çıktı | Bağımlılık |
|---|---|---|---|
|1|PB-063|Atomik satın alım ve fiş uzlaştırma|yok|
|2|PB-062|Tek liste, ürün CRUD, gerçek navigasyon|PB-063|
|3|PB-064|Ses/fotoğraf ve zengin AI önizlemesi|PB-062|
|3|PB-067|Yerel ayar, bildirim, ekran kilidi|PB-062|
|4|PB-065|Kota/maliyet ve çok dilli taahhüt|PB-064|
|4|PB-066|Android PDF raporu|PB-063, PB-062|
|4|PB-068|Ürün/kategori alış analizi|PB-063, PB-064|
|5|PB-069|Tüm akışın cihaz ve yayın kabulü|önceki yedi görev|

## Örnek uçtan uca kabul
1. İngilizce arayüz + TRY seç. “Pazar alışverişi; 2 kg domates kilosu 40, bir X marka süt” söyle. Başlık, 80 toplam tahmin, marka ve kategori önizlemede görünür; onaydan önce kayıt yok.
2. Yeni satırı tek listede tikle; fiyat bilinmiyorsa gerçek “—”. Fotoğrafla gerçek fiyat 45/kg gir; gerçek miktar 1.5kg ise 67.50; plan miktarı 2kg kalır.
3. Sütü sil/güncelle; iptal hiçbir değişiklik yapmaz. Uzun isim/büyük yazıda fiyat ve menü erişilir.
4. Bazı ürünler alınmadan bitir; fişi daha sonra ekle. Aynı domates satırı fişte 68 ise toplam 68 olur, 135.50 olmaz. İkinci onay tekrar eklemez.
5. Ana sayfa tamamlananlar → aynı liste; bu ay kartı → doğru para birimiyle harcama; PDF kaydet/aç.
6. Tekrar açınca veri korunur; mikrofon ikinci kez çalışır veya açıklayıcı hata verir; ekran kilidi arka planda tutulmaz.

## Sınırlı tokenla çalışma
Her görev bir davranış kümesi ve bir checkpoint. Dosyaların tamamını tekrar okuma; Map ve sembollerle aralık oku. Önce regresyon testi, sonra en küçük ortak değişiklik. Tam test paketini yalnız persistence/cross-domain ve finalde çalıştır; aynı yeşil testi sebepsiz tekrarlama. Kanıtı görevde sakla. Büyük görev 8 dosya/300 satırı aşıyorsa `PB new` ile alt görev çıkar; kabul maddelerini kaybetme.

## Kapsam eşlemesi
Tıklanamayan kart/yeni liste/asistan → 062. Silme/tik/tahmin/gerçek/uzun ad → 062+063. Ses başlık/ürün/marka/kategori ve fotoğraf → 064. Fişle plansız/kısmi alışveriş → 063+064. Ülke/para/sayı/ekran kilidi/bildirim → 067. Free/Pro/Max/lifetime/yıllık/kâr → 065. PDF/KDV → 066. Ürün sıklığı/miktar/kategori/grafik → 068. Profesyonel uçtan uca kanıt → 069.
