import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/assistant/assistant_bubble.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  testWidgets('kapalıyken araç yok; açıkken menüden 5 eylem', (tester) async {
    AssistantPrefs.set(false);
    await tester.pumpWidget(
      NShoptorApp(db: db, fixedLocale: const Locale('tr')),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('assistant_bubble')), findsNothing);
    await tester.tap(find.byKey(const Key('lists_tools_button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lists_tool_assistant')), findsNothing);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    AssistantPrefs.set(true);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('assistant_bubble')), findsNothing);
    await tester.tap(find.byKey(const Key('lists_tools_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('lists_tool_assistant')));
    await tester.pumpAndSettle();
    expect(find.text('Merhaba! Ne yapmak istiyorsun?'), findsOneWidget);
    for (final a in AssistantAction.values) {
      expect(find.byKey(Key('assistant_${a.name}')), findsOneWidget);
    }
    await dispose(tester);
  });
}
