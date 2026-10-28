import '../../../core/money/decimal_fixed.dart';
import '../insights/insights_repository.dart' show SpendAmount;
import 'report_repository.dart';

/// Read-only report groupings for the History views (F30): by store and by
/// product over the shopping trips of one period. Amounts stay in minor units.
typedef ReportDayAmount = ({DateTime day, SpendAmount spent});

final class ReportGroup {
  ReportGroup({
    required this.key,
    required this.label,
    required this.spent,
    required this.count,
    List<ReportQuantity> quantities = const [],
    List<ReportDayAmount> byDay = const [],
  }) : quantities = List.unmodifiable(quantities),
       byDay = List.unmodifiable(byDay);

  /// Case-insensitive grouping key.
  final String key;

  /// Display name; null only for a store that is not known.
  final String? label;
  final SpendAmount spent;

  /// Shopping trips that contributed to this group.
  final int count;
  final List<ReportQuantity> quantities;

  /// Spend per local calendar day, ascending.
  final List<ReportDayAmount> byDay;
}

SpendAmount addSpend(SpendAmount a, SpendAmount b) => SpendAmount(
  a.minor + b.minor,
  known: a.known || b.known,
  unknown: a.unknown || b.unknown,
);

const _none = SpendAmount(0, known: false, unknown: false);

DateTime _day(ShoppingReport s) {
  final at = (s.list.completedAt ?? s.list.createdAt).toLocal();
  return DateTime(at.year, at.month, at.day);
}

int _byAmount(ReportGroup a, ReportGroup b) {
  final amount = b.spent.minor.compareTo(a.spent.minor);
  if (amount != 0) return amount;
  if (a.label == null) return 1;
  if (b.label == null) return -1;
  return a.label!.toLowerCase().compareTo(b.label!.toLowerCase());
}

List<ReportDayAmount> _days(Map<DateTime, SpendAmount> days) =>
    [for (final e in days.entries) (day: e.key, spent: e.value)]
      ..sort((a, b) => a.day.compareTo(b.day));

/// Spend per day of the given trips, ascending (the daily chart).
List<ReportDayAmount> spendByDay(Iterable<ShoppingReport> shopping) {
  final days = <DateTime, SpendAmount>{};
  for (final s in shopping) {
    days[_day(s)] = addSpend(days[_day(s)] ?? _none, s.spent);
  }
  return _days(days);
}

/// Groups spend by cleaned store name; one trip may count for several stores.
List<ReportGroup> groupByStore(Iterable<ShoppingReport> shopping) {
  final spent = <String, SpendAmount>{};
  final labels = <String, String?>{};
  final trips = <String, Set<int>>{};
  final days = <String, Map<DateTime, SpendAmount>>{};
  for (final s in shopping) {
    for (final part in s.storeSpend) {
      final key = part.store?.toLowerCase() ?? '';
      labels.putIfAbsent(key, () => part.store);
      spent[key] = addSpend(spent[key] ?? _none, part.spent);
      trips.putIfAbsent(key, () => {}).add(s.list.id);
      final d = days.putIfAbsent(key, () => {});
      d[_day(s)] = addSpend(d[_day(s)] ?? _none, part.spent);
    }
  }
  return [
    for (final key in spent.keys)
      ReportGroup(
        key: key,
        label: labels[key],
        spent: spent[key]!,
        count: trips[key]!.length,
        byDay: _days(days[key]!),
      ),
  ]..sort(_byAmount);
}

/// Groups bought products by name (case-insensitive): quantity per unit and
/// spend. Unbought planned items and receipt discount rows are not products.
List<ReportGroup> groupByProduct(Iterable<ShoppingReport> shopping) {
  final spent = <String, SpendAmount>{};
  final labels = <String, String>{};
  final trips = <String, Set<int>>{};
  final quantities = <String, Map<String, DecimalFixed>>{};
  final days = <String, Map<DateTime, SpendAmount>>{};
  for (final s in shopping) {
    for (final p in s.products) {
      if (p.isDiscount || p.actualQuantities.isEmpty && !p.actual.unknown) {
        continue;
      }
      final key = p.name.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
      if (key.isEmpty) continue;
      final name = p.name.trim().replaceAll(RegExp(r'\s+'), ' ');
      final seen = labels[key];
      // Prefer a capitalised spelling over an all-lowercase one.
      if (seen == null || seen == seen.toLowerCase() && name != seen) {
        labels[key] = name;
      }
      spent[key] = addSpend(spent[key] ?? _none, p.actual);
      trips.putIfAbsent(key, () => {}).add(s.list.id);
      final q = quantities.putIfAbsent(key, () => {});
      for (final a in p.actualQuantities) {
        q[a.unitCode] = (q[a.unitCode] ?? DecimalFixed.zero()) + a.quantity;
      }
      final d = days.putIfAbsent(key, () => {});
      d[_day(s)] = addSpend(d[_day(s)] ?? _none, p.actual);
    }
  }
  return [
    for (final key in spent.keys)
      ReportGroup(
        key: key,
        label: labels[key],
        spent: spent[key]!,
        count: trips[key]!.length,
        quantities: [
          for (final e in quantities[key]!.entries)
            (quantity: e.value, unitCode: e.key),
        ],
        byDay: _days(days[key]!),
      ),
  ]..sort(_byAmount);
}
