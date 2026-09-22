# Mimari

Tek Flutter uygulaması, feature-first yapı (spec §11). Harici state
framework'ü yok: drift akışları (`Stream`) + `StatefulWidget` /
`ChangeNotifier`.

```text
lib/
├── main.dart            # DB + ayar deposu açılır, NShoptorApp başlar
├── app/                 # NShoptorApp (MaterialApp, tema, l10n), LanguageController
├── core/                # widget'tan bağımsız, tamamen test edilen mantık
│   ├── money/           # Currency, DecimalFixed, Money, MoneyParser, formatMoney
│   ├── quantity/        # UnitCode, UnitConversion, PackagingContent
│   ├── calc/            # LineCalc, ListCalc, EffectSplit, VarianceThreshold
│   ├── l10n/            # tr/en ARB + üretilmiş AppLocalizations
│   ├── theme/           # AppTheme (M3), SemanticDelta (WCAG AA)
│   └── util/            # normalizeName, combineLatest3
├── data/db/             # drift şeması (14 tablo), migration
└── features/
    ├── home/            # HomeShell (4 sekme), HomeScreen, şablon kartı
    ├── lists/           # listeler, ürün formu, liste detayı, öneriler,
    │                    # taksonomi, şablonlar, hatırlatmalar, ekler
    ├── shopping_mode/   # alışveriş modu + summary/ (sonuç ekranı)
    ├── history/         # price_history/, insights/
    ├── voice_input/     # SpeechService, VoicePreviewSheet, parser/
    ├── receipts/        # OcrTextSource, shelf_label/, parser/, review/
    └── settings/        # SettingsScreen, backup/
```

## Katman kuralları

- `core/` Flutter widget'ı içermez; parasal değerlerde `double` yoktur.
- Her feature kendi repository'sini (`*_repository.dart`) drift üzerinden
  tutar; ekranlar repository akışlarını dinler.
- Platform servisleri soyutlamanın arkasındadır ve testte sahtesi verilir:
  `SpeechService` (→ `SttSpeechService`), `OcrTextSource`
  (→ `MlKitTextSource`), `ReminderScheduler`. `ListDetailScreen` bu
  servisleri isteğe bağlı parametre olarak alır.
- OCR/ses çıktısı yalnız onay ekranından sonra veriye dönüşür
  (`ReceiptReviewController.commit`, `VoicePreviewSheet` → ürün formu).

## Önemli kararlar

- ADR-001: kalıcılık için drift 2.35; üretilmiş kod repoda
  (`.project-brain/decisions/ADR-001.md`).
- Raf etiketi için kırpma/döndürme arayüzü yok: ML Kit görüntü yönünü
  kendisi okur, kullanıcı tüm fiyat adayları arasından seçer; ayrı kırpma
  paketi eklenmedi.
