import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/reports/report_export_service.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:share_plus/share_plus.dart';

OcrScanResult _scan(List<String> rows) =>
    OcrScanResult(lines: [for (final text in rows) OcrLine(text: text)]);

ReceiptDocument _receipt({
  String store = 'ŞOK MARKETLER TİC. A.Ş.',
  String number = '000123',
  String? total = '20,00',
}) => ReceiptDocument.fromScan(
  _scan([
    store,
    'TARİH: 24.10.2026',
    'SAAT: 18:41:35',
    'FİŞ NO: $number',
    'ELMA 20,00',
    if (total != null) 'TOPLAM $total TL',
  ]),
  currencyCode: 'TRY',
);

const _print = MethodChannel('nshoptor/print');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late ListRepository lists;
  late int listId;
  late int completeId;
  late int draftId;
  late Directory dir;
  late List<ShareParams> shared;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    lists = ListRepository(db);
    listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    final controller = ReceiptReviewController(
      db: db,
      document: _receipt(),
      listId: listId,
      parseResult: ReceiptParser().parse(_scan(['X 1,00', 'TOPLAM 1,00'])),
    );
    for (var i = 0; i < controller.lines.length; i++) {
      controller.accept(i);
    }
    await controller.commit();
    controller.dispose();
    completeId = (await db.select(db.receipts).get()).single.id;
    draftId = await ReceiptDraftRepository(db).save(
      document: _receipt(store: 'BİM', number: '000999', total: null),
      listId: listId,
    );
    dir = Directory.systemTemp.createTempSync('list_share_');
    shared = [];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          _print,
          (call) async => call.method == 'renderPdf'
              ? Uint8List.fromList(utf8.encode('%PDF-1.7 fake'))
              : null,
        );
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_print, null);
    dir.deleteSync(recursive: true);
  });

  Future<void> open(
    WidgetTester tester, {
    String locale = 'en',
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
        home: ListDetailScreen(
          db: db,
          listRepository: lists,
          listId: listId,
          pickImage: () async => null,
          reportExportService: ReportExportService(
            tempDirectory: () async => dir,
            shareFiles: (params) async => shared.add(params),
            printer: (html, title) async {},
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

  Finder tile(int id) => find.byKey(ValueKey('detail_receipt_$id'));

  testWidgets('receipts section shows store, date, total and state '
      '(text + icon, not colour alone) and the receipt date (F19)', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(412, 1400));
    final semantics = tester.ensureSemantics();
    await open(tester);
    expect(find.byKey(const Key('detail_receipts_section')), findsOneWidget);
    expect(find.text('Receipts (2)'), findsOneWidget);
    expect(
      find.descendant(
        of: tile(completeId),
        matching: find.text('ŞOK MARKETLER'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: tile(completeId),
        matching: find.textContaining('Complete'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: tile(completeId),
        matching: find.byIcon(Icons.check_circle_outline),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: tile(completeId),
        matching: find.textContaining('Oct 24, 2026'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey('detail_receipt_total_$completeId')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: tile(draftId),
        matching: find.textContaining('Incomplete'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: tile(draftId),
        matching: find.byIcon(Icons.pending_outlined),
      ),
      findsOneWidget,
    );
    expect(find.byKey(const Key('detail_receipt_date')), findsOneWidget);
    expect(find.textContaining('Receipt date: Oct 24, 2026'), findsOneWidget);
    expect(tester.getSize(tile(draftId)).height, greaterThanOrEqualTo(48));
    final menu = find.byKey(ValueKey('detail_receipt_menu_$draftId'));
    expect(tester.getSize(menu).height, greaterThanOrEqualTo(48));
    expect(tester.getSize(menu).width, greaterThanOrEqualTo(48));
    semantics.dispose();
    await close(tester);
  });

  testWidgets('many receipts stay collapsed until "Show all"', (tester) async {
    for (var i = 0; i < 4; i++) {
      await db
          .into(db.receipts)
          .insert(
            ReceiptsCompanion.insert(
              listId: Value(listId),
              detectedStore: Value('STORE $i'),
              processingStatus: const Value('error'),
            ),
          );
    }
    await tester.binding.setSurfaceSize(const Size(412, 1600));
    await open(tester);
    expect(find.text('Receipts (6)'), findsOneWidget);
    expect(
      find.byType(ListTile).evaluate().where((e) {
        final key = e.widget.key;
        return key is ValueKey<String> &&
            key.value.startsWith('detail_receipt_');
      }),
      hasLength(3),
    );
    expect(find.text('Show all (6)'), findsOneWidget);
    await tester.tap(find.byKey(const Key('detail_receipts_toggle')));
    await tester.pumpAndSettle();
    expect(find.text('STORE 3'), findsOneWidget);
    expect(find.textContaining('Failed'), findsWidgets);
    expect(find.text('Show less'), findsOneWidget);
    await close(tester);
  });

  testWidgets('tapping an incomplete receipt continues that draft directly', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(412, 1400));
    await open(tester);
    await tester.tap(tile(draftId));
    await tester.pumpAndSettle();
    // No picker: the continuation sheet of this draft opens at once.
    expect(find.byKey(const Key('receipt_new_capture')), findsNothing);
    expect(find.byKey(Key('receipt_resume_$draftId')), findsNothing);
    expect(find.byKey(const Key('receipt_capture_later')), findsOneWidget);
    await tester.tap(find.byKey(const Key('receipt_capture_later')));
    await tester.pumpAndSettle();
    expect(tile(draftId), findsOneWidget);
    await close(tester);
  });

  testWidgets('complete receipts are not resumed by tap', (tester) async {
    await tester.binding.setSurfaceSize(const Size(412, 1400));
    await open(tester);
    await tester.tap(tile(completeId));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('receipt_capture_later')), findsNothing);
    await close(tester);
  });

  testWidgets('deleting a receipt asks first, then removes it and its items', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(412, 1400));
    await open(tester);
    expect(find.text('ELMA'), findsOneWidget);
    await tester.tap(find.byKey(ValueKey('detail_receipt_menu_$completeId')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('detail_receipt_delete_$completeId')));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Delete this receipt and the items it added? '
        'You can import it again later.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(tile(completeId), findsOneWidget);
    await tester.longPress(tile(completeId));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('receipt_delete_confirm')));
    await tester.pumpAndSettle();
    expect(tile(completeId), findsNothing);
    expect(find.text('Receipt deleted.'), findsOneWidget);
    expect(find.text('ELMA'), findsNothing);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await close(tester);
  });

  testWidgets('list overflow opens the shared PDF/CSV/Print menu', (
    tester,
  ) async {
    await open(tester);
    await tester.tap(find.byKey(const Key('detail_more_menu')));
    await tester.pumpAndSettle();
    expect(find.text('Save PDF report'), findsNothing);
    await tester.tap(find.byKey(const Key('detail_report_share')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('report_share_menu')), findsOneWidget);
    expect(find.byKey(const Key('report_share_pdf')), findsOneWidget);
    expect(find.byKey(const Key('report_share_print')), findsOneWidget);
    await tester.tap(find.byKey(const Key('report_share_csv')));
    for (var i = 0; i < 3; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pumpAndSettle();
    }
    expect(shared, hasLength(1));
    expect(shared.single.files!.single.path, endsWith('.csv'));
    await close(tester);
  });

  for (final config in [
    ('ar', false, 320.0, 2.0),
    ('tr', true, 320.0, 1.0),
    ('en', false, 1280.0, 1.0),
  ]) {
    testWidgets(
      'receipts section layout ${config.$1}/${config.$2}/${config.$3}',
      (tester) async {
        await tester.binding.setSurfaceSize(Size(config.$3, 1800));
        await open(
          tester,
          locale: config.$1,
          dark: config.$2,
          scale: config.$4,
        );
        expect(tester.takeException(), isNull);
        expect(tile(completeId), findsOneWidget);
        expect(tile(draftId), findsOneWidget);
        await close(tester);
      },
    );
  }
}
