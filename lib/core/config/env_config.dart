import 'package:flutter/material.dart';
import 'package:napp_core/napp_core.dart';

/// Uygulama kimliği ve harici adresler (ORTAK_UYGULAMA_STANDARDI.md §1.2).
///
/// Her değer `--dart-define` ile üretimde ezilebilir; varsayılanlar
/// projenin kendi adresleri ya da açık yer tutuculardır (`.example` TLD).
/// Gerçek mağaza kimlikleri (AdMob vb.) repoya ASLA girmez — test
/// kimlikleri napp_ads AdsConfig'in varsayılanıdır.
class EnvConfig {
  EnvConfig._();

  static const _sourceUrl = String.fromEnvironment(
    'NSHOPTOR_SOURCE_URL',
    defaultValue: 'https://github.com/XPersPective/nshoptor',
  );
  static const _privacyUrl = String.fromEnvironment(
    'NSHOPTOR_PRIVACY_URL',
    // Yayınlanacak sayfa (PB-044 taslağı); yayınlanana dek yer tutucu.
    defaultValue: 'https://github.com/XPersPective/nshoptor/blob/main/docs/store/privacy-policy.md',
  );
  static const _contactEmail = String.fromEnvironment(
    'NSHOPTOR_CONTACT_EMAIL',
    defaultValue: 'devcrazypenguin@gmail.com',
  );
  static const _otherAppsUrl = String.fromEnvironment(
    'NSHOPTOR_OTHER_APPS_URL',
    // Crazy Penguin'in apps.json adresi bilinene dek yer tutucu (§3.6);
    // paylaşılamaz Köşfet bu URL'yi önbelleksiz dener, çevrimdışı gömülü
    // kopyaya düşer.
    defaultValue: 'https://raw.githubusercontent.com/XPersPective/napp_apps/HEAD/apps.json',
  );

  static const String proProductId = 'com.crazypenguin.nshoptor.pro_lifetime';

  static AppIdentity get identity => AppIdentity(
        appName: 'NShoptor',
        packageName: 'com.crazypenguin.nshoptor',
        sourceUrl: _sourceUrl,
        privacyPolicyUrl: _privacyUrl,
        contactEmail: _contactEmail,
        otherAppsUrl: _otherAppsUrl,
        iconAsset: 'assets/brand/icon_1024.png',
        brandColor: const Color(0xFF0B8457),
      );
}
