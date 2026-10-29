import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/history_screen.dart';

const captureDir = String.fromEnvironment('HISTORY_QA_DIR');
const captureKey = Key('history_currency_capture');

void main() {
  setUpAll(() async {
    if (captureDir.isEmpty) return;
    final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
    Future<ByteData> font(String path) async =>
        ByteData.sublistView(await File(path).readAsBytes());
    final textFont = FontLoader('Roboto');
    final windowsFont = File('C:/Windows/Fonts/segoeui.ttf');
    textFont.addFont(
      font(
        windowsFont.existsSync()
            ? windowsFont.path
            : '$root/bin/cache/artifacts/material_fonts/roboto-regular.ttf',
      ),
    );
    await textFont.load();
    await (FontLoader('MaterialIcons')..addFont(
          font(
            '$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
          ),
        ))
        .load();
  });

  for (final (width, scale, locale, dark) in [
    (320.0, 2.0, 'tr', false),
    (320.0, 2.0, 'ar', true),
    (1280.0, 1.0, 'tr', true),
    (1280.0, 1.0, 'ar', false),
  ]) {
    final scene = '${width.toInt()}_${locale}_${dark ? 'dark' : 'light'}';
    testWidgets('History currency label stays below date selector $scene', (
      tester,
    ) async {
      final db = AppDatabase(NativeDatabase.memory());
      AppDefaults.attach(SettingsStore());
      AppFormatLocale.attach(locale);
      addTearDown(AppFormatLocale.attachReset);
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final semantics = tester.ensureSemantics();
      try {
        final now = DateTime(2026, 10, 21, 12);
        await tester.runAsync(() async {
          for (final currency in ['TRY', 'USD']) {
            await db
                .into(db.shoppingLists)
                .insert(
                  ShoppingListsCompanion.insert(
                    currencyCode: currency,
                    status: const Value('completed'),
                    completedAt: Value(now),
                    title: Value(currency),
                  ),
                );
          }
        });
        await tester.pumpWidget(
          RepaintBoundary(
            key: captureKey,
            child: MaterialApp(
              theme: dark ? AppTheme.dark() : AppTheme.light(),
              locale: Locale(locale),
              supportedLocales: AppLocalizations.supportedLocales,
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
              home: HistoryScreen(db: db, now: now),
            ),
          ),
        );
        Future<void> settle() async {
          for (var i = 0; i < 5; i++) {
            await tester.runAsync(
              () => Future<void>.delayed(const Duration(milliseconds: 30)),
            );
            await tester.pumpAndSettle();
          }
        }

        await settle();
        final l = AppLocalizations.of(
          tester.element(find.byType(HistoryScreen)),
        );
        final calendar = find.byKey(const Key('history_calendar'));
        final currencyField = find.byType(DropdownButtonFormField<String>);
        expect(currencyField, findsOneWidget);
        expect(
          tester.getRect(find.text(l.currencyLabel)).top,
          greaterThanOrEqualTo(tester.getRect(calendar).bottom + 4),
        );
        expect(tester.getSize(currencyField).height, greaterThanOrEqualTo(48));
        expect(
          find.bySemanticsLabel(RegExp(RegExp.escape(l.currencyLabel))),
          findsWidgets,
        );
        expect(tester.takeException(), isNull);
        if (captureDir.isNotEmpty) {
          final boundary = tester.renderObject<RenderRepaintBoundary>(
            find.byKey(captureKey),
          );
          await tester.runAsync(() async {
            final image = await boundary.toImage(pixelRatio: 1);
            final png = await image.toByteData(format: ui.ImageByteFormat.png);
            await Directory(captureDir).create(recursive: true);
            await File('$captureDir/$scene.png')
                .writeAsBytes(png!.buffer.asUint8List());
            image.dispose();
          });
        }
        final originalPeriod = tester
            .widget<Text>(
              find.descendant(of: calendar, matching: find.byType(Text)).first,
            )
            .data;
        await tester.tap(currencyField);
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pumpAndSettle();
        expect(
          find.descendant(of: currencyField, matching: find.text('TRY')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('history_period_reset')), findsNothing);
        await tester.tap(currencyField);
        await tester.pumpAndSettle();
        await tester.tap(find.text('USD').last);
        await settle();
        expect(
          find.descendant(of: currencyField, matching: find.text('USD')),
          findsOneWidget,
        );
        await tester.tap(find.byTooltip(l.previousPeriodAction));
        await settle();
        expect(find.byKey(const Key('history_period_reset')), findsOneWidget);
        expect(
          tester
              .widget<Text>(
                find
                    .descendant(of: calendar, matching: find.byType(Text))
                    .first,
              )
              .data,
          isNot(originalPeriod),
        );
        await tester.tap(find.byKey(const Key('history_period_reset')));
        await settle();
        expect(find.byKey(const Key('history_period_reset')), findsNothing);
        expect(
          find.descendant(of: currencyField, matching: find.text('USD')),
          findsOneWidget,
        );
        expect(
          tester
              .widget<Text>(
                find
                    .descendant(of: calendar, matching: find.byType(Text))
                    .first,
              )
              .data,
          originalPeriod,
        );
        expect(tester.takeException(), isNull);
      } finally {
        semantics.dispose();
        await tester.pumpWidget(const SizedBox.shrink());
        final closing = db.close();
        await tester.pump(const Duration(milliseconds: 1));
        await closing;
      }
    });
  }
}
