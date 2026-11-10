import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidate_sheet.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';

PriceCandidate candidate(String dbValue) => PriceCandidate(
  value: DecimalFixed.parse(dbValue),
  currencyCode: 'TRY',
  sourceLine: '$dbValue TL',
  confidence: 'high',
  isUnitPrice: false,
);

Widget app(Future<void> Function(BuildContext context) open) => MaterialApp(
  locale: const Locale('tr'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: Scaffold(
    body: Builder(
      builder: (context) => TextButton(
        key: const Key('open_sheet'),
        onPressed: () => open(context),
        child: const Text('open'),
      ),
    ),
  ),
);

void main() {
  testWidgets('picking a listed candidate returns it unchanged', (tester) async {
    PriceCandidateSheetResult? result;
    await tester.pumpWidget(app((context) async {
      result = await showPriceCandidateSheet(
        context,
        [candidate('24.95')],
        currencyCode: 'TRY',
      );
    }));
    await tester.tap(find.byKey(const Key('open_sheet')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('price_candidate_0')));
    await tester.pumpAndSettle();
    expect(result, isNotNull);
    expect(result!.retake, isFalse);
    expect(result!.candidate!.value.toDbString(), '24.95');
    expect(result!.candidate!.sourceLine, '24.95 TL');
  });

  testWidgets('manual entry accepts a typed price and returns a candidate', (
    tester,
  ) async {
    PriceCandidateSheetResult? result;
    await tester.pumpWidget(app((context) async {
      result = await showPriceCandidateSheet(
        context,
        const [],
        currencyCode: 'TRY',
      );
    }));
    await tester.tap(find.byKey(const Key('open_sheet')));
    await tester.pumpAndSettle();
    // An empty reading is not a dead end: manual entry stays reachable.
    expect(find.byKey(const Key('no_price_candidates')), findsOneWidget);
    final manualAction = find.byKey(const Key('price_manual_entry'));
    expect(manualAction, findsOneWidget);
    expect(tester.getSize(manualAction).height, greaterThanOrEqualTo(48));

    await tester.tap(manualAction);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('price_manual_entry_field')),
      '12,50',
    );
    await tester.tap(find.byKey(const Key('price_manual_entry_confirm')));
    await tester.pumpAndSettle();

    expect(result, isNotNull);
    expect(result!.retake, isFalse);
    final typed = result!.candidate!;
    expect(typed.value.toDbString(), '12.50');
    expect(typed.currencyCode, 'TRY');
    expect(typed.confidence, 'manual');
    expect(typed.isUnitPrice, isFalse);
  });

  testWidgets('manual entry rejects an invalid amount without closing', (
    tester,
  ) async {
    PriceCandidateSheetResult? result;
    await tester.pumpWidget(app((context) async {
      result = await showPriceCandidateSheet(context, const []);
    }));
    await tester.tap(find.byKey(const Key('open_sheet')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('price_manual_entry')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('price_manual_entry_field')),
      '1,2,3',
    );
    await tester.tap(find.byKey(const Key('price_manual_entry_confirm')));
    await tester.pumpAndSettle();
    // The dialog stays open with an error; the sheet has no result yet.
    expect(find.byKey(const Key('price_manual_entry_field')), findsOneWidget);
    expect(result, isNull);
    // Cancel keeps the sheet open so the user can still pick or retake.
    await tester.tap(find.text('Vazgeç'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('price_manual_entry')), findsOneWidget);
    expect(result, isNull);
  });

  testWidgets('retake action pops with the retake sentinel', (tester) async {
    PriceCandidateSheetResult? result;
    await tester.pumpWidget(app((context) async {
      result = await showPriceCandidateSheet(
        context,
        [candidate('24.95')],
        currencyCode: 'TRY',
      );
    }));
    await tester.tap(find.byKey(const Key('open_sheet')));
    await tester.pumpAndSettle();
    final retake = find.byKey(const Key('price_retake'));
    expect(tester.getSize(retake).height, greaterThanOrEqualTo(48));
    await tester.tap(retake);
    await tester.pumpAndSettle();
    expect(result, isNotNull);
    expect(result!.retake, isTrue);
    expect(result!.candidate, isNull);
  });

  testWidgets('the flow can hide the retake action on the last attempt', (
    tester,
  ) async {
    PriceCandidateSheetResult? result;
    await tester.pumpWidget(app((context) async {
      result = await showPriceCandidateSheet(
        context,
        [candidate('24.95')],
        allowRetake: false,
      );
    }));
    await tester.tap(find.byKey(const Key('open_sheet')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('price_retake')), findsNothing);
    expect(find.byKey(const Key('price_manual_entry')), findsOneWidget);
    // Manual entry remains available even without retake.
    await tester.tap(find.byKey(const Key('price_manual_entry')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('price_manual_entry_field')),
      '5',
    );
    await tester.tap(find.byKey(const Key('price_manual_entry_confirm')));
    await tester.pumpAndSettle();
    expect(result!.candidate!.value.toDbString(), '5');
  });

  testWidgets('renders shelf candidate sheet cleanly without overflow', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    await tester.pumpWidget(RepaintBoundary(
      key: const Key('repaint'),
      child: app((context) async {
        await showPriceCandidateSheet(
          context,
          [candidate('24.95'), candidate('19.90')],
          currencyCode: 'TRY',
        );
      }),
    ));
    await tester.tap(find.byKey(const Key('open_sheet')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('price_candidate_0')), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.runAsync(() async {
      final boundary = tester.renderObject(find.byKey(const Key('repaint'))) as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final out = File('.project-brain/evidence/PB-208/shelf-candidate-sheet.png');
        out.parent.createSync(recursive: true);
        out.writeAsBytesSync(byteData.buffer.asUint8List());
      }
    });
  });
}
