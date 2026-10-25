import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_export_service.dart';
import 'package:nshoptor/features/history/reports/report_preview_screen.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';

class _Export extends ReportExportService {
  Completer<Uint8List> pending = Completer();
  int renders = 0, saves = 0, shares = 0;
  @override
  Future<Uint8List> bytes(
    ReportDocument document,
    ReportText text,
    ReportFileFormat format, {
    bool rtl = false,
  }) {
    renders++;
    return pending.future;
  }

  @override
  Future<bool> save(
    Uint8List data,
    ReportFileFormat format,
    String title,
  ) async {
    saves++;
    return false;
  }

  @override
  Future<void> share(
    Uint8List data,
    ReportFileFormat format,
    Rect origin,
  ) async {
    shares++;
  }
}

ReportDocument document({bool empty = false}) {
  final date = DateTime(2026, 10, 25, 12, 30);
  return ReportDocument(
    title: 'Pazar / قائمة المشتريات',
    currencyCode: 'TRY',
    shopping: empty
        ? []
        : [
            ShoppingReport(
              list: ShoppingList(
                id: 1,
                title: 'Market / السوق',
                createdAt: date,
                updatedAt: date,
                completedAt: date,
                currencyCode: 'TRY',
                status: 'completed',
                sortOrder: 0,
              ),
              storeName: 'Örnek / السوق',
              receipts: [],
              plannedMinor: 4000,
              spent: const SpendAmount(3000, known: true, unknown: false),
              products: [
                ReportProduct(
                  name: 'Çilek ve yoğurt / تفاح وحليب',
                  plannedQuantity: DecimalFixed.parse('1.25'),
                  plannedUnitCode: 'kilogram',
                  plannedMinor: 4000,
                  actualQuantities: [
                    (
                      quantity: DecimalFixed.parse('1.25'),
                      unitCode: 'kilogram',
                    ),
                  ],
                  actual: const SpendAmount(3000, known: true, unknown: false),
                  purchased: true,
                ),
              ],
            ),
          ],
  );
}

Widget subject(
  ReportDocument document, {
  String locale = 'tr',
  bool dark = false,
  double scale = 1,
  ReportExportService service = const ReportExportService(),
}) => MaterialApp(
  locale: Locale(locale),
  theme: dark ? AppTheme.dark() : AppTheme.light(),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: ReportPreviewScreen(document: document, exportService: service),
);

void main() {
  for (final spec in [
    (320.0, 'tr', true, 2.0),
    (320.0, 'ar', false, 2.0),
    (800.0, 'ar', true, 2.0),
    (412.0, 'tr', false, 1.0),
  ]) {
    testWidgets('preview wraps and preserves read-only semantics $spec', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(Size(spec.$1, 850));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpWidget(
          subject(document(), locale: spec.$2, dark: spec.$3, scale: spec.$4),
        );
        await tester.pumpAndSettle();
        expect(find.byType(Checkbox), findsNothing);
        expect(find.byKey(const Key('report_product_0_0')), findsOneWidget);
        final mark = find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.checked == true,
        );
        expect(mark, findsOneWidget);
        expect(tester.widget<Semantics>(mark).properties.readOnly, isTrue);
        await tester.tap(find.byKey(const Key('report_zoom')));
        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView), const Offset(0, -600));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      } finally {
        semantics.dispose();
      }
    });
  }
  testWidgets(
    'export rejects double taps, cancellation is quiet, errors permit retry',
    (tester) async {
      final export = _Export();
      await tester.pumpWidget(subject(document(empty: true), service: export));
      await tester.pumpAndSettle();
      final l = AppLocalizations.of(tester.element(find.byType(Scaffold)));
      final button = find.widgetWithText(OutlinedButton, l.reportPdfAction);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();
      await tester.tap(button);
      expect(export.renders, 1);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      export.pending.complete(Uint8List.fromList('%PDF-qa'.codeUnits));
      await tester.pumpAndSettle();
      expect(export.saves, 1);
      expect(find.text(l.reportSaved), findsNothing);
      expect(find.text(l.saveFailed), findsNothing);
      export.pending = Completer();
      await tester.tap(button);
      await tester.pump();
      export.pending.completeError(StateError('synthetic renderer failure'));
      await tester.pumpAndSettle();
      expect(find.text(l.saveFailed), findsOneWidget);
      expect(tester.widget<OutlinedButton>(button).onPressed, isNotNull);
    },
  );
}
