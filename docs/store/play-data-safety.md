# Google Play Veri güvenliği — NShoptor

> 2026-10-10, 1.2.1 kaynak koduna göre hazırlanan taslak; Console formunun
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
- Reklam: banner/uygulama açılışı; ödüllü birim yapılandırılmışsa ödüllü reklam.
- Satın alma: yeni `nshoptor_pro_v2`, `nshoptor_max_v2`; eski `nshoptor_pro`, `nshoptor_max` hakları ve `com.crazypenguin.nshoptor.pro_lifetime` korunur.
- Çocuklara yönelik değildir. Mikrofon/kamera yalnız ilgili kullanımda;
  bildirim izni yalnız hatırlatma kurulurken istenir.
