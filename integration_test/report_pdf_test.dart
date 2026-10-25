import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations_tr.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_export_service.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'native PDF preserves a multipage Unicode report and releases job',
    (tester) async {
      await initializeDateFormatting('tr');
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final id = await db
          .into(db.shoppingLists)
          .insert(
            ShoppingListsCompanion.insert(
              title: const Value('Pazar / سوق'),
              currencyCode: 'TRY',
              status: const Value('completed'),
              completedAt: Value(DateTime(2026, 10, 25, 12)),
            ),
          );
      for (var i = 0; i < 120; i++) {
        final item = await db
            .into(db.plannedItems)
            .insert(
              PlannedItemsCompanion.insert(
                listId: id,
                name: 'Ürün $i – Çilek, yoğurt / تفاح وحليب',
                normalizedName: 'qa $i',
                plannedQuantity: '2',
                plannedUnitCode: 'piece',
                pricingInputMode: 'lineTotal',
                plannedLineTotalMinorUnits: const Value(4000),
              ),
            );
        await db
            .into(db.purchaseEntries)
            .insert(
              PurchaseEntriesCompanion.insert(
                listId: id,
                plannedItemId: Value(item),
                name: 'Ürün $i – Çilek, yoğurt / تفاح وحليب',
                normalizedName: 'qa $i',
                actualQuantity: '2',
                actualUnitCode: 'piece',
                actualUnitPrice: const Value('15'),
                actualLineTotalMinorUnits: 3000,
                source: const Value('manual'),
                userConfirmed: const Value(true),
              ),
            );
      }
      final before = await db.select(db.purchaseEntries).get();
      final report = await ReportRepository(db).shopping(id);
      expect(report.spent.minor, 360000);
      final document = ReportDocument(
        title: 'Haftalık rapor / تقرير',
        currencyCode: 'TRY',
        shopping: [report],
      );
      final text = ReportText(AppLocalizationsTr(), 'tr', 'TRY');
      const service = ReportExportService();
      final bytes = await service.bytes(
        document,
        text,
        ReportFileFormat.pdf,
        rtl: true,
      );
      expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
      expect(bytes.length, greaterThan(10000));
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/nshoptor-report-qa-20261025.pdf');
      await file.writeAsBytes(bytes, flush: true);
      // Only synthetic fixture paths and totals are logged.
      // ignore: avoid_print
      print(
        'REPORT_QA path=${file.path} bytes=${bytes.length} totalMinor=360000',
      );
      final second = await service.bytes(
        ReportDocument(
          title: 'Kısa rapor',
          currencyCode: 'TRY',
          shopping: const [],
        ),
        text,
        ReportFileFormat.pdf,
      );
      expect(String.fromCharCodes(second.take(5)), '%PDF-');
      expect(await db.select(db.purchaseEntries).get(), before);
    },
  );
}
