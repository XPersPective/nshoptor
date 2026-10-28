import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_capture_flow.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';

OcrScanResult _scan(List<String> rows) =>
    OcrScanResult(lines: [for (final text in rows) OcrLine(text: text)]);
const _header = [
  'A101 MARKET',
  'TARİH: 24.10.2026',
  'SAAT: 18:41',
  'FİŞ NO: 000123',
];

class _Frames implements OcrTextSource {
  _Frames(this.frames);
  final List<OcrScanResult> frames;
  @override
  Future<OcrScanResult> scan(String _) async => frames.removeAt(0);
}

class _Images extends ReceiptImageStore {
  final copied = <String>[];
  final removed = <String>[];
  @override
  Future<String?> keep(String _) async {
    final name = 'owned-image-${copied.length}';
    copied.add(name);
    return name;
  }

  @override
  Future<bool> removeOwned(String path) async {
    removed.add(path);
    return true;
  }
}

void main() {
  late AppDatabase db;
  late _Images images;
  int? committed;
  int? flowListId;
  Object? failure;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    images = _Images();
    committed = null;
    flowListId = null;
    failure = null;
  });
  tearDown(() => db.close());
  setUpAll(() async {
    if (const String.fromEnvironment('CAPTURE_OUT').isEmpty) return;
    final fonts = FontLoader('Roboto');
    for (final name in ['segoeui.ttf', 'segoeuib.ttf']) {
      fonts.addFont(
        File('C:/Windows/Fonts/$name').readAsBytes().then(ByteData.sublistView),
      );
    }
    await fonts.load();
    final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
    await (FontLoader('MaterialIcons')..addFont(
          File(
            '$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
          ).readAsBytes().then(ByteData.sublistView),
        ))
        .load();
  });

  Widget app(
    _Frames source, {
    String locale = 'tr',
    bool dark = false,
    double scale = 1,
    bool cancel = false,
  }) => MaterialApp(
    locale: Locale(locale),
    supportedLocales: AppLocalizations.supportedLocales,
    theme: dark ? AppTheme.dark() : AppTheme.light(),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(scale)),
      child: child!,
    ),
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          key: const Key('open_capture'),
          onPressed: () async {
            try {
              committed = await openReceiptCaptureFlow(
                context,
                db: db,
                currencyCode: 'TRY',
                listId: flowListId,
                pickImage: () async => cancel ? null : 'picker.img',
                ocrSource: source,
                imageStore: images,
              );
            } catch (error) {
              failure = error;
            }
          },
          child: const Text('open'),
        ),
      ),
    ),
  );

  // Headed unfinished receipts are owned by the list created for them.
  Future<ReceiptDraft> ownedDraft() async {
    final lists = await db.select(db.shoppingLists).get();
    // A header-less part has no list yet; it lives only for this session.
    return (await ReceiptDraftRepository(db)
            .pending(listId: lists.isEmpty ? null : lists.single.id))
        .single;
  }

  Future<void> tap(WidgetTester tester, String key) async {
    final finder = find.byKey(Key(key));
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    expect(finder.hitTestable(), findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'canceling initial acquisition creates no draft or shopping data',
    (tester) async {
      await tester.pumpWidget(app(_Frames([]), cancel: true));
      await tap(tester, 'open_capture');
      expect(await db.select(db.receipts).get(), isEmpty);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(images.copied, isEmpty);
      expect(failure, isNull);
    },
  );

  testWidgets(
    'partial receipt saves, leaves and resumes to one approved purchase set',
    (tester) async {
      final frames = _Frames([
        _scan([..._header, 'ELMA 20,00', 'EKMEK 40,00']),
        _scan(['EKMEK 40,00', 'SÜT 30,00', 'TOPLAM 90,00 TL']),
      ]);
      await tester.pumpWidget(app(frames));
      await tap(tester, 'open_capture');
      expect(find.byKey(const Key('receipt_capture_camera')), findsOneWidget);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      await tap(tester, 'receipt_capture_later');
      // Store and date are known: the list now owns the unfinished receipt.
      final list = (await db.select(db.shoppingLists).get()).single;
      expect(list.title, 'A101 MARKET');
      expect(await ReceiptDraftRepository(db).pending(), isEmpty);
      final draft = (await ReceiptDraftRepository(db).pending(listId: list.id))
          .single;
      expect(draft.document.fragments, hasLength(1));
      flowListId = list.id;
      await tap(tester, 'open_capture');
      await tap(tester, 'receipt_resume_${draft.id}');
      await tap(tester, 'receipt_capture_camera');
      expect(find.byKey(const Key('receipt_line_2')), findsOneWidget);
      await tap(tester, 'receipt_accept_all');
      await tap(tester, 'receipt_commit_button');
      expect(failure, isNull);
      expect(committed, isNotNull);
      expect(await db.select(db.receipts).get(), hasLength(1));
      expect(await db.select(db.purchaseEntries).get(), hasLength(3));
      expect(await ReceiptDraftRepository(db).pending(), isEmpty);
      expect(find.byKey(const Key('open_capture')), findsOneWidget);
    },
  );

  testWidgets(
    'new receipt list uses merchant title and review quantity basis is readable',
    (tester) async {
      await tester.pumpWidget(
        app(
          _Frames([
            _scan([
              ..._header,
              'SÜT 1 kg × 20,00 20,00',
              'ELMA 20,00',
              'TOPLAM 40,00 TL',
            ]),
          ]),
        ),
      );
      await tap(tester, 'open_capture');

      final quantityRow = tester
          .widgetList<Text>(
            find.descendant(
              of: find.byKey(const Key('receipt_line_0')),
              matching: find.byType(Text),
            ),
          )
          .last
          .data!;
      expect(quantityRow, startsWith('1 kg × '));

      final plainRow = tester
          .widgetList<Text>(
            find.descendant(
              of: find.byKey(const Key('receipt_line_1')),
              matching: find.byType(Text),
            ),
          )
          .last
          .data!;
      expect(plainRow, isNot(startsWith('·')));
      expect(plainRow, isNot(endsWith('×')));

      await tap(tester, 'receipt_accept_all');
      await tap(tester, 'receipt_commit_button');
      expect(failure, isNull);
      expect(committed, isNotNull);
      final list = (await db.select(db.shoppingLists).get()).single;
      expect(list.title, 'A101 MARKET');
      expect(await db.select(db.purchaseEntries).get(), hasLength(2));
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'nonoverlapping photo preserves previous evidence and remains recoverable',
    (tester) async {
      await tester.pumpWidget(
        app(
          _Frames([
            _scan([..._header, 'ELMA 20,00', 'EKMEK 40,00']),
            _scan(['AYVA 10,00', 'TOPLAM 10,00 TL']),
          ]),
        ),
      );
      await tap(tester, 'open_capture');
      await tap(tester, 'receipt_capture_camera');
      expect(
        find.text(
          'Bu fotoğraf birleştirilemedi. Aynı fişin ortak ürünleri görünecek şekilde yeniden çekin.',
        ),
        findsOneWidget,
      );
      expect(images.copied, hasLength(1));
      await tap(tester, 'receipt_capture_later');
      final draft = await ownedDraft();
      expect(draft.document.fragments, hasLength(1));
      expect(draft.document.productLines, hasLength(2));
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    },
  );

  testWidgets(
    'header recovery keeps original images in document reading order',
    (tester) async {
      await tester.pumpWidget(
        app(
          _Frames([
            _scan(['EKMEK 40,00', 'SÜT 30,00', 'TOPLAM 90,00 TL']),
            _scan([..._header, 'ELMA 20,00', 'EKMEK 40,00']),
          ]),
        ),
      );
      await tap(tester, 'open_capture');
      await tap(tester, 'receipt_capture_gallery');
      final draft = await ownedDraft();
      expect(draft.imagePaths, ['owned-image-1', 'owned-image-0']);
      expect(draft.document.productLines.map((l) => l.name), [
        'ELMA',
        'EKMEK',
        'SÜT',
      ]);
      await tap(tester, 'receipt_cancel');
      expect(await db.select(db.shoppingLists).get(), isEmpty);
    },
  );

  testWidgets(
    'continuing a total mismatch never silently replaces prior evidence',
    (tester) async {
      await tester.pumpWidget(
        app(
          _Frames([
            _scan([..._header, 'ELMA 20,00', 'TOPLAM 90,00 TL']),
            _scan([..._header, 'EKMEK 40,00', 'SÜT 30,00', 'TOPLAM 90,00 TL']),
          ]),
        ),
      );
      await tap(tester, 'open_capture');
      await tap(tester, 'receipt_capture_gallery');
      await tap(tester, 'receipt_capture_later');
      final draft = await ownedDraft();
      expect(draft.document.productLines.single.name, 'ELMA');
      expect(draft.imagePaths, ['owned-image-0']);
      expect(images.copied, ['owned-image-0']);
      expect(images.removed, isEmpty);
      // The header is known, so the list exists (F12) but has no purchases.
      expect(await db.select(db.shoppingLists).get(), hasLength(1));
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    },
  );

  testWidgets(
    'successful retake cleans superseded images after durable replacement',
    (tester) async {
      await tester.pumpWidget(
        app(
          _Frames([
            _scan([..._header, 'ELMA 20,00']),
            _scan([..._header, 'ELMA 20,00', 'TOPLAM 20,00 TL']),
          ]),
        ),
      );
      await tap(tester, 'open_capture');
      await tap(tester, 'receipt_capture_restart');
      expect(images.removed, ['owned-image-0']);
      final draft = await ownedDraft();
      expect(draft.imagePaths, ['owned-image-1']);
      await tap(tester, 'receipt_cancel');
    },
  );

  testWidgets(
    'failed draft write removes its new image without shopping side effects',
    (tester) async {
      await db.customStatement(
        "CREATE TRIGGER fail_draft BEFORE INSERT ON receipts BEGIN SELECT RAISE(ABORT, 'test'); END",
      );
      await tester.pumpWidget(
        app(
          _Frames([
            _scan([..._header, 'ELMA 20,00']),
          ]),
        ),
      );
      await tap(tester, 'open_capture');
      expect(failure, isNotNull);
      expect(images.removed, images.copied);
      expect(await db.select(db.receipts).get(), isEmpty);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    },
  );

  for (final config in [
    (width: 320.0, locale: 'ar', dark: true, scale: 2.0),
    (width: 412.0, locale: 'tr', dark: false, scale: 1.0),
    (width: 800.0, locale: 'en', dark: true, scale: 1.0),
  ]) {
    testWidgets(
      'continuation controls fit ${config.width} ${config.locale} ${config.scale}',
      (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = Size(config.width, 900);
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          await tester.pumpWidget(
            app(
              _Frames([
                _scan([..._header, 'ELMA 20,00']),
              ]),
              locale: config.locale,
              dark: config.dark,
              scale: config.scale,
            ),
          );
          await tap(tester, 'open_capture');
          expect(tester.takeException(), isNull);
          final output = const String.fromEnvironment('CAPTURE_OUT');
          if (output.isNotEmpty) {
            await expectLater(
              find.byType(MaterialApp),
              matchesGoldenFile(
                '$output/continuation-${config.locale}-${config.width.toInt()}.png',
              ),
            );
          }
          for (final key in [
            'receipt_capture_camera',
            'receipt_capture_gallery',
            'receipt_capture_restart',
            'receipt_capture_later',
          ]) {
            final action = find.byKey(Key(key));
            await tester.ensureVisible(action);
            expect(tester.getSize(action).height, greaterThanOrEqualTo(48));
            expect(tester.getSemantics(action).label, isNotEmpty);
          }
          await tap(tester, 'receipt_capture_later');
          expect(tester.takeException(), isNull);
        } finally {
          semantics.dispose();
        }
      },
    );
  }
}
