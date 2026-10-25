import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations_tr.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_export_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('nshoptor/print');
  const service = ReportExportService();
  final l10n = AppLocalizationsTr();
  final text = ReportText(l10n, 'tr', 'TRY');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'PDF channel receives matching escaped HTML, text, title, and RTL',
    () async {
      final document = ReportDocument(
        title: '<script>annual</script>',
        currencyCode: 'TRY',
        shopping: const [],
      );
      MethodCall? received;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            received = call;
            return Uint8List.fromList('%PDF-1.7'.codeUnits);
          });

      final result = await service.bytes(
        document,
        text,
        ReportFileFormat.pdf,
        rtl: true,
      );

      expect(String.fromCharCodes(result.take(5)), '%PDF-');
      expect(received?.method, 'renderPdf');
      final payload = Map<Object?, Object?>.from(received!.arguments as Map);
      expect(payload['title'], document.title);
      expect(
        payload['html'],
        buildShoppingReportHtml(document, text, rtl: true),
      );
      expect(payload['html'], contains('dir="rtl"'));
      expect(
        payload['html'],
        contains('&lt;script&gt;annual&lt;&#47;script&gt;'),
      );
      expect(payload['text'], buildShoppingReportText(document, text));
      expect(payload['text'], contains(document.title));
    },
  );

  test('PDF title is capped before native rendering', () async {
    final document = ReportDocument(
      title: 'x' * 240,
      currencyCode: 'TRY',
      shopping: const [],
    );
    MethodCall? received;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          received = call;
          return Uint8List.fromList('%PDF-1.7'.codeUnits);
        });

    await service.bytes(document, text, ReportFileFormat.pdf);

    final payload = Map<Object?, Object?>.from(received!.arguments as Map);
    expect((payload['title'] as String).length, 200);
  });

  test(
    'PDF rejects null, malformed, short, and oversized native output',
    () async {
      final document = ReportDocument(
        title: 'Report',
        currencyCode: 'TRY',
        shopping: const [],
      );
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

      messenger.setMockMethodCallHandler(channel, (_) async => null);
      await expectLater(
        service.bytes(document, text, ReportFileFormat.pdf),
        throwsFormatException,
      );

      messenger.setMockMethodCallHandler(
        channel,
        (_) async => Uint8List.fromList('not a pdf'.codeUnits),
      );
      await expectLater(
        service.bytes(document, text, ReportFileFormat.pdf),
        throwsFormatException,
      );

      messenger.setMockMethodCallHandler(
        channel,
        (_) async => Uint8List.fromList('%PDF'.codeUnits),
      );
      await expectLater(
        service.bytes(document, text, ReportFileFormat.pdf),
        throwsFormatException,
      );

      final oversized = Uint8List(20 * 1024 * 1024 + 1)
        ..setRange(0, 5, '%PDF-'.codeUnits);
      messenger.setMockMethodCallHandler(channel, (_) async => oversized);
      await expectLater(
        service.bytes(document, text, ReportFileFormat.pdf),
        throwsFormatException,
      );
    },
  );

  test(
    'CSV export has UTF-8 BOM, formula-safe text, and numeric negatives',
    () async {
      final csv = await service.bytes(
        ReportDocument(title: 'CSV', currencyCode: 'TRY', shopping: const []),
        text,
        ReportFileFormat.csv,
      );

      expect(csv.take(3), [0xEF, 0xBB, 0xBF]);
      final content = utf8.decode(csv.sublist(3));
      expect(content, contains('"${l10n.reportDateColumn}"'));
      expect(service.fileName(ReportFileFormat.csv), 'NShoptor-report.csv');
      expect(service.mime(ReportFileFormat.csv), 'text/csv');
    },
  );
}
