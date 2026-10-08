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

const _locale = String.fromEnvironment('STORE_LOCALE');
const _out = String.fromEnvironment('STORE_OUT');

const _slogan = {
  'en': ('Plan it. Shop it. Compare it.', 'AI matches your receipt.'),
  'tr': ('Planla. Alışveriş yap. Karşılaştır.', 'Fişini yapay zeka eşleştirsin.'),
  'de': ('Planen. Einkaufen. Vergleichen.', 'KI gleicht deinen Kassenbon ab.'),
  'fr': ('Planifiez. Achetez. Comparez.', 'L’IA vérifie votre ticket.'),
  'es': ('Planifica. Compra. Compara.', 'La IA revisa tu ticket.'),
  'it': ('Pianifica. Compra. Confronta.', 'L’IA controlla lo scontrino.'),
  'pt': ('Planeie. Compre. Compare.', 'A IA confere o seu talão.'),
  'ru': ('Планируйте. Покупайте. Сравнивайте.', 'ИИ сверит ваш чек.'),
  'ar': ('خطّط. تسوّق. قارن.', 'الذكاء الاصطناعي يطابق إيصالك.'),
};

// Betiğe uygun Windows yazı tipi (store_capture_test ile aynı eşleme).
const _fonts = <String, List<String>>{
  'th': ['LeelawUI.ttf'], 'lo': ['LeelawUI.ttf'],
  'hi': ['Nirmala.ttc'], 'bn': ['Nirmala.ttc'], 'gu': ['Nirmala.ttc'], 'kn': ['Nirmala.ttc'],
  'ml': ['Nirmala.ttc'], 'mr': ['Nirmala.ttc'], 'ne': ['Nirmala.ttc'], 'pa': ['Nirmala.ttc'],
  'si': ['Nirmala.ttc'], 'ta': ['Nirmala.ttc'], 'te': ['Nirmala.ttc'],
  'ja': ['YuGothR.ttc', 'YuGothB.ttc'], 'ko': ['malgun.ttf', 'malgunbd.ttf'],
  'zh': ['msyh.ttc', 'msyhbd.ttc'], 'my': ['mmrtext.ttf', 'mmrtextb.ttf'],
};
const _rtl = {'ar', 'fa', 'he', 'ur', 'ps'};

void main() {
  if (_locale.isEmpty) return;
  testWidgets('tanıtım görseli ($_locale)', (tester) async {
    tester.view.physicalSize = const Size(1024, 500);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final bg = File('build/feature_bg.png').readAsBytesSync();
    await tester.runAsync(() async {
      final font = FontLoader('Seg');
      for (final f in _fonts[_locale] ?? ['segoeui.ttf', 'seguisb.ttf', 'segoeuib.ttf']) {
        font.addFont(Future.value(ByteData.sublistView(File('C:/Windows/Fonts/$f').readAsBytesSync())));
      }
      await font.load();
    });

    final extra = File('test/store_slogans.json').existsSync()
        ? (jsonDecode(File('test/store_slogans.json').readAsStringSync()) as Map)[_locale] as Map?
        : null;
    final (a, b) = _slogan[_locale] ?? (extra!['a'] as String, extra['b'] as String);
    const white = Color(0xFFFFFFFF);
    final rtl = _rtl.contains(_locale);
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(children: [
        Positioned.fill(child: Image.memory(bg, fit: BoxFit.fill)),
        Positioned(
          left: 425,
          right: 44,
          top: 168,
          child: DefaultTextStyle(
            style: const TextStyle(fontFamily: 'Seg', color: white),
            child: Column(
              crossAxisAlignment: rtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                const Text('NShoptor', style: TextStyle(fontSize: 76, fontWeight: FontWeight.w700, height: 1.1)),
                const SizedBox(height: 8),
                for (final line in [a, b])
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(line,
                        textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
                        style: const TextStyle(fontSize: 32, height: 1.5, color: Color(0xF2FFFFFF))),
                  ),
              ],
            ),
          ),
        ),
      ]),
    ));
    await tester.runAsync(() => precacheImage(MemoryImage(bg), tester.element(find.byType(Stack))));
    await tester.pump();
    await expectLater(find.byType(Stack), matchesGoldenFile('$_out/featureGraphic.png'));
  });
}
