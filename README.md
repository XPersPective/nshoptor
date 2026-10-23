# NShoptor

**Türkçe:** Evdeki hesap çarşıya uyar.  
**English:** Plan at home. Shop as planned.

NShoptor is a multilingual, offline-first shopping planner by Crazy Penguin.
It compares estimated shopping costs with actual quantities and prices.

## Özellikler

- Hesapsız, çevrimdışı alışveriş listeleri; ondalıklı miktar + tahmini fiyat
- İsteğe bağlı alışveriş tarih/saat; varsayılan tarih sırası, A–Z ve manuel sıralama
- Yeni fiyat girişinde seçilen miktarın toplamı; ev/market için bağımsız toplam–birim geçişi. Örneğin400g için350TL, toplam350TL'dir. Açık45TL/kg etiketi2kg için90TL hesaplanır.
- Tahmin ve gerçek fiyat geçmişi aynı para ve uyumlu birim bazında ayrı serilerle karşılaştırılır.
- Tek liste ekranında tik, gerçek miktar/fiyat girişi, plansız ürün, "alınmadı"
  (0 TL değildir), anlık tahmini kasa toplamı
- Sonuç ekranı: tahmin–gerçek farkı **fiyat etkisi** ve **miktar etkisi**
  olarak ayrı satırlarda
- Fiyat hafızası ve ürün fiyat geçmişi; önceki alışverişten plan (şablon)
- Yardımcı girişler — hepsi düzenlenebilir onay ekranının arkasında:
  sesle ürün ekleme, raf etiketinden fiyat, fiş tarama (cihazda OCR)
- Yerel hatırlatma bildirimleri, Pro JSON yedekleme, ücretsiz PDF/CSV raporu
- 71 arayüz dili; bağımsız dil/sayı biçimi/para birimi, koyu tema, büyük yazı, ekran okuyucu etiketleri

## Planlar ve mağaza durumu

Temel alışveriş listeleri, fiyat karşılaştırması, PDF/CSV raporları ve cihazdaki
kayıtlar hesap açmadan kullanılabilir. İsteğe bağlı yapay zeka internet gerektirir.
Yeni ücretli **Pro ve Max teklifleri yalnız aylık aboneliktir**: iptal edilene
kadar her ay otomatik yenilenir. Güncel fiyat ve varsa deneme uygunluğu Google
Play satın alma ekranından gelir; bu belgede fiyat veya sabit deneme sözü yoktur.
Abonelik Google Play üzerinden yönetilir ve iptal edilir. Mevcut eski/yıllık
satın almalar geri yüklenebilir; eski haklar korunur.

| Plan | Aylık yapay zeka kotası | Ek özellikler |
|---|---|---|
| Ücretsiz | 10 istek | Temel özellikler; reklamlar |
| Pro | 100 istek | Reklamsız kullanım, JSON yedekleme ve geri yükleme |
| Max | 300 istek | Reklamsız kullanım, JSON yedekleme ve geri yükleme |

Eski Pro/Max ürünlerinin sırasıyla 200/1000 aylık istek hakları korunur.
Kotalar istemci ve sunucu politikasını anlatır; sunucu satın almayı Google Play
ile doğrular. Çevrimdışıyken yapay zeka yerine elle giriş kullanılabilir.

**English:** New Pro and Max offers are monthly subscriptions, automatically
renewing until cancelled in Google Play. The Play purchase screen supplies the
current price and any trial eligibility. Existing subscriptions, including older
yearly purchases, remain restorable with their entitlements preserved. Core
shopping and PDF/CSV reports are available without a subscription; JSON backup
and restore require Pro or Max access.

