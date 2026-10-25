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

  testWidgets('uygulama Türkçe liste eylemleriyle açılır', (tester) async {
    await tester.pumpWidget(
      NShoptorApp(db: db, fixedLocale: const Locale('tr')),
    );
    await tester.pumpAndSettle();
    expect(find.text('Yeni liste'), findsOneWidget);
    expect(find.text('Fişten liste'), findsOneWidget);
    expect(find.text('Listeler'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('uygulama İngilizce liste eylemleriyle açılır', (tester) async {
    await tester.pumpWidget(
      NShoptorApp(db: db, fixedLocale: const Locale('en')),
    );
    await tester.pumpAndSettle();
    expect(find.text('New list'), findsOneWidget);
    expect(find.text('From receipt'), findsOneWidget);
    expect(find.text('Lists'), findsOneWidget);
    await disposeApp(tester);
  });
}
