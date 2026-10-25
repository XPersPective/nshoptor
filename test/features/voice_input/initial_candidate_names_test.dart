import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/features/voice_input/ai_list_parser.dart';
import 'package:nshoptor/features/voice_input/list_draft_sheet.dart';
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';
import 'package:nshoptor/features/voice_input/voice_input_service.dart';
import 'package:nshoptor/features/voice_input/voice_preview_sheet.dart';

final _candidate = ParsedItemCandidate(
  name: 'incir eLMa',
  rawText: '400 gram incir',
  brand: 'Özel',
  category: 'Custom',
  quantity: DecimalFixed.fromInt(400),
  unitCode: UnitCode.gram,
  unitPrice: DecimalFixed.fromInt(875),
  currencyCode: 'TRY',
  isUnitPrice: true,
  priceUnitCode: UnitCode.kilogram,
  priceDestination: VoicePriceDestination.actual,
);

class _Parser extends AiListParser {
  _Parser() : super(localeCode: 'tr');

  @override
  Future<ListDraft> parse(String text) async => ListDraft(
    [_candidate],
    fromAi: true,
    parseDuration: const Duration(milliseconds: 123),
    modelCalls: 1,
  );
}

Widget _app(Widget child) => MaterialApp(
  locale: const Locale('tr'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: Scaffold(body: child),
);

void _expectMetadata(ParsedItemCandidate item) {
  expect(item.rawText, _candidate.rawText);
  expect(item.brand, _candidate.brand);
  expect(item.category, _candidate.category);
  expect(item.quantity?.toDbString(), _candidate.quantity?.toDbString());
  expect(item.unitCode, _candidate.unitCode);
  expect(item.unitPrice?.toDbString(), _candidate.unitPrice?.toDbString());
  expect(item.currencyCode, _candidate.currencyCode);
  expect(item.isUnitPrice, _candidate.isUnitPrice);
  expect(item.priceUnitCode, _candidate.priceUnitCode);
  expect(item.priceDestination, _candidate.priceDestination);
}

void main() {
  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  test('name copy preserves every candidate field', () {
    final renamed = _candidate.withName('İncir eLMa');
    expect(renamed.name, 'İncir eLMa');
    _expectMetadata(renamed);
    expect(_candidate.name, 'incir eLMa');
  });

  testWidgets(
    'draft names initially capitalize; explicit lowercase edits and metadata survive approval',
    (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      ListDraft? approved;
      await tester.pumpWidget(
        _app(
          ListDraftSheet(
            parser: _Parser(),
            initialText: 'incir',
            allowTitle: false,
            onApprove: (value) async {
              approved = value;
            },
          ),
        ),
      );
      await settle(tester);
      expect(find.text('İncir eLMa'), findsOneWidget);
      await tester.tap(find.byKey(const Key('draft_edit_0')));
      await settle(tester);
      await tester.enterText(
        find.byKey(const Key('draft_edit_name')),
        'incir eLMa',
      );
      await tester.tap(find.byKey(const Key('draft_edit_save')));
      await settle(tester);
      expect(find.text('incir eLMa'), findsOneWidget);
      await tester.tap(find.byKey(const Key('draft_add_button')));
      await settle(tester);
      expect(approved?.items.single.name, 'incir eLMa');
      _expectMetadata(approved!.items.single);
      expect(approved!.parseDuration, const Duration(milliseconds: 123));
      expect(approved!.modelCalls, 1);
      expect(approved!.fromAi, isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('single voice preview capitalizes its initial candidate', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(VoicePreviewSheet(service: FakeSpeechService())),
    );
    await tester.enterText(
      find.byKey(const Key('voice_transcript_field')),
      'bir incir',
    );
    await settle(tester);
    await tester.ensureVisible(find.byKey(const Key('voice_parse_button')));
    await tester.tap(find.byKey(const Key('voice_parse_button')));
    await settle(tester);
    expect(find.textContaining('İncir'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
