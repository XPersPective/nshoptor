import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/data/db/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  testWidgets('uygulama açılır; tr seçiliyken Türkçe slogan', (tester) async {
    await tester.pumpWidget(NShoptorApp(
      db: db,
      fixedLocale: const Locale('tr'),
    ));
    await tester.pump();
    expect(find.text('Evdeki hesap çarşıya uyar.'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('en seçiliyken İngilizce slogan', (tester) async {
    await tester.pumpWidget(NShoptorApp(
      db: db,
      fixedLocale: const Locale('en'),
    ));
    await tester.pump();
    expect(find.text('Plan at home. Shop as planned.'), findsOneWidget);
    await disposeApp(tester);
  });
}
