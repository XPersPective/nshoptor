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

  testWidgets('assistant visibility never adds a duplicate home tools menu', (
    tester,
  ) async {
    AssistantPrefs.set(false);
    await tester.pumpWidget(
      NShoptorApp(db: db, fixedLocale: const Locale('tr')),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('assistant_bubble')), findsNothing);
    expect(find.byKey(const Key('lists_tools_button')), findsNothing);
    AssistantPrefs.set(true);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('assistant_bubble')), findsNothing);
    expect(find.byKey(const Key('lists_tools_button')), findsNothing);
    expect(find.byKey(const Key('lists_new_list_button')), findsOneWidget);
    expect(find.byKey(const Key('lists_receipt_button')), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('standalone assistant still exposes its supported actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      NShoptorApp(db: db, fixedLocale: const Locale('tr')),
    );
    await tester.pumpAndSettle();
    final context = tester.element(
      find.byKey(const Key('lists_new_list_button')),
    );
    final result = showModalBottomSheet<AssistantChoice>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const AssistantSheet(),
    );
    await tester.pumpAndSettle();
    for (final action in AssistantAction.values) {
      expect(find.byKey(Key('assistant_${action.name}')), findsOneWidget);
    }
    await tester.tap(find.byKey(const Key('assistant_newList')));
    await tester.pumpAndSettle();
    expect((await result)?.action, AssistantAction.newList);
    await dispose(tester);
  });
}
