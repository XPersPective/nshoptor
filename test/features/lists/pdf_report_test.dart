import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/item_status.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/features/shopping_mode/summary/pdf_report.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('report escapes all text, preserves currency precision, units and unknown amounts', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final l10n = await AppLocalizations.delegate.load(const Locale('tr'));
    final id = await ListRepository(db).createList(title: '<script>Çığ Şölen & "税"</script>', currencyCode: 'KWD');
    final item = await ItemRepository(db).addItem(listId: id, name: '<img src=x onerror=alert(1)>',
      quantity: DecimalFixed.fromInt(2), unitCode: 'kilogram', priceIsUnitPrice: true, price: DecimalFixed.parse('1.234'));
    await ShoppingRepository(db).setItemStatus(item, ItemStatus.inCart);
    await ShoppingRepository(db).recordPurchase(listId: id, name: 'طماطم & <b>税</b>', normalizedName: 'طماطم',
      quantity: DecimalFixed.parse('1.5'), unitCode: 'kilogram', unitPrice: DecimalFixed.parse('1.001'));
    final html = await buildPdfReport(db, id, l10n, 'tr', rtl: true);
    expect(html, contains('&lt;script&gt;Çığ Şölen &amp; &quot;税&quot;&lt;&#47;script&gt;'));
    expect(html, isNot(contains('<script>')));
    expect(html, isNot(contains('<img ')));
    expect(html, contains('&lt;img src=x onerror=alert(1)&gt;'));
    expect(html, contains('طماطم &amp; &lt;b&gt;税&lt;&#47;b&gt;'));
    expect(html, contains('dir="rtl"'));
    expect(html, contains('KWD'));
    expect(html, contains('2,468'));
    expect(html, contains('1,502'));
    expect(html, contains('1,5 kg'));
    expect(html, contains('<bdi>—</bdi>'));
    expect(html, contains(l10n.reportNotInvoice));
    expect(html, contains('table-header-group'));
  });

  testWidgets('print error and repeat request leave purchases unchanged', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final id = await ListRepository(db).createList(title: 'Market', currencyCode: 'TRY');
    var calls = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(pdfPrintChannel, (call) async {
      expect(call.method, 'print'); expect((call.arguments as Map)['html'], contains('Market'));
      if (++calls == 1) throw PlatformException(code: 'print_failed');
      return null;
    });
    await tester.pumpWidget(MaterialApp(locale: const Locale('tr'), supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      home: Scaffold(appBar: AppBar(actions: [PdfReportButton(db: db, listId: id)]))));
    await tester.tap(find.byKey(const Key('report_pdf_button'))); await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(tester.widget<SnackBar>(find.byType(SnackBar)).showCloseIcon, isTrue);
    await tester.tap(find.byKey(const Key('report_pdf_button'))); await tester.pumpAndSettle();
    expect(calls, 2); expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close(); await tester.pump(const Duration(milliseconds: 1)); await closing;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(pdfPrintChannel, null);
  });
}
