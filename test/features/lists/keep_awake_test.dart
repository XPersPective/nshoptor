import 'dart:async';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/app/navigation.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/ads/ad_gate.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';

// Decode only the installed plugin's Pigeon ToggleMessage wrapper.
class _WakeCodec extends StandardMessageCodec {
  const _WakeCodec();
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) =>
      type == 129 ? readValue(buffer) : super.readValueOfType(type, buffer);
}

void main() {
  const channel = 'dev.flutter.pigeon.wakelock_plus_platform_interface.WakelockPlusApi.toggle';
  late AppDatabase db;
  late ListRepository repo;
  late SettingsStore store;
  var nativeAwake = false;
  var failEnable = false;
  Completer<void>? pendingEnable;
  setUp(() {
    TestWidgetsFlutterBinding.instance.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    db = AppDatabase(NativeDatabase.memory()); repo = ListRepository(db);
    store = SettingsStore(); AppDefaults.attach(store);
    nativeAwake = false; failEnable = false; pendingEnable = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(channel, (message) async {
      final args = const _WakeCodec().decodeMessage(message) as List;
      final enable = (args.first as List).first as bool;
      if (enable && failEnable) return const StandardMessageCodec().encodeMessage(['denied', 'blocked', null]);
      if (enable && pendingEnable != null) await pendingEnable!.future;
      nativeAwake = enable;
      return const StandardMessageCodec().encodeMessage([null]);
    });
  });

  Widget screen(int id) => ListDetailScreen(db: db, listRepository: repo, listId: id);
  Widget app(int id) => MaterialApp(navigatorObservers: [appRouteObserver], locale: const Locale('tr'),
    localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
    supportedLocales: AppLocalizations.supportedLocales, home: screen(id));
  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink()); await tester.pumpAndSettle();
    expect(nativeAwake, false); expect(AdGate.shoppingModeActive, false);
    await db.close(); AppDefaults.attach(SettingsStore());
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(channel, null);
  }
  IconButton button(WidgetTester tester) => tester.widget<IconButton>(find.byKey(const Key('list_keep_awake')));

  testWidgets('saved preference follows sheet, nested route, lifecycle and disposal', (tester) async {
    store.setBool(SettingsRepository.keepAwakeKey, true);
    final id = await repo.createList(currencyCode: 'TRY');
    final second = await repo.createList(currencyCode: 'TRY');
    await tester.pumpWidget(app(id)); await tester.pumpAndSettle();
    expect(nativeAwake, true); expect(button(tester).isSelected, true);
    expect(button(tester).tooltip, isNotEmpty);
    expect(tester.getSize(find.byKey(const Key('list_keep_awake'))).shortestSide, greaterThanOrEqualTo(48));
    await tester.tap(find.byKey(const Key('detail_add_item_button'))); await tester.pumpAndSettle();
    expect(nativeAwake, false);
    Navigator.of(tester.element(find.byKey(const Key('item_name_field')))).pop(); await tester.pumpAndSettle();
    expect(nativeAwake, true);
    final nav = Navigator.of(tester.element(find.byType(ListDetailScreen)));
    nav.push(MaterialPageRoute<void>(builder: (_) => screen(second))); await tester.pumpAndSettle();
    expect(nativeAwake, true); expect(AdGate.shoppingModeActive, true);
    nav.pop(); await tester.pumpAndSettle();
    expect(nativeAwake, true); expect(AdGate.shoppingModeActive, true);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused); await tester.pumpAndSettle();
    expect(nativeAwake, false);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed); await tester.pumpAndSettle();
    expect(nativeAwake, true);
    await close(tester);
  });

  testWidgets('failed enable is not selected; delayed enable cannot survive a covered route', (tester) async {
    final id = await repo.createList(currencyCode: 'TRY');
    await tester.pumpWidget(app(id)); await tester.pumpAndSettle();
    expect(nativeAwake, false); expect(button(tester).isSelected, false);
    failEnable = true;
    await tester.tap(find.byKey(const Key('list_keep_awake'))); await tester.pumpAndSettle();
    expect(button(tester).isSelected, false); expect(AppDefaults.keepScreenAwake(), false);
    expect(find.text('Ekran açık tutulamadı. Lütfen yeniden deneyin.'), findsOneWidget);
    failEnable = false;
    await tester.tap(find.byKey(const Key('list_keep_awake'))); await tester.pumpAndSettle();
    expect(nativeAwake, true); expect(AppDefaults.keepScreenAwake(), true);
    await tester.tap(find.byKey(const Key('list_keep_awake'))); await tester.pumpAndSettle();
    expect(nativeAwake, false); expect(AppDefaults.keepScreenAwake(), false);
    pendingEnable = Completer<void>();
    await tester.tap(find.byKey(const Key('list_keep_awake'))); await tester.pump();
    final nav = Navigator.of(tester.element(find.byType(ListDetailScreen)));
    nav.push(MaterialPageRoute<void>(builder: (_) => const Scaffold(body: Text('Covered'))));
    await tester.pump(const Duration(milliseconds: 400));
    pendingEnable!.complete(); await tester.pumpAndSettle();
    expect(nativeAwake, false);
    nav.pop(); await tester.pumpAndSettle(); expect(nativeAwake, false);
    await close(tester);
  });
}
