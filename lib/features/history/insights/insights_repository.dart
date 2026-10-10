import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';

/// Aylık toplamlar (para birimi başına, spec §7.1: karışık para toplanmaz).
class MonthlyBucket {
  const MonthlyBucket({
    required this.month,
    required this.currencyCode,
    required this.plannedMinor,
    required this.actualMinor,
    this.comparedCount = 0,
    this.comparedPlannedMinor = 0,
    this.comparedActualMinor = 0,
  });

  /// `YYYY-MM`
  final String month;
  final String currencyCode;
  final int plannedMinor;
  final int actualMinor;

  final int comparedCount;
  final int comparedPlannedMinor;
  final int comparedActualMinor;
  int? get varianceMinor => comparedCount == 0 ? null : comparedActualMinor - comparedPlannedMinor;
}

/// Kategori veya mağaza bazlı harcama kırılımı.
class SpendingSlice {
  const SpendingSlice({required this.label, required this.actualMinor});

  /// Kategori adı (kanonik token) veya mağaza adı; null = adsız/diğer.
  final String? label;
  final int actualMinor;
}

/// Net purchases; visits use positive purchases, not receipt lines or edits.
class PurchaseStats {
  PurchaseStats({required this.name, required this.unitCode, this.productId});
  final String name;
  final String unitCode;
  final int? productId;
  DecimalFixed quantity = DecimalFixed.zero();
  int actualMinor = 0;
  final Map<int, DateTime> visits = {};
  DateTime? get firstAt => visits.isEmpty ? null : visits.values.reduce((a, b) => a.isBefore(b) ? a : b);
  DateTime? get lastAt => visits.isEmpty ? null : visits.values.reduce((a, b) => a.isAfter(b) ? a : b);
  DecimalFixed? get intervalDays => visits.length < 2 ? null :
    DecimalFixed.fromInt(lastAt!.difference(firstAt!).inSeconds)
      .divide(DecimalFixed.fromInt((visits.length - 1) * 86400), scale: 2);
}

/// Tahmin sapması en büyük ürün satırı.
class VarianceItem {
  const VarianceItem({
    required this.name,
    required this.plannedMinor,
    required this.actualMinor,
  });

  final String name;
  final int plannedMinor;
  final int actualMinor;

  int get varianceMinor => actualMinor - plannedMinor;
  int get varianceAbs => varianceMinor.abs();
}

/// Geçmiş ve içgörüler (spec §6.12). Yetersiz veride metodlar boş liste/[]
/// döner; çağıran taraf anlamlı boş durum gösterir, yanlış trend üretilmez.
class InsightsRepository {
  InsightsRepository(this._db);

  final AppDatabase _db;

