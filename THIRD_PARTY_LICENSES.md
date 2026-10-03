# Üçüncü Taraf Lisansları

Bu dosya ORTAK_UYGULAMA_STANDARDI.md §2 gereği her bağımlılık, font,
ikon ve görseli listeler. Uygulamanın kendi lisansı **GNU GPL-3.0**
(`LICENSE`); aşağıdaki listeler Flutter Lisanslar ekranında da gösterilir
(`showLicensePage` + `ExtraLicense` girdileri).

Sürüm notları: her paket eklenip çıkarıldığında bu liste güncellenir
(`flutter pub deps --style=list` ile karşılaştırılır).

## Dart paketleri (pubspec.yaml)

| Paket | Kullanım | Lisans |
|---|---|---|
| napp_core / napp_pro / napp_ads | Crazy Penguin ortak çekirdeği (ayarlar, Hakkında, Keşfet, Pro, reklam politikası) | GPL-3.0 (kendi repomuz: napp_kit) |
| drift, drift_flutter | SQLite veri katmanı | Apache-2.0 (drift: MPL-2.0 — ikisi de GPL uyumlu) |
| sqlite3_flutter_libs (drift aracılığıyla) | Android SQLite | MIT |
| flutter_localizations, intl | Yerelleştirme | BSD-3-Clause |
| flutter_local_notifications | Hatırlatma bildirimleri | Apache-2.0 |
| timezone | DST-güvenli planlama | Apache-2.0 |
| speech_to_text | Sesle ürün girişi (platform tanıyıcısı) | BSD-3-Clause |
| google_mlkit_text_recognition | Cihaz içi fiş OCR (ücretsiz, çevrimdışı) | Apache-2.0 |
| image_picker | Fiş/raf fotoğrafı seçimi | Apache-2.0 |
| path_provider | Uygulama dizinleri | BSD-3-Clause |
| share_plus | Uygulama paylaşımı / yedek paylaşımı | BSD-3-Clause |
| file_picker | Yedek içe aktarma | MIT |
| wakelock_plus | Alışveriş modunda ekran açık | BSD-3-Clause |
| in_app_purchase | Ömür boyu Pro satın alma | BSD-3-Clause |
| google_mobile_ads | Banner reklam | Apache-2.0 |
| app_tracking_transparency (napp_ads aracılığıyla) | iOS ATT izni | MIT |
| shared_preferences (napp paketleri aracılığıyla) | Reklam politikası sayacı | BSD-3-Clause |
| url_launcher (napp_core aracılığıyla) | Mağaza/e-posta bağlantıları | BSD-3-Clause |
| http (napp_core aracılığıyla) | Keşfet apps.json indirme | BSD-3-Clause |

## Fontlar / ikonlar / görseller

- Material Icons (Flutter SDK): LICENSE BSD-3-Clause / Apache-2.0
  (flutter Lisanslar ekranı otomatik listeler).
- Uygulama ikonu: `tool/brand/make_source_icon.py` ile üretilmiştir
  (kaynak kod bu repoda, GPL-3.0).

## Ürün yazılımları

- Google ML Kit Text Recognition (Latin): cihaz içi çalışır, model
  uygulamaya gömülüdür, ağa veri göndermez. Kullanım koşulları:
  Google Play Services / ML Kit terms.
