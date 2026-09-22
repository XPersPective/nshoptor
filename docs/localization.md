# Yerelleştirme

Resmi Flutter l10n: ARB dosyaları `lib/core/l10n/app_{en,tr}.arb`,
üretilmiş kod `lib/core/l10n/generated/` (repoda). Şablon dil: `en`
(`l10n.yaml`).

## Yeni metin ekleme

1. Anahtarı `app_en.arb` ve `app_tr.arb` dosyalarına ekleyin.
2. `flutter gen-l10n` çalıştırın.
3. Kodda `AppLocalizations.of(context).anahtar` kullanın.

## Yeni dil ekleme

1. `app_<kod>.arb` oluşturun (tüm anahtarlar, `slogan` dahil).
2. `flutter gen-l10n`.
3. Dil seçeneğini `LanguageController`'a (`lib/app/language_controller.dart`)
   ve Ayarlar ekranındaki dil seçimine ekleyin.

## Kurallar

- Kanonik değerler (birim, durum, kategori) kod olarak saklanır; görünen ad
  l10n'dan gelir.
- Para/tarih biçimi `intl` ile locale'e göre; slogan seçili dili izler.
