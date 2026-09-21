import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/reminders/reminders_repository.dart';
import 'package:nshoptor/features/lists/reminders/reminder_scheduler.dart';

/// Çağrıları kaydeden sahte zamanlayıcı (done-when: sahte servis doğrulaması).
class FakeReminderScheduler implements ReminderScheduler {
  FakeReminderScheduler({this.permissionGranted = true});

  bool permissionGranted;
  int permissionCalls = 0;
  final List<ScheduledReminder> scheduled = [];
  final List<int> cancelled = [];

  @override
  Future<bool> ensurePermission() async {
    permissionCalls++;
    return permissionGranted;
  }

  @override
  Future<void> schedule(ScheduledReminder reminder) async {
    scheduled.removeWhere((r) => r.id == reminder.id);
    scheduled.add(reminder);
  }

  @override
  Future<void> cancel(int id) async => cancelled.add(id);
}

void main() {
  late AppDatabase db;
  late FakeReminderScheduler fake;
  late RemindersRepository reminders;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    fake = FakeReminderScheduler();
    reminders = RemindersRepository(db, fake);
  });

  tearDown(() => db.close());

  Future<int> makeList() => db
      .into(db.shoppingLists)
      .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));

  test('hatırlatma kurma: izin istenir, schedule çağrılır, DB satırı aktif',
      () async {
    final listId = await makeList();
    final at = DateTime.utc(2026, 9, 25, 7, 30);

    await reminders.setReminder(
        listId: listId, title: 'NShoptor', body: 'Market', atUtc: at);

    expect(fake.permissionCalls, 1);
    expect(fake.scheduled, hasLength(1));
    expect(fake.scheduled.single.atUtc, at);
    expect(fake.scheduled.single.body, 'Market');

    final active = await reminders.activeForList(listId);
    expect(active, isNotNull);
    expect(active!.status, 'active');
  });

  test('güncelleme: eski iptal edilir yenisi planlanır', () async {
    final listId = await makeList();
    final first = DateTime.utc(2026, 9, 25, 9);
    await reminders.setReminder(
        listId: listId, title: 'N', body: 'b', atUtc: first);

    final second = DateTime.utc(2026, 9, 26, 10);
    await reminders.setReminder(
        listId: listId, title: 'N', body: 'b', atUtc: second);

    // Eski id cancel listesinde; her iki an da planlı (farklı id).
    expect(fake.cancelled, isNotEmpty);
    expect(fake.scheduled, hasLength(2));
    expect(fake.scheduled.last.atUtc, second);
    expect((await reminders.activeForList(listId))!.scheduledAt.toUtc(), second);
  });

  test('izin reddi: schedule çağrılmaz, satır oluşmaz, uygulama çalışır',
      () async {
    final listId = await makeList();
    fake.permissionGranted = false;

    await reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: DateTime.utc(2026, 9, 25));

    expect(fake.scheduled, isEmpty);
    expect(await reminders.activeForList(listId), isNull);
    expect(await db.select(db.reminders).get(), isEmpty);
  });

  test('liste silinince tüm aktif hatırlatmalar iptal edilir', () async {
    final listRepo = ListRepository(db, reminders: reminders);
    final listId = await listRepo.createList(title: 'Silinecek', currencyCode: 'TRY');
    await reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: DateTime.utc(2026, 9, 25, 8));

    await listRepo.deleteList(listId);

    expect(fake.cancelled, isNotEmpty);
    expect(await db.select(db.reminders).get(), isEmpty); // cascade
  });

  test('DST/dayanıklılık: mutlak UTC anı saklanır, kayma yaratmaz', () async {
    final listId = await makeList();
    // Kış saati anı ve yaz saati anı: mutlak instanlar korunmalıdır.
    final winter = DateTime.utc(2026, 12, 21, 7, 0);
    final summer = DateTime.utc(2027, 6, 21, 7, 0);

    await reminders.setReminder(
        listId: listId, title: 'N', body: 'b', atUtc: winter);
    final row1 = await reminders.activeForList(listId);
    expect(row1!.scheduledAt.toUtc(), winter);

    await reminders.setReminder(
        listId: listId, title: 'N', body: 'b', atUtc: summer);
    final row2 = await reminders.activeForList(listId);
    expect(row2!.scheduledAt.toUtc(), summer);
    expect(fake.scheduled.last.atUtc.isUtc, isTrue);
  });

  test('cancelReminder: scheduler.cancel çağrılır ve satır işaretlenir',
      () async {
    final listId = await makeList();
    await reminders.setReminder(
        listId: listId, title: 'N', body: 'b', atUtc: DateTime.utc(2026, 9, 25));
    final row = await reminders.activeForList(listId);

    await reminders.cancelReminder(row!.id);

    expect(fake.cancelled, contains(row.id));
    final after = await (db.select(db.reminders)
          ..where((t) => t.id.equals(row.id)))
        .getSingle();
    expect(after.status, 'cancelled');
  });
}
