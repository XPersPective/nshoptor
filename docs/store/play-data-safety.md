# Google Play "Veri güvenliği" formu — NShoptor

> **Durum:** 1.1.0 (PB-059) için güncel. Kaynak: docs/store/privacy-policy.md,
> server/ (Worker), ADR-004.

## Genel sorular

- Veri topluyor veya paylaşıyor mu? **EVET** (AI metni geçici işlenir; AdMob reklam kimliği).
- Aktarımda şifreli mi? **EVET** (yalnız HTTPS).
- Silme talebi yolu: **EVET** — uygulama içi "Tüm verileri sil" + kaldırma; sunucuda kişisel veri yok.

## Veri matrisi

| Play kategorisi | Toplanan | Paylaşılan | Geçici işleme | Amaç | Zorunlu |
|---|---|---|---|---|---|
| Uygulama etkinliği › Diğer kullanıcı içeriği (AI'ya giden metin: fiş satırı, ürün adı, cümle) | EVET | HAYIR¹ | **EVET** (saklanmaz) | Uygulama işlevselliği | Hayır (AI kapatılabilir) |
| Cihaz veya diğer kimlikler (rastgele kurulum kimliği — kota) | EVET | HAYIR | Hayır | Uygulama işlevselliği, kötüye kullanımı önleme | Evet (AI kullanılırken) |
| Cihaz veya diğer kimlikler (reklam kimliği — AdMob) | EVET | EVET (Google) | Hayır | Reklam | Hayır (ücretli planlarda yok) |
| Finansal bilgi › Satın alma geçmişi (Play jetonu → plan) | EVET | HAYIR | Hayır (yalnız SHA-256 özeti, kısa önbellek) | Uygulama işlevselliği | Hayır |
| Fotoğraflar, ses kayıtları, konum, kişisel bilgiler | HAYIR (cihazda işlenir/kalır) | HAYIR | — | — | — |

¹ Hizmet sağlayıcılar (Cloudflare, AI model sağlayıcısı) adımıza işlediği için
Play tanımında "paylaşım" sayılmaz.

## Diğer formlar

- **Reklam içeriği:** EVET (AdMob banner, uygulama açılışı, ödüllü).
- **Uygulama içi satın alma:** EVET — `nshoptor_pro`, `nshoptor_max` (abonelik),
  `com.crazypenguin.nshoptor.pro_lifetime` (tek seferlik).
- **Hedef kitle:** 18+ değil, genel; çocuklara yönelik değil.
- **İzinler:** mikrofon/kamera yalnız kullanım anında; bildirim yalnız hatırlatma kurulurken.
