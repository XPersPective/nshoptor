import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_capture_flow.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/receipt_repository.dart';

/// Device OCR that cannot read the script (e.g. Arabic): always empty.
class _Blind implements OcrTextSource {
  @override
  Future<OcrScanResult> scan(String _) async => const OcrScanResult(lines: []);
}

class _Images extends ReceiptImageStore {
  var n = 0;
  @override
  Future<String?> keep(String _) async => 'photo-${n++}';
  @override
  Future<bool> removeOwned(String path) async => true;
}

Map<String, dynamic> _complete() => {
  'schema': 2,
  'status': 'complete',
  'store': 'بنده هايبر',
  'date': '2026-10-20',
  'time': '18:41',
  'documentNumber': '000123',
  'currency': 'SAR',
  'items': [
    {'name': 'حليب', 'lineTotal': '7.50'},
    {'name': 'خبز', 'lineTotal': '2.00'},
  ],
  'discounts': [],
  'total': '9.50',
  'reconciles': true,
};

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets(
    'a cut-off receipt is completed by guided continuation without losing the first photo',
    (tester) async {
      final requests = <List<Object?>>[];
      final answers = [
        {
          'schema': 2,
          'status': 'bottom_missing',
          'store': 'بنده هايبر',
          'date': '2026-10-20',
          // Rows visible on the cut-off part go to the list at once (F16).
          'items': [
            {'name': 'حليب', 'lineTotal': '7.50'},
          ],
        },
        _complete(),
      ];
      final ai = AiClient(
        store: SettingsStore(),
        baseUrl: 'https://x',
        httpClient: MockClient((request) async {
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          if (body['task'] != 'read_receipt_image') {
            // Line matching is not under test: let the app fall back.
            return http.Response('{"error":"ai_failed"}', 502);
          }
          requests.add((body['input'] as Map)['images'] as List);
          return http.Response(
            jsonEncode({
              'tier': 'pro',
              'used': requests.length,
              'limit': 100,
              'result': answers[requests.length - 1],
            }),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );
      Object? failure;
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
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
                key: const Key('open'),
                onPressed: () async {
                  try {
                    await openReceiptCaptureFlow(
                      context,
                      db: db,
                      // Device currency differs from the receipt (F: emulator en-US).
                      currencyCode: 'USD',
                      ai: ai,
                      pickImage: () async => 'picked.jpg',
                      ocrSource: _Blind(),
                      imageStore: _Images(),
                      encodeAiImage: (path) async => '/9j/$path',
                    );
                  } catch (e) {
                    failure = e;
                  }
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      // The mock HTTP response completes on the real event loop.
      Future<void> settle() async {
        for (var i = 0; i < 30; i++) {
          await tester.pump(const Duration(milliseconds: 100));
          await tester.runAsync(() async {});
        }
      }

      await tester.tap(find.byKey(const Key('open')));
      await settle();

      // The model saw the top only: the app asks for the rest itself.
      final l10n = await AppLocalizations.delegate.load(const Locale('ar'));
      expect(find.text(l10n.receiptIncompleteTail), findsOneWidget);
      expect(requests.single, ['/9j/photo-0']);
      // Header read: the list exists at once and owns the unfinished receipt.
      final list = (await db.select(db.shoppingLists).get()).single;
      expect(list.title, 'بنده هايبر');
      expect((await db.select(db.plannedItems).get()).map((i) => i.name), [
        'حليب',
      ]);
      expect(
        (await ReceiptDraftRepository(db).pending(listId: list.id))
            .single
            .imagePaths,
        ['photo-0'],
      );
      expect(await ReceiptDraftRepository(db).pending(), isEmpty);
      final partialDraft = (await ReceiptDraftRepository(
        db,
      ).pending(listId: list.id)).single;
      expect(
        (await db.select(db.plannedItems).get()).single.createdByReceiptId,
        partialDraft.id,
      );

      await tester.tap(find.byKey(const Key('receipt_capture_camera')));
      await settle();

      expect(failure, isNull);
      expect(requests.last, ['/9j/photo-0', '/9j/photo-1']);
      expect(find.byKey(const Key('receipt_line_1')), findsOneWidget);
      expect(find.text('حليب'), findsWidgets);

      // Saving keeps every line without per-line approval (F17).
      await tester.ensureVisible(
        find.byKey(const Key('receipt_commit_button')),
      );
      await tester.tap(find.byKey(const Key('receipt_commit_button')));
      await settle();
      expect(failure, isNull);
      expect(await db.select(db.purchaseEntries).get(), hasLength(2));
      // The early row is priced by the saved receipt, not duplicated.
      expect(
        (await db.select(db.plannedItems).get()).map((i) => i.name).toList()
          ..sort(),
        ['حليب', 'خبز']..sort(),
      );
      expect(
        (await db.select(db.shoppingLists).get()).single.currencyCode,
        'SAR',
      );
      final receipt = (await db.select(db.receipts).get()).single;
      expect(receipt.id, partialDraft.id);
      expect(
        (await db.select(db.plannedItems).get()).map(
          (i) => i.createdByReceiptId,
        ),
        everyElement(receipt.id),
      );
      await ReceiptRepository(db).delete(receipt.id);
      expect(await db.select(db.plannedItems).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    },
  );
}
