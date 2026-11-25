import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_preview_screen.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kDebugMode) {
    throw StateError('Report export QA entrypoint requires a debug build.');
  }

  final db = AppDatabase(NativeDatabase.memory());
  final completedAt = DateTime(2026, 10, 27, 12);
  final listId = await db
      .into(db.shoppingLists)
      .insert(
        ShoppingListsCompanion.insert(
          title: const Value('Synthetic report preview'),
          currencyCode: 'TRY',
          status: const Value('completed'),
          completedAt: Value(completedAt),
        ),
      );
  const products = <({String name, int totalMinor, String unitPrice})>[
    (name: 'Çilek / Strawberry', totalMinor: 1250, unitPrice: '12.50'),
    (name: 'Süt / Milk', totalMinor: 2000, unitPrice: '20.00'),
    (name: '米 / Rice', totalMinor: 3500, unitPrice: '35.00'),
  ];
  for (var index = 0; index < products.length; index++) {
    final product = products[index];
    final itemId = await db
        .into(db.plannedItems)
        .insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: product.name,
            normalizedName: 'qa product $index',
            plannedQuantity: '1',
            plannedUnitCode: 'piece',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: Value(product.totalMinor),
          ),
        );
    await db
        .into(db.purchaseEntries)
        .insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(itemId),
            name: product.name,
            normalizedName: 'qa product $index',
            actualQuantity: '1',
            actualUnitCode: 'piece',
            actualUnitPrice: Value(product.unitPrice),
            actualLineTotalMinorUnits: product.totalMinor,
            source: const Value('manual'),
            userConfirmed: const Value(true),
          ),
        );
  }

  final report = await ReportRepository(db).shopping(listId);
  await db.close();
  final document = ReportDocument(
    title: 'Synthetic report preview',
    currencyCode: 'TRY',
    shopping: [report],
  );
  runApp(_ReportPreviewQa(document: document));
}

class _ReportPreviewQa extends StatelessWidget {
  const _ReportPreviewQa({required this.document});

  final ReportDocument document;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'NShoptor report export QA',
    debugShowCheckedModeBanner: false,
    locale: const Locale('en'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: AppTheme.light(),
    home: ReportPreviewScreen(document: document),
  );
}
