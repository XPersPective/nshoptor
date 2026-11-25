import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/app/language_controller.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/reminders/reminders_repository.dart';
import 'package:nshoptor/features/settings/backup/backup_repository.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';
import 'package:nshoptor/features/settings/settings_screen.dart';

import '../../lists/reminders/reminders_test.dart' show FakeReminderScheduler;
import '../settings_test.dart' show FakeSettingsStore;

void main() {
  late AppDatabase db;
  late FakeReminderScheduler scheduler;
  late RemindersRepository reminders;
  late BackupRepository backup;
  final later = DateTime.utc(2035, 1, 2, 10);
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    scheduler = FakeReminderScheduler();
    reminders = RemindersRepository(db, scheduler);
    backup = BackupRepository(db);
  });
  tearDown(() => db.close());

  Future<String> snapshot() async {
    final id = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            currencyCode: 'TRY',
            title: const Value('Market'),
          ),
        );
    await db
        .into(db.reminders)
        .insert(RemindersCompanion.insert(listId: id, scheduledAt: later));
    final json = await backup.exportBackup();
    await db.delete(db.reminders).go();
    await db.delete(db.shoppingLists).go();
    return json;
  }

  test('restore imports inactive; explicit activation alone requests native scheduling', () async {
    final json = await snapshot();
    await backup.importBackup(json, ImportMode.merge);
    final pending = (await reminders.pendingRestores()).single;
    expect(await reminders.activeForList(pending.listId), isNull);
    expect(scheduler.permissionCalls, 0);
    expect(scheduler.scheduled, isEmpty);
    expect(
      await reminders.activateRestoredReminder(
        reminderId: pending.id,
        title: 'Reminder',
        body: 'Market',
      ),
      isTrue,
    );
    expect(scheduler.permissionCalls, 1);
    expect(scheduler.scheduled.single.atUtc, later);
    expect(
      (await reminders.activeForList(pending.listId))!.id,
      scheduler.scheduled.single.id,
    );
    expect(await reminders.pendingRestores(), isEmpty);
  });

  test('denial and native failure retain pending restore without losing successful import', () async {
    await backup.importBackup(await snapshot(), ImportMode.merge);
    final pending = (await reminders.pendingRestores()).single;
    scheduler.permissionGranted = false;
    expect(
      await reminders.activateRestoredReminder(
        reminderId: pending.id,
        title: 'Reminder',
        body: 'Market',
      ),
      isFalse,
    );
    expect(await reminders.pendingRestores(), hasLength(1));
    scheduler.permissionGranted = true;
    scheduler.failScheduling = true;
    await expectLater(
      reminders.activateRestoredReminder(
        reminderId: pending.id,
        title: 'Reminder',
        body: 'Market',
      ),
      throwsStateError,
    );
    expect(await reminders.pendingRestores(), hasLength(1));
    expect(await db.select(db.shoppingLists).get(), hasLength(1));
    expect(await reminders.activeForList(pending.listId), isNull);
  });

  test('merge collision retains existing native alarm; changed imported schedule gets fresh pending ID', () async {
    final json = await snapshot();
    await backup.importBackup(json, ImportMode.merge);
    final pending = (await reminders.pendingRestores()).single;
    await reminders.activateRestoredReminder(
      reminderId: pending.id,
      title: 'R',
      body: 'B',
    );
    final active = (await reminders.activeForList(pending.listId))!;
    final changed = jsonDecode(json) as Map<String, dynamic>;
    final incoming = (changed['reminders'] as List).single as Map;
    incoming['id'] = active.id;
    incoming['scheduledAt'] = later
        .add(const Duration(days: 2))
        .millisecondsSinceEpoch;
    final nativeBefore = scheduler.scheduled.single;
    await backup.importBackup(jsonEncode(changed), ImportMode.merge);
    expect(
      (await reminders.activeForList(pending.listId))!.scheduledAt,
      active.scheduledAt,
    );
    expect(scheduler.scheduled.single, same(nativeBefore));
    final imported = (await reminders.pendingRestores()).single;
    expect(imported.id, isNot(active.id));
    expect(imported.scheduledAt.toUtc(), later.add(const Duration(days: 2)));
    await backup.importBackup(jsonEncode(changed), ImportMode.merge);
    expect(await reminders.pendingRestores(), hasLength(1));
    scheduler.failScheduling = true;
    await expectLater(
      reminders.activateRestoredReminder(
        reminderId: imported.id,
        title: 'R',
        body: 'B',
      ),
      throwsStateError,
    );
    expect(scheduler.scheduled.single, same(nativeBefore));
    expect(
      (await reminders.activeForList(pending.listId))!.scheduledAt,
      active.scheduledAt,
    );
    expect(await reminders.pendingRestores(), hasLength(1));
  });

  test('separate import remaps reminder list and leaves original active state intact', () async {
    final json = await snapshot();
    await backup.importBackup(json, ImportMode.merge);
    final original = (await reminders.pendingRestores()).single;
    await reminders.activateRestoredReminder(
      reminderId: original.id,
      title: 'R',
      body: 'B',
    );
    await backup.importBackup(json, ImportMode.separate);
    final imported = (await reminders.pendingRestores()).single;
    expect(imported.listId, isNot(original.listId));
    expect(await reminders.activeForList(original.listId), isNotNull);
    expect(await reminders.activeForList(imported.listId), isNull);
    expect(scheduler.scheduled, hasLength(1));
  });

  testWidgets(
    'pending restore stays retryable after denial and shows success after activation',
    (tester) async {
      await backup.importBackup(await snapshot(), ImportMode.merge);
      final pending = (await reminders.pendingRestores()).single;
      scheduler.permissionGranted = false;
      final repository = SettingsRepository(
        db,
        FakeSettingsStore(),
        reminders: reminders,
      );
      await tester.binding.setSurfaceSize(const Size(900, 6000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: SettingsScreen(
            repository: repository,
            languageController: LanguageController(store: SettingsStore())
              ..load(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final action = find.byKey(Key('restore_reminder_${pending.id}'));
      await tester.ensureVisible(action);
      expect(
        find.descendant(of: action, matching: find.text('Set reminder')),
        findsOneWidget,
      );
      expect(scheduler.permissionCalls, 0);
      final l = AppLocalizations.of(
        tester.element(find.byType(SettingsScreen)),
      );
      await tester.tap(action);
      await tester.pumpAndSettle();
      expect(scheduler.permissionCalls, 1);
      expect(action, findsOneWidget);
      expect(find.text('Reminder set.'), findsNothing);
      expect(find.text(l.reminderPermissionDenied), findsOneWidget);
      expect(find.text(l.saveFailed), findsNothing);
      expect(await reminders.pendingRestores(), hasLength(1));
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      scheduler.permissionGranted = true;
      await tester.tap(action);
      await tester.pumpAndSettle();
      expect(scheduler.permissionCalls, 2);
      expect(action, findsNothing);
      expect(find.text(l.reminderScheduled), findsOneWidget);
      expect(find.text(l.saveFailed), findsNothing);
      expect(await reminders.pendingRestores(), isEmpty);
      expect(await reminders.activeForList(pending.listId), isNotNull);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
