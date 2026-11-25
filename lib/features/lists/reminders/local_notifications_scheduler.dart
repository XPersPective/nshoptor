import 'dart:async';

import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_scheduler.dart';

/// [ReminderScheduler]'ın flutter_local_notifications üretim uygulaması.
///
/// - İzin YALNIZ hatırlatma kurulurken istenir (spec §6.13): bildirim izni
///   (Android 13+ POST_NOTIFICATIONS) uygulama içi diyalogla.
/// - Tam alarm izni (Android 12+) İSTENMEZ: plugin isteği kullanıcıyı
///   sessizce sistem ayarlarına atıyor (UX kararı). İzin zaten varsa exact
///   planlanır; yoksa inexact kipine düşülür (doze etkisiyle ±dakika
///   gecikme toleransı — alışveriş hatırlatması için yeterli).
/// - Mutlak UTC anı TZDateTime'a çevrilerek planlanır (DST güvenli).
class LocalNotificationsScheduler implements ReminderScheduler {
  LocalNotificationsScheduler();

  static final _selected = StreamController<int>.broadcast();
  static Stream<int> get selectedReminders => _selected.stream;

  /// Taps on "receipt read" notifications, as the list id to open.
  static final _receiptLists = StreamController<int>.broadcast();
  static Stream<int> get selectedReceiptLists => _receiptLists.stream;

  static int? receiptListFromPayload(String? payload) {
    final match = RegExp(r'^receipt-list:([1-9]\d{0,9})$').firstMatch(payload ?? '');
    final id = match == null ? null : int.tryParse(match.group(1)!);
    return id != null && id <= 2147483647 ? id : null;
  }

  Future<int?> initialReceiptListId() async {
    await _ensureInit();
    final launch = await _plugin.getNotificationAppLaunchDetails();
    return launch?.didNotificationLaunchApp == true
        ? receiptListFromPayload(launch?.notificationResponse?.payload)
        : null;
  }

  /// Immediate notification when a receipt finishes reading in the
  /// background (F08). Permission is never requested here: without it the
  /// result simply waits in the list.
  Future<void> showReceiptResult({
    required int id,
    required String title,
    required String body,
    int? listId,
  }) async {
    await _ensureInit();
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'NShoptor',
          channelDescription: 'Shopping reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: listId == null ? null : 'receipt-list:$listId',
    );
  }

  static int? reminderIdFromPayload(String? payload) {
    final match = RegExp(r'^reminder:([1-9]\d{0,9})$').firstMatch(payload ?? '');
    final id = match == null ? null : int.tryParse(match.group(1)!);
    return id != null && id <= 2147483647 ? id : null;
  }

  Future<int?> initialReminderId() async {
    await _ensureInit();
    final launch = await _plugin.getNotificationAppLaunchDetails();
    return launch?.didNotificationLaunchApp == true
      ? reminderIdFromPayload(launch?.notificationResponse?.payload)
      : null;
  }

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  Future<void>? _initializing;

  Future<void> _ensureInit() {
    if (_initialized) return Future<void>.value();
    return _initializing ??= _initialize().whenComplete(() {
      _initializing = null;
    });
  }

  Future<void> _initialize() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    final ready = await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        // Removing a reminder also initializes the plugin. Ask for permission
        // only in ensurePermission(), after the user chooses a reminder.
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final id = reminderIdFromPayload(response.payload);
        if (id != null) _selected.add(id);
        final list = receiptListFromPayload(response.payload);
        if (list != null) _receiptLists.add(list);
      },
    );
    final ios = _plugin.resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin
    >();
    // iOS initialize may return false when permission prompts are deferred.
    final deferredIosPermission = ready == false && ios != null;
    if (ready != true && !deferredIosPermission) {
      throw PlatformException(code: 'notification_initialization_failed');
    }
    _initialized = true;
  }

  @override
  Future<bool> ensurePermission() async {
    await _ensureInit();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, sound: true) ?? false;
    }
    return false;
  }

  @override
  Future<void> schedule(ScheduledReminder reminder) async {
    await _ensureInit();
    // "Şimdi" seçilen hatırlatma, kullanıcı onayına dek geçmişe düşebilir;
    // eklenti geçmiş tarihi REDDERİR (emülatör logcat kanıtı 2026-10-03:
    // "Must be a date in the future"). Planlama anından 30 sn sonraya
    // kaydırılır — kapatılabilir davranış en yakın eşdeğeridir.
    final nowUtc = DateTime.now().toUtc();
    final fireAt = reminder.atUtc.isAfter(nowUtc)
        ? reminder.atUtc
        : nowUtc.add(const Duration(seconds: 30));
    final when = tz.TZDateTime.from(fireAt, tz.UTC);
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        'NShoptor',
        channelDescription: 'Shopping reminders',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );
    Future<void> plan(AndroidScheduleMode mode) => _plugin.zonedSchedule(
          id: reminder.id,
          title: reminder.title,
          body: reminder.body,
          scheduledDate: when,
          notificationDetails: details,
          androidScheduleMode: mode,
          payload: 'reminder:${reminder.id}',
        );
    try {
      await plan(AndroidScheduleMode.exactAllowWhileIdle);
    } on PlatformException catch (error) {
      if (error.code != 'exact_alarms_not_permitted') rethrow;
      // Tam alarm izni verilmedi: inexact planla (gecikme toleranslı).
      await plan(AndroidScheduleMode.inexactAllowWhileIdle);
    }
  }

  @override
  Future<void> cancel(int id) async {
    await _ensureInit();
    await _plugin.cancel(id: id);
  }

  static const String _channelId = 'nshoptor_reminders';
}
