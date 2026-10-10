import 'dart:convert';
import 'dart:async';
import 'package:drift/native.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/format_locale.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/voice_input/ai_list_parser.dart';
import 'package:nshoptor/features/voice_input/list_draft_sheet.dart';

AiClient _ai(http.Response Function() reply) => AiClient(
      store: SettingsStore(),
      baseUrl: 'https://x',
      httpClient: MockClient((_) async => reply()),
    );

http.Response _items(List<Map<String, Object?>> items) => http.Response(
      jsonEncode({'tier': 'free', 'used': 1, 'limit': 15, 'result': {'items': items}}),
      200,
    );

class _PreviewParser extends AiListParser {
  _PreviewParser() : super(localeCode: 'tr');
  @override
  Future<ListDraft> parse(String text) async => ListDraft([ParsedItemCandidate(name: 'elma', rawText: text,
    brand: 'Farm', category: 'produce', quantity: DecimalFixed.fromInt(2), unitCode: UnitCode.kilogram,
    unitPrice: DecimalFixed.fromInt(40), isUnitPrice: true)], fromAi: true);
}

class _DelayedParser extends AiListParser {
  _DelayedParser() : super(localeCode: 'tr');
  var calls = 0;
  Completer<ListDraft> result = Completer<ListDraft>();
  @override
  Future<ListDraft> parse(String text) { calls++; return result.future; }
}

