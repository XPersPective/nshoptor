import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:image/image.dart' as img;
import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/receipt_queue_service.dart';
import 'package:nshoptor/features/receipts/receipt_read_failure.dart';
import 'package:nshoptor/features/receipts/receipt_read_failure_text.dart';
import 'package:nshoptor/features/receipts/receipt_repository.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/shopping_mode/item_price_cell.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/features/subscription/plan_badge.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

class _StubAiClient extends AiClient {
  _StubAiClient(this.responder)
    : super(
        store: SettingsStore(),
        baseUrl: 'https://example.invalid',
        httpClient: MockClient((_) async => http.Response('{}', 500)),
      );

  final Future<AiResult> Function(String task, Map<String, Object?> input)
  responder;

  @override
  Future<AiResult> request(
    String task,
    Map<String, Object?> input, {
    String locale = 'en',
    Duration? timeout,
  }) => responder(task, input);
}

Uint8List _tinyJpegBytes() {
  final image = img.Image(width: 16, height: 16);
  img.fill(image, color: img.ColorRgb8(240, 240, 240));
  return Uint8List.fromList(img.encodeJpg(image));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SOK receipt discount attribution & core fixes', () {
    late AppDatabase db;
    late Directory tempDir;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      tempDir = Directory.systemTemp.createTempSync('receipt_discount_test_');
    });

    tearDown(() async {
      await db.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test(
      'attributes item discount via token match and explicit itemIndex, roundtrips, commits net 427.42 TL, and reports discount details',
      () async {
        final aiResultPayload = <String, Object?>{
          'schema': 2,
          'status': 'complete',
          'store': 'ŞOK MARKETLER TİC. A.Ş.',
          'date': '2026-11-12',
          'time': '19:15',
          'documentNumber': 'SOK-427',
          'currency': 'TRY',
          'total': '427.42',
          'items': [
            {
              'name': 'FINISH QUANTUM 20 KAP.',
              'quantity': '2',
              'unit': 'piece',
              'unitPrice': '259.00',
              'lineTotal': '518.00',
            },
            {
              'name': 'TAM YAĞLI TAZE PEYNİR',
              'quantity': '1',
              'unit': 'piece',
              'unitPrice': '207.42',
              'lineTotal': '207.42',
            },
          ],
          'discounts': [
            {
              'label': '25TLFINISH110TL',
              'amount': '298.00',
              'itemIndex': null,
            },
          ],
        };

        final reader = AiReceiptReader(
          _StubAiClient(
            (_, _) async =>
                AiOk(aiResultPayload, tier: 'pro', used: 1, limit: 100),
          ),
          localeCode: 'tr',
          encode: (_) async => base64Encode([1, 2, 3]),
        );

        final outcome = await reader.read(['page1.jpg'], currencyCode: 'TRY');
        expect(outcome, isA<AiReceiptVerified>());
        final doc = (outcome as AiReceiptVerified).document;

        // Roundtrip through encode/decode keeps discount fields.
        final decoded = ReceiptDocument.decode(doc.encode());
        final parse = decoded.toParseResult();
        expect(parse.unattributedDiscountMinor, 0);
        expect(parse.lines, hasLength(2));

        final finish = parse.lines[0];
        expect(finish.name, 'FINISH QUANTUM 20 KAP.');
        expect(finish.lineTotalMinor, 51800);
        expect(finish.discountMinor, 29800);
        expect(finish.discountLabel, '25TLFINISH110TL');
        expect(parse.computedTotalMinor, 42742);

        // Explicit itemIndex attribution also works cleanly.
        aiResultPayload['discounts'] = [
          {
            'label': 'KASA INDIRIMI',
            'amount': '298.00',
            'itemIndex': 0,
          },
        ];
        final explicitOutcome = await reader.read([
          'page1.jpg',
        ], currencyCode: 'TRY');
        final explicitLines = (explicitOutcome as AiReceiptVerified).document
            .toParseResult()
            .lines;
        expect(explicitLines[0].discountMinor, 29800);
        expect(explicitLines[0].discountLabel, 'KASA INDIRIMI');

        // Commit through ReceiptReviewController into a list.
        final lists = ListRepository(db);
        final listId = await lists.createList(
          title: 'ŞOK Market',
          currencyCode: 'TRY',
        );
        final controller = ReceiptReviewController(
          db: db,
          document: decoded,
          listId: listId,
          parseResult: parse,
        );
        for (var i = 0; i < controller.lines.length; i++) {
          controller.accept(i);
        }
        await controller.commit();
        controller.dispose();

        final shoppingRepo = ShoppingRepository(db);
        final entries = await shoppingRepo.watchEntries(listId).first;
        final planned = await shoppingRepo.watchItems(listId).first;
        expect(planned, hasLength(2));
        expect(entries, hasLength(2));

        final finishItem = planned.firstWhere(
          (p) => p.name.contains('FINISH'),
        );
        final finishEntry = entries.firstWhere(
          (e) => e.plannedItemId == finishItem.id,
        );
        expect(finishEntry.actualLineTotalMinorUnits, 22000);
        expect(finishEntry.discountMinorUnits, 29800);
        expect(finishEntry.note, '25TLFINISH110TL');

        final prices = ItemPrices.of(finishItem, entries);
        expect(prices.actualMinor, 22000);
        expect(prices.grossActualMinor, 51800);
        expect(prices.discountMinor, 29800);
        expect(prices.discountLabel, '25TLFINISH110TL');

        final report = await ReportRepository(db).shopping(listId);
        expect(report.spent.minor, 42742);
        final finishReport = report.products.firstWhere(
          (p) => p.name.contains('FINISH'),
        );
        expect(finishReport.actual.minor, 22000);
        expect(finishReport.discountMinor, 29800);
        expect(finishReport.discountLabel, '25TLFINISH110TL');
      },
    );

    test(
      'detachAndDelete and removePhoto delete targeted receipt/photo while preserving list items',
      () async {
        final images = ReceiptImageStore(directoryOverride: tempDir);
        final repo = ReceiptRepository(db, images: images);
        final lists = ListRepository(db);
        final listId = await lists.createList(
          title: 'Market',
          currencyCode: 'TRY',
        );

        final p1 = await images.keepBytes(Uint8List.fromList([1, 2, 3]));
        final p2 = await images.keepBytes(Uint8List.fromList([4, 5, 6]));
        final receiptId = await db
            .into(db.receipts)
            .insert(
              ReceiptsCompanion.insert(
                listId: Value(listId),
                detectedStore: const Value('ŞOK'),
                processingStatus: const Value('complete'),
                imagePaths: Value([p1, p2]),
              ),
            );
        final itemId = await db
            .into(db.plannedItems)
            .insert(
              PlannedItemsCompanion.insert(
                listId: listId,
                name: 'Finish Quantum',
                normalizedName: 'finish quantum',
                plannedQuantity: '1',
                plannedUnitCode: 'piece',
                pricingInputMode: 'unitPrice',
                createdByReceiptId: Value(receiptId),
              ),
            );
        await db
            .into(db.purchaseEntries)
            .insert(
              PurchaseEntriesCompanion.insert(
                listId: listId,
                plannedItemId: Value(itemId),
                receiptId: Value(receiptId),
                name: 'Finish Quantum',
                normalizedName: 'finish quantum',
                actualQuantity: '1',
                actualUnitCode: 'piece',
                actualLineTotalMinorUnits: 22000,
              ),
            );

        expect(await repo.removePhoto(receiptId, p1), isTrue);
        expect(File(p1).existsSync(), isFalse);
        expect(File(p2).existsSync(), isTrue);
        final afterPhotoRemove = await (db.select(
          db.receipts,
        )..where((t) => t.id.equals(receiptId))).getSingle();
        expect(afterPhotoRemove.imagePaths, [p2]);

        expect(await repo.detachAndDelete(receiptId), isTrue);
        expect(File(p2).existsSync(), isFalse);
        expect(await db.select(db.receipts).get(), isEmpty);
        final items = await db.select(db.plannedItems).get();
        final entries = await db.select(db.purchaseEntries).get();
        expect(items, hasLength(1));
        expect(items.single.createdByReceiptId, isNull);
        expect(entries, hasLength(1));
        expect(entries.single.receiptId, isNull);
        expect(entries.single.actualLineTotalMinorUnits, 22000);
      },
    );

    test('AiQuota maps to ReceiptReadFailure.quotaExceeded cleanly', () async {
      final images = ReceiptImageStore(directoryOverride: tempDir);
      final owned = await images.keepBytes(_tinyJpegBytes());
      final drafts = ReceiptDraftRepository(db);
      final draftId = await drafts.enqueueCaptured(
        imagePaths: [owned],
        currencyCode: 'TRY',
      );
      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        ai: _StubAiClient(
          (_, _) async => const AiQuota(tier: 'free', limit: 10, used: 10),
        ),
        scheduleBackgroundHook: () async {},
      );
      await service.drain();
      final failed = (await drafts.getById(draftId))!;
      expect(failed.queueState, 'failed');
      final failure = ReceiptReadFailure.fromCode(failed.queueError);
      expect(failure, ReceiptReadFailure.quotaExceeded);
      expect(failure.code, 'quota_reached');
      final l10n = await AppLocalizations.delegate.load(const Locale('tr'));
      expect(failure.label(l10n), isNotEmpty);
      expect(failure.guidance(l10n), isNotEmpty);
    });

    testWidgets(
      'AppTheme dark uses slate-grey surface and PlanBadge shows Free pill',
      (tester) async {
        final darkSurface = AppTheme.dark().colorScheme.surface;
        expect(darkSurface, AppTheme.brandDarkSurface);
        final g = (darkSurface.g * 255).round();
        final r = (darkSurface.r * 255).round();
        final b = (darkSurface.b * 255).round();
        expect(g, greaterThan(r));
        expect(g, greaterThan(b));

        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context);
                return Scaffold(
                  body: PlanBadge(
                    badgeKey: const Key('test_free_badge'),
                    label: planLabel(
                      l10n,
                      tier: Tier.free,
                      proUnlocked: false,
                    ),
                    trial: false,
                    active: false,
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
        );
        expect(find.text('Free'), findsOneWidget);
      },
    );
  });
}
