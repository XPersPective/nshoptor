import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:napp_core/napp_core.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/reminders/reminders_repository.dart';
import 'package:nshoptor/features/lists/reminders/reminder_scheduler.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';

/// Çağrıları kaydeden sahte zamanlayıcı (done-when: sahte servis doğrulaması).
class FakeReminderScheduler implements ReminderScheduler {
  FakeReminderScheduler({this.permissionGranted = true});

  bool permissionGranted;
  bool failScheduling = false;
  bool failCancellation = false;
  int permissionCalls = 0;
  final List<ScheduledReminder> scheduled = [];
  final List<ScheduledReminder> scheduleCalls = [];
  final List<int> cancelled = [];

  @override
  Future<bool> ensurePermission() async {
    permissionCalls++;
    return permissionGranted;
  }

  @override
  Future<void> schedule(ScheduledReminder reminder) async {
    scheduleCalls.add(reminder);
    if (failScheduling) throw StateError('native scheduling failed');
    scheduled.removeWhere((r) => r.id == reminder.id);
    scheduled.add(reminder);
  }

  @override
  Future<void> cancel(int id) async {
    if (failCancellation) throw StateError('native cancellation failed');
    cancelled.add(id);
    scheduled.removeWhere((r) => r.id == id);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late FakeReminderScheduler fake;
  late RemindersRepository reminders;
  late DateTime clock;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    fake = FakeReminderScheduler();
    clock = DateTime.utc(2026, 9, 1);
    reminders = RemindersRepository(db, fake, now: () => clock);
  });

  tearDown(() => db.close());

  Future<int> makeList() => db
      .into(db.shoppingLists)
      .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));

  test(
    'default deletion cancels native IDs; cancellation failure retains data',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      AndroidFlutterLocalNotificationsPlugin.registerWith();
      const channel = MethodChannel(
        'dexterous.com/flutter/local_notifications',
      );
      final calls = <MethodCall>[];
      var failCancel = true;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            calls.add(call);
            if (call.method == 'cancel' && failCancel) {
              throw PlatformException(code: 'qa_cancel');
            }
            return call.method == 'initialize' ? true : null;
          });
      addTearDown(() {
        debugDefaultTargetPlatformOverride = null;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, null);
      });
      final first = await makeList(), second = await makeList();
      for (final listId in [first, second]) {
        await reminders.setReminder(
          listId: listId,
          title: 'QA',
          body: 'QA',
          atUtc: DateTime.utc(2030),
        );
      }
      final ids = (await db.select(db.reminders).get())
          .map((r) => r.id)
          .toList();
      final lists = ListRepository(db); // actual default production wiring
      await expectLater(
        lists.deleteList(first),
        throwsA(isA<PlatformException>()),
      );
      expect(await db.select(db.shoppingLists).get(), hasLength(2));
      expect(await db.select(db.reminders).get(), hasLength(2));
      failCancel = false;
      await lists.deleteList(first);
      final settings = SettingsRepository(
        db,
        NappSettingsStoreOps(SettingsStore()),
      )..confirmDeleteAll();
      failCancel = true;
      await expectLater(
        settings.deleteAllData(),
        throwsA(isA<PlatformException>()),
      );
      expect(await db.select(db.shoppingLists).get(), hasLength(1));
      expect(await db.select(db.reminders).get(), hasLength(1));
      failCancel = false;
      settings.confirmDeleteAll();
      await settings.deleteAllData();
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(await db.select(db.reminders).get(), isEmpty);
      expect(
        calls
            .where((c) => c.method == 'cancel')
            .map((c) => (c.arguments as Map)['id']),
        [ids.first, ids.first, ids.last, ids.last],
      );
      expect(
        calls.where((c) => c.method.toLowerCase().contains('permission')),
        isEmpty,
      );
    },
  );

  test(
    'hatırlatma kurma: izin istenir, schedule çağrılır, DB satırı aktif',
    () async {
      final listId = await makeList();
      final at = DateTime.utc(2026, 9, 25, 7, 30);

      await reminders.setReminder(
        listId: listId,
        title: 'NShoptor',
        body: 'Market',
        atUtc: at,
      );

      expect(fake.permissionCalls, 1);
      expect(fake.scheduled, hasLength(1));
      expect(fake.scheduled.single.atUtc, at);
      expect(fake.scheduled.single.body, 'Market');

      final active = await reminders.activeForList(listId);
      expect(active, isNotNull);
      expect(active!.status, 'active');
    },
  );

  test('expired reminders are not active and next save replaces the delayed native ID', () async {
    final list = await makeList();
    await reminders.setReminder(
      listId: list,
      title: 'N',
      body: 'b',
      atUtc: clock.add(const Duration(minutes: 1)),
    );
    final original = await reminders.activeForList(list);
    clock = clock.add(const Duration(minutes: 2));
    expect(await reminders.activeForList(list), isNull);
    await reminders.setReminder(
      listId: list,
      title: 'N',
      body: 'b',
      atUtc: clock.add(const Duration(days: 1)),
    );
    expect((await reminders.activeForList(list))!.id, original!.id);
    expect(await db.select(db.reminders).get(), hasLength(1));
    expect(fake.scheduled, hasLength(1));
  });

  test(
    'past time is canonicalized once for the database and native scheduler',
    () async {
      clock = clock.add(const Duration(milliseconds: 123));
      final list = await makeList();
      await reminders.setReminder(
        listId: list,
        title: 'N',
        body: 'b',
        atUtc: clock.subtract(const Duration(days: 1)),
      );
      final expected = DateTime.utc(2026, 9, 1, 0, 0, 31);
      expect(
        (await reminders.activeForList(list))!.scheduledAt.toUtc(),
        expected,
      );
      expect(fake.scheduled.single.atUtc, expected);
    },
  );

  Future<void> failActiveWrite() => db.customStatement('''
    CREATE TRIGGER fail_reminder_write BEFORE UPDATE ON reminders
    WHEN NEW.status = 'active'
    BEGIN SELECT RAISE(ABORT, 'qa_reminder_write'); END;
  ''');

  test(
    'DB write failure after new native schedule cancels its orphaned ID',
    () async {
      final list = await makeList();
      await failActiveWrite();
      await expectLater(
        reminders.setReminder(
          listId: list,
          title: 'N',
          body: 'b',
          atUtc: clock.add(const Duration(days: 1)),
        ),
        throwsA(isA<Exception>()),
      );
      expect(await db.select(db.reminders).get(), isEmpty);
      expect(fake.scheduleCalls, hasLength(1));
      expect(fake.cancelled, [fake.scheduleCalls.single.id]);
      expect(fake.scheduled, isEmpty);
    },
  );

  test(
    'DB edit failure restores prior future native time and stored state',
    () async {
      final list = await makeList();
      final first = clock.add(const Duration(days: 1));
      await reminders.setReminder(
        listId: list,
        title: 'N',
        body: 'b',
        atUtc: first,
      );
      final before = await reminders.activeForList(list);
      await failActiveWrite();
      await expectLater(
        reminders.setReminder(
          listId: list,
          title: 'N',
          body: 'b',
          atUtc: clock.add(const Duration(days: 2)),
        ),
        throwsA(isA<Exception>()),
      );
      expect((await reminders.activeForList(list))!.scheduledAt.toUtc(), first);
      expect(fake.scheduleCalls, hasLength(3));
      expect(fake.scheduled.single.id, before!.id);
      expect(fake.scheduled.single.atUtc, first);
      expect(fake.cancelled, isEmpty);
      await db.customStatement('DROP TRIGGER fail_reminder_write');
      expect(
        await reminders.setReminder(
          listId: list,
          title: 'N',
          body: 'b',
          atUtc: clock.add(const Duration(days: 3)),
        ),
        isTrue,
      );
    },
  );

  test('deferred commit failure cancels the successfully scheduled native orphan', () async {
    await db.customStatement('PRAGMA defer_foreign_keys = ON');
    await expectLater(reminders.setReminder(listId: 999999, title: 'N', body: 'b',
      atUtc: clock.add(const Duration(days: 1))), throwsA(isA<Exception>()));
    expect(await db.select(db.reminders).get(), isEmpty);
    expect(fake.scheduleCalls, hasLength(1));
    expect(fake.cancelled, [fake.scheduleCalls.single.id]);
    expect(fake.scheduled, isEmpty);
  });

  test(
    'güncelleme: aynı native kimlik değiştirilir, iptal aralığı oluşmaz',
    () async {
      final listId = await makeList();
      final first = DateTime.utc(2026, 9, 25, 9);
      await reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: first,
      );

      final second = DateTime.utc(2026, 9, 26, 10);
      await reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: second,
      );

      expect(fake.cancelled, isEmpty);
      expect(fake.scheduled, hasLength(1));
      expect(fake.scheduled.last.atUtc, second);
      expect(
        (await reminders.activeForList(listId))!.scheduledAt.toUtc(),
        second,
      );
    },
  );

  test(
    'native scheduling failure leaves no ghost active row and permits retry',
    () async {
      final listId = await makeList();
      fake.failScheduling = true;
      Future<bool> save() => reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: DateTime.utc(2030),
      );
      await expectLater(save(), throwsStateError);
      expect(await db.select(db.reminders).get(), isEmpty);
      fake.failScheduling = false;
      expect(await save(), isTrue);
      expect(await reminders.activeForList(listId), isNotNull);
      expect(fake.scheduled, hasLength(1));
    },
  );

  test(
    'failed reminder edit preserves the previous native and stored time',
    () async {
      final listId = await makeList();
      final first = DateTime.utc(2030), next = DateTime.utc(2030, 2);
      await reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: first,
      );
      final previous = await reminders.activeForList(listId);
      fake.failScheduling = true;
      await expectLater(
        reminders.setReminder(
          listId: listId,
          title: 'N',
          body: 'b',
          atUtc: next,
        ),
        throwsStateError,
      );
      final preserved = await reminders.activeForList(listId);
      expect(preserved!.id, previous!.id);
      expect(preserved.scheduledAt.toUtc(), first);
      expect(fake.scheduled.single.atUtc, first);
      expect(fake.cancelled, isEmpty);
    },
  );

  test('concurrent reminder saves serialize to one active native ID', () async {
    final listId = await makeList();
    await Future.wait([
      for (var hour = 1; hour <= 2; hour++)
        reminders.setReminder(
          listId: listId,
          title: 'N',
          body: 'b',
          atUtc: DateTime.utc(2030, 1, 1, hour),
        ),
    ]);
    expect(
      (await db.select(db.reminders).get()).where((r) => r.status == 'active'),
      hasLength(1),
    );
    expect(fake.scheduled, hasLength(1));
  });

  test(
    'izin reddi: schedule çağrılmaz, satır oluşmaz, uygulama çalışır',
    () async {
      final listId = await makeList();
      fake.permissionGranted = false;

      await reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: DateTime.utc(2026, 9, 25),
      );

      expect(fake.scheduled, isEmpty);
      expect(await reminders.activeForList(listId), isNull);
      expect(await db.select(db.reminders).get(), isEmpty);
    },
  );

  test('liste silinince tüm aktif hatırlatmalar iptal edilir', () async {
    final listRepo = ListRepository(db, reminders: reminders);
    final listId = await listRepo.createList(
      title: 'Silinecek',
      currencyCode: 'TRY',
    );
    await reminders.setReminder(
      listId: listId,
      title: 'N',
      body: 'b',
      atUtc: DateTime.utc(2026, 9, 25, 8),
    );

    await listRepo.deleteList(listId);

    expect(fake.cancelled, isNotEmpty);
    expect(await db.select(db.reminders).get(), isEmpty); // cascade
  });

  test('permission revoked on edit preserves the previous reminder without native writes', () async {
    final list = await makeList();
    final original = clock.add(const Duration(days: 1));
    await reminders.setReminder(listId: list, title: 'N', body: 'b', atUtc: original);
    final before = await reminders.activeForList(list);
    fake.permissionGranted = false;
    expect(await reminders.setReminder(listId: list, title: 'N', body: 'b',
      atUtc: clock.add(const Duration(days: 2))), isFalse);
    expect((await reminders.activeForList(list))!.id, before!.id);
    expect((await reminders.activeForList(list))!.scheduledAt.toUtc(), original);
    expect(fake.scheduleCalls, hasLength(1));
    expect(fake.cancelled, isEmpty);
  });

  test('native cancellation failure retains the reminder and retry needs no permission', () async {
    final list = await makeList();
    await reminders.setReminder(listId: list, title: 'N', body: 'b',
      atUtc: clock.add(const Duration(days: 1)));
    final original = await reminders.activeForList(list);
    fake.failCancellation = true;
    await expectLater(reminders.cancelReminder(original!.id), throwsStateError);
    expect((await reminders.activeForList(list))!.id, original.id);
    expect(fake.scheduled.single.id, original.id);
    fake.permissionGranted = false;
    fake.failCancellation = false;
    await reminders.cancelReminder(original.id);
    expect(await reminders.activeForList(list), isNull);
    expect(fake.scheduled, isEmpty);
    expect(fake.permissionCalls, 1);
  });

  test('DST/dayanıklılık: mutlak UTC anı saklanır, kayma yaratmaz', () async {
    final listId = await makeList();
    // Kış saati anı ve yaz saati anı: mutlak instanlar korunmalıdır.
    final winter = DateTime.utc(2026, 12, 21, 7, 0);
    final summer = DateTime.utc(2027, 6, 21, 7, 0);

    await reminders.setReminder(
      listId: listId,
      title: 'N',
      body: 'b',
      atUtc: winter,
    );
    final row1 = await reminders.activeForList(listId);
    expect(row1!.scheduledAt.toUtc(), winter);

    await reminders.setReminder(
      listId: listId,
      title: 'N',
      body: 'b',
      atUtc: summer,
    );
    final row2 = await reminders.activeForList(listId);
    expect(row2!.scheduledAt.toUtc(), summer);
    expect(fake.scheduled.last.atUtc.isUtc, isTrue);
  });

  test(
    'cancelReminder: scheduler.cancel çağrılır ve satır işaretlenir',
    () async {
      final listId = await makeList();
      await reminders.setReminder(
        listId: listId,
        title: 'N',
        body: 'b',
        atUtc: DateTime.utc(2026, 9, 25),
      );
      final row = await reminders.activeForList(listId);

      await reminders.cancelReminder(row!.id);

      expect(fake.cancelled, contains(row.id));
      final after = await (db.select(
        db.reminders,
      )..where((t) => t.id.equals(row.id))).getSingle();
      expect(after.status, 'cancelled');
    },
  );

  test(
    'dated list reminder mode persists and reuses single reminder row on mode change',
    () async {
      final listId = await makeList();
      final plannedUtc = DateTime.utc(2026, 10, 26, 10, 0);
      await reminders.setReminder(
        listId: listId,
        title: 'NShoptor',
        body: 'Same day',
        atUtc: plannedUtc,
      );
      final firstRow = await reminders.activeForList(listId);
      expect(firstRow, isNotNull);
      expect(firstRow!.scheduledAt.toUtc(), plannedUtc);

      final oneHourBefore = plannedUtc.subtract(const Duration(hours: 1));
      await reminders.setReminder(
        listId: listId,
        title: 'NShoptor',
        body: '1h before',
        atUtc: oneHourBefore,
      );
      final secondRow = await reminders.activeForList(listId);
      expect(secondRow!.id, firstRow.id);
      expect(secondRow.scheduledAt.toUtc(), oneHourBefore);
      expect(await db.select(db.reminders).get(), hasLength(1));
    },
  );
}