  /// Tamamlanan alışverişler (en yeni önce); başlık/mağaza filtreleri UI
  /// katmanında uygulanır.
  Stream<List<ShoppingList>> watchCompleted() =>
      (_db.select(_db.shoppingLists)
            ..where((t) => t.status.equals('completed'))
            ..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
          .watch();

  Future<List<MonthlyBucket>> monthlyTotals() => _monthlyQuery().get();
  Stream<List<MonthlyBucket>> watchMonthlyTotals() => _monthlyQuery().watch();

  // Aggregate purchases before joining plans: multiple receipt rows count the
  // estimate once. The known-price predicate matches ResultRepository.
  Selectable<MonthlyBucket> _monthlyQuery() => _db.customSelect(
    '''WITH purchases AS (
      SELECT list_id, planned_item_id, SUM(actual_line_total_minor_units) AS actual,
        MIN(gross_total_minor_units IS NOT NULL OR actual_line_total_minor_units != 0
          OR source = 'receiptOcr') AS known
      FROM purchase_entries GROUP BY list_id, planned_item_id
    ), plans AS (
      SELECT list_id, SUM(planned_line_total_minor_units) AS planned
      FROM planned_items GROUP BY list_id
    ), actuals AS (
      SELECT list_id, SUM(actual) AS actual FROM purchases GROUP BY list_id
    ), compared AS (
      SELECT pi.list_id, COUNT(*) AS compared_count,
        SUM(pi.planned_line_total_minor_units) AS compared_planned,
        SUM(p.actual) AS compared_actual
      FROM planned_items pi JOIN purchases p
        ON p.list_id = pi.list_id AND p.planned_item_id = pi.id
      WHERE pi.planned_line_total_minor_units IS NOT NULL AND p.known = 1
      GROUP BY pi.list_id
    )
    SELECT strftime('%Y-%m', sl.completed_at, 'unixepoch', 'localtime') AS month,
      sl.currency_code AS currency,
      COALESCE(SUM(plans.planned), 0) AS planned,
      COALESCE(SUM(actuals.actual), 0) AS actual,
      COALESCE(SUM(compared.compared_count), 0) AS compared_count,
      COALESCE(SUM(compared.compared_planned), 0) AS compared_planned,
      COALESCE(SUM(compared.compared_actual), 0) AS compared_actual
    FROM shopping_lists sl
    LEFT JOIN plans ON plans.list_id = sl.id
    LEFT JOIN actuals ON actuals.list_id = sl.id
    LEFT JOIN compared ON compared.list_id = sl.id
    WHERE sl.status = 'completed' AND sl.completed_at IS NOT NULL
    GROUP BY month, sl.currency_code ORDER BY month DESC, sl.currency_code
    ''', readsFrom: {_db.plannedItems, _db.purchaseEntries, _db.shoppingLists},
  ).map((row) => MonthlyBucket(month: row.read<String>('month'),
    currencyCode: row.read<String>('currency'), plannedMinor: row.read<int>('planned'),
    actualMinor: row.read<int>('actual'), comparedCount: row.read<int>('compared_count'),
    comparedPlannedMinor: row.read<int>('compared_planned'), comparedActualMinor: row.read<int>('compared_actual')));

  /// Tamamlanan alışverişlerin kategori bazında gerçek harcaması.
  Future<List<SpendingSlice>> spendingByCategory(String currencyCode) {
    return _db.customSelect(
      '''
      SELECT
        COALESCE(c.name, 'other') AS label,
        SUM(pe.actual_line_total_minor_units) AS total
      FROM purchase_entries pe
      JOIN shopping_lists sl ON pe.list_id = sl.id
      LEFT JOIN planned_items pi ON pe.planned_item_id = pi.id
      LEFT JOIN categories c ON pi.category_id = c.id
      WHERE sl.status = 'completed' AND sl.completed_at IS NOT NULL AND pe.user_confirmed = 1 AND sl.currency_code = ?
      GROUP BY label
      ORDER BY total DESC
      ''',
      variables: [Variable.withString(currencyCode)],
      readsFrom: {
        _db.purchaseEntries,
        _db.shoppingLists,
        _db.plannedItems,
        _db.categories,
      },
    ).get().then((rows) => [
          for (final row in rows)
            SpendingSlice(
              label: row.readNullable<String>('label'),
              actualMinor: row.read<int>('total'),
            ),
        ]);
  }

  /// Mağaza bazında gerçek harcama; mağazasız alımlar null etiketlidir.
  Future<List<SpendingSlice>> spendingByStore(String currencyCode) {
    return _db.customSelect(
      '''
      SELECT
        s.name AS label,
        SUM(pe.actual_line_total_minor_units) AS total
      FROM purchase_entries pe
      JOIN shopping_lists sl ON pe.list_id = sl.id
      LEFT JOIN stores s ON sl.store_id = s.id
      WHERE sl.status = 'completed' AND sl.completed_at IS NOT NULL AND pe.user_confirmed = 1 AND sl.currency_code = ?
      GROUP BY s.name
      ORDER BY total DESC
      ''',
      variables: [Variable.withString(currencyCode)],
      readsFrom: {_db.purchaseEntries, _db.shoppingLists, _db.stores},
    ).get().then((rows) => [
          for (final row in rows)
            SpendingSlice(
              label: row.readNullable<String>('label'),
              actualMinor: row.read<int>('total'),
            ),
        ]);
  }

  Future<List<PurchaseStats>> purchaseStats(String currencyCode, {bool byCategory = false}) async {
    final rows = await _db.customSelect(
      '''SELECT pe.*, sl.completed_at AS completed_at,
        COALESCE(c.name, 'other') AS category,
        (SELECT pm.id FROM product_memory pm WHERE pm.normalized_name = pe.normalized_name LIMIT 1) AS product_id
      FROM purchase_entries pe JOIN shopping_lists sl ON sl.id = pe.list_id
      LEFT JOIN planned_items pi ON pi.id = pe.planned_item_id AND pi.list_id = pe.list_id
      LEFT JOIN categories c ON c.id = pi.category_id
      WHERE sl.status = 'completed' AND sl.completed_at IS NOT NULL
        AND pe.user_confirmed = 1 AND sl.currency_code = ?
      ORDER BY sl.completed_at, pe.id''',
      variables: [Variable.withString(currencyCode)],
      readsFrom: {_db.purchaseEntries, _db.shoppingLists, _db.plannedItems, _db.categories, _db.productMemory},
    ).get();
    final groups = <(String, String, int?), PurchaseStats>{};
    for (final row in rows) {
      final quantity = DecimalFixed.parse(row.read<String>('actual_quantity'));
      if (quantity.isZero) continue; // global receipt discount, no product quantity
      final storedUnit = row.read<String>('actual_unit_code');
      final unit = UnitCode.values.where((u) => u.dbCode == storedUnit || u.name == storedUnit).firstOrNull;
      final code = unit?.dbCode ?? storedUnit;
      final label = row.read<String>(byCategory ? 'category' : 'name');
      // ponytail: custom/unknown units have no stored label; keep entry-separated
      // until a unit label exists in the schema rather than summing unlike measures.
      final key = (row.read<String>(byCategory ? 'category' : 'normalized_name'), code,
        unit == null || unit == UnitCode.custom ? row.read<int>('id') : null);
      final group = groups.putIfAbsent(key, () => PurchaseStats(name: label, unitCode: code,
        productId: byCategory ? null : row.readNullable<int>('product_id')));
      group.quantity += quantity;
      group.actualMinor = int.parse((BigInt.from(group.actualMinor) + BigInt.from(row.read<int>('actual_line_total_minor_units'))).toString());
      if (quantity.isPositive) group.visits[row.read<int>('list_id')] = row.read<DateTime>('completed_at');
    }
    return groups.values.toList()..sort((a, b) {
      final visits = b.visits.length.compareTo(a.visits.length);
      return visits != 0 ? visits : a.name.compareTo(b.name);
    });
  }

  /// Tahmin sapması en büyük ürünler: plan-gerçek satır farkı mutlak değeri
  /// ile sıralı (tamamlanan listelerde).
  Future<List<VarianceItem>> biggestVariances({int limit = 5}) {
    return _db.customSelect(
      '''
      SELECT
        pi.name AS name,
        COALESCE(pi.planned_line_total_minor_units, 0) AS planned,
        COALESCE((SELECT SUM(pe2.actual_line_total_minor_units)
          FROM purchase_entries pe2 WHERE pe2.planned_item_id = pi.id AND pe2.list_id = pi.list_id), 0) AS actual
      FROM planned_items pi
      JOIN shopping_lists sl ON pi.list_id = sl.id
      WHERE sl.status = 'completed' AND sl.completed_at IS NOT NULL
        AND pi.planned_line_total_minor_units IS NOT NULL
        AND EXISTS(SELECT 1 FROM purchase_entries p WHERE p.planned_item_id = pi.id AND p.list_id = pi.list_id)
        AND NOT EXISTS(SELECT 1 FROM purchase_entries p WHERE p.planned_item_id = pi.id AND p.list_id = pi.list_id
          AND p.gross_total_minor_units IS NULL AND p.actual_line_total_minor_units = 0 AND p.source != 'receiptOcr')
      ''',
      readsFrom: {_db.plannedItems, _db.purchaseEntries, _db.shoppingLists},
    ).get().then((rows) {
      final items = [
        for (final row in rows)
          VarianceItem(
            name: row.read<String>('name'),
            plannedMinor: row.read<int>('planned'),
            actualMinor: row.read<int>('actual'),
          ),
      ]..sort((a, b) => b.varianceAbs.compareTo(a.varianceAbs));
      return items.take(limit).toList();
    });
  }

  /// Plan dışı harcama toplamı (minor unit, tüm zamanlar).
  Future<int> unplannedTotal(String currencyCode) async {
    final rows = await _db.customSelect(
      '''
      SELECT COALESCE(SUM(pe.actual_line_total_minor_units), 0) AS total
      FROM purchase_entries pe
      JOIN shopping_lists sl ON pe.list_id = sl.id
      WHERE pe.planned_item_id IS NULL AND sl.status = 'completed' AND sl.completed_at IS NOT NULL AND pe.user_confirmed = 1 AND sl.currency_code = ?
      ''',
      variables: [Variable.withString(currencyCode)],
      readsFrom: {_db.purchaseEntries, _db.shoppingLists},
    ).get();
    return rows.single.read<int>('total');
  }

  /// Tamamlanan alışverişler: (tarih, gerçek toplam) — tek para biriminde
  /// (spec §7.1: karışık para toplanmaz). Takvim ve grafiklerin kaynağı.
  Future<List<SpendPoint>> completedSpend(String currencyCode) async {
    final rows = await _db.customSelect(
      '''
      SELECT sl.id AS id, sl.completed_at AS completed_at,
             COALESCE(SUM(pe.actual_line_total_minor_units), 0) AS total
      FROM shopping_lists sl
      LEFT JOIN purchase_entries pe ON pe.list_id = sl.id AND pe.user_confirmed = 1
      WHERE sl.status = 'completed' AND sl.completed_at IS NOT NULL
        AND sl.currency_code = ?
      GROUP BY sl.id
      ''',
      variables: [Variable.withString(currencyCode)],
      readsFrom: {_db.purchaseEntries, _db.shoppingLists},
    ).get();
    return [
      for (final r in rows)
        SpendPoint(
          listId: r.read<int>('id'),
          at: r.read<DateTime>('completed_at'),
          actualMinor: r.read<int>('total'),
        ),
    ]..sort((a, b) => a.at.compareTo(b.at));
  }
}

/// Bir tamamlanmış alışverişin tarihi ve gerçek toplamı.
class SpendPoint {
  const SpendPoint({required this.listId, required this.at, required this.actualMinor});
  final int listId;
  final DateTime at;
  final int actualMinor;
}

/// Saf toplama yardımcıları (test edilebilir; tarihler yerel saatle).
class SpendMath {
  SpendMath._();

