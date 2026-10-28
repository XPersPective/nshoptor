import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_export_service.dart';
import 'package:nshoptor/features/history/reports/report_share_menu.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/summary/result_repository.dart';
import 'package:nshoptor/features/shopping_mode/summary/summary_screen.dart';

void main() {
  for (final locale in ['en', 'ar']) {
    testWidgets('summary has one Share action; its menu fits 320dp at 2x ($locale)', (tester) async {
      tester.view.physicalSize = const Size(320, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        final closing = db.close(); await tester.pump(const Duration(milliseconds: 1)); await closing;
      });
      final id = await ListRepository(db).createList(title: 'Owned QA', currencyCode: 'TRY');
      await ItemRepository(db).addItem(listId: id, name: '=1+2', quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece', priceIsUnitPrice: true, price: DecimalFixed.parse('1.23'));
      await tester.pumpWidget(MaterialApp(locale: Locale(locale), supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(2)), child: child!),
        home: SummaryScreen(repository: ResultRepository(db), listId: id)));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('summary_csv_export')), findsNothing);
      expect(find.byKey(const Key('report_pdf_button')), findsNothing);
      final share = find.byKey(const Key('summary_share'));
      expect(find.descendant(of: share, matching: find.byType(IconButton)), findsOneWidget);
      await tester.tap(share);
      await tester.pumpAndSettle();
      for (final action in ['pdf', 'csv', 'print']) {
        expect(find.byKey(Key('report_share_$action')), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    });
  }

  testWidgets('summary CSV share: file with BOM, defused formula, planned price', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close(); await tester.pump(const Duration(milliseconds: 1)); await closing;
    });
    final id = await ListRepository(db).createList(title: 'Owned QA', currencyCode: 'TRY');
    await ItemRepository(db).addItem(listId: id, name: '=1+2', quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece', priceIsUnitPrice: true, price: DecimalFixed.parse('1.23'));
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SummaryScreen(repository: ResultRepository(db), listId: id),
    ));
    await tester.pumpAndSettle();
    // The summary uses the shared report service; drive its CSV generator
    // through the same document the button builds.
    final button = tester.widget<ReportShareButton>(find.byKey(const Key('summary_share')));
    final document = await button.document();
    expect(document.shopping.single.list.id, id);
    final l10n = AppLocalizations.of(tester.element(find.byType(Scaffold)));
    final bytes = await tester.runAsync(() => button.service.bytes(
      document, ReportText(l10n, 'en', document.currencyCode), ReportFileFormat.csv));
    final csv = utf8.decode(bytes!.skip(3).toList());
    expect(bytes.take(3), [0xef, 0xbb, 0xbf]);
    expect(csv, contains('"\'=1+2"'));
    expect(csv, contains('1.23'));
  });
}
