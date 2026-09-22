# Release kontrol listesi

## Her sürümde

- [ ] `flutter analyze` → 0 sorun
- [ ] `flutter test` → tamamı yeşil
- [ ] `flutter test integration_test` (emülatör/cihaz)
- [ ] `pubspec.yaml` `version:` artırıldı, `CHANGELOG.md` güncellendi
- [ ] Gerçek cihaz doğrulama listesi (aşağıda) tamamlandı

## Android

```bash
flutter build apk --debug
flutter build apk --release
flutter build appbundle --release
```

Crazy Penguin tarafından sağlanacak alanlar:

- [ ] `applicationId` / `namespace` (`android/app/build.gradle.kts`,
      şu an `com.example.nshoptor`)
- [ ] `android/key.properties` (şablon: `android/key.properties.example`):
      `storeFile`, `storePassword`, `keyAlias`, `keyPassword`
- [ ] `key.properties` yoksa release derlemesi **debug anahtarıyla**
      imzalanır — mağazaya yüklemeden önce dosyanın mevcut olduğunu doğrulayın
- [ ] R8 minify+shrink açık; release APK'da ses/OCR akışları kontrol edildi

## iOS (macOS + Xcode gerekir; Windows'ta derlenemez)

```bash
flutter build ios --release
flutter build ipa
```

- [ ] Bundle ID (şu an `com.example.nshoptor`), Team, provisioning profile
- [ ] `Info.plist` izin metinleri (kamera, fotoğraflar, mikrofon, konuşma
      tanıma) gözden geçirildi

## Gerçek cihaz doğrulaması (spec §13)

- [ ] Android + iOS temel akış: liste → alışveriş → sonuç
- [ ] Fiş: düşük ışık, uzun fiş, eğik fiş, Türkçe karakterli ürün
- [ ] Uçak modunda fiş OCR
- [ ] Ses: internet açık / kapalı, izin reddi → manuel giriş
- [ ] Düşük bellek / arka plandan dönüş sonrası veri korunuyor
- [ ] Hatırlatma bildirimi (OS adaptörü `LocalNotificationsScheduler`
      bağlandıktan sonra)
