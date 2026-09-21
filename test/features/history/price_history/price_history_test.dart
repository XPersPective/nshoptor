import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/price_history/price_history_repository.dart';

void main() {
  late AppDatabase db;
  late PriceHistoryRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = PriceHistoryRepository(db);
  });

  tearDown(() => db.close());

  Future<int> seedProductAndStores() async {
    await db.into(db.stores).insert(
        StoresCompanion.insert(name: 'Market A', sortOrder: const Value(1)));
    await db.into(db.stores).insert(
        StoresCompanion.insert(name: 'Market B', sortOrder: const Value(2)));
    return db.into(db.productMemory).insert(
          ProductMemoryCompanion.insert(
            canonicalName: 'Süt',
            normalizedName: 'sut',
          ),
        );
  }

  Future<void> observe(
    int productId,
    String unitPrice,
    DateTime at, {
    String currency = 'TRY',
    int? storeId,
  }) {
    return db.into(db.priceObservations).insert(
          PriceObservationsCompanion.insert(
            productId: Value(productId),
            storeId: Value(storeId),
            observedAt: Value(at),
            quantity: '1',
            unitCode: 'adet',
            unitPrice: unitPrice,
            lineTotalMinorUnits: 0,
            currencyCode: currency,
            source: 'manual',
          ),
        );
  }

  test('min/medyan/max/ortalama doğruluğu (5 gözlem)', () async {
    final productId = await seedProductAndStores();
    final base = DateTime(2026, 9, 1);
    await observe(productId, '40.00', base);
    await observe(productId, '35.00', base.add(const Duration(days: 1)));
    await observe(productId, '38.00', base.add(const Duration(days: 2)));
    await observe(productId, '42.00', base.add(const Duration(days: 3)));
    await observe(productId, '36.00', base.add(const Duration(days: 4)));

    final stats = await repo.stats(productId);
    expect(stats, isNotNull);
    expect(stats!.currencyCode, 'TRY');
    expect(stats.sampleCount, 5);
    expect(stats.minMinor, 3500);
    expect(stats.maxMinor, 4200);
    expect(stats.medianMinor, 3800); // 35,36,38,40,42
    expect(stats.averageMinor, (3500 + 3600 + 3800 + 4000 + 4200) ~/ 5);
  });

  test('son N gözlem ile sınırlı hesap', () async {
    final productId = await seedProductAndStores();
    final base = DateTime(2026, 9, 1);
    await observe(productId, '20.00', base); // eski, n=3 dışında
    await observe(productId, '30.00', base.add(const Duration(days: 1)));
    await observe(productId, '32.00', base.add(const Duration(days: 2)));
    await observe(productId, '34.00', base.add(const Duration(days: 3)));

    final stats = await repo.stats(productId, n: 3);
    expect(stats!.sampleCount, 3);
    expect(stats.minMinor, 3000);
    expect(stats.maxMinor, 3400);
  });

  test('farklı para birimleri karıştırılmaz (spec §7.1)', () async {
    final productId = await seedProductAndStores();
    final base = DateTime(2026, 9, 1);
    await observe(productId, '32.00', base, currency: 'TRY');
    await observe(productId, '2.00', base.add(const Duration(days: 1)),
        currency: 'EUR');
    await observe(productId, '30.00', base.add(const Duration(days: 2)),
        currency: 'TRY');

    // TRY baskın: yalnız TRY gözlemleri hesaba girer.
    final stats = await repo.stats(productId);
    expect(stats!.currencyCode, 'TRY');
    expect(stats.sampleCount, 2);
    expect(stats.minMinor, 3000);
    expect(stats.maxMinor, 3200);
  });

  test('görülen en ucuz mağaza', () async {
    final productId = await seedProductAndStores();
    final base = DateTime(2026, 9, 1);
    await observe(productId, '32.00', base, storeId: 1);
    await observe(productId, '29.90', base.add(const Duration(days: 1)),
        storeId: 2);
    await observe(productId, '31.00', base.add(const Duration(days: 2)),
        storeId: 1);

    expect(await repo.cheapestStore(productId), 2);
  });

  test('eğilim: yükseliş/düşüş/sabit/yetersiz veri', () async {
    final productId = await seedProductAndStores();
    final base = DateTime(2026, 9, 1);
    expect(await repo.trend(productId), isNull); // veri yok

    await observe(productId, '30.00', base);
    expect(await repo.trend(productId), isNull); // tek gözlem

    await observe(productId, '33.00', base.add(const Duration(days: 1)));
    expect(await repo.trend(productId), PriceTrend.rising);

    await observe(productId, '31.00', base.add(const Duration(days: 2)));
    expect(await repo.trend(productId), PriceTrend.falling);

    await observe(productId, '31.00', base.add(const Duration(days: 3)));
    expect(await repo.trend(productId), PriceTrend.stable);
  });

  test('eski fiyat göstergesi: 30 günden eskiyse bayrak', () async {
    final productId = await seedProductAndStores();
    final now = DateTime(2026, 9, 20);

    final old = PriceStubs.observation(
        productId, '30.00', now.subtract(const Duration(days: 45)));
    final fresh = PriceStubs.observation(
        productId, '30.00', now.subtract(const Duration(days: 3)));

    expect(repo.isStale(old, now: now), isTrue);
    expect(repo.isStale(fresh, now: now), isFalse);
    expect(repo.isStale(null, now: now), isTrue);
  });
}

/// Test yardımı: DB'ye yazmadan PriceObservation örneği üretir.
class PriceStubs {
  PriceStubs._();

  static PriceObservation observation(
          int productId, String unitPrice, DateTime at) =>
      PriceObservation(
        id: 0,
        productId: productId,
        purchaseEntryId: null,
        storeId: null,
        observedAt: at,
        quantity: '1',
        unitCode: 'adet',
        normalizedBaseQuantity: null,
        unitPrice: unitPrice,
        lineTotalMinorUnits: 0,
        discountMinorUnits: 0,
        currencyCode: 'TRY',
        source: 'manual',
      );
}
