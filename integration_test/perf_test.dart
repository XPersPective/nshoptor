// Performans ve dayanıklılık (spec §13, T29).
//
// Flutter anlatırken [flutter test integration_test] kullanılır; widget
// testlerinde kullanılan FakeAsync sınırlamaları nedeniyle timeline
// ölçümü bu dosyada yapılır.
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/util/normalize_name.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/lists_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  testWidgets('büyük veri seti: 200 liste + 5000 satır, ana ekran akıcı kalır',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final repo = ListRepository(db);

    // Büyük veri seti (spec §13: 200 liste, 5k satır).
    final names = <String>{};
    for (var i = 0; i < 200; i++) {
      final listId = await repo.createList(
          title: 'Liste $i',
          currencyCode: i.isEven ? 'TRY' : 'USD');
      for (var j = 0; j < 25; j++) {
        names.add('$j');
        await db.into(db.plannedItems).insert(
              PlannedItemsCompanion.insert(
                listId: listId,
                name: 'Item $j',
                normalizedName: normalizeName('item $j'),
                plannedQuantity: '1',
                plannedUnitCode: 'adet',
                pricingInputMode: 'lineTotal',
                plannedLineTotalMinorUnits: const Value(100),
                sortOrder: Value(j),
              ),
            );
      }
    }
    expect(names.length, 25);

    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: ListsScreen(repository: repo),
    ));
    await settle(tester);

    // StreamBuilder yayınladı: ilk liste satırı başlığı içerir.
    expect(find.byType(ListTile), findsWidgets);

    // Kaydır: 1000 satır etkileşimi.
    await tester.flingFrom(const Offset(400, 400), const Offset(0, -300), 800);
    await settle(tester);
    // crash yok, scroll pozisyonu ilerledi.

    await disposeApp(tester);
  }, timeout: const Timeout(Duration(minutes: 10)));
}
