# Google Play Veri güvenliği — NShoptor

> 2026-10-27, 1.3.1+20 kaynak koduna göre güncellenen taslak; Console formunun
> güncellendiği/yayımlandığı iddia edilmez. Üretim sürümü1 için mevcut form
> ile yeni sürümün kapsamı yayın öncesinde ayrıca karşılaştırılmalıdır.

## Beyan kapsamı

Veri toplanır/paylaşılır: isteğe bağlı AI metni, kota/abonelik metaverisi ve
reklam SDK'sı. Uygulama/proxy HTTPS kullanır. Uygulama içi silme sunucu
kayıtlarını veya dışa aktarılan dosyaları silmez; talepler için
[politika/iletişim](privacy-policy.md). Kurulum/satın alma özetlerini sırf
isim içermediği için anonim veya kişisel veri dışı saymayın.

| Veri | İşleme / alıcı | Amaç / seçim |
|---|---|---|
| AI metni (ürün/fiş/cümle) | Cloudflare vekil ve Qwen; Worker metni kalıcı tutmaz, sağlayıcı saklaması doğrulanmadı | İşlevsellik; AI kapatılabilir |
| Kurulum kimliği / satın alma SHA-256 özeti / plan / bağlı kota sahipliği | Worker/D1; yetki önbelleği süreli, sahiplik süresiz tutulur; kimlikler Qwen'e iletilmez | Kota, işlevsellik ve kötüye kullanım önleme; AI kullanılırken |
| Satın alma geçmişi / Play jetonu | Google Play doğrulaması; ham jeton kalıcı kaydedilmez | İsteğe bağlı ücretli özellik |
| IP kaynaklı yaklaşık konum, cihaz/reklam kimlikleri, ürün etkileşimleri, tanılama | AdMob/Google SDK işleme ve paylaşımı; reklamsız hak SDK hiç başlamaz garantisi değildir | Reklam, analitik, dolandırıcılık önleme |
| Fotoğraf/ses | Uygulamanın OCR/ses akışları yüklemez; cihazda işlenir | Yerel giriş |
| Kullanıcının dışa aktardığı dosya | Seçilen sistem/bulut dosya sağlayıcısı | Kullanıcının başlattığı kaydetme |

AI için "geçici işleme" veya hizmet sağlayıcı paylaşım istisnası otomatik
seçilmez: sağlayıcının fiilî koşulları doğrulanmadan saklama/paylaşım yok
denemez. Kaynak matrisi nihai Console cevaplarının yerine geçmez.

## Kaynaklar ve diğer formlar

- [Google Play beyan kapsamı](https://support.google.com/googleplay/android-developer/answer/10787469?hl=en): SDK ve cihaz dışı akışları da değerlendirin.
- [AdMob açıklaması](https://developers.google.com/admob/android/privacy/play-data-disclosure): güncel kılavuz25.5.0 içindir; yayımlanan AAB'nin gerçek SDK sürümüyle karşılaştırın.
- Reklam: banner ve yapılandırılmış isteğe bağlı ödüllü video; uygulama açılışı reklamı bu kaynakta kullanılmaz. İlk yedi gün reklam gösterilmez; SDK/onay başlatması ayrı değerlendirilir.
- Yeni satış: yalnız yıllık `nshoptor_pro_v2` (Pro100YZ/ay). Eski Pro/Max ürün ve planları ile `com.crazypenguin.nshoptor.pro_lifetime` hakları korunur; yeni Max/aylık/ömür boyu satış yoktur.
- Çocuklara yönelik değildir. Mikrofon/kamera yalnız ilgili kullanımda;
  bildirim izni yalnız hatırlatma kurulurken istenir.
