# NShoptor

**Türkçe:** Evdeki hesap çarşıya uyar.  
**English:** Plan at home. Shop as planned.

NShoptor is a multilingual, offline-first shopping planner by Crazy Penguin.
It compares estimated shopping costs with actual quantities and prices.

## Özellikler

- Hesapsız, çevrimdışı alışveriş listeleri; ondalıklı miktar + tahmini fiyat
- Alışveriş modu: gerçek miktar/fiyat girişi, plansız ürün, "alınmadı"
  (0 TL değildir), anlık tahmini kasa toplamı
- Sonuç ekranı: tahmin–gerçek farkı **fiyat etkisi** ve **miktar etkisi**
  olarak ayrı satırlarda
- Fiyat hafızası ve ürün fiyat geçmişi; önceki alışverişten plan (şablon)
- Yardımcı girişler — hepsi düzenlenebilir onay ekranının arkasında:
  sesle ürün ekleme, raf etiketinden fiyat, fiş tarama (cihazda OCR)
- Hatırlatma kayıtları (OS bildirim bağlantısı henüz yok — cihaz
  doğrulamasıyla eklenecek), yedekleme (JSON içe/dışa), CSV sonuç dışa aktarma
- tr/en, koyu tema, büyük yazı, ekran okuyucu etiketleri

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
| speech_to_text | Platform konuşma tanıma (Android SpeechRecognizer / iOS Speech); model indirmesi yok |
| google_mlkit_text_recognition | Cihazda, pakete gömülü Latin OCR; internetsiz |
| image_picker | Kamera/galeriden görüntü |
| path_provider | Uygulama özel dizini (fotoğraflar, yedek) |
| flutter_local_notifications, timezone | Yerel hatırlatmalar (OS adaptörü beklemede) |
| wakelock_plus | Alışveriş modunda ekranı açık tutma |
| share_plus, file_picker | Yedek paylaşma / içe aktarma dosyası seçme |
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

İnternet izni istenmez; kullanıcı verisi cihazdan çıkmaz.

## Yedek formatı

Sürümlenmiş JSON: `{"format":"nshoptor-backup","version":1,"exportedAt":…,
"stores":[…],"lists":[…],…}` — 13 tablo. İçe aktarma önce tüm dosyayı
doğrular, tek transaction'da yazar; bozuk dosya mevcut veriye dokunmaz.
"Birleştir" kimlikleri korur, "ayrı" mod yeni kimliklerle ekler. Fotoğraf
dosyaları JSON'a gömülmez (yalnız yollar).

## Kimlik

- Uygulama adı: **NShoptor** (büyük N, büyük S)
- Yayıncı: **Crazy Penguin**
- Android application ID / iOS bundle ID: şu an `com.crazypenguin.nshoptor`
  yer tutucusudur. Gerçek mağaza kimlikleri ve imzalama bilgileri Crazy
  Penguin tarafından sağlanınca değiştirilecektir (bkz.
  [release kontrol listesi](docs/release-checklist.md)).

## Lisans

GNU GPL-3.0 — bkz. [LICENSE](LICENSE). Uygulama adı ve logosu markadır;
lisansa dahil değildir.
