import 'dart:async';

import 'package:drift/drift.dart' hide Column;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/reminders/local_notifications_scheduler.dart';
import 'package:nshoptor/features/lists/reminders/reminders_repository.dart';

const _firstQaId = 2000000000;
const _deliveryQaId = 2000000001;
const _seedId = 1999999999;
const _qaTitle = 'Native QA reminder';
const _qaBody = 'Synthetic reminder';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kDebugMode) {
    throw StateError('Reminder QA requires a debug build.');
  }
  if (defaultTargetPlatform != TargetPlatform.iOS) {
    throw StateError('Reminder QA requires an iOS simulator.');
  }

  AppDatabase? openedDb;
  try {
    final db = AppDatabase(NativeDatabase.memory());
    openedDb = db;
    final listId = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            title: const Value('Synthetic reminder QA'),
            currencyCode: 'USD',
          ),
        );
    await db
        .into(db.reminders)
        .insert(
          RemindersCompanion.insert(
            id: const Value(_seedId),
            listId: listId,
            scheduledAt: DateTime.utc(2099),
            status: const Value('cancelled'),
          ),
        );

    final scheduler = LocalNotificationsScheduler();
    await scheduler.cancel(_firstQaId);
    await scheduler.cancel(_deliveryQaId);
    final launchId = await scheduler.initialReminderId();
    final seed = await (db.select(
      db.reminders,
    )..where((row) => row.id.equals(_seedId))).getSingleOrNull();
    if (seed?.status != 'cancelled') {
      throw StateError('Reserved QA reminder ID seed did not persist.');
    }

    runApp(
      _ReminderQaApp(
        db: db,
        scheduler: scheduler,
        repository: RemindersRepository(db, scheduler),
        listId: listId,
        launchId: launchId,
      ),
    );
  } catch (error, stack) {
    await openedDb?.close();
    runApp(_BootFailure(error: error, stack: stack));
  }
}

class _ReminderQaApp extends StatelessWidget {
  const _ReminderQaApp({
    required this.db,
    required this.scheduler,
    required this.repository,
    required this.listId,
    required this.launchId,
  });

  final AppDatabase db;
  final LocalNotificationsScheduler scheduler;
  final RemindersRepository repository;
  final int listId;
  final int? launchId;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Reminder QA',
    debugShowCheckedModeBanner: false,
    home: _ReminderQaScreen(
      db: db,
      scheduler: scheduler,
      repository: repository,
      listId: listId,
      launchId: launchId,
    ),
  );
}

class _ReminderQaScreen extends StatefulWidget {
  const _ReminderQaScreen({
    required this.db,
    required this.scheduler,
    required this.repository,
    required this.listId,
    required this.launchId,
  });

  final AppDatabase db;
  final LocalNotificationsScheduler scheduler;
  final RemindersRepository repository;
  final int listId;
  final int? launchId;

  @override
  State<_ReminderQaScreen> createState() => _ReminderQaScreenState();
}

class _ReminderQaScreenState extends State<_ReminderQaScreen> {
  final _plugin = FlutterLocalNotificationsPlugin();
  StreamSubscription<int>? _selectionSubscription;
  bool _busy = false;
  bool _deliveryPending = false;
  String _result = 'READY';
  String _error = 'none';
  int _targetId = _firstQaId;
  int? _selectedId;
  bool? _permissionEnabled;
  bool? _permissionAlert;
  bool? _permissionSound;
  int _activeCount = 0;
  int? _databaseId;
  String _databaseStatus = 'absent';
  String _databaseScheduledUtc = 'none';
  int _nativeCount = 0;
  int? _nativeId;
  String _nativeTitle = 'none';
  String _nativeBody = 'none';
  String _nativePayload = 'none';

