import 'package:drift/drift.dart';

import '../../data/db/app_database.dart';

/// Ana ekran verisi: aktif listeler, son tamamlananlar ve bu ay toplamları
/// (spec §6.4). Bu ay kartı yalnız ay içinde tamamlanmış alışveriş varsa
/// anlamlıdır; yoksa UI boş durum gösterir (demo veri yok).
class HomeRepository {
  HomeRepository(this._db);

  final AppDatabase _db;

  Stream<List<ShoppingList>> watchActiveLists() =>
      (_db.select(_db.shoppingLists)
            ..where((t) => t.status.isIn(const ['draft', 'planned', 'shopping']))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Stream<List<ShoppingList>> watchRecentCompleted({int limit = 3}) =>
      (_db.select(_db.shoppingLists)
            ..where((t) => t.status.equals('completed'))
            ..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
          .watch();

  /// Bu ay tamamlanan listelerin PARA BİRİMİ BAŞINA planlanan ve gerçek
  /// toplamları (spec §7.1: farklı para birimleri asla toplanmaz).
  /// Ay içinde tamamlanan alışveriş yoksa boş liste yayar.
  Stream<List<MonthlyTotals>> watchMonthlyTotals() {
    final now = DateTime.now();
    final monthPrefix =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';
    return _db.customSelect(
      '''
      SELECT
        sl.currency_code AS currency,
        COALESCE(SUM(pi.planned_line_total_minor_units), 0) AS planned,
        COALESCE((SELECT SUM(pe.actual_line_total_minor_units)
          FROM purchase_entries pe
          JOIN shopping_lists sl2 ON pe.list_id = sl2.id
          WHERE sl2.status = 'completed'
            AND sl2.currency_code = sl.currency_code
            AND strftime('%Y-%m', sl2.completed_at, 'unixepoch') = ?), 0) AS actual
      FROM shopping_lists sl
      LEFT JOIN planned_items pi ON pi.list_id = sl.id
      WHERE sl.status = 'completed'
        AND strftime('%Y-%m', sl.completed_at, 'unixepoch') = ?
      GROUP BY sl.currency_code
      ORDER BY sl.currency_code
      ''',
      variables: [Variable(monthPrefix), Variable(monthPrefix)],
      readsFrom: {
        _db.plannedItems,
        _db.purchaseEntries,
        _db.shoppingLists,
      },
    ).watch().map((rows) => [
          for (final row in rows)
            MonthlyTotals(
              currencyCode: row.read<String>('currency'),
              plannedMinor: row.read<int>('planned'),
              actualMinor: row.read<int>('actual'),
            ),
        ]);
  }
}

/// Bir para biriminin aylık toplamları (minor unit).
class MonthlyTotals {
  const MonthlyTotals({
    required this.currencyCode,
    required this.plannedMinor,
    required this.actualMinor,
  });

  final String currencyCode;
  final int plannedMinor;
  final int actualMinor;

  int get varianceMinor => actualMinor - plannedMinor;
}
