import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations_en.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations_tr.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_period.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';

void main() {
  late AppDatabase db;

  setUpAll(() => initializeDateFormatting('tr'));
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<int> addList({
    required String title,
    String currency = 'TRY',
    int? storeId,
    DateTime? completedAt,
  }) => db
      .into(db.shoppingLists)
      .insert(
        ShoppingListsCompanion.insert(
          title: Value(title),
          currencyCode: currency,
          status: const Value('completed'),
          completedAt: Value(completedAt ?? DateTime(2026, 1, 2, 12)),
          storeId: Value(storeId),
        ),
      );

  Future<int> addPlanned(
    int listId,
    String name, {
    int? plannedMinor,
    String status = 'pending',
  }) => db
      .into(db.plannedItems)
      .insert(
        PlannedItemsCompanion.insert(
          listId: listId,
          name: name,
          normalizedName: name.toLowerCase(),
          plannedQuantity: '2',
          plannedUnitCode: 'piece',
          pricingInputMode: 'lineTotal',
          plannedLineTotalMinorUnits: Value(plannedMinor),
          status: Value(status),
        ),
      );

  Future<void> addPurchase(
    int listId,
    String name,
    int amount, {
    int? plannedItemId,
    String? unitPrice,
    bool confirmed = true,
    String source = 'manual',
  }) async {
    await db
        .into(db.purchaseEntries)
        .insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(plannedItemId),
            name: name,
            normalizedName: name.toLowerCase(),
            actualQuantity: '1',
            actualUnitCode: 'piece',
            actualLineTotalMinorUnits: amount,
            actualUnitPrice: Value(unitPrice),
            userConfirmed: Value(confirmed),
            source: Value(source),
          ),
        );
  }

  Future<void> addReceipt(
    int listId, {
    required String store,
    required String number,
  }) async {
    await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            listId: Value(listId),
            confirmedStore: Value(store),
            confirmedAt: Value(DateTime(2026, 1, 2, 10, 30)),
            documentNumber: Value(number),
            processingStatus: const Value('reviewed'),
          ),
        );
  }

  Future<ShoppingReport> snapshot(int listId) =>
      ReportRepository(db).shopping(listId);

  test('exports retain one list total and aggregate multiple lists', () async {
    final first = await addList(title: 'First');
    final second = await addList(title: 'Second');
    await addPurchase(first, 'Milk', 3000, unitPrice: '30');
    await addPurchase(second, 'Bread', 2000, unitPrice: '20');
    final reports = [await snapshot(first), await snapshot(second)];
    final text = ReportText(AppLocalizationsTr(), 'tr', 'TRY');
    for (final count in [0, 1, 2]) {
      final document = ReportDocument(
        title: 'Report',
        currencyCode: 'TRY',
        shopping: reports.take(count).toList(),
      );
      final fragments = buildShoppingReportHtmlFragments(document, text);
      expect(fragments.html, buildShoppingReportHtml(document, text));
      expect(fragments.toMap().keys.toList(), [
        'version',
        'start',
        'end',
        'sections',
      ]);
      expect(fragments.toMap()['version'], 1);
      expect(fragments.sections.length, count == 0 ? 1 : count);
      expect(
        fragments.sections.fold<int>(
          0,
          (total, section) =>
              total + section.footer.split('class="spent"').length - 1,
        ),
        count == 2 ? 3 : 1,
      );
      if (count == 0) {
        expect(fragments.sections.single.start, isEmpty);
        expect(fragments.sections.single.rows, isEmpty);
        expect(fragments.sections.single.end, isEmpty);
      }
      for (final section in fragments.sections) {
        expect(section.toMap().keys.toList(), [
          'start',
          'rows',
          'end',
          'footer',
        ]);
      }
      final expectedTotals = count == 2 ? 3 : 1;
      for (final output in [
        fragments.html,
        buildShoppingReportText(document, text),
      ]) {
        expect(
          text.l10n.reportTotalSpent.allMatches(output).length,
          expectedTotals,
        );
        expect(
          output,
          contains(count == 0 ? '—' : text.money(count == 1 ? 3000 : 5000)),
        );
      }
    }
  });

  test('localized RTL HTML escapes content and retains report financial and receipt data', () async {
    final storeId = await db
        .into(db.stores)
        .insert(StoresCompanion.insert(name: 'Store <West> & Sons'));
    final listId = await addList(
      title: '<script>alert("title")</script>',
      storeId: storeId,
    );
    final matched = await addPlanned(
      listId,
      '<img src=x onerror=alert(1)>',
      plannedMinor: 4000,
    );
    final free = await addPlanned(listId, 'Free item');
    await addPlanned(listId, 'Estimate only', plannedMinor: 2500);
    await addPlanned(listId, 'Unknown legacy item', status: 'inCart');
    await addPurchase(
      listId,
      'Matched hostile item',
      3000,
      plannedItemId: matched,
      unitPrice: '30',
    );
    await addPurchase(
      listId,
      'Free item',
      0,
      plannedItemId: free,
      unitPrice: '0',
    );
    await addPurchase(listId, 'Discount', -500, source: 'receiptOcr');
    await addReceipt(listId, store: 'Receipt <Market> & Co', number: 'F-001');

    final report = await snapshot(listId);
    final document = ReportDocument(
      title: '<script>alert("document")</script>',
      currencyCode: 'TRY',
      shopping: [report],
    );
    final l10n = AppLocalizationsTr();
    final text = ReportText(l10n, 'tr', 'TRY');
    final html = buildShoppingReportHtml(document, text, rtl: true);
    final fragments = buildShoppingReportHtmlFragments(
      document,
      text,
      rtl: true,
    );

    expect(fragments.html, html);
    expect(fragments.sections.single.rows, hasLength(report.products.length));
    expect(
      fragments.sections.single.rows.join(),
      contains('&lt;img src=x onerror=alert(1)&gt;'),
    );
    expect(
      fragments.sections.single.rows.join(),
      isNot(contains('<img src=x')),
    );
    expect(html, contains('dir="rtl"'));
    expect(html, contains(l10n.compareActual));
    expect(html, contains(l10n.reportTotalSpent));
    expect(html, contains(l10n.reportReceiptNumber));
    expect(html, contains('F-001'));
    expect(html, contains(text.money(4000)));
    expect(html, contains(text.money(3000)));
    expect(html, contains(text.money(-1000)));
    expect(html, contains(text.money(-500)));
    expect(html, contains(text.money(0)));
    expect(
      html,
      contains('&lt;script&gt;alert(&quot;title&quot;)&lt;&#47;script&gt;'),
    );
    expect(
      html,
      contains('&lt;script&gt;alert(&quot;document&quot;)&lt;&#47;script&gt;'),
    );
    expect(html, contains('&lt;img src=x onerror=alert(1)&gt;'));
    expect(html, contains('Store &lt;West&gt; &amp; Sons'));
    expect(html, contains('Receipt &lt;Market&gt; &amp; Co'));
    expect(html, isNot(contains('<script>alert')));
    expect(html, isNot(contains('<img src=x')));
    expect(
      report.products
          .singleWhere((product) => product.name == 'Unknown legacy item')
          .actual
          .unknown,
      isTrue,
    );
  });

  test('CSV quotes multiline cells, neutralizes formulas, leaves money numeric, and blanks unknown actuals', () async {
    final listId = await addList(title: '＝Quarterly report');
    final matched = await addPlanned(listId, 'Matched', plannedMinor: 4000);
    await addPurchase(
      listId,
      'Matched',
      3000,
      plannedItemId: matched,
      unitPrice: '30',
    );
    for (final name in ['=1+1', '+SUM(A1:A2)', '-2+3', '@cmd', '＝1+1']) {
      await addPlanned(listId, name);
    }
    final unknown = await addPlanned(
      listId,
      'Unknown amount',
      status: 'inCart',
    );
    await addPlanned(listId, 'Quoted, "line one"\nline two');
    await addPurchase(listId, 'Discount', -500, source: 'receiptOcr');

    final report = await snapshot(listId);
    final document = ReportDocument(
      title: 'CSV',
      currencyCode: 'TRY',
      shopping: [report],
    );
    final csv = buildShoppingReportCsv(
      document,
      ReportText(AppLocalizationsEn(), 'en', 'TRY'),
    );
    final rows = _parseCsv(csv);
    final header = rows.first;
    final itemColumn = header.indexOf('Item');
    final actualColumn = header.indexOf(AppLocalizationsEn().compareActual);
    final differenceColumn = header.indexOf('Difference');

    for (final formula in ['=1+1', '+SUM(A1:A2)', '-2+3', '@cmd', '＝1+1']) {
      final row = rows.singleWhere(
        (candidate) => candidate[itemColumn] == "'$formula",
      );
      expect(row[itemColumn].startsWith("'"), isTrue);
    }
    final titleCell = rows[1][header.indexOf('Shopping')];
    expect(titleCell, "'＝Quarterly report");
    final unknownRow = rows.singleWhere(
      (row) => row[itemColumn] == 'Unknown amount',
    );
    expect(unknownRow[actualColumn], isEmpty);
    final matchedRow = rows.singleWhere((row) => row[itemColumn] == 'Matched');
    expect(matchedRow[actualColumn], '30.00');
    expect(matchedRow[differenceColumn], '-10.00');
    expect(matchedRow[differenceColumn].startsWith("'"), isFalse);
    final discountRow = rows.singleWhere(
      (row) => row[itemColumn] == 'Discount',
    );
    expect(discountRow[actualColumn], '-5.00');
    final quotedRow = rows.singleWhere(
      (row) => row[itemColumn] == 'Quoted, "line one"\nline two',
    );
    expect(quotedRow[itemColumn], 'Quoted, "line one"\nline two');
    expect(csv, contains('"Quoted, ""line one""\nline two"'));
    expect(
      report.products
          .singleWhere((product) => product.name == 'Unknown amount')
          .actual
          .unknown,
      isTrue,
    );
    expect(unknown, isNotNull);
  });

  test('currency-filtered repository output excludes foreign lists and mixed documents reject', () async {
    final domestic = await addList(
      title: 'Domestic',
      completedAt: DateTime(2026, 4, 2),
    );
    final foreign = await addList(
      title: 'Foreign EUR',
      currency: 'EUR',
      completedAt: DateTime(2026, 4, 3),
    );
    final domesticItem = await addPlanned(
      domestic,
      'Domestic item',
      plannedMinor: 1000,
    );
    final foreignItem = await addPlanned(
      foreign,
      'Foreign item',
      plannedMinor: 2000,
    );
    await addPurchase(
      domestic,
      'Domestic item',
      900,
      plannedItemId: domesticItem,
      unitPrice: '9',
    );
    await addPurchase(
      foreign,
      'Foreign item',
      1800,
      plannedItemId: foreignItem,
      unitPrice: '18',
    );

    final period = ReportPeriod.forSpan(
      ReportSpan.month,
      DateTime(2026, 4, 15),
    );
    final periodReport = await ReportRepository(db).period(period, 'TRY');
    expect(periodReport.shopping.map((report) => report.list.title), [
      'Domestic',
    ]);
    final document = ReportDocument(
      title: 'April',
      currencyCode: 'TRY',
      shopping: periodReport.shopping,
    );
    final csv = buildShoppingReportCsv(
      document,
      ReportText(AppLocalizationsEn(), 'en', 'TRY'),
    );
    expect(csv, contains('Domestic item'));
    expect(csv, isNot(contains('Foreign EUR')));
    expect(csv, isNot(contains('Foreign item')));

    final foreignSnapshot = await snapshot(foreign);
    expect(
      () => ReportDocument(
        title: 'Mixed',
        currencyCode: 'TRY',
        shopping: [...periodReport.shopping, foreignSnapshot],
      ),
      throwsArgumentError,
    );
  });
}

List<List<String>> _parseCsv(String source) {
  final rows = <List<String>>[];
  var row = <String>[];
  final cell = StringBuffer();
  var quoted = false;
  for (var index = 0; index < source.length; index++) {
    final char = source[index];
    if (quoted) {
      if (char == '"') {
        if (index + 1 < source.length && source[index + 1] == '"') {
          cell.write('"');
          index++;
        } else {
          quoted = false;
        }
      } else {
        cell.write(char);
      }
    } else if (char == '"') {
      quoted = true;
    } else if (char == ',') {
      row.add(cell.toString());
      cell.clear();
    } else if (char == '\n') {
      row.add(cell.toString());
      cell.clear();
      if (row.length != 1 || row.single.isNotEmpty) rows.add(row);
      row = <String>[];
    } else if (char != '\r') {
      cell.write(char);
    }
  }
  if (row.isNotEmpty || cell.isNotEmpty) {
    row.add(cell.toString());
    rows.add(row);
  }
  return rows;
}
