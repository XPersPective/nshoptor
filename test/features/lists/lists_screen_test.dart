import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/lists_screen.dart';

void main() {
  late AppDatabase db;
  late ListRepository repo;

/// Test bitiminde drift akışlarının sıfır-süreli kapanış zamanlayıcısının
/// çalışabilmesi için widget ağacını boşaltır (testWidgets pending-timer
/// değişmezini sağlar).
/// Odaklı TextField'ın imleç yanıp sönmeleri pumpAndSettle'ı sonsuza dek
/// meşgul ettiğinden, önce odağı bırakıp sonra yerleşmeye çalışır.
Future<void> settle(WidgetTester tester) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
}

Future<void> disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  // Drift kapanışı, iptal edilen akışların Timer.run geri çağrılarını
  // bekler; FakeAsync'te bunlar pump ile çalışır. Kapanışı başlatıp
  // araya pump koyarak tamamla (drift dokümantasyonundaki desen).
  final closing = db.close();
  await tester.pump(const Duration(milliseconds: 1));
  await closing;
}



  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ListRepository(db);
  });

  tearDown(() async => db.close());

  Widget subject() => MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: ListsScreen(repository: repo),
      );

  testWidgets('iki liste oluşturulur; yeni controller ile de görünür (kalıcılık)',
      (tester) async {
    await tester.pumpWidget(subject());
    await settle(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);
    await tester.enterText(find.byKey(const Key('list_title_field')), 'Haftalık');
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);
    await tester.enterText(find.byKey(const Key('list_title_field')), 'Market');
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);

    expect(find.text('Haftalık'), findsOneWidget);
    expect(find.text('Market'), findsOneWidget);

    // Yeni controller (uygulama yeniden başlangıcı benzetimi): aynı db.
    final freshRepo = ListRepository(db);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: ListsScreen(repository: freshRepo),
      ),
    );
    await settle(tester);
    expect(find.text('Haftalık'), findsOneWidget);
    expect(find.text('Market'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('başlıksız liste otomatik ad alır', (tester) async {
    await tester.pumpWidget(subject());
    await settle(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);

    // Akış sorguları FakeAsync'te pump beklemeden teslim edilmez;
    // kalıcılığı tek-seferlik sorguyla doğrula.
    final lists = await db.select(db.shoppingLists).get();
    expect(lists, hasLength(1));
    expect(lists.single.title, isNull);
    expect(lists.single.generatedTitle, contains('alışverişi'));
    await disposeApp(tester);
  });

  testWidgets('silme onay sorar; geri al listeyi geri getirir', (tester) async {
    final id = await repo.createList(title: 'Geçici', currencyCode: 'TRY');
    await tester.pumpWidget(subject());
    await settle(tester);

    await tester.tap(find.byIcon(Icons.more_vert));
    await settle(tester);
    await tester.tap(find.text('Sil').last);
    await settle(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Sil'));
    await settle(tester);

    expect(find.text('Geçici'), findsNothing);

    await tester.tap(find.text('Geri al'));
    await settle(tester);
    expect(await repo.getById(id).then((l) => l.title), 'Geçici');
    await disposeApp(tester);
  });

  testWidgets('para birimi değişiminde tutarlar varsa onay diyaloğu çıkar',
      (tester) async {
    final id = await repo.createList(
        title: 'Bütçeli', currencyCode: 'TRY', budgetMinorUnits: 10000);
    await tester.pumpWidget(subject());
    await settle(tester);

    await tester.tap(find.byIcon(Icons.more_vert));
    await settle(tester);
    await tester.tap(find.text('Düzenle'));
    await settle(tester);

    await tester.tap(find.byKey(const Key('list_currency_field')));
    await settle(tester);
    await tester.scrollUntilVisible(
      find.text('USD').last,
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('USD').last);
    await settle(tester);
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);

    // Onay diyaloğu: Rakamları koru seçilir.
    expect(find.text('Para birimi değişiyor. Mevcut tutarlar ne yapılsın?'),
        findsOneWidget);
    await tester.tap(find.text('Rakamları koru'));
    await settle(tester);

    final list = await repo.getById(id);
    expect(list.currencyCode, 'USD');
    expect(list.budgetMinorUnits, 10000);
    await disposeApp(tester);
  });

  testWidgets('arama listeleri filtreler', (tester) async {
    await repo.createList(title: 'Pazar market', currencyCode: 'TRY');
    await repo.createList(title: 'Bakkal', currencyCode: 'TRY');
    await tester.pumpWidget(subject());
    await settle(tester);

    await tester.enterText(find.byKey(const Key('lists_search_field')), 'market');
    await settle(tester);

    expect(find.text('Pazar market'), findsOneWidget);
    expect(find.text('Bakkal'), findsNothing);
    await disposeApp(tester);
  });
}
