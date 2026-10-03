# Yeni dil ekleme (ADR-003: ARB altyapısı)

1. `lib/core/l10n/app_en.arb` dosyasını `app_<kod>.arb` olarak kopyala
   (ör. `app_de.arb`) ve TÜM değerleri çevir.
2. `flutter gen-l10n` — üretim eksik anahtar bulursa hata verir; ayrıca
   eksik-anahtar testi kırmızıya düşer.
3. `lib/app/app.dart` → `supportedLocales` listesine `Locale('<kod>')`
   ekle; Ayarlar dil menüsüne satır ekle (ARB'ye `language<Kod>` anahtarı).
4. Birim adları (`unitAdet` vb.) yeni dilde ARB'ye girilmelidir.
5. `flutter analyze && flutter test` yeşil olmalı; emülatörde dil
   değişimi elle doğrulanır (slogan dahil).
6. RTL diller için: napp_core `ltrIsolate` sayı/birim sarmalayıcısını
   kullan; tam RTL doğrulaması cihazda yapılır.

Not: sayı/para BİÇİMİ ayrı ayardır (C-001) — yeni dil, biçim ayarını
zorlamaz; biçim seçenekleri Sistem/tr/en kalır.
