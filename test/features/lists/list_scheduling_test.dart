import 'dart:io';

import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/app/app_defaults.dart';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/list_scheduling.dart';
import 'package:nshoptor/features/lists/lists_screen.dart';

import 'package:nshoptor/features/voice_input/ai_list_parser.dart';
import 'package:nshoptor/features/voice_input/list_draft_sheet.dart';
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';

class _ScheduleParser extends AiListParser {
  _ScheduleParser() : super(localeCode: 'tr');
  @override
  Future<ListDraft> parse(String text) async => const ListDraft([
    ParsedItemCandidate(name: 'Elma', rawText: 'elma'),
  ], fromAi: false);
}

Widget app(Widget child) => MaterialApp(
  locale: const Locale('tr'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: Scaffold(body: child),
);

void main() {
  setUp(() => AppDefaults.attach(SettingsStore()));
  test('sort preference reloads from store and rejects invalid modes', () {
    final store = SettingsStore();
    AppDefaults.attach(store);
    expect(AppDefaults.listSort(), 'date');
    AppDefaults.setListSort('title');
    AppDefaults.attach(store);
    expect(AppDefaults.listSort(), 'title');
    AppDefaults.setListSort('invalid');
    expect(AppDefaults.listSort(), 'date');
  });

  testWidgets('editing an existing list clears persisted shopping date', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final repo = ListRepository(db);
    final id = await repo.createList(
      title: 'Pazar',
      currencyCode: 'TRY',
      plannedAt: DateTime.utc(2020),
    );
    final existing = await repo.getById(id);
    await tester.pumpWidget(
      app(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => showListEditor(context, repo, existing: existing),
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('shopping_date_clear')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('list_save_button')));
    await tester.pumpAndSettle();
    expect((await repo.getById(id)).plannedAt, isNull);
    expect((await repo.getById(id)).createdAt, existing.createdAt);
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  });
  testWidgets(
    'voice-created draft carries optional shopping date only for list creation',
    (tester) async {
      ListDraft? approved;
      await tester.pumpWidget(
        app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => ListDraftSheet(
                  parser: _ScheduleParser(),
                  initialText: 'elma',
                  onApprove: (draft) async {
                    approved = draft;
                  },
                ),
              ),
              child: const Text('Open draft'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open draft'));
      await tester.pumpAndSettle();
      final schedule = DateTime.utc(2030, 4, 5, 14, 30);
      tester
          .widget<ShoppingDateField>(find.byType(ShoppingDateField))
          .onChanged(schedule);
      await tester.pump();
      await tester.ensureVisible(find.byKey(const Key('draft_add_button')));
      await tester.tap(find.byKey(const Key('draft_add_button')));
      await tester.pumpAndSettle();
      expect(approved?.plannedAt, schedule);
      await tester.pumpWidget(
        app(
          ListDraftSheet(
            key: const Key('existing_list'),
            parser: _ScheduleParser(),
            initialText: 'elma',
            allowTitle: false,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ShoppingDateField), findsNothing);
    },
  );

  testWidgets(
    'shopping date field fits narrow screens with large text in both themes',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      for (final brightness in Brightness.values) {
        await tester.pumpWidget(
          app(
            Theme(
              data: ThemeData(brightness: brightness),
              child: MediaQuery(
                data: const MediaQueryData(
                  size: Size(320, 640),
                  textScaler: TextScaler.linear(2),
                ),
                child: Center(
                  child: ShoppingDateField(
                    value: DateTime(2030, 12, 31, 23, 59),
                    onChanged: (_) {},
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byKey(const Key('shopping_date_clear')), findsOneWidget);
      }
    },
  );

  test('shopping dates persist on disk, default order ignores manual order; duplicate preserves date', () async {
    final dir = await Directory.systemTemp.createTemp('enshop_schedule_');
    final file = File('${dir.path}/lists.sqlite');
    var db = AppDatabase(NativeDatabase(file));
    try {
      var repo = ListRepository(db);
      final undated = await repo.createList(
        title: 'Tarihsiz',
        currencyCode: 'TRY',
      );
      final later = await repo.createList(
        title: 'Sonra',
        currencyCode: 'TRY',
        plannedAt: DateTime.utc(2030, 8, 2, 18, 30),
      );
      final overdue = await repo.createList(
        title: 'Geçmiş',
        currencyCode: 'TRY',
        plannedAt: DateTime.utc(2020, 1, 2, 8),
      );
      await repo.reorderLists([undated, later, overdue]);
      expect((await repo.watchAll().first).map((e) => e.id), [
        overdue,
        later,
        undated,
      ]);
      final copied = await repo.duplicateList(later);
      expect(
        (await repo.getById(copied)).plannedAt?.toUtc(),
        DateTime.utc(2030, 8, 2, 18, 30),
      );
      await db.close();
      db = AppDatabase(NativeDatabase(file));
      repo = ListRepository(db);
      expect(
        (await repo.getById(later)).plannedAt?.toUtc(),
        DateTime.utc(2030, 8, 2, 18, 30),
      );
      expect(
        (await repo.getById(overdue)).plannedAt?.toUtc(),
        DateTime.utc(2020, 1, 2, 8),
      );
      await repo.updatePlannedAt(later, null);
      expect((await repo.getById(later)).plannedAt, isNull);
    } finally {
      await db.close();
      await dir.delete(recursive: true);
    }
  });

  test('Turkish alphabetical order, generated title fallback and deterministic ties', () async {
    final db = AppDatabase(NativeDatabase.memory());
    try {
      final repo = ListRepository(db);
      for (final title in [
        'İzmir',
        'Isparta',
        'Şehir',
        'Samsun',
        'Çarşı',
        'Ceviz',
      ]) {
        await repo.createList(title: title, currencyCode: 'TRY');
      }
      await repo.createList(generatedTitle: 'Ankara', currencyCode: 'TRY');
      final rows = await repo.watchAll().first;
      expect(
        sortShoppingLists(
          rows,
          mode: ListSortMode.title,
        ).map(shoppingListTitle),
        ['Ankara', 'Ceviz', 'Çarşı', 'Isparta', 'İzmir', 'Samsun', 'Şehir'],
      );
      final same = DateTime.utc(2030);
      final tied = rows
          .take(2)
          .map((r) => r.copyWith(createdAt: same))
          .toList()
          .reversed;
      expect(
        sortShoppingLists(tied).map((r) => r.id),
        [rows[0].id, rows[1].id]..sort(),
      );
      expect(ListSortMode.fromCode('invalid'), ListSortMode.date);
    } finally {
      await db.close();
    }
  });

  testWidgets(
    'shopping date cancels preserve value, selection commits after time, clear removes',
    (tester) async {
      DateTime? value = DateTime(2020, 1, 2, 8).toUtc();
      final changes = <DateTime?>[];
      await tester.pumpWidget(
        app(
          StatefulBuilder(
            builder: (context, setState) => ShoppingDateField(
              value: value,
              onChanged: (next) {
                changes.add(next);
                setState(() => value = next);
              },
            ),
          ),
        ),
      );
      final material = MaterialLocalizations.of(
        tester.element(find.byType(ShoppingDateField)),
      );
      await tester.tap(find.byKey(const Key('shopping_date_pick')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(material.cancelButtonLabel));
      await tester.pumpAndSettle();
      expect(changes, isEmpty);
      await tester.tap(find.byKey(const Key('shopping_date_pick')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(material.okButtonLabel));
      await tester.pumpAndSettle();
      expect(find.byType(TimePickerDialog), findsOneWidget);
      await tester.tap(find.text(material.cancelButtonLabel));
      await tester.pumpAndSettle();
      expect(changes, isEmpty);
      await tester.tap(find.byKey(const Key('shopping_date_pick')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(material.okButtonLabel));
      await tester.pumpAndSettle();
      await tester.tap(find.text(material.okButtonLabel));
      await tester.pumpAndSettle();
      expect(changes.single, DateTime(2020, 1, 2, 8).toUtc());
      await tester.tap(find.byKey(const Key('shopping_date_clear')));
      await tester.pumpAndSettle();
      expect(changes.last, isNull);
      expect(find.byKey(const Key('shopping_date_clear')), findsNothing);
      expect(find.text('Alışveriş tarihi'), findsOneWidget);
      expect(find.text('Tarih belirlenmedi'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'sort button cycles date, A-Z, manual, date and persists its current mode',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = ListRepository(db);
      await repo.createList(title: 'A tarihsiz', currencyCode: 'TRY');
      await repo.createList(
        title: 'Z tarihli',
        currencyCode: 'TRY',
        plannedAt: DateTime.utc(2020),
      );
      await tester.pumpWidget(app(ListsScreen(repository: repo)));
      await tester.pumpAndSettle();
      expect(
        tester.getTopLeft(find.text('Z tarihli')).dy,
        lessThan(tester.getTopLeft(find.text('A tarihsiz')).dy),
      );
      expect(find.byType(ReorderableListView), findsNothing);
      await tester.tap(find.byKey(const Key('lists_sort_button')));
      await tester.pumpAndSettle();
      expect(
        tester.getTopLeft(find.text('A tarihsiz')).dy,
        lessThan(tester.getTopLeft(find.text('Z tarihli')).dy),
      );
      await tester.tap(find.byKey(const Key('lists_sort_button')));
      await tester.pumpAndSettle();
      expect(find.byType(ReorderableListView), findsOneWidget);
      expect(AppDefaults.listSort(), 'manual');
      // Recreate the screen with the same store to prove selected-mode reload.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      await tester.pumpWidget(app(ListsScreen(repository: repo)));
      await tester.pumpAndSettle();
      expect(find.byType(ReorderableListView), findsOneWidget);
      expect(
        tester
            .widget<IconButton>(find.byKey(const Key('lists_sort_button')))
            .tooltip,
        contains('Elle'),
      );
      await tester.tap(find.byKey(const Key('lists_sort_button')));
      await tester.pumpAndSettle();
      expect(AppDefaults.listSort(), 'date');
      expect(find.byType(ReorderableListView), findsNothing);
      expect(
        tester.getTopLeft(find.text('Z tarihli')).dy,
        lessThan(tester.getTopLeft(find.text('A tarihsiz')).dy),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    },
  );
}
