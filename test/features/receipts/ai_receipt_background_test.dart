import 'dart:async';
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

class _Blind implements OcrTextSource {
  @override
  Future<OcrScanResult> scan(String _) async => const OcrScanResult(lines: []);
}

class _Images extends ReceiptImageStore {
  @override
  Future<String?> keep(String _) async => 'photo-0';
  @override
  Future<bool> removeOwned(String path) async => true;
}

void main() {
  for (final scenario in ['complete', 'partial', 'deleted', 'superseded']) {
    testWidgets(
      'background reading respects draft identity and lifecycle: $scenario',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        final answer = Completer<http.Response>();
        final ai = AiClient(
          store: SettingsStore(),
          baseUrl: 'https://x',
          httpClient: MockClient((_) => answer.future),
        );
        int? returned = -1;
        await tester.pumpWidget(
          MaterialApp(
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
                  key: const Key('open'),
                  onPressed: () async {
                    returned = await openReceiptCaptureFlow(
                      context,
                      db: db,
                      currencyCode: 'TRY',
                      ai: ai,
                      pickImage: () async => 'picked.jpg',
                      ocrSource: _Blind(),
                      imageStore: _Images(),
                      encodeAiImage: (path) async => '/9j/$path',
                    );
                  },
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        );
        Future<void> settle() async {
          for (var i = 0; i < 20; i++) {
            await tester.pump(const Duration(milliseconds: 100));
            await tester.runAsync(() async {});
          }
        }

        await tester.tap(find.byKey(const Key('open')));
        await settle();
        expect(
          find.byKey(const Key('receipt_reading_progress')),
          findsOneWidget,
        );
        await tester.tap(find.byKey(const Key('receipt_read_in_background')));
        await settle();
        expect(find.byKey(const Key('receipt_reading_progress')), findsNothing);
        expect(returned, isNull);
        final initial = (await ReceiptDraftRepository(db).pending()).single;
        if (scenario == 'deleted') {
          await ReceiptRepository(db).delete(initial.id);
        } else if (scenario == 'superseded') {
          await ReceiptDraftRepository(db).save(
            draftId: initial.id,
            document: initial.document,
            imagePaths: ['replacement-photo'],
          );
        }

        answer.complete(
          http.Response(
            jsonEncode({
              'tier': 'pro',
              'used': 1,
              'limit': 100,
              'result': {
                'schema': 2,
                'status': scenario == 'partial' ? 'bottom_missing' : 'complete',
                'store': 'A101 MARKET',
                'date': '2026-10-24',
                'time': '18:41',
                'documentNumber': '000123',
                'currency': 'TRY',
                'items': [
                  {'name': 'ELMA', 'lineTotal': '20.00'},
                  {'name': 'SÜT', 'lineTotal': '30.00'},
                ],
                'discounts': [],
                if (scenario != 'partial') 'total': '50.00',
                'reconciles': true,
              },
            }),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          ),
        );
        await settle();

        if (scenario == 'deleted' || scenario == 'superseded') {
          expect(await db.select(db.shoppingLists).get(), isEmpty);
          expect(await db.select(db.plannedItems).get(), isEmpty);
          final drafts = await ReceiptDraftRepository(db).pending();
          if (scenario == 'deleted') {
            expect(drafts, isEmpty);
          } else {
            expect(drafts.single.id, initial.id);
            expect(drafts.single.imagePaths, ['replacement-photo']);
          }
          return;
        }

        final list = (await db.select(db.shoppingLists).get()).single;
        expect(list.title, 'A101 MARKET');
        final draft = (await ReceiptDraftRepository(
          db,
        ).pending(listId: list.id)).single;
        expect(draft.id, initial.id);
        if (scenario == 'partial') {
          expect(
            (await db.select(db.plannedItems).get()).map(
              (i) => i.createdByReceiptId,
            ),
            [draft.id, draft.id],
          );
          await ReceiptDraftRepository(db).discard(draft.id);
          expect(await db.select(db.plannedItems).get(), isEmpty);
        } else {
          expect(draft.document.toParseResult().totalMinor, 5000);
        }
        expect(await ReceiptDraftRepository(db).pending(), isEmpty);
      },
    );
  }
}
