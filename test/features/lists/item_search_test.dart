import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/list_status.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    if (!const bool.fromEnvironment('CAPTURE_SEARCH')) return;
    final fonts = FontLoader('Roboto')
      ..addFont(
        Future.value(
          ByteData.sublistView(
            File('C:/Windows/Fonts/segoeui.ttf').readAsBytesSync(),
          ),
        ),
      );
    final icons = FontLoader('MaterialIcons')
      ..addFont(
        Future.value(
          ByteData.sublistView(
            File(
              'C:/flutter/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
            ).readAsBytesSync(),
          ),
        ),
      );
    await fonts.load();
    await icons.load();
  });
  late AppDatabase db;
  late ListRepository lists;
  late int listId;
  late List<int> ids;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    lists = ListRepository(db);
    listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    ids = [];
    for (final name in ['İncir', 'Ispanak', 'Süt']) {
      ids.add(
        await ItemRepository(db).addItem(
          listId: listId,
          name: name,
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'piece',
          priceIsUnitPrice: false,
          price: DecimalFixed.fromInt(10),
        ),
      );
    }
  });
  Future<void> open(
    WidgetTester tester, {
    String locale = 'tr',
    bool dark = false,
    double scale = 1,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: dark ? AppTheme.dark() : AppTheme.light(),
        locale: Locale(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: RepaintBoundary(
          key: const Key('search_capture'),
          child: ListDetailScreen(
            db: db,
            listRepository: lists,
            listId: listId,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
    await tester.binding.setSurfaceSize(null);
  }

  Future<void> buy(int? id, String name) async {
    await ShoppingRepository(db).recordPurchase(
      listId: listId,
      plannedItemId: id,
      name: name,
      normalizedName: name.toLowerCase(),
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      unitPrice: DecimalFixed.fromInt(0),
    );
  }

  Finder row(int index) => find.byKey(Key('detail_item_${ids[index]}'));
  final search = find.byKey(const Key('detail_item_search'));

  Future<void> capture(WidgetTester tester, String name) async {
    if (!const bool.fromEnvironment('CAPTURE_SEARCH')) return;
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(const Key('search_capture')),
    );
    await tester.runAsync(() async {
      final image = await boundary.toImage(pixelRatio: 1);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final dir = Directory('artifacts/qa/PB-134')..createSync(recursive: true);
      File('${dir.path}/$name.png')
          .writeAsBytesSync(bytes!.buffer.asUint8List());
      image.dispose();
    });
  }

  testWidgets(
    'zero market price moves below pending; clearing restores saved order and reopen',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 1100));
      await open(tester);
      expect(tester.testTextInput.isVisible, isFalse);
      await buy(ids[0], 'İncir');
      await tester.pumpAndSettle();
      expect(
        tester.getTopLeft(row(1)).dy,
        lessThan(tester.getTopLeft(row(0)).dy),
      );
      expect(
        tester.getTopLeft(row(2)).dy,
        lessThan(tester.getTopLeft(row(0)).dy),
      );
      expect(
        tester
            .widget<Checkbox>(find.byKey(Key('detail_check_${ids[0]}')))
            .value,
        isTrue,
      );
      await ShoppingRepository(db).removePurchases(ids[0]);
      await tester.pumpAndSettle();
      expect(
        tester.getTopLeft(row(0)).dy,
        lessThan(tester.getTopLeft(row(1)).dy),
      );
      await buy(ids[0], 'İncir');
      await tester.pumpWidget(const SizedBox.shrink());
      await open(tester);
      expect(
        tester.getTopLeft(row(2)).dy,
        lessThan(tester.getTopLeft(row(0)).dy),
      );
      await close(tester);
    },
  );

  testWidgets(
    'search covers planned and unplanned, keeps totals and protects full reorder',
    (tester) async {
      await open(tester);
      await buy(null, 'İrmik');
      await tester.pumpAndSettle();
      final before = await db.select(db.plannedItems).get();
      await tester.enterText(search, 'incir');
      await tester.pumpAndSettle();
      expect(row(0), findsOneWidget);
      expect(row(1), findsNothing);
      expect(find.byType(ReorderableDelayedDragStartListener), findsNothing);
      final reorder = tester.widget<ReorderableListView>(
        find.byType(ReorderableListView),
      );
      reorder.onReorderItem!(0, 0);
      await tester.pumpAndSettle();
      expect(
        (await db.select(db.plannedItems).get()).map((item) => item.sortOrder),
        before.map((item) => item.sortOrder),
      );
      expect(find.textContaining(RegExp(r'30[.,]00')), findsWidgets);
      await tester.enterText(search, 'ıspanak');
      await tester.pumpAndSettle();
      expect(row(1), findsOneWidget);
      expect(row(0), findsNothing);
      await tester.enterText(search, 'irmik');
      await tester.pumpAndSettle();
      expect(find.text('İrmik'), findsOneWidget);
      expect(row(0), findsNothing);
      await tester.enterText(search, 'xyz');
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('detail_search_reset')), findsOneWidget);
      await tester.tap(find.byKey(const Key('detail_search_clear')));
      await tester.pumpAndSettle();
      expect(row(0), findsOneWidget);
      expect(row(1), findsOneWidget);
      expect(await db.select(db.purchaseEntries).get(), hasLength(1));
      await close(tester);
    },
  );

  testWidgets(
    'manual reorder persists all IDs within groups and rejects crossing',
    (tester) async {
      await buy(ids[0], 'İncir');
      await open(tester);
      var reorder = tester.widget<ReorderableListView>(
        find.byType(ReorderableListView),
      );
      reorder.onReorderItem!(0, 1);
      await tester.pumpAndSettle();
      var saved = await db.select(db.plannedItems).get();
      saved.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      expect(saved.map((item) => item.name), ['Süt', 'Ispanak', 'İncir']);
      expect(saved.map((item) => item.id).toSet(), ids.toSet());
      reorder = tester.widget<ReorderableListView>(
        find.byType(ReorderableListView),
      );
      reorder.onReorderItem!(2, 0);
      await tester.pumpAndSettle();
      saved = await db.select(db.plannedItems).get();
      saved.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      expect(saved.map((item) => item.name), ['Süt', 'Ispanak', 'İncir']);
      await close(tester);
    },
  );

  testWidgets('read-only completed lists remain searchable', (tester) async {
    await lists.changeStatus(listId, ListStatus.planned);
    await lists.changeStatus(listId, ListStatus.shopping);
    await lists.changeStatus(listId, ListStatus.completed);
    await open(tester);
    await tester.enterText(search, 'süt');
    await tester.pumpAndSettle();
    expect(row(2), findsOneWidget);
    expect(row(0), findsNothing);
    expect(find.byKey(const Key('detail_quick_entry')), findsNothing);
    expect(
      tester
          .widget<Checkbox>(find.byKey(Key('detail_check_${ids[2]}')))
          .onChanged,
      isNull,
    );
    await close(tester);
  });

  for (final config in [
    ('tr', false, 412.0, 1.0),
    ('tr', true, 412.0, 1.0),
    ('ar', true, 320.0, 2.0),
  ]) {
    testWidgets(
      'search layout and semantics ${config.$1}/${config.$2}/${config.$3}',
      (tester) async {
        await tester.binding.setSurfaceSize(Size(config.$3, 1000));
        final semantics = tester.ensureSemantics();
        await buy(ids[0], 'İncir');
        await open(
          tester,
          locale: config.$1,
          dark: config.$2,
          scale: config.$4,
        );
        await tester.enterText(search, 'xyz');
        await tester.pumpAndSettle();
        final context = tester.element(search);
        final label = MaterialLocalizations.of(context).searchFieldLabel;
        expect(
          find.bySemanticsLabel(RegExp(RegExp.escape(label))),
          findsWidgets,
        );
        final clear = find.byKey(const Key('detail_search_clear'));
        expect(tester.getSize(clear).height, greaterThanOrEqualTo(48));
        expect(tester.getSize(clear).width, greaterThanOrEqualTo(48));
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await capture(tester, '${config.$1}-${config.$2}-${config.$3}-empty');
        await tester.tap(find.byKey(const Key('detail_search_reset')));
        await tester.pumpAndSettle();
        expect(row(0), findsOneWidget);
        expect(tester.takeException(), isNull);
        await capture(
          tester,
          '${config.$1}-${config.$2}-${config.$3}-populated',
        );
        semantics.dispose();
        await close(tester);
      },
    );
  }
}
