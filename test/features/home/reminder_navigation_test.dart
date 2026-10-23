import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';

void main() {
  testWidgets('cold notification opens its persisted list; duplicate taps do not stack routes', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    const channel = MethodChannel('dexterous.com/flutter/local_notifications');
    final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    final db = AppDatabase(NativeDatabase.memory());
    late int listId, reminderId;
    await tester.runAsync(() async {
      listId = await ListRepository(db).createList(title: 'Pazar', currencyCode: 'TRY');
      reminderId = await db.into(db.reminders).insert(RemindersCompanion.insert(
        listId: listId, scheduledAt: DateTime.now(), status: const Value('active')));
    });
    final calls = <String>[];
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call.method);
      if (call.method == 'initialize') return true;
      if (call.method == 'getNotificationAppLaunchDetails') { return {
        'notificationLaunchedApp': true,
        'notificationResponse': {'notificationId': reminderId, 'payload': 'reminder:$reminderId', 'notificationResponseType': 0},
      }; }
      return null;
    });
    addTearDown(() {
      debugDefaultTargetPlatformOverride = null;
      messenger.setMockMethodCallHandler(channel, null);
    });
    Future<void> settle() async {
      for (var i = 0; i < 4; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
        await tester.pumpAndSettle();
      }
    }
    await tester.pumpWidget(MaterialApp(locale: const Locale('tr'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      home: HomeShell(db: db, listRepository: ListRepository(db))));
    await settle();
    expect(tester.widget<ListDetailScreen>(find.byType(ListDetailScreen)).listId, listId);
    for (var i = 0; i < 2; i++) {
      await messenger.handlePlatformMessage(channel.name,
        const StandardMethodCodec().encodeMethodCall(MethodCall('didReceiveNotificationResponse', {
          'notificationId': reminderId, 'payload': 'reminder:$reminderId', 'notificationResponseType': 0,
        })), null);
    }
    await settle();
    expect(find.byType(ListDetailScreen), findsOneWidget);
    expect(calls.where((name) => name.toLowerCase().contains('permission')), isEmpty);
    Navigator.of(tester.element(find.byType(ListDetailScreen))).pop();
    await settle();
    await messenger.handlePlatformMessage(channel.name,
      const StandardMethodCodec().encodeMethodCall(const MethodCall('didReceiveNotificationResponse', {
        'notificationId': 999, 'payload': 'reminder:999', 'notificationResponseType': 0,
      })), null);
    await settle();
    expect(find.byType(ListDetailScreen), findsNothing);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
    debugDefaultTargetPlatformOverride = null;
  });
}
