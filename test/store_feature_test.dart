// Play tanıtım görseli (1024x500), dil başına. store_capture_test ile aynı
// yöntem; arka plan (sepet + degrade) build/feature_bg.png'den gelir:
//   flutter test test/store_feature_test.dart --update-goldens
//     --dart-define=STORE_LOCALE=<tr|en|de|fr|es|it|pt|ru|ar>
//     --dart-define=STORE_OUT=<klasör>
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';

const _locale = String.fromEnvironment('STORE_LOCALE');
const _localesEnv = String.fromEnvironment('STORE_LOCALES');
const _out = String.fromEnvironment('STORE_OUT');

const _slogan = {
  'en': ('Plan at home, match at checkout.', 'See what you planned and paid.'),
  'tr': ('Evdeki hesap çarşıya uyar.', 'Planla, karşılaştır, kontrol sende.'),
  'de': (
    'Zuhause geplant, im Laden bewährt.',
    'Planen, vergleichen, Überblick behalten.',
  ),
  'fr': (
    'Prévu à la maison, validé en magasin.',
    'Planifiez, comparez, gardez le contrôle.',
  ),
  'es': (
    'Planifica en casa, acierta en el súper.',
    'Planifica, compara y decide.',
  ),
  'it': (
    'I conti di casa tornano alla cassa.',
    'Pianifica, confronta, controlla.',
  ),
  'pt': ('Planeie. Compre. Compare.', 'A IA confere o seu talão.'),
  'ru': (
    'Посчитано дома — сходится на кассе.',
    'Планируйте, сравнивайте, контролируйте.',
  ),
  'ar': ('خطّط. تسوّق. قارن.', 'الذكاء الاصطناعي يطابق إيصالك.'),
};

// Betiğe uygun Windows yazı tipi (store_capture_test ile aynı eşleme).
const _fonts = <String, List<String>>{
  'th': ['LeelawUI.ttf'],
  'lo': ['LeelawUI.ttf'],
  'hi': ['Nirmala.ttc'],
  'bn': ['Nirmala.ttc'],
  'gu': ['Nirmala.ttc'],
  'kn': ['Nirmala.ttc'],
  'ml': ['Nirmala.ttc'],
  'mr': ['Nirmala.ttc'],
  'ne': ['Nirmala.ttc'],
  'pa': ['Nirmala.ttc'],
  'si': ['Nirmala.ttc'],
  'ta': ['Nirmala.ttc'],
  'te': ['Nirmala.ttc'],
  'ja': ['YuGothR.ttc', 'YuGothB.ttc'],
  'ko': ['malgun.ttf', 'malgunbd.ttf'],
  'zh': ['msyh.ttc', 'msyhbd.ttc'],
  'my': ['mmrtext.ttf', 'mmrtextb.ttf'],
};
const _rtl = {'ar', 'fa', 'he', 'ur', 'ps'};

void main() {
  final locales = _localesEnv.isNotEmpty
      ? _localesEnv
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList()
      : (_locale.isEmpty ? const <String>[] : <String>[_locale]);
  if (locales.isEmpty) {
    test('STORE_LOCALE/STORE_LOCALES olmadan tanıtım görseli atlanır', () {
      expect(locales, isEmpty);
    });
    return;
  }

  final bg = File('assets/brand/feature_bg.png').readAsBytesSync();
  var loadedFonts = false;

  for (final loc in locales) {
    final outDir = _localesEnv.isNotEmpty ? '$_out/$loc/current' : _out;
    testWidgets('tanıtım görseli ($loc)', (tester) async {
      tester.view.physicalSize = const Size(1024, 500);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      if (!loadedFonts) {
        loadedFonts = true;
        await tester.runAsync(() async {
          final font = FontLoader('Seg');
          for (final f
              in _fonts[loc] ??
                  ['segoeui.ttf', 'seguisb.ttf', 'segoeuib.ttf']) {
            font.addFont(
              Future.value(
                ByteData.sublistView(
                  File('C:/Windows/Fonts/$f').readAsBytesSync(),
                ),
              ),
            );
          }
          await font.load();
        });
      }

      final extra = File('test/store_slogans.json').existsSync()
          ? (jsonDecode(File('test/store_slogans.json').readAsStringSync())
                    as Map)[loc]
                as Map?
          : null;
      final (a, b) =
          _slogan[loc] ?? (extra!['a'] as String, extra['b'] as String);
      const white = Color(0xFFFFFFFF);
      final rtl = _rtl.contains(loc);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Positioned.fill(child: Image.memory(bg, fit: BoxFit.fill)),
              Positioned(
                left: 425,
                right: 44,
                top: 136,
                child: DefaultTextStyle(
                  style: const TextStyle(fontFamily: 'Seg', color: white),
                  child: Column(
                    crossAxisAlignment: rtl
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NShoptor',
                        style: TextStyle(
                          fontSize: 76,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (final line in [a, b])
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            line,
                            textDirection: rtl
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 32,
                              height: 1.5,
                              color: Color(0xF2FFFFFF),
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x3310B981),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color(0xA6A7F3D0),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            _promoLabel(loc),
                            textDirection: rtl
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              color: Color(0xFFF0FDF4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      await tester.runAsync(
        () =>
            precacheImage(MemoryImage(bg), tester.element(find.byType(Stack))),
      );
      await tester.pump();
      await expectLater(
        find.byType(Stack),
        matchesGoldenFile('$outDir/featureGraphic.png'),
      );
    });
  }
}

String _promoLabel(String loc) {
  final parts = loc.split(RegExp('[-_]'));
  final lang = switch (parts.first) {
    'iw' => 'he',
    'in' => 'id',
    'no' => 'nb',
    final code => code,
  };
  final second = parts.length > 1 ? parts[1] : null;
  final script = second != null && second.length == 4 ? second : null;
  final country = switch ((parts.length > 1 ? parts.last : null)) {
    final s? when s.length == 2 || s.length == 3 => s,
    'CN' => 'CN',
    'TW' => 'TW',
    _ => null,
  };
  final desired = Locale.fromSubtags(
    languageCode: lang,
    scriptCode: script ??
        switch ((lang, country)) {
          ('zh', 'TW' || 'HK') => 'Hant',
          ('zh', 'CN') => 'Hans',
          _ => null,
        },
    countryCode: country,
  );
  final resolved = basicLocaleListResolution(
    [desired],
    AppLocalizations.supportedLocales,
  );
  return lookupAppLocalizations(resolved).homeProPromoTitle;
}