  /// Ayın günlerine göre toplam: gün → minor.
  static Map<int, int> byDay(List<SpendPoint> points, int year, int month) {
    final out = <int, int>{};
    for (final p in points) {
      final d = p.at.toLocal();
      if (d.year == year && d.month == month) {
        out[d.day] = (out[d.day] ?? 0) + p.actualMinor;
      }
    }
    return out;
  }

  /// Son [weeks] haftanın (pazartesi başlangıç) toplamları, eskiden yeniye.
  static List<(DateTime, int)> byWeek(List<SpendPoint> points, DateTime now, {int weeks = 8}) {
    final today = DateTime(now.year, now.month, now.day);
    final thisMonday = today.subtract(Duration(days: today.weekday - 1));
    return [
      for (var w = weeks - 1; w >= 0; w--)
        () {
          final start = DateTime(thisMonday.year, thisMonday.month, thisMonday.day - 7 * w);
          final end = DateTime(start.year, start.month, start.day + 7);
          final total = points
              .where((p) => !p.at.toLocal().isBefore(start) && p.at.toLocal().isBefore(end))
              .fold<int>(0, (s, p) => s + p.actualMinor);
          return (start, total);
        }(),
    ];
  }

  /// Son [months] ayın toplamları, eskiden yeniye.
  static List<(DateTime, int)> byMonth(List<SpendPoint> points, DateTime now, {int months = 6}) {
    return [
      for (var m = months - 1; m >= 0; m--)
        () {
          final start = DateTime(now.year, now.month - m);
          final total = points
              .where((p) => p.at.toLocal().year == start.year && p.at.toLocal().month == start.month)
              .fold<int>(0, (s, p) => s + p.actualMinor);
          return (start, total);
        }(),
    ];
  }
}
