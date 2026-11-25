import 'package:napp_core/napp_core.dart';

/// Compile-time snapshot of the publisher feed (PB-209): the first launch of
/// a fresh install can be offline and still show the sibling apps. The daily
/// feed job (XPersPerspective/napp_apps) stays the source of truth; this list
/// only needs to stay roughly current at release time. The repository drops
/// this app's own entry by package name.
const List<OtherApp> embeddedOtherApps = [
  OtherApp(
    id: 'doctorfilter',
    androidPackage: 'com.crazypenguin.doctorfilter',
    iconUrl:
        'https://raw.githubusercontent.com/XPersPective/napp_apps/HEAD/icons/doctorfilter.png',
    name: {'en': 'DoctorFilter Blue Light Filter', 'tr': 'DoctorFilter'},
    description: {
      'en': 'Comfortable screen colors with a blue light filter.',
      'tr': 'Mavi ışık filtresiyle gözünü yormayan ekran renkleri.',
    },
    order: 1,
  ),
  OtherApp(
    id: 'halen',
    androidPackage: 'com.crazypenguin.halenquitsmoking',
    iconUrl:
        'https://raw.githubusercontent.com/XPersPective/napp_apps/HEAD/icons/halen.png',
    name: {'en': 'Halen Quit Smoking', 'tr': 'Halen Sigara Bırakma'},
    description: {
      'en': 'Quit smoking with tracked progress and motivation.',
      'tr': 'İlerlemeni izleyerek sigarayı bırakma.',
    },
    order: 2,
  ),
  OtherApp(
    id: 'kamubul',
    androidPackage: 'com.crazypenguin.kamubul',
    appStoreId: '6826592263',
    iconUrl:
        'https://raw.githubusercontent.com/XPersPective/napp_apps/HEAD/icons/kamubul.png',
    name: {'en': 'KamuBul', 'tr': 'KamuBul'},
    description: {
      'en': 'Find public institutions and their services.',
      'tr': 'Kamu kurumlarını ve hizmetlerini bul.',
    },
    order: 3,
  ),
];