void main() {
  testWidgets('AI duplicate blocked; failure preserves source and permits retry', (tester) async {
    final parser = _DelayedParser();
    await tester.pumpWidget(MaterialApp(locale: const Locale('tr'),
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate], supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: ListDraftSheet(parser: parser))));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('draft_text_field')), '2 ekmek');
    await tester.tap(find.byKey(const Key('draft_convert_button'))); await tester.pump();
    await tester.tap(find.byKey(const Key('draft_convert_button'))); await tester.pump();
    expect(parser.calls, 1);
    parser.result.completeError(StateError('offline')); await tester.pumpAndSettle();
    expect(find.byKey(const Key('draft_error')), findsOneWidget);
    expect(tester.widget<TextField>(find.byKey(const Key('draft_text_field'))).controller!.text, '2 ekmek');
    parser.result = Completer<ListDraft>();
    await tester.tap(find.byKey(const Key('draft_convert_button'))); await tester.pump();
    expect(parser.calls, 2);
    // A completion after dismissal cannot mutate a disposed sheet.
    await tester.pumpWidget(const SizedBox.shrink());
    parser.result.complete(const ListDraft([], fromAi: false)); await tester.pump();
    expect(tester.takeException(), isNull);
  });

  test('local digits and decimal commas retain quantities and per-unit price', () async {
    final draft = await AiListParser(localeCode: 'tr').parse('1,5 kilo elma kilosu 40 lira, 2 ekmek');
    expect(draft.items, hasLength(2));
    expect(draft.items.first.name, 'elma');
    expect(draft.items.first.quantity!.toDbString(), '1.5');
    expect(draft.items.first.unitPrice!.toDbString(), '40');
    expect(draft.items.first.isUnitPrice, true);
    expect(draft.items.last.quantity!.toDbString(), '2');
  });

  test('AI metadata reaches DB only on approval; category reuse and rollback', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final parser = AiListParser(localeCode: 'tr', ai: _ai(() => http.Response(jsonEncode({
      'tier': 'free', 'used': 1, 'limit': 15, 'result': {'title': 'Weekend', 'items': [
        {'name': 'elma', 'brand': 'Farm', 'category': 'produce', 'quantity': '2', 'unit': 'kilogram', 'estimatedPrice': '40', 'priceIsUnitPrice': true},
        {'name': 'ekmek', 'category': 'Bakery custom', 'quantity': '2', 'unit': 'piece', 'estimatedPrice': '40', 'priceIsUnitPrice': false},
      ]}}), 200)));
    final draft = await parser.parse('elma ve ekmek');
    expect(await db.select(db.categories).get(), isEmpty);
    expect(await db.select(db.shoppingLists).get(), isEmpty);
    final repo = ItemRepository(db);
    final id = await db.transaction(() async {
      final id = await ListRepository(db).createList(title: draft.title, currencyCode: 'TRY');
      await repo.addCandidates(id, draft.items); return id;
    });
    expect((await ListRepository(db).getById(id)).title, 'Weekend');
    final items = await repo.getItems(id);
    expect(items.first.brand, 'Farm'); expect(items.first.plannedLineTotalMinorUnits, 8000);
    expect(items.last.plannedLineTotalMinorUnits, 4000);
    final originalCategory = items.first.categoryId;
    await repo.addCandidates(id, [ParsedItemCandidate(name: 'pear', rawText: '', category: 'PRODUCE')]);
    expect((await repo.getItems(id)).last.categoryId, originalCategory);
    expect(await db.select(db.categories).get(), hasLength(2));
    await expectLater(db.transaction(() async {
      final badId = await ListRepository(db).createList(title: 'Bad', currencyCode: 'TRY');
      await repo.addCandidates(badId, [ParsedItemCandidate(name: 'valid', rawText: '', category: 'should roll back'),
        ParsedItemCandidate(name: 'bad', rawText: '', quantity: DecimalFixed.zero())]);
    }), throwsArgumentError);
    expect(await db.select(db.shoppingLists).get(), hasLength(1));
    expect(await db.select(db.categories).get(), hasLength(2));
    expect((await repo.getItems(id)).first.categoryId, originalCategory);
  });

  testWidgets('preview title and metadata editable; failed approval keeps draft for retry', (tester) async {
    AppFormatLocale.attach('tr'); addTearDown(AppFormatLocale.attachReset);
    var attempts = 0;
    ListDraft? approved;
    final parser = _PreviewParser();
    await tester.pumpWidget(MaterialApp(locale: const Locale('tr'),
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate], supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: ListDraftSheet(parser: parser, initialText: 'elma', onApprove: (draft) async {
        attempts++; if (attempts == 1) throw StateError('save failed'); approved = draft;
      }))));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('draft_title_field')), 'Edited weekend');
    await tester.tap(find.byKey(const Key('draft_edit_0'))); await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('draft_edit_name')), 'Armut');
    await tester.enterText(find.byKey(const Key('draft_edit_brand')), 'My brand');
    await tester.enterText(find.byKey(const Key('draft_edit_category')), 'My category');
    await tester.enterText(find.byKey(const Key('draft_edit_quantity')), '1,5');
    await tester.ensureVisible(find.byKey(const Key('draft_edit_save')));
    await tester.tap(find.byKey(const Key('draft_edit_save'))); await tester.pumpAndSettle();
    expect(attempts, 0);
    await tester.ensureVisible(find.byKey(const Key('draft_add_button')));
    await tester.tap(find.byKey(const Key('draft_add_button'))); await tester.pumpAndSettle();
    expect(attempts, 1); expect(find.byKey(const Key('draft_error')), findsOneWidget);
    expect(find.text('Armut'), findsOneWidget);
    await tester.tap(find.byKey(const Key('draft_add_button'))); await tester.pumpAndSettle();
    expect(approved!.title, 'Edited weekend');
    expect(approved!.items.single.brand, 'My brand'); expect(approved!.items.single.category, 'My category');
    expect(approved!.items.single.quantity!.toDbString(), '1.5'); expect(approved!.items.single.isUnitPrice, true);
  });

  test('AI adayları: miktar, birim, tahmini fiyat', () async {
    final parser = AiListParser(
      localeCode: 'tr',
      ai: _ai(() => _items([
            {'name': 'elma', 'quantity': '1', 'unit': 'kilogram', 'estimatedPrice': '20', 'priceIsUnitPrice': false},
            {'name': 'ekmek', 'quantity': '2', 'unit': 'piece', 'estimatedPrice': null},
          ])),
    );
    final draft = await parser.parse('1 kilo elma alacağım 20 lira, 2 ekmek');
    expect(draft.fromAi, isTrue);
    expect(draft.items.map((i) => i.name), ['elma', 'ekmek']);
    expect(draft.items[0].unitCode, UnitCode.kilogram);
    expect(draft.items[0].unitPrice!.toDbString(), '20');
    expect(draft.items[1].unitPrice, isNull);
  });

  test('AI kota/hata → cihaz ayrıştırıcısı, sebep korunur', () async {
    final parser = AiListParser(
      localeCode: 'tr',
      ai: _ai(() => http.Response(jsonEncode({'error': 'quota', 'tier': 'free', 'limit': 15, 'used': 15}), 429)),
    );
    final draft = await parser.parse('2 ekmek, 1 litre süt');
    expect(draft.fromAi, isFalse);
    expect(draft.aiResult, isA<AiQuota>());
    expect(draft.items.length, 2);
  });

  test('AI yokken de cümle bölünür', () async {
    final draft = await AiListParser(localeCode: 'tr').parse('domates ve biber');
    expect(draft.items.map((i) => i.name), ['domates', 'biber']);
  });

  testWidgets('taslak sayfası: yalnız işaretlenenler döner (onaysız kayıt yok)', (tester) async {
    ListDraft? result;
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () async {
              result = await showModalBottomSheet<ListDraft>(
                context: context,
                isScrollControlled: true,
                builder: (_) => ListDraftSheet(parser: AiListParser(localeCode: 'tr')),
              );
            },
            child: const Text('aç'),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('aç'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('draft_text_field')), 'domates, biber, soğan');
    await tester.pump();
    await tester.tap(find.byKey(const Key('draft_convert_button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('draft_item_2')), findsOneWidget);
    await tester.tap(find.byKey(const Key('draft_item_1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('draft_add_button')));
    await tester.pumpAndSettle();
    expect(result!.items.map((c) => c.name), ['domates', 'soğan']);
  });
}
