import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Shared persistent Drift database executor for foreground UI and background
/// isolates (`PRAGMA busy_timeout` in `AppDatabase.beforeOpen` guards access).
QueryExecutor openAppDatabase() => driftDatabase(name: 'nshoptor');
