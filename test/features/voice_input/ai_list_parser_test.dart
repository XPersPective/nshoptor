import 'dart:convert';

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
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';

AiClient _ai(http.Response Function() reply) => AiClient(
      store: SettingsStore(),
      baseUrl: 'https://x',
      httpClient: MockClient((_) async => reply()),
    );

http.Response _items(List<Map<String, Object?>> items) => http.Response(
      jsonEncode({'tier': 'free', 'used': 1, 'limit': 15, 'result': {'items': items}}),
      200,
    );

void main() {
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
    List<ParsedItemCandidate>? result;
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
              result = await showModalBottomSheet<List<ParsedItemCandidate>>(
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
    expect(result!.map((c) => c.name), ['domates', 'soğan']);
  });
}
