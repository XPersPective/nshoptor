import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app.dart';

void main() {
  testWidgets('uygulama açılır; tr seçiliyken Türkçe slogan', (tester) async {
    await tester.pumpWidget(NShoptorApp(fixedLocale: const Locale('tr')));
    await tester.pump();
    expect(find.text('Evdeki hesap çarşıya uyar.'), findsOneWidget);
  });

  testWidgets('en seçiliyken İngilizce slogan', (tester) async {
    await tester.pumpWidget(NShoptorApp(fixedLocale: const Locale('en')));
    await tester.pump();
    expect(find.text('Plan at home. Shop as planned.'), findsOneWidget);
  });
}
