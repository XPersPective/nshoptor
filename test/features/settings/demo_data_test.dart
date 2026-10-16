import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';
import 'package:nshoptor/features/settings/demo_data.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('sample data: 12 months of completed shopping with price history; remove keeps user data', () async {
    final userList = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
          currencyCode: 'TRY', title: const Value('Benim listem')));
    final l10n = await AppLocalizations.delegate.load(const Locale('tr'));
    final demo = DemoData(db);
    final now = DateTime(2026, 10, 20);

    final count = await demo.insert(l10n, currencyCode: 'TRY', now: now);
    expect(count, greaterThan(20));
    expect(await demo.present(), isTrue);

    final points = await InsightsRepository(db).completedSpend('TRY');
    expect(points.length, count);
    expect(points.every((p) => p.actualMinor > 0), isTrue);
    expect(points.every((p) => !p.at.isAfter(now)), isTrue);
    final months = {for (final p in points) '${p.at.year}-${p.at.month}'};
    expect(months.length, 12);

    final stats = await InsightsRepository(db).purchaseStats('TRY');
    expect(stats.map((s) => s.name), containsAll(['Elma', 'Ekmek', 'Süt']));
    expect(await db.select(db.priceObservations).get(), isNotEmpty);

    // Loading twice does not duplicate.
    await demo.insert(l10n, currencyCode: 'TRY', now: now);
    expect((await InsightsRepository(db).completedSpend('TRY')).length, count);

    await demo.remove();
    expect(await demo.present(), isFalse);
    expect(await InsightsRepository(db).completedSpend('TRY'), isEmpty);
    expect(await db.select(db.priceObservations).get(), isEmpty);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    final lists = await db.select(db.shoppingLists).get();
    expect(lists.single.id, userList);
  });
}
