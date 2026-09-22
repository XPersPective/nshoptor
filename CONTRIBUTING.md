# Katkı

1. `flutter pub get`
2. Değişiklikten sonra `flutter analyze` (0 sorun) ve `flutter test`.
3. Para/ondalık hesapta `double` kullanmayın; `lib/core/money` kullanın.
4. Kullanıcıya görünen her metin iki ARB dosyasına (`app_en.arb`,
   `app_tr.arb`) eklenir, ardından `flutter gen-l10n`.
5. Şema değişikliği: `schemaVersion` artırılır, migration adımı ve testi
   eklenir, `dart run build_runner build` ile üretilen kod commit edilir.
6. Yeni bağımlılık yalnız gerekçeyle (bakım, lisans, platform) ve README
   tablosuna eklenerek.
7. Günlüklere kullanıcı verisi (fiş metni, ürün listesi, dosya yolu) yazmayın.
8. Commit mesajı: `tür(kapsam): özet` (feat, fix, test, docs, chore).

Katkılar GPL-3.0 altında kabul edilir.