  IOSFlutterLocalNotificationsPlugin get _iosPlugin {
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios == null) throw StateError('iOS notification API is unavailable.');
    return ios;
  }

  @override
  void initState() {
    super.initState();
    _selectedId = widget.launchId;
    _selectionSubscription = LocalNotificationsScheduler.selectedReminders
        .listen((id) {
          if (!mounted) return;
          setState(() => _selectedId = id);
          if (_deliveryPending && id == _deliveryQaId) {
            _deliveryPending = false;
            unawaited(
              _run('notification tap', () async {
                _targetId = _deliveryQaId;
                await _refresh();
                _require(id == _deliveryQaId, 'Tapped reminder ID mismatch.');
                _require(
                  _databaseStatus == 'active',
                  'Tapped reminder is not active in the DB.',
                );
                _result = 'PASS';
              }),
            );
          }
        });
    unawaited(
      _run('initial state', () async {
        await _refresh();
        _require(_activeCount == 0, 'Unexpected active QA database rows.');
        _require(_nativeCount == 0, 'Unexpected pending QA native requests.');
        _result = 'READY';
      }),
    );
  }

  @override
  void dispose() {
    unawaited(_selectionSubscription?.cancel());
    unawaited(widget.db.close());
    super.dispose();
  }

  Future<void> _refresh() async {
    final permissions = await _iosPlugin.checkPermissions();
    final rows = await (widget.db.select(
      widget.db.reminders,
    )..where((row) => row.id.isBiggerOrEqualValue(_firstQaId))).get();
    final requests = (await _plugin.pendingNotificationRequests())
        .where(
          (request) => request.id == _firstQaId || request.id == _deliveryQaId,
        )
        .toList();
    final targetRow = rows.where((row) => row.id == _targetId).firstOrNull;
    final targetRequest = requests
        .where((request) => request.id == _targetId)
        .firstOrNull;
    _permissionEnabled = permissions?.isEnabled;
    _permissionAlert = permissions?.isAlertEnabled;
    _permissionSound = permissions?.isSoundEnabled;
    _activeCount = rows.where((row) => row.status == 'active').length;
    _databaseId = targetRow?.id;
    _databaseStatus = targetRow?.status ?? 'absent';
    _databaseScheduledUtc =
        targetRow?.scheduledAt.toUtc().toIso8601String() ?? 'none';
    _nativeCount = requests.length;
    _nativeId = targetRequest?.id;
    _nativeTitle = targetRequest?.title ?? 'none';
    _nativeBody = targetRequest?.body ?? 'none';
    _nativePayload = targetRequest?.payload ?? 'none';
    if (mounted) setState(() {});
  }

  Future<void> _run(String action, Future<void> Function() work) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = 'none';
      _result = 'RUNNING';
    });
    try {
      await work();
      await _refresh();
      if (_result == 'RUNNING') _result = 'PASS';
    } catch (error) {
      _result = 'FAIL';
      _error = '$action: $error';
      try {
        await _refresh();
      } catch (refreshError) {
        _error = '$_error; state refresh failed: $refreshError';
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _require(bool condition, String message) {
    if (!condition) throw StateError(message);
  }

  Future<void> _schedule({
    required bool delivery,
    bool reschedule = false,
  }) async {
    _targetId = delivery ? _deliveryQaId : _firstQaId;
    final requestedAt = DateTime.now().toUtc().add(
      Duration(seconds: delivery ? 10 : (reschedule ? 10 : 5) * 60),
    );
    final scheduled = await widget.repository.setReminder(
      listId: widget.listId,
      title: _qaTitle,
      body: _qaBody,
      atUtc: requestedAt,
    );
    await _refresh();
    if (!scheduled) {
      _require(
        _databaseStatus != 'active',
        'Denied request became active in the DB.',
      );
      _require(_nativeId == null, 'Denied request was queued natively.');
      _require(
        _permissionEnabled != true,
        'Permission reports enabled after denial.',
      );
      _require(
        _permissionAlert != true,
        'Alert permission is enabled after denial.',
      );
      _require(
        _permissionSound != true,
        'Sound permission is enabled after denial.',
      );
      _result = 'PASS';
      return;
    }
    _require(
      _permissionEnabled == true,
      'iOS does not report notifications enabled.',
    );
    _require(_permissionAlert == true, 'iOS alert permission is not enabled.');
    _require(_permissionSound == true, 'iOS sound permission is not enabled.');
    _require(_databaseId == _targetId, 'Unexpected reminder database ID.');
    _require(
      _databaseStatus == 'active',
      'Reminder database row is not active.',
    );
    final scheduledAt = DateTime.parse(_databaseScheduledUtc).toUtc();
    final schedulingDelta = scheduledAt.difference(requestedAt);
    _require(
      schedulingDelta >= const Duration(seconds: -10) &&
          schedulingDelta <= const Duration(seconds: 30),
      'Database UTC schedule differs from the requested time.',
    );
    _require(_activeCount == 1, 'Expected exactly one active reminder.');
    _require(_nativeCount == 1, 'Expected exactly one pending QA request.');
    _require(
      _nativeId == _targetId,
      'Native request ID does not match the DB.',
    );
    _require(_nativeTitle == _qaTitle, 'Native title mismatch.');
    _require(_nativeBody == _qaBody, 'Native body mismatch.');
    _require(
      _nativePayload == 'reminder:$_targetId',
      'Native payload mismatch.',
    );
    if (delivery) {
      _deliveryPending = true;
      _result = 'READY FOR DELIVERY';
    } else {
      _result = 'PASS';
    }
  }

  Future<void> _cancel() async {
    final id = _targetId;
    await widget.repository.cancelReminder(id);
    await widget.repository.cancelReminder(id);
    await _refresh();
    _require(_databaseStatus == 'cancelled', 'Database row is not cancelled.');
    _require(
      _nativeId == null,
      'Cancelled reminder remains in the native queue.',
    );
    _require(_activeCount == 0, 'An active reminder remains in the DB.');
    _require(
      _nativeCount == 0,
      'A pending QA request remains in the native queue.',
    );
    _result = 'PASS';
  }

  Future<void> _read() async {
    await _refresh();
    _result = 'PASS';
  }

  Widget _line(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text('$label: $value', key: ValueKey(label)),
  );

  Widget _button(String label, Future<void> Function() action) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _busy ? null : () => unawaited(_run(label, action)),
        child: Text(label),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Reminder QA')),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _line('QA result', _result),
            _line('Permission enabled', '$_permissionEnabled'),
            _line('Permission alert', '$_permissionAlert'),
            _line('Permission sound', '$_permissionSound'),
            _line('Database active', '$_activeCount'),
            _line('Database id', '$_databaseId'),
            _line('Database status', _databaseStatus),
            _line('Database scheduled UTC', _databaseScheduledUtc),
            _line('Native requests', '$_nativeCount'),
            _line('Native id', '$_nativeId'),
            _line('Native title', _nativeTitle),
            _line('Native body', _nativeBody),
            _line('Native payload', _nativePayload),
            _line('Initial reminder id', '${widget.launchId}'),
            _line('Selected reminder', '$_selectedId'),
            _line('Failure', _error),
            const SizedBox(height: 12),
            _button('Read native state', _read),
            _button('Schedule reminder', () => _schedule(delivery: false)),
            _button('Reschedule reminder', () async {
              _require(
                _databaseStatus == 'active',
                'Schedule an active reminder first.',
              );
              await _schedule(delivery: false, reschedule: true);
            }),
            _button('Cancel reminder twice', _cancel),
            _button(
              'Schedule delivery reminder',
              () => _schedule(delivery: true),
            ),
          ],
        ),
      ),
    ),
  );
}

class _BootFailure extends StatelessWidget {
  const _BootFailure({required this.error, required this.stack});

  final Object error;
  final StackTrace stack;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Reminder QA')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('QA result: FAIL\nFailure: $error\n$stack'),
      ),
    ),
  );
}
