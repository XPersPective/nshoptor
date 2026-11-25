import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plus/share_plus.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_export_service.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';
import 'package:nshoptor/features/history/reports/report_share_menu.dart';

const _channel = MethodChannel('nshoptor/print');

ReportDocument _document() {
  final date = DateTime(2026, 10, 28, 12);
  return ReportDocument(
    title: 'Pazar',
    currencyCode: 'TRY',
    shopping: [
      ShoppingReport(
        list: ShoppingList(id: 1, title: 'Pazar', createdAt: date, updatedAt: date, completedAt: date,
          currencyCode: 'TRY', status: 'completed', sortOrder: 0),
        storeName: null,
        receipts: [],
        plannedMinor: 1000,
        spent: const SpendAmount(1250, known: true, unknown: false),
        products: [
          ReportProduct(
            name: '=Elma',
            plannedQuantity: DecimalFixed.parse('1'),
            plannedUnitCode: 'piece',
            plannedMinor: 1000,
            actualQuantities: [(quantity: DecimalFixed.parse('1'), unitCode: 'piece')],
            actual: const SpendAmount(1250, known: true, unknown: false),
            purchased: true,
          ),
        ],
      ),
    ],
  );
}

void main() {
  late Directory dir;
  late List<ShareParams> shared;
  late List<String> printed;
  late List<MethodCall> calls;
  late ReportExportService service;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('nshoptor_share_');
    shared = [];
    printed = [];
    calls = [];
    service = ReportExportService(
      tempDirectory: () async => dir,
      shareFiles: (params) async => shared.add(params),
      printer: (html, title) async => printed.add(html),
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, (call) async {
      calls.add(call);
      return call.method == 'renderPdf' ? Uint8List.fromList(utf8.encode('%PDF-1.7 fake')) : null;
    });
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, null);
    dir.deleteSync(recursive: true);
  });

  Widget app({String locale = 'en', ReportExportService? custom}) => MaterialApp(
    locale: Locale(locale),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: Center(
        child: ReportShareButton(
          key: const Key('share'),
          document: () async => _document(),
          service: custom ?? service,
        ),
      ),
    ),
  );

  Future<void> choose(WidgetTester tester, String action) async {
    await tester.tap(find.byKey(const Key('share')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('report_share_$action')));
    for (var i = 0; i < 3; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pumpAndSettle();
    }
  }

  testWidgets('one Share action opens a menu with PDF, CSV and Print (48dp, labelled)', (tester) async {
    await tester.pumpWidget(app());
    expect(find.text('Share'), findsOneWidget);
    expect(tester.getSize(find.byKey(const Key('share'))).height, greaterThanOrEqualTo(48));
    await tester.tap(find.byKey(const Key('share')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('report_share_menu')), findsOneWidget);
    for (final (key, label) in [('pdf', 'Share as PDF'), ('csv', 'Share as CSV'), ('print', 'Print')]) {
      final tile = find.byKey(Key('report_share_$key'));
      expect(find.descendant(of: tile, matching: find.text(label)), findsOneWidget);
      expect(tester.getSize(tile).height, greaterThanOrEqualTo(48));
    }
    final handle = tester.ensureSemantics();
    final node = tester.getSemantics(find.byKey(const Key('report_share_print'))).getSemanticsData();
    expect(node.label, 'Print');
    expect(node.hasAction(SemanticsAction.tap), isTrue);
    handle.dispose();
    await tester.tapAt(const Offset(5, 5));
    await tester.pumpAndSettle();
    expect(shared, isEmpty);
    expect(printed, isEmpty);
  });

  testWidgets('Share as PDF writes a temporary PDF file and passes it to the share function', (tester) async {
    await tester.pumpWidget(app());
    await choose(tester, 'pdf');
    expect(calls.single.method, 'renderPdf');
    final file = shared.single.files!.single;
    expect(file.path, endsWith('NShoptor-report.pdf'));
    expect(file.mimeType, 'application/pdf');
    expect(File(file.path).parent.parent.path, dir.path);
    expect(utf8.decode(File(file.path).readAsBytesSync()), startsWith('%PDF-'));
    expect(printed, isEmpty);
  });

  testWidgets('Share as CSV writes a UTF-8 BOM CSV file and shares it', (tester) async {
    await tester.pumpWidget(app());
    await choose(tester, 'csv');
    expect(calls, isEmpty);
    final file = shared.single.files!.single;
    expect(file.path, endsWith('NShoptor-report.csv'));
    expect(file.mimeType, 'text/csv');
    final bytes = File(file.path).readAsBytesSync();
    expect(bytes.take(3), [0xef, 0xbb, 0xbf]);
    final csv = utf8.decode(bytes.skip(3).toList());
    expect(csv, contains('"\'=Elma"'));
    expect(csv, contains('"12.50"'));
  });

  testWidgets('Print reaches the print path and shares nothing', (tester) async {
    await tester.pumpWidget(app());
    await choose(tester, 'print');
    expect(printed.single, contains('Pazar'));
    expect(shared, isEmpty);
  });

  testWidgets('default print path calls the native print method', (tester) async {
    await tester.pumpWidget(app(custom: ReportExportService(tempDirectory: () async => dir)));
    await choose(tester, 'print');
    expect(calls.single.method, 'print');
    expect((calls.single.arguments as Map)['html'], contains('<!doctype html>'));
  });

  testWidgets('a failed PDF shows an error and shares nothing; menu is RTL in Arabic', (tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel,
      (call) async => throw PlatformException(code: 'print_failed'));
    await tester.pumpWidget(app(locale: 'ar'));
    await tester.tap(find.byKey(const Key('share')));
    await tester.pumpAndSettle();
    expect(Directionality.of(tester.element(find.byKey(const Key('report_share_pdf')))), TextDirection.rtl);
    await tester.tap(find.byKey(const Key('report_share_pdf')));
    for (var i = 0; i < 3; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pumpAndSettle();
    }
    expect(shared, isEmpty);
    expect(tester.widget<SnackBar>(find.byType(SnackBar)).showCloseIcon, isTrue);
    expect(tester.takeException(), isNull);
  });
}
