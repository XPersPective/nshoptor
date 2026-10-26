import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';
import 'reminder_scheduler.dart';

/// Liste hatırlatmaları (spec §6.13): planla/iptal/güncelle; liste silinince
/// OS bildirimi de iptal edilir; silinmiş liste hedefli bildirim tıklanınca
/// UI "açıklayıcı fallback" gösterir (derin bağlantı akışı T13 ekranında).
class RemindersRepository {
  RemindersRepository(this._db, this._scheduler, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final AppDatabase _db;
  final ReminderScheduler _scheduler;
  final DateTime Function() _now;
  static final _writes = Expando<Future<void>>();

  // Include native compensation in serialization: a later successful edit
  // must never be overwritten by an earlier failed edit's recovery.
  Future<T> _serialize<T>(Future<T> Function() action) {
    final previous = _writes[_db] ?? Future<void>.value();
    final next = previous.then((_) => action());
    _writes[_db] = next.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return next;
  }

  /// Edits replace the existing native ID. A scheduling failure preserves the
  /// previous reminder instead of cancelling it first or leaving an active
  /// database row for a notification that was never scheduled.
  /// Returns false when permission was denied.
  Future<bool> setReminder({
    required int listId,
    required String title,
    required String body,
    required DateTime atUtc,
  }) => _serialize(
    () => _setReminder(listId: listId, title: title, body: body, atUtc: atUtc),
  );

  Future<bool> _setReminder({
    required int listId,
    required String title,
    required String body,
    required DateTime atUtc,
  }) async {
    final granted = await _scheduler.ensurePermission();
    if (!granted) return false;

    Reminder? existing;
    int? scheduledId;
    var nativeScheduled = false;
    try {
      await _db.transaction(() async {
        // An expired exact/inexact alarm may still be pending at the OS. Reuse
        // its native ID rather than creating a second delayed notification.
        existing = await _storedActiveForList(listId);
        final nowUtc = _now().toUtc();
        final requested = atUtc.toUtc();
        final requestedFireAt = requested.isAfter(nowUtc)
            ? requested
            : nowUtc.add(const Duration(seconds: 30));
        // Drift stores seconds. Round upward so DB and native receive the
        // same future instant even when the injected/system clock has micros.
        final fireAt = DateTime.fromMicrosecondsSinceEpoch(
          ((requestedFireAt.microsecondsSinceEpoch + 999999) ~/ 1000000) *
              1000000,
          isUtc: true,
        );
        final id =
            existing?.id ??
            await _db
                .into(_db.reminders)
                .insert(
                  RemindersCompanion.insert(
                    listId: listId,
                    scheduledAt: fireAt,
                    status: const Value('pending'),
                  ),
                );
        scheduledId = id;
        await _scheduler.schedule(
          ScheduledReminder(id: id, title: title, body: body, atUtc: fireAt),
        );
        nativeScheduled = true;
        await (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
          RemindersCompanion(
            scheduledAt: Value(fireAt),
            status: const Value('active'),
          ),
        );
        await (_db.update(_db.reminders)..where(
              (t) =>
                  t.listId.equals(listId) & t.status.equals('pendingRestore'),
            ))
            .write(const RemindersCompanion(status: Value('cancelled')));
      });
    } catch (error, stack) {
      if (nativeScheduled && scheduledId != null) {
        try {
          final previous = existing;
          if (previous != null &&
              previous.scheduledAt.isAfter(_now().toUtc())) {
            // The schema stores the schedule, not old localized content.
            // Restore its time/ID with the current list's supplied message.
            await _scheduler.schedule(
              ScheduledReminder(
                id: previous.id,
                title: title,
                body: body,
                atUtc: previous.scheduledAt.toUtc(),
              ),
            );
          } else {
            await _scheduler.cancel(scheduledId!);
          }
        } catch (recoveryError) {
          throw ReminderRecoveryFailure(error, recoveryError);
        }
      }
      // A native call that throws may have partially succeeded; its final OS
      // state cannot be proven through this scheduler contract.
      Error.throwWithStackTrace(error, stack);
    }
    return true;
  }

  /// Hatırlatmayı iptal eder: OS bildirimi + DB satırı.
  Future<void> cancelReminder(int reminderId) async {
    await _serialize(() => _cancelReminder(reminderId));
  }

  Future<void> _cancelReminder(int reminderId) async {
    final row = await (_db.select(
      _db.reminders,
    )..where((t) => t.id.equals(reminderId))).getSingleOrNull();
    await _scheduler.cancel(reminderId);
    if (row != null) {
      await (_db.update(_db.reminders)..where((t) => t.id.equals(reminderId)))
          .write(const RemindersCompanion(status: Value('cancelled')));
    }
  }

  /// Listenin tüm aktif hatırlatmalarını iptal eder; liste silinirken
  /// çağrılır (spec §6.13: liste silinince iptal).
  Future<void> cancelForList(int listId) => _serialize(() async {
    final rows =
        await (_db.select(_db.reminders)
              ..where((t) => t.listId.equals(listId))
              ..where((t) => t.status.equals('active')))
            .get();
    for (final row in rows) {
      await _scheduler.cancel(row.id);
      await (_db.update(_db.reminders)..where((t) => t.id.equals(row.id)))
          .write(const RemindersCompanion(status: Value('cancelled')));
    }
  });

  /// Tüm aktif OS hatırlatmalarını kayıtları silmeden önce iptal eder.
  Future<void> cancelAll() => _serialize(() async {
    final rows = await (_db.select(
      _db.reminders,
    )..where((t) => t.status.equals('active'))).get();
    for (final row in rows) {
      await _cancelReminder(row.id);
    }
  });

  /// Aktif hatırlatma (varsa).
  Future<Reminder?> activeForList(int listId) =>
      (_db.select(_db.reminders)
            ..where((t) => t.listId.equals(listId))
            ..where((t) => t.status.equals('active'))
            ..where((t) => t.scheduledAt.isBiggerThanValue(_now().toUtc()))
            ..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)])
            ..limit(1))
          .getSingleOrNull();

  /// Imported schedules stay visible for explicit activation. Reading them
  /// never initializes the OS notification plugin or asks for permission.
  Future<List<Reminder>> pendingRestores() =>
      (_db.select(_db.reminders)
            ..where((t) => t.status.equals('pendingRestore'))
            ..orderBy([(t) => OrderingTerm.asc(t.scheduledAt)]))
          .get();

  Future<bool> activateRestoredReminder({
    required int reminderId,
    required String title,
    required String body,
  }) => _serialize(() async {
    final reminder =
        await (_db.select(_db.reminders)..where(
              (t) =>
                  t.id.equals(reminderId) & t.status.equals('pendingRestore'),
            ))
            .getSingleOrNull();
    if (reminder == null) throw StateError('Imported reminder is not pending');
    return _setReminder(
      listId: reminder.listId,
      title: title,
      body: body,
      atUtc: reminder.scheduledAt,
    );
  });

  Future<Reminder?> _storedActiveForList(int listId) =>
      (_db.select(_db.reminders)
            ..where((t) => t.listId.equals(listId) & t.status.equals('active'))
            ..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)])
            ..limit(1))
          .getSingleOrNull();
}

/// Both persistence and native compensation failed; callers must not report
/// success or assume the previous OS schedule was restored.
class ReminderRecoveryFailure implements Exception {
  const ReminderRecoveryFailure(this.cause, this.recoveryError);
  final Object cause;
  final Object recoveryError;
}
