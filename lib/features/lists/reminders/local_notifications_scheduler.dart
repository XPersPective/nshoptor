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

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> _ensureInit() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    _initialized = true;
  }

  @override
  Future<bool> ensurePermission() async {
    await _ensureInit();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await android?.requestNotificationsPermission() ?? true;
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
    );
    Future<void> plan(AndroidScheduleMode mode) => _plugin.zonedSchedule(
          id: reminder.id,
          title: reminder.title,
          body: reminder.body,
          scheduledDate: when,
          notificationDetails: details,
          androidScheduleMode: mode,
        );
    try {
      await plan(AndroidScheduleMode.exactAllowWhileIdle);
    } on PlatformException {
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
