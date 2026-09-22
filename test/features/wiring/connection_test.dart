import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/list_status.dart';
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

  Future<int> addItem(int listId, String name, {int? productId}) => db
      .into(db.plannedItems)
      .insert(
        PlannedItemsCompanion.insert(
          listId: listId,
          productId: Value(productId),
          name: name,
          normalizedName: name.toLowerCase(),
          plannedQuantity: '1',
          plannedUnitCode: 'adet',
          pricingInputMode: 'unitPrice',
          plannedUnitPrice: const Value('10'),
        ),
      );

  Widget detail(int listId, {OcrTextSource? ocr, SpeechService? speech}) =>
      ListDetailScreen(
        db: db,
        listRepository: listRepo,
        listId: listId,
        ocrSource: ocr,
        speechService: speech,
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
    expect(find.byKey(const Key('detail_start_shopping')), findsOneWidget);
    expect(find.text('Süt'), findsOneWidget); // plan kopyalandı
    expect(await TemplateRepository(db).templateIds(), [src]);

    await disposeApp(tester);
  });

  testWidgets('ürün formu: ses önizlemesi form alanlarını doldurur', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await listRepo.createList(
      title: 'Market',
      currencyCode: 'TRY',
    );

    await tester.pumpWidget(
      app(detail(listId, speech: FakeSpeechService(available: false))),
    );
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_add_item_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('item_voice_button')));
    await settle(tester);

    // Servis yok → manuel geri dönüş mesajı; transcript elle yazılabilir.
    await tester.tap(find.byKey(const Key('voice_mic_button')));
    await settle(tester);
    expect(find.byKey(const Key('voice_unavailable')), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('voice_transcript_field')),
      'Üç tane süt, tanesi otuz iki lira',
    );
    await settle(tester);
    await tester.tap(find.byKey(const Key('voice_parse_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('voice_confirm_button')));
    await settle(tester);

    final name = tester.widget<TextField>(
      find.byKey(const Key('item_name_field')),
    );
    expect(name.controller!.text.toLowerCase(), contains('süt'));
    expect(
      await db.select(db.plannedItems).get(),
      isEmpty,
    ); // onaysız kayıt yok

    await disposeApp(tester);
  });

  testWidgets('ürün formu: raf etiketi adayı seçilince fiyat dolar', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await listRepo.createList(
      title: 'Market',
      currencyCode: 'TRY',
    );

    await tester.pumpWidget(
      app(detail(listId, ocr: _FakeOcr(['SÜT 1 LT', '₺42,90']))),
    );
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_add_item_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('item_shelf_label_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('price_candidate_0')));
    await settle(tester);

    expect(find.widgetWithText(TextField, '42.90'), findsOneWidget);

    await disposeApp(tester);
  });

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
    await tester.tap(find.byKey(const Key('detail_scan_receipt')));
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

  testWidgets('fiyat geçmişi: ürüne dokununca açılır', (tester) async {
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
    await addItem(listId, 'Domates', productId: productId);
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

    await tester.pumpWidget(app(detail(listId)));
    await settle(tester);
    await tester.tap(find.text('Domates'));
    await settle(tester);

    expect(find.textContaining('42,90'), findsOneWidget);

    await disposeApp(tester);
  });
}
