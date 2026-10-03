# Google Play "Veri güvenliği" formu taslağı — NShoptor

> **Durum:** TASLAK (PB-044). Yayın öncesi Play Console'a doldurulur;
> UNKNOWN alanlar Crazy Penguin değerle doldurur.

## Toplanan/paylaşılan veri matrisi

| Veri | Toplanıyor mu? | Paylaşılıyor mu? | Amaç | Zorunlu mu? |
|---|---|---|---|---|
| Kişisel kimlik (ad, e-posta) | HAYIR | HAYIR | — | — |
| Kullanıcı etkinliği (analiz) | HAYIR | HAYIR | — | — |
| Konum | HAYIR | HAYIR | — | — |
| Fotoğraf/videolar | Yalnız sizin seçtiğiniz fiş görselleri, CİHAZ İÇİ işlenir | HAYIR | Fiş tanıma; dosya cihazda kalır, yüklenmez | Hayır (elle giriş alternatifi var) |
| Ses kaydı | Mikrofon yalnız "Sesle ekle" basılıyken; platform tanıyıcısı dinler | HAYIR (tanıma cihaz/OS hizmetiyle) | Ürün adı girişi | Hayır (klavye alternatifi var) |
| Uygulama etkinliği (liste/fiyat verisi) | CİHAZ İÇİ | HAYIR | Uygulamanın işlevi | Evet (cihazdan çıkmaz) |
| Reklam kimliği | EVET (AdMob SDK'sı, ücretsiz sürüm) | EVET (Google Ads) | Reklam gösterimi | Hayır — Pro ile tamamen kalkar; onay reddedilebilir |

## Silme beyanı

Uygulama kaldırıldığında tüm yerel veriler silinir; sunucuda kullanıcı
verisi tutulmadığından uzaktan silme gerekmez.

## Diğer formlar

- **Yaş derecelendirmesi:** Herkes (3+ önerisi; reklam nedeniyle ESRB
  benzeri "dijital satın alma" beyanı: EVET — Pro satın alma).
- **Reklam içeriği:** Uygulama reklam içerir (AdMob banner).
- **Hedef SDK / izinler:** Bildirim izni yalnız hatırlatma kurulurken
  istenir; mikrofon/kamera yalnız kullanım anında.
- **Dijital varlar (Play Billing):** `nshoptor_pro_lifetime` tek seferlik.
- UNKNOWN: Play Console hesap bilgileri, mağaza görselleri, açıklama
  metinleri (docs/store/play-listing.md tamamlanınca).
