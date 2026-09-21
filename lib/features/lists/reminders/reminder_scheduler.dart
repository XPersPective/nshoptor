import 'package:flutter/foundation.dart';

/// Hatırlatıcının planlanabilir OS çağrılarının soyutlaması (spec §6.13).
///
/// Testler [ReminderScheduler] taklidiyle çağrıları doğrular; üretimde
/// [LocalNotificationsScheduler] flutter_local_notifications'a bağlanır.
/// Bildirim izni YALNIZ kullanıcı hatırlatma açtığında istenir: bu sınıfın
/// `ensurePermission` çağrısıyla.
@immutable
class ScheduledReminder {
  const ScheduledReminder({
    required this.id,
    required this.title,
    required this.body,
    required this.atUtc,
  });

  /// OS bildirim kimliği: DB reminder id'si kullanılır.
  final int id;
  final String title;
  final String body;

  /// Mutlak UTC anı — TZ/DST kaymalarından bağımsız.
  final DateTime atUtc;
}

abstract class ReminderScheduler {
  /// İzin durumunu sorgular; verilmediyse kullanıcıya sorar (yalnız
  /// hatırlatma açıldığında çağrılır). true = izin verildi/zaten var.
  Future<bool> ensurePermission();

  /// Bildirimi mutlak UTC anına planlar; aynı id verilirse üzerine yazar.
  Future<void> schedule(ScheduledReminder reminder);

  Future<void> cancel(int id);
}
