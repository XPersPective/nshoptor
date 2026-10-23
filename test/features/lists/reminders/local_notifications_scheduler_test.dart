import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/lists/reminders/local_notifications_scheduler.dart';
import 'package:nshoptor/features/lists/reminders/reminder_scheduler.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('dexterous.com/flutter/local_notifications');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late List<MethodCall> calls;
  var granted = true;

  setUp(() {
    calls = [];
    granted = true;
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return switch (call.method) {
        'initialize' => true,
        'requestPermissions' || 'requestNotificationsPermission' => granted,
        _ => null,
      };
    });
  });
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    messenger.setMockMethodCallHandler(channel, null);
  });

  ScheduledReminder reminder() => ScheduledReminder(
    id: 42,
    title: 'Pazar alÄ±ÅŸveriÅŸi',
    body: 'Listeniz hazÄ±r',
    atUtc: DateTime.now().toUtc().add(const Duration(hours: 1)),
  );

  test('iOS cancellation never asks permission; reminder asks only on demand', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    IOSFlutterLocalNotificationsPlugin.registerWith();
    final scheduler = LocalNotificationsScheduler();
    await scheduler.cancel(42);
    final settings = calls.singleWhere((c) => c.method == 'initialize').arguments as Map;
    expect(settings['requestAlertPermission'], isFalse);
    expect(settings['requestSoundPermission'], isFalse);
    expect(settings['requestBadgePermission'], isFalse);
    expect(calls.where((c) => c.method == 'requestPermissions'), isEmpty);

    granted = false;
    expect(await scheduler.ensurePermission(), isFalse);
    granted = true;
    expect(await scheduler.ensurePermission(), isTrue);
    final permission = calls.last.arguments as Map;
    expect(permission['alert'], isTrue);
    expect(permission['sound'], isTrue);
    expect(permission['badge'], isFalse);
    await scheduler.schedule(reminder());
    final scheduled = calls.last;
    expect(scheduled.method, 'zonedSchedule');
    expect((scheduled.arguments as Map)['id'], 42);
    expect((scheduled.arguments as Map)['payload'], 'reminder:42');
    expect((scheduled.arguments as Map)['timeZoneName'], 'Etc/UTC');
    expect(calls.where((c) => c.method == 'initialize'), hasLength(1));
  });

  test('cold launch and live native taps carry only a validated reminder ID', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      if (call.method == 'initialize') return true;
      if (call.method == 'getNotificationAppLaunchDetails') { return {
        'notificationLaunchedApp': true,
        'notificationResponse': {'notificationId': 42, 'payload': 'reminder:42', 'notificationResponseType': 0},
      }; }
      return null;
    });
    final scheduler = LocalNotificationsScheduler();
    expect(await scheduler.initialReminderId(), 42);
    final received = <int>[];
    final subscription = LocalNotificationsScheduler.selectedReminders.listen(received.add);
    addTearDown(subscription.cancel);
    for (final payload in ['reminder:42', 'reminder:-1', 'https://example.com', 'reminder:2147483648']) {
      await messenger.handlePlatformMessage(channel.name,
        const StandardMethodCodec().encodeMethodCall(MethodCall('didReceiveNotificationResponse', {
          'notificationId': 42, 'payload': payload, 'notificationResponseType': 0,
        })), null);
    }
    await Future<void>.delayed(Duration.zero);
    expect(received, [42]);
    expect(calls.where((c) => c.method.toLowerCase().contains('permission')), isEmpty);
  });

  test('concurrent platform operations initialize once and failed init can retry', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    IOSFlutterLocalNotificationsPlugin.registerWith();
    final gate = Completer<bool>();
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      if (call.method == 'initialize') return gate.future;
      return null;
    });
    final scheduler = LocalNotificationsScheduler();
    final first = scheduler.cancel(1), second = scheduler.cancel(2);
    await Future<void>.delayed(Duration.zero);
    expect(calls.where((c) => c.method == 'initialize'), hasLength(1));
    gate.completeError(PlatformException(code: 'initialize_failed'));
    await expectLater(first, throwsA(isA<PlatformException>()));
    await expectLater(second, throwsA(isA<PlatformException>()));
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return call.method == 'initialize' ? true : null;
    });
    await scheduler.cancel(3);
    expect(calls.where((c) => c.method == 'initialize'), hasLength(2));
  });

  test('Android falls back only for exact alarm permission and reports other errors', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    String? failure = 'exact_alarms_not_permitted';
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      if (call.method == 'initialize') return true;
      if (call.method == 'zonedSchedule' && failure != null) {
        final code = failure!;
        failure = null;
        throw PlatformException(code: code);
      }
      return null;
    });
    final scheduler = LocalNotificationsScheduler();
    await scheduler.schedule(reminder());
    final schedules = calls.where((c) => c.method == 'zonedSchedule').toList();
    expect(schedules, hasLength(2));
    expect(((schedules.first.arguments as Map)['platformSpecifics'] as Map)['scheduleMode'], 'exactAllowWhileIdle');
    expect(((schedules.last.arguments as Map)['platformSpecifics'] as Map)['scheduleMode'], 'inexactAllowWhileIdle');
    calls.clear();
    failure = 'invalid_icon';
    await expectLater(scheduler.schedule(reminder()), throwsA(isA<PlatformException>()));
    expect(calls.where((c) => c.method == 'zonedSchedule'), hasLength(1));
  });
}
