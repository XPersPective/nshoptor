import 'package:nshoptor/core/money/format_locale.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/features/lists/item_repository.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/list_status.dart';
import 'package:nshoptor/features/lists/reminders/reminder_scheduler.dart';
import 'package:nshoptor/features/lists/templates/template_repository.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/voice_input/voice_input_service.dart';

/// PB-033: tamamlanmış mantığın ekran bağlantıları.
class _FakeOcr implements OcrTextSource {
  _FakeOcr(this.lines);
  final List<String> lines;

  @override
  Future<OcrScanResult> scan(String imagePath) async =>
      OcrScanResult(lines: [for (final t in lines) OcrLine(text: t)]);
}

void main() {
  setUp(() => AppFormatLocale.attach('tr'));
  tearDown(AppFormatLocale.attachReset);
  late AppDatabase db;
  late ListRepository listRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    listRepo = ListRepository(db);
  });

  Widget app(Widget home) => MaterialApp(
    locale: const Locale('tr'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );

  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  Future<int> addItem(
    int listId,
    String name, {
    int? productId,
    String unitCode = 'adet',
  }) => db
      .into(db.plannedItems)
      .insert(
        PlannedItemsCompanion.insert(
          listId: listId,
          productId: Value(productId),
          name: name,
          normalizedName: name.toLowerCase(),
          plannedQuantity: '1',
          plannedUnitCode: unitCode,
          pricingInputMode: 'unitPrice',
          plannedUnitPrice: const Value('10'),
        ),
      );

  Widget detail(
    int listId, {
    OcrTextSource? ocr,
    SpeechService? speech,
    ReminderScheduler? scheduler,
  }) => ListDetailScreen(
    db: db,
    listRepository: listRepo,
    listId: listId,
    ocrSource: ocr,
    speechService: speech,
    reminderScheduler: scheduler,
    pickImage: () async => 'fake.jpg',
  );

  testWidgets('ana ekran: tamamlanan listeden plan → şablon kartı', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final src = await listRepo.createList(
      title: 'Geçen hafta',
      currencyCode: 'TRY',
    );
    await addItem(src, 'Süt');
    for (final s in [
      ListStatus.planned,
      ListStatus.shopping,
      ListStatus.completed,
    ]) {
      await listRepo.changeStatus(src, s);
    }

    await tester.pumpWidget(
      app(
        HomeScreen(
          db: db,
          listRepository: listRepo,
          onOpenList: (_) {},
          onNewList: () {},
        ),
      ),
    );
    await settle(tester);

    await tester.tap(find.byKey(Key('home_plan_from_$src')));
    await settle(tester);
    expect(find.byKey(const Key('detail_more_menu')), findsOneWidget);
    expect(find.text('Süt'), findsOneWidget); // plan kopyalandı
    expect(await TemplateRepository(db).templateIds(), [src]);

    await disposeApp(tester);
  });

  testWidgets('tek mikrofon: hızlı ekleme sahibi olarak kalır', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await listRepo.createList(
      title: 'Market',
      currencyCode: 'TRY',
    );
    await addItem(listId, 'Süt');

    await tester.pumpWidget(
      app(detail(listId, speech: FakeSpeechService(available: false))),
    );
    await settle(tester);
    await tester.tap(find.text('Süt'));
    await settle(tester);
    expect(find.byKey(const Key('item_voice_button')), findsNothing);
    expect(find.byKey(const Key('detail_quick_entry')), findsOneWidget);
    expect(find.byKey(const Key('detail_quick_list')), findsOneWidget);
    expect(find.byKey(const Key('voice_mic_button')), findsNothing);
    expect(await db.select(db.plannedItems).get(), hasLength(1));

    await disposeApp(tester);
  });

  testWidgets('ürün formu: kamera kontrolü görünmez, fiyat elle girilir', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await listRepo.createList(
      title: 'Market',
      currencyCode: 'TRY',
    );
    await addItem(listId, 'Süt');

    await tester.pumpWidget(
      app(detail(listId, ocr: _FakeOcr(['SÜT 1 LT', '₺42,90']))),
    );
    await settle(tester);
    await tester.tap(find.text('Süt'));
    await settle(tester);
    expect(find.byKey(const Key('item_shelf_label_button')), findsNothing);
    await tester.enterText(
      find.byKey(const Key('item_actual_price_field')),
      '42,90',
    );

    expect(
      tester
          .widget<TextField>(find.byKey(const Key('item_actual_price_field')))
          .controller!
          .text,
      '42,90',
    );
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('item_name_field')))
          .controller!
          .text,
      'Süt',
    );
    expect(await db.select(db.plannedItems).get(), hasLength(1));
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('item_price_field')))
          .controller!
          .text,
      isNotEmpty,
    );

    await disposeApp(tester);
  });

  testWidgets('kamera kontrolü yok, manuel fiyat girişi alanları korur', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final listId = await listRepo.createList(
      title: 'Market',
      currencyCode: 'TRY',
    );
    await addItem(listId, 'Manual milk');
    await tester.pumpWidget(
      app(ListDetailScreen(db: db, listRepository: listRepo, listId: listId)),
    );
    await settle(tester);
    await tester.tap(find.text('Manual milk'));
    await settle(tester);
    await tester.enterText(
      find.byKey(const Key('item_name_field')),
      'Manual milk',
    );
    await tester.enterText(find.byKey(const Key('item_price_field')), '20');
    expect(find.byKey(const Key('item_shelf_label_button')), findsNothing);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('item_name_field')))
          .controller!
          .text,
      'Manual milk',
    );
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('item_price_field')))
          .controller!
          .text,
      '20',
    );
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await tester.enterText(
      find.byKey(const Key('item_actual_price_field')),
      '25',
    );
    await tester.ensureVisible(find.byKey(const Key('item_save_button')));
    await tester.tap(find.byKey(const Key('item_save_button')));
    await settle(tester);
    expect(
      (await db.select(db.purchaseEntries).get())
          .single
          .actualLineTotalMinorUnits,
      2500,
    );
    await disposeApp(tester);
  });

  testWidgets(
    'row edit preserves estimate and commits the chosen kg unit price',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final listId = await listRepo.createList(
        title: 'Market',
        currencyCode: 'TRY',
      );
      final id = await ItemRepository(db).addItem(
        listId: listId,
        name: 'Old apple',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'kilogram',
        priceIsUnitPrice: true,
        price: DecimalFixed.fromInt(50),
      );
      await tester.pumpWidget(app(detail(listId)));
      await settle(tester);
      await tester.tap(find.text('Old apple'));
      await settle(tester);
      expect(find.byKey(const Key('item_shelf_label_button')), findsNothing);
      await tester.enterText(
        find.byKey(const Key('item_actual_price_field')),
        '40,00',
      );
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('item_name_field')))
            .controller!
            .text,
        'Old apple',
      );
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('item_actual_price_field')))
            .controller!
            .text,
        '40,00',
      );
      await tester.tap(find.byKey(const Key('item_details_expand')));
      await tester.pumpAndSettle();
      // Details holds only brand, category and note; the price is per kg.
      expect(find.byKey(const Key('item_brand_field')), findsOneWidget);
      expect(find.byKey(const Key('item_note_field')), findsOneWidget);
      expect(find.byKey(const Key('item_actual_quantity_field')), findsNothing);
      expect(find.byKey(const Key('item_discount_field')), findsNothing);
      expect(find.text('Çarşıdaki Fiyat / kg'), findsOneWidget);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      await tester.ensureVisible(find.byKey(const Key('item_save_button')));
      await tester.tap(find.byKey(const Key('item_save_button')));
      await settle(tester);
      final item = (await ItemRepository(db).getItems(listId)).single;
      expect(item.id, id);
      expect(item.plannedLineTotalMinorUnits, 10000);
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualUnitCode, 'kilogram');
      expect(entry.actualQuantity, '2');
      expect(entry.actualLineTotalMinorUnits, 8000);
      await disposeApp(tester);
    },
  );

  testWidgets(
    'home receipt opens standalone preview; cancel and empty OCR leave no list',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final ocr = _FakeOcr(['MILK 10,00']);
      await tester.pumpWidget(
        app(
          HomeShell(
            db: db,
            listRepository: listRepo,
            pickImage: () async => 'fake.jpg',
            ocrSource: ocr,
          ),
        ),
      );
      await settle(tester);
      Future<void> scan() async {
        await tester.tap(find.byKey(const Key('lists_tools_button')));
        await settle(tester);
        await tester.tap(find.byKey(const Key('lists_tool_receipt')));
        await settle(tester);
      }

      await scan();
      expect(find.byKey(const Key('receipt_commit_button')), findsOneWidget);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      await tester.binding.handlePopRoute();
      await settle(tester);
      await scan();
      await tester.tap(find.byKey(const Key('receipt_cancel')));
      await settle(tester);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      ocr.lines.clear();
      await scan();
      expect(find.byKey(const Key('receipt_commit_button')), findsNothing);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      await disposeApp(tester);
    },
  );

  testWidgets('fiş: tarama → inceleme; onaya dek DB yazımı yok', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await listRepo.createList(
      title: 'Market',
      currencyCode: 'TRY',
    );
    final ekmekId = await addItem(listId, 'Ekmek');

    await tester.pumpWidget(
      app(
        detail(
          listId,
          ocr: _FakeOcr(['MERK MARKET', 'EKMEK 15,00', 'TOPLAM 15,00']),
        ),
      ),
    );
    await settle(tester);
    // Fiş tarama composer'da görünür: menüye gerek yok.
    await tester.tap(find.byKey(const Key('detail_receipt_button')));
    await settle(tester);
    expect(find.text('EKMEK'), findsOneWidget);

    // Satırı planlanan ürüne bağla (bağlama kabul de eder).
    await tester.tap(find.byKey(const Key('receipt_line_0')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('receipt_action_link')));
    await settle(tester);
    await tester.tap(find.text('Ekmek').last);
    await settle(tester);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);

    await tester.tap(find.byKey(const Key('receipt_commit_button')));
    await settle(tester);
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries.single.plannedItemId, ekmekId);
    expect(entries.single.actualLineTotalMinorUnits, 1500);

    await disposeApp(tester);
  });

  testWidgets('fiyat geçmişi: ürün formundan açılır', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await listRepo.createList(
      title: 'Market',
      currencyCode: 'TRY',
    );
    final productId = await db
        .into(db.productMemory)
        .insert(
          ProductMemoryCompanion.insert(
            canonicalName: 'Domates',
            normalizedName: 'domates',
          ),
        );
    await addItem(
      listId,
      'Domates',
      productId: productId,
      unitCode: 'kilogram',
    );
    await db
        .into(db.priceObservations)
        .insert(
          PriceObservationsCompanion.insert(
            productId: Value(productId),
            quantity: '1',
            unitCode: 'kilogram',
            unitPrice: '42.90',
            lineTotalMinorUnits: 4290,
            currencyCode: 'TRY',
            source: 'manual',
          ),
        );
    await db
        .into(db.priceObservations)
        .insert(
          PriceObservationsCompanion.insert(
            productId: Value(productId),
            quantity: '1',
            unitCode: 'kilogram',
            unitPrice: '2.00',
            lineTotalMinorUnits: 200,
            currencyCode: 'EUR',
            source: 'manual',
          ),
        );
    await db
        .into(db.priceObservations)
        .insert(
          PriceObservationsCompanion.insert(
            productId: Value(productId),
            quantity: '1',
            unitCode: 'adet',
            unitPrice: '99.00',
            lineTotalMinorUnits: 9900,
            currencyCode: 'TRY',
            source: 'manual',
          ),
        );

    await tester.pumpWidget(app(detail(listId)));
    await settle(tester);
    // Price history lives in the item form (rows have no menu).
    await tester.tap(find.text('Domates'));
    await settle(tester);
    await tester.tap(find.byKey(const Key('item_details_expand')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('item_price_history')));
    await tester.tap(find.byKey(const Key('item_price_history')));
    await settle(tester);

    // Both the formatted chart range and the single observation show money.
    expect(find.textContaining('42,90'), findsNWidgets(2));
    expect(find.byType(Card), findsNWidgets(2));
    expect(find.textContaining('2,00'), findsNothing);
    expect(find.textContaining('99,00'), findsNothing);

    await disposeApp(tester);
  });

  testWidgets(
    'liste satırı: tahmini hep görünür; gerçek fiyat satırdan girilince fark anında görünür',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      final listId = await listRepo.createList(
        title: 'Market',
        currencyCode: 'TRY',
      );
      await ItemRepository(db).addItem(
        listId: listId,
        name: 'Elma',
        quantity: DecimalFixed.fromInt(1),
        unitCode: 'adet',
        priceIsUnitPrice: true,
        price: DecimalFixed.parse('10'),
      ); // tahmini 10,00

      await tester.pumpWidget(app(detail(listId)));
      await settle(tester);
      // Tahmini satırda ve toplamda; gerçek henüz yok.
      expect(find.byKey(const Key('price_planned')), findsOneWidget);
      expect(find.textContaining('10,00'), findsWidgets);
      expect(find.byKey(const Key('price_actual')), findsNothing);

      // Satıra dokun → gerçek fiyat gir (ayrıntı ekranına gitmeden).
      await tester.tap(find.text('Elma'));
      await settle(tester);
      await tester.enterText(
        find.byKey(const Key('item_actual_price_field')),
        '15',
      );
      await tester.tap(find.byKey(const Key('item_save_button')));
      await settle(tester);

      expect(find.byKey(const Key('price_actual')), findsOneWidget);
      expect(find.text('15,00 ₺'), findsWidgets); // gerçek (satır + toplam)
      expect(find.text('+5,00 ₺'), findsWidgets); // fark (satır + toplam)
      expect(find.byKey(const Key('detail_totals')), findsOneWidget);

      // Yeniden girmek öncekini değiştirir: çift sayılmaz.
      await tester.tap(find.text('Elma'));
      await settle(tester);
      await tester.enterText(
        find.byKey(const Key('item_actual_price_field')),
        '12',
      );
      await tester.tap(find.byKey(const Key('item_save_button')));
      await settle(tester);
      expect(find.text('12,00 ₺'), findsWidgets);
      expect(find.text('+2,00 ₺'), findsWidgets);
      expect(find.text('15,00 ₺'), findsNothing);

      await disposeApp(tester);
    },
  );

  testWidgets('hatırlatma: izin red → açıklayıcı snackbar, kurulum yok', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await listRepo.createList(
      title: 'Hatırlatmalı',
      currencyCode: 'TRY',
    );
    final scheduler = _DeniedScheduler();

    await tester.pumpWidget(app(detail(listId, scheduler: scheduler)));
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_more_menu')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_set_reminder')));
    await settle(tester);

    expect(find.textContaining('bildirim izni gerekir'), findsOneWidget);
    expect(scheduler.calls, 1);
    expect(
      tester.widget<SnackBar>(find.byType(SnackBar)).showCloseIcon,
      isTrue,
    );
    await tester.tap(find.byKey(const Key('detail_more_menu')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_set_reminder')));
    await settle(tester);
    expect(scheduler.calls, 2);
    await tester.tap(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.byType(IconButton),
      ),
    );
    await settle(tester);
    await tester.pump(const Duration(seconds: 5));
    expect(
      find.byType(SnackBar),
      findsNothing,
    ); // no previous notice remains queued

    await disposeApp(tester);
  });
}

/// İzin hep reddedilen sahte zamanlayıcı.
class _DeniedScheduler implements ReminderScheduler {
  int calls = 0;

  @override
  Future<bool> ensurePermission() async {
    calls++;
    return false;
  }

  @override
  Future<void> schedule(ScheduledReminder reminder) async {}

  @override
  Future<void> cancel(int id) async {}
}
