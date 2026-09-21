import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';
import 'reminder_scheduler.dart';

/// Liste hatırlatmaları (spec §6.13): planla/iptal/güncelle; liste silinince
/// OS bildirimi de iptal edilir; silinmiş liste hedefli bildirim tıklanınca
/// UI "açıklayıcı fallback" gösterir (derin bağlantı akışı T13 ekranında).
class RemindersRepository {
  RemindersRepository(this._db, this._scheduler);

  final AppDatabase _db;
  final ReminderScheduler _scheduler;

  /// Hatırlatma kurar/k günceller: varsa eskisi iptal edilir, yenisi
  /// planlanır. plannedAt değişince bu metot yeniden çağrılır (spec:
  /// tarih değişince bildirimi güncelle).
  Future<void> setReminder({
    required int listId,
    required String title,
    required String body,
    required DateTime atUtc,
  }) async {
    final granted = await _scheduler.ensurePermission();
    if (!granted) return; // izin reddi: hatırlatma kurulmaz, uygulama çalışır

    await cancelForList(listId);
    final id = await _db.into(_db.reminders).insert(
          RemindersCompanion.insert(
            listId: listId,
            scheduledAt: atUtc,
            status: const Value('active'),
          ),
        );
    await _scheduler.schedule(ScheduledReminder(
      id: id,
      title: title,
      body: body,
      atUtc: atUtc,
    ));
  }

  /// Hatırlatmayı iptal eder: OS bildirimi + DB satırı.
  Future<void> cancelReminder(int reminderId) async {
    final row = await (_db.select(_db.reminders)
          ..where((t) => t.id.equals(reminderId)))
        .getSingleOrNull();
    await _scheduler.cancel(reminderId);
    if (row != null) {
      await (_db.update(_db.reminders)
            ..where((t) => t.id.equals(reminderId)))
          .write(const RemindersCompanion(status: Value('cancelled')));
    }
  }

  /// Listenin tüm aktif hatırlatmalarını iptal eder; liste silinirken
  /// çağrılır (spec §6.13: liste silinince iptal).
  Future<void> cancelForList(int listId) async {
    final rows = await (_db.select(_db.reminders)
          ..where((t) => t.listId.equals(listId))
          ..where((t) => t.status.equals('active')))
        .get();
    for (final row in rows) {
      await _scheduler.cancel(row.id);
      await (_db.update(_db.reminders)
            ..where((t) => t.id.equals(row.id)))
          .write(const RemindersCompanion(status: Value('cancelled')));
    }
  }

  /// Aktif hatırlatma (varsa).
  Future<Reminder?> activeForList(int listId) =>
      (_db.select(_db.reminders)
            ..where((t) => t.listId.equals(listId))
            ..where((t) => t.status.equals('active')))
          .getSingleOrNull();
}
