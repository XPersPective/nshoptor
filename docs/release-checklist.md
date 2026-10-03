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
- [ ] APK tüm ABI'leri içeriyor (fat `flutter build apk --release`;
      `--target-platform` ile kısıtlarsanız x86_64 emülatörde
      `UnsatisfiedLinkError` oluşur — 2026-09-29'da yakalanan hata)

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
- [ ] Uçak modunda fiş OCR (emülatörde pickImage akışı da doğrulanabilir;
      korpus: test/fixtures/receipts/market_tr_1.txt)
- [x] Ses: izin reddi → manuel giriş (servis yoksa fallback kanıtlı;
      emülatörde speech_to_text yok → manuel akış)
- [ ] Düşük bellek / arka plandan dönüş sonrası veri korunuyor
- [x] Uygulama ikonu: adaptive + monochrome + splash (launcher
      ekran görüntüsü kanıtı 2026-10-03; Flutter varsayılanı kalmadı)
- [x] Pro satın alma/geri yükleme: paywall dürüst (gerçek faydalar,
      restore düğmesi, tek ödeme vurgusu) — mağaza kimlikleri
      girilince canlı satın alma testi yapılır
- [x] Keşfet: çevrimdışı boş-durum, çökme yok (apps.json adresi
      girince besleme doğrulanır)
- [x] Sürüm dizesi jargonsuz: "Sürüm 1.0.0"
- [x] Gizlilik politikası taslağı + Play Veri güvenliği taslağı
      (docs/store/; yayın Crazy Penguin'de)
- [x] Hatırlatma bildirimi: alarm düğmesi → izin → tarih/saat →
      bildirim düştü (emülatör: dumpsys + panel görüntüsü); ARKA PLAN
      düştü; REBOOT sonrası düştü (alarm AlarmManager'da korundu,
      alıcı süreç başlattı — 2026-10-04). İzin red → açıklayıcı
      snackbar. Not: kullanıcı "Durdurmaya zorlarsa" bildirim gelmez
      (Android stopped-state; platform davranışı).
      (OS adaptörü: `LocalNotificationsScheduler`; geçmiş-zaman +30 sn
      kıskacı; tam alarm izni yoksa inexact kip)
