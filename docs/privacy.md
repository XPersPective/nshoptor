# Gizlilik

- Hesap girişi yoktur; alışveriş veritabanı ve tercihler cihazdadır.
- OCR gömülü Latin ML Kit modeliyle, ses Android native cihaz içi tanıma
  ile çalışır; bu akışlar fotoğraf/sesi sunucuya yüklemez.
- İsteğe bağlı AI, seçilen metin ve dili Cloudflare Worker üzerinden Qwen'e
  gönderir. Kurulum kimliği ve varsa Play jetonu yalnız vekile gider;
  sağlayıcıya iletilmez. Worker metni kalıcı kaydetmez; sağlayıcının
  saklama/eğitim davranışı hakkında doğrulanmamış garanti verilmez.
- D1 kurulum/satın alma özetiyle kota, plan ve bağlı jeton sahipliği tutar.
  Yetki önbelleğinin süresi dolsa da sahiplik kayıtları otomatik silinmez.
- Play satın alma, AdMob ve Keşfet internet kullanır. AdMob bağlantı,
  etkileşim, tanılama ve cihaz kimlikleri işleyebilir; reklamsız hak,
  reklam gösterimini kapatır, SDK'nın hiç başlatılmadığı anlamına gelmez.
- Günlüklere fiş/ürün metni veya sır yazılmaz; cleartext kapalıdır.
- İzinler ilgili özellikte istenir. Ayarlar → Tüm verileri sil alışveriş
  veritabanını temizler; paylaşılan tercihler, dışa aktarılan dosyalar ve
  sunucu kota/sahiplik kayıtları bununla silinmez. Uygulamayı kaldırmak
  uygulama özel deposunu kaldırır, dış dosyaları/sunucu kayıtlarını kaldırmaz.
- JSON/CSV/PDF kullanıcının seçtiği sistem dosya sağlayıcısına kaydedilir;
  seçilen bulut sağlayıcısı dosyayı kendi hizmetine aktarabilir.

Kullanıcıya yönelik TR/EN açıklama ve iletişim:
[gizlilik politikası](store/privacy-policy.md). Play beyanı kaynak taslağıdır;
Console'da yayımlandığı iddia edilmez: [veri güvenliği](store/play-data-safety.md).