[Türkçe tanıtım ve kullanım rehberi](https://xperspective.github.io/nshoptor/) ·
[English website and guide](https://xperspective.github.io/nshoptor/en/)

GitHub Pages sitesi yayımlıdır. Android mağaza adresi
[Google Play](https://play.google.com/store/apps/details?id=com.crazypenguin.nshoptor)
üzerindedir; genel üretim indirmesi bu belgeyle doğrulanmış sayılmaz. Doğrulanmış
bir iOS mağaza bağlantısı bulunmadığından App Store indirme vaadi verilmez.

## Kurulum ve çalıştırma

Gereksinim: Flutter stable 3.47.x (Dart null safety).

```bash
flutter pub get
flutter run
```

Kod üretimi (yalnız drift şeması değişince): `dart run build_runner build`.
Üretilmiş `app_database.g.dart` repoda tutulur.

## Testler

```bash
flutter analyze
flutter test
flutter test integration_test   # emülatör/cihaz gerekir
```

CI (`.github/workflows/ci.yml`): analyze + test, gitleaks, release APK build.

## Paketler ve gerekçeleri

| Paket | Neden |
|---|---|
| intl, flutter_localizations | Resmi ARB yerelleştirme, locale-aware para/tarih |
| drift, drift_flutter | Tipli SQLite, sürümlü migration, transaction (ADR-001) |
| Android native SpeechRecognizer | API31+ cihaz içi konuşma; bulut tanıma yok, eksik dil modeli için desteklenen cihazda indirme isteği |
| google_mlkit_text_recognition | Cihazda, pakete gömülü Latin OCR; internetsiz |
| image_picker | Kamera/galeriden görüntü |
| path_provider | Uygulama özel dizini (fotoğraflar, yedek) |
| flutter_local_notifications, timezone | Yerel hatırlatmalar; izin ve inexact alarm fallback |
| wakelock_plus | Alışveriş modunda ekranı açık tutma |
| share_plus, file_picker | Paylaşım; native JSON kaydetme/seçme ve CSV kaydetme |
| napp_core | Ayar deposu ve dil denetleyicisi (Crazy Penguin ortak çekirdeği) |

Para ve ondalık hesap için harici paket yok: `lib/core/money` (bkz.
[docs/calculations.md](docs/calculations.md)).

## Belgeler

- [Mimari](docs/architecture.md) · [Veri modeli](docs/data-model.md) ·
  [Hesaplamalar](docs/calculations.md) · [Yerelleştirme](docs/localization.md)
- [Fiş OCR](docs/receipt-ocr.md) · [Sesle giriş](docs/voice-input.md) ·
  [Gizlilik](docs/privacy.md) · [Release kontrol listesi](docs/release-checklist.md)
- Bağlayıcı ürün tanımı: [docs/spec/master-prompt-tr.md](docs/spec/master-prompt-tr.md)
- Proje durumu / plan: `.project-brain/` (project-brain protokolü)

## İzinler

| Platform | İzin | Ne zaman |
|---|---|---|
| Android | `RECORD_AUDIO` | Sesle ürün eklemede mikrofon düğmesine basınca |
| iOS | Kamera, Fotoğraflar | Raf etiketi / fiş fotoğrafı |
| iOS | Mikrofon, Konuşma tanıma | Sesle ürün ekleme |

Alışveriş kayıtları çevrimdışı çalışır. İnternet: isteğe bağlı AI metin vekili,
reklamlar, Play satın alma doğrulaması ve Keşfet. Seçtiğiniz bulut dosya
sağlayıcısı kaydettiğiniz dosyayı kendi hizmetine aktarabilir. Ses/OCR cihaz içidir.

## Yedek formatı

Sürümlenmiş JSON: `{"format":"nshoptor-backup","version":1,"exportedAt":…,
"stores":[…],"lists":[…],…}` — 13 tablo. İçe aktarma önce tüm dosyayı
doğrular (en çok 16 MiB), tek transaction'da yazar; bozuk dosya mevcut veriye dokunmaz.
"Birleştir" kimlikleri korur, "ayrı" mod yeni kimliklerle ekler. Fotoğraf
dosyaları JSON'a gömülmez (yalnız yollar).

## Kimlik

- Uygulama adı: **NShoptor** (büyük N, büyük S)
- Yayıncı: **Crazy Penguin**
- Android application ID: `com.crazypenguin.nshoptor` (Play'de mevcut).
- Yayın ve imza dosyaları `D:/AppPublishing/apps/nshoptor` altında;
  `fastlane build_release` ve `fastlane deploy_internal` kullanılır.
  iOS yayını ertelenmiştir (bkz. [release kontrol listesi](docs/release-checklist.md)).

## Lisans

GNU GPL-3.0 — bkz. [LICENSE](LICENSE). Uygulama adı ve logosu markadır;
lisansa dahil değildir.
