import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/price_history/price_history_repository.dart';
import 'package:nshoptor/features/history/price_history/price_history_sheet.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  late AppDatabase db;
  late PriceHistoryRepository repo;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = PriceHistoryRepository(db);
  });
  tearDown(() => db.close());

  Future<({int product, int list, int item})> seedEstimate({
    String currency = 'TRY',
    String unit = 'gram',
  }) async {
    final product = await db
        .into(db.productMemory)
        .insert(
          ProductMemoryCompanion.insert(
            canonicalName: 'Kıyma',
            normalizedName: 'kiyma',
          ),
        );
    final list = await ListRepository(
      db,
    ).createList(currencyCode: currency, plannedAt: DateTime.utc(2026, 10, 2));
    final item = await ItemRepository(db).addItem(
      listId: list,
      name: 'Kıyma',
      quantity: DecimalFixed.fromInt(400),
      unitCode: unit,
      priceIsUnitPrice: false,
      price: DecimalFixed.fromInt(350),
    );
    return (product: product, list: list, item: item);
  }

  test('400g estimate350 and actual320 normalize separately to875 and800 per kilogram', () async {
    final seeded = await seedEstimate();
    final estimates = await repo.estimatedHistory(
      seeded.product,
      currencyCode: 'TRY',
      unitCode: 'kilogram',
    );
    expect(estimates.single.unitPrice.toMinorUnits(2), 87500);
    expect(estimates.single.unitCode, 'kilogram');
    expect(
      estimates.single.at.isAtSameMomentAs(DateTime.utc(2026, 10, 2)),
      isTrue,
    );
    expect(await repo.stats(seeded.product), isNull);
    expect(await db.select(db.priceObservations).get(), isEmpty);
    await ShoppingRepository(db).recordPurchase(
      listId: seeded.list,
      plannedItemId: seeded.item,
      name: 'Kıyma',
      normalizedName: 'kiyma',
      quantity: DecimalFixed.fromInt(400),
      unitCode: 'gram',
      lineTotalMinor: 32000,
    );
    final actual = await repo.normalizedHistory(
      seeded.product,
      currencyCode: 'TRY',
      unitCode: 'kilogram',
    );
    expect(actual.single.unitPrice.toMinorUnits(2), 80000);
    final stats = await repo.stats(seeded.product);
    expect(stats!.sampleCount, 1);
    expect(stats.minMinor, 80000);
    expect(await repo.trend(seeded.product), isNull);
    expect(
      (await repo.estimatedHistory(seeded.product)).single.unitPrice
          .toMinorUnits(2),
      87500,
    );
    expect(await db.select(db.priceObservations).get(), hasLength(1));
  });

  test('estimated series filters currency and dimension and falls back to list creation date', () async {
    final seeded = await seedEstimate();
    for (final (currency, unit) in [('EUR', 'gram'), ('TRY', 'piece')]) {
      final list = await ListRepository(db).createList(currencyCode: currency);
      await ItemRepository(db).addItem(
        listId: list,
        name: 'Kıyma',
        quantity: DecimalFixed.fromInt(1),
        unitCode: unit,
        priceIsUnitPrice: false,
        price: DecimalFixed.fromInt(5),
      );
    }
    final rows = await repo.estimatedHistory(
      seeded.product,
      currencyCode: 'TRY',
      unitCode: 'kilogram',
    );
    expect(rows, hasLength(1));
    final euros = await repo.estimatedHistory(
      seeded.product,
      currencyCode: 'EUR',
      unitCode: 'kilogram',
    );
    final euroList = await ListRepository(db).getById(euros.single.item.listId);
    expect(euros.single.at, euroList.createdAt);
    expect(await repo.estimatedHistory(-1), isEmpty);
  });

  test(
    'package prices compare per package without inventing package contents',
    () async {
      final product = await db
          .into(db.productMemory)
          .insert(
            ProductMemoryCompanion.insert(
              canonicalName: 'Sigara',
              normalizedName: 'sigara',
            ),
          );
      final list = await ListRepository(db).createList(currencyCode: 'TRY');
      final item = await ItemRepository(db).addItem(
        listId: list,
        name: 'Sigara',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'package',
        priceIsUnitPrice: false,
        price: DecimalFixed.fromInt(260),
      );
      await ShoppingRepository(db).recordPurchase(
        listId: list,
        plannedItemId: item,
        name: 'Sigara',
        normalizedName: 'sigara',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'package',
        lineTotalMinor: 25000,
      );
      final estimates = await repo.estimatedHistory(
        product,
        unitCode: 'package',
      );
      final actual = await repo.normalizedHistory(product, unitCode: 'package');
      expect(estimates.single.unitPrice.toMinorUnits(2), 13000);
      expect(actual.single.unitPrice.toMinorUnits(2), 12500);
      expect(await repo.normalizedHistory(product, unitCode: 'piece'), isEmpty);
      expect(
        await repo.estimatedHistory(product, unitCode: 'kilogram'),
        isEmpty,
      );
    },
  );

  testWidgets(
    'kg screen includes legacy gram observations plus separately labeled estimates at2x',
    (tester) async {
      final seeded = await seedEstimate();
      final observation = await db
          .into(db.priceObservations)
          .insert(
            PriceObservationsCompanion.insert(
              productId: Value(seeded.product),
              quantity: '400',
              unitCode: 'gram',
              unitPrice: '0.8',
              lineTotalMinorUnits: 32000,
              currencyCode: 'TRY',
              source: 'manual',
            ),
          );
      AppFormatLocale.attach('en');
      addTearDown(AppFormatLocale.attachReset);
      await tester.binding.setSurfaceSize(const Size(320, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: PriceHistoryScreen(
            db: db,
            productId: seeded.product,
            currencyCode: 'TRY',
            unitCode: 'kilogram',
          ),
        ),
      );
      await tester.pumpAndSettle();
      final chart = find.byKey(const Key('price_history_chart'));
      expect(chart, findsOneWidget);
      expect(find.byKey(Key('price_obs_$observation')), findsOneWidget);
      expect(find.byKey(Key('price_estimate_${seeded.item}')), findsOneWidget);
      final l10n = AppLocalizations.of(
        tester.element(find.byType(PriceHistoryScreen)),
      );
      expect(find.textContaining(l10n.compareEstimated), findsWidgets);
      expect(find.textContaining(l10n.compareActual), findsWidgets);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'an estimate-only product has a graph without inventing an observation',
    (tester) async {
      final seeded = await seedEstimate();
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: PriceHistoryScreen(
            db: db,
            productId: seeded.product,
            currencyCode: 'TRY',
            unitCode: 'kilogram',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('price_history_chart')), findsOneWidget);
      expect(await db.select(db.priceObservations).get(), isEmpty);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
