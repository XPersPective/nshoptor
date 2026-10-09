import '../../../core/calc/line_calc.dart';
import '../../../core/calc/list_calc.dart';
import '../../../core/calc/variance.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/money.dart';
import '../../../data/db/app_database.dart';
import '../item_status.dart';

/// Ürünün sonuç sınıflandırmasında birden fazla gruba düşebilmesi için
/// etiket kümesi (spec §6.11 grupları).
enum ItemResultGroup { pricier, cheaper, close, notTaken, unplanned, quantityChanged, unverified }

/// Tek bir planlanan ürünün (veya plansız alımın) sonuç satırı.
class ItemResultRow {
  const ItemResultRow({
    required this.name,
    required this.plannedQuantity,
    required this.actualQuantity,
    required this.plannedUnitPrice,
    required this.actualUnitPrice,
    required this.plannedLineTotalMinor,
    required this.actualLineTotalMinor,
    required this.lineVarianceMinor,
    required this.variancePercent,
    required this.discountMinor,
    required this.groups,
    required this.notTaken,
    required this.isUnplanned,
    required this.userConfirmed,
    this.actualKnown = true,
    this.plannedKnown = true,
  });

  final String name;
  final DecimalFixed? plannedQuantity;
  final DecimalFixed? actualQuantity;
  final DecimalFixed? plannedUnitPrice;
  final DecimalFixed? actualUnitPrice;
  final int plannedLineTotalMinor;
  final int actualLineTotalMinor;
  final int lineVarianceMinor;
  final DecimalFixed? variancePercent;
  final int discountMinor;
  final Set<ItemResultGroup> groups;
  final bool notTaken;
  final bool isUnplanned;
  final bool userConfirmed;
  final bool actualKnown;
  final bool plannedKnown;

  /// "Pahalandı" yargısı YALNIZ birim fiyat farkına dayanır; miktar artışı
  /// tek başına pahalı grubuna sokmaz (spec §6.11).
  bool get priceChanged {
    final p = plannedUnitPrice;
    final a = actualUnitPrice;
    return p != null && a != null && a.compareTo(p) != 0;
  }
}

/// Liste düzeyi sonuç özeti (spec §6.11).
class ListResult {
  const ListResult({
    required this.currencyCode,
    required this.plannedTotalMinor,
    required this.actualTotalMinor,
    required this.unplannedTotalMinor,
    required this.unpurchasedPlannedMinor,
    required this.totalDiscountMinor,
    required this.variancePercent,
    required this.accuracy,
    required this.rows,
    this.budgetMinor,
    this.comparedPlannedMinor,
    this.comparedActualMinor,
  });

  /// Listenin bütçesi (varsa); karşılaştırma tablosunda bütçe satırı.
  final int? budgetMinor;

  final String currencyCode;
  final int plannedTotalMinor;
  final int actualTotalMinor;

  /// Difference for purchased items with both prices known; skipped estimates are excluded.
  int get varianceMinor => (comparedActualMinor ?? actualTotalMinor) - (comparedPlannedMinor ?? plannedTotalMinor);
  final int? comparedPlannedMinor;
  final int? comparedActualMinor;
  final DecimalFixed? variancePercent;
  final int unplannedTotalMinor;
  final int unpurchasedPlannedMinor;
  final int totalDiscountMinor;

  /// 0-100 arası; plan 0 iken null.
  final DecimalFixed? accuracy;

  final List<ItemResultRow> rows;

  Set<ItemResultGroup> get presentGroups {
    final groups = <ItemResultGroup>{};
    for (final r in rows) {
      groups.addAll(r.groups);
    }
    return groups;
  }

  bool get hasComparison => rows.any((r) => !r.notTaken && !r.isUnplanned && r.actualKnown && r.plannedKnown);
  bool get hasKnownPlan => rows.any((r) => !r.isUnplanned && r.plannedKnown);
  bool get hasKnownActual => rows.any((r) => !r.notTaken && r.actualKnown);
  bool get hasUnknownActual => rows.any((r) => !r.notTaken && !r.actualKnown);
}

/// Tamamlanan alışverişin sonuç hesabı (spec §6.11, §7.3).
class ResultRepository {
  ResultRepository(this._db, {VarianceThreshold? threshold})
      : threshold = threshold ?? VarianceThreshold();

  final AppDatabase _db;
  AppDatabase get db => _db;
  final VarianceThreshold threshold;

  Future<ListResult> compute(int listId) async {
    final list = await (_db.select(_db.shoppingLists)
          ..where((t) => t.id.equals(listId)))
        .getSingle();
    final items = await (_db.select(_db.plannedItems)
          ..where((t) => t.listId.equals(listId)))
        .get();
    final entries = await (_db.select(_db.purchaseEntries)
          ..where((t) => t.listId.equals(listId)))
        .get();

    final currency = Currency.fromCode(list.currencyCode);
    final digits = currency.minorUnitDigits;

    var plannedTotal = 0;
    var unpurchasedPlanned = 0;
    var comparedPlanned = 0;
    var comparedActual = 0;
    final rows = <ItemResultRow>[];

    for (final item in items) {
      final plannedLine = item.plannedLineTotalMinorUnits ?? 0;
      plannedTotal += plannedLine;
      final status = ItemStatus.tryFromDb(item.status) ?? ItemStatus.pending;
      final itemEntries = entries
          .where((e) => e.plannedItemId == item.id)
          .toList(growable: false);

      if (itemEntries.isEmpty && !status.isInCart) {
        // Planlanıp alınmadı: gerçeğe 0 YAZILMAZ, ayrı grup (spec §6.6).
        unpurchasedPlanned += plannedLine;
        rows.add(ItemResultRow(
          name: item.name,
          plannedQuantity: DecimalFixed.parse(item.plannedQuantity),
          actualQuantity: null,
          plannedUnitPrice: _parseD(item.plannedUnitPrice),
          actualUnitPrice: null,
          plannedLineTotalMinor: plannedLine,
          actualLineTotalMinor: 0,
          lineVarianceMinor: 0,
          variancePercent: null,
          discountMinor: 0,
          groups: {ItemResultGroup.notTaken},
          notTaken: true,
          isUnplanned: false,
          userConfirmed: true,
          actualKnown: false,
          plannedKnown: item.plannedLineTotalMinorUnits != null,
        ));
        continue;
      }

      final sameUnit = itemEntries.map((e) => e.actualUnitCode).toSet().length <= 1;
      final actualQty = sameUnit ? itemEntries.fold<DecimalFixed>(
          DecimalFixed.zero(), (s, e) => s + DecimalFixed.parse(e.actualQuantity)) : null;
      final actualLine =
          itemEntries.fold<int>(0, (s, e) => s + e.actualLineTotalMinorUnits);
      final discount = itemEntries
          .fold<int>(0, (s, e) => s + e.discountMinorUnits);
      final plannedQty = DecimalFixed.parse(item.plannedQuantity);
      final plannedUnit = _parseD(item.plannedUnitPrice);
      final actualKnown = itemEntries.isNotEmpty && itemEntries.every((e) =>
        e.grossTotalMinorUnits != null || e.actualLineTotalMinorUnits != 0 || e.source == 'receiptOcr');
      final compatible = itemEntries.every((e) => e.actualUnitCode == item.plannedUnitCode);
      final actualUnit = actualKnown && compatible && actualQty != null && !actualQty.isZero ?
        DecimalFixed.fromMinorUnits(actualLine + discount, digits).divide(actualQty, scale: DecimalFixed.maxFractionDigits) : null;
      final comparable = actualKnown && item.plannedLineTotalMinorUnits != null;
      if (comparable) { comparedPlanned += plannedLine; comparedActual += actualLine; }

      final variance = comparable ? actualLine - plannedLine : 0;
      final percent = comparable ? _percent(variance, plannedLine, digits) : null;
      final quantityChanged = !compatible || actualQty == null || actualQty.compareTo(plannedQty) != 0;
      // "Pahalandı/ucuzladı" yargısı birim fiyat farkına dayanır; birim
      // fiyat aynıysa (veya kayıtsızsa) satır farkı yönü bildirmez
      // (spec §6.11: miktar artışı pahalandı demek değildir).
      final priceChanged =
          plannedUnit != null && actualUnit != null && actualUnit.compareTo(plannedUnit) != 0;
      final directionGroup = priceChanged
          ? _direction(variance, percent, list.currencyCode)
          : ItemResultGroup.close;
      final groups = <ItemResultGroup>{
        if (comparable) directionGroup,
        if (quantityChanged) ItemResultGroup.quantityChanged,
        if (!actualKnown) ItemResultGroup.unverified,
      };
      final verified = itemEntries.every((e) => e.userConfirmed);
      if (!verified) groups.add(ItemResultGroup.unverified);

      rows.add(ItemResultRow(
        name: item.name,
        plannedQuantity: plannedQty,
        actualQuantity: actualQty,
        plannedUnitPrice: plannedUnit,
        actualUnitPrice: actualUnit,
        plannedLineTotalMinor: plannedLine,
        actualLineTotalMinor: actualLine,
        lineVarianceMinor: variance,
        variancePercent: percent,
        discountMinor: discount,
        groups: groups,
        notTaken: false,
        isUnplanned: false,
        userConfirmed: verified,
        actualKnown: actualKnown,
        plannedKnown: item.plannedLineTotalMinorUnits != null,
      ));
    }

    // Plansız alımlar: plannedItemId null.
    var unplannedTotal = 0;
    for (final e in entries.where((e) => e.plannedItemId == null)) {
      unplannedTotal += e.actualLineTotalMinorUnits;
      rows.add(ItemResultRow(
        name: e.name,
        plannedQuantity: null,
        actualQuantity: DecimalFixed.parse(e.actualQuantity),
        plannedUnitPrice: null,
        actualUnitPrice: _parseD(e.actualUnitPrice),
        plannedLineTotalMinor: 0,
        actualLineTotalMinor: e.actualLineTotalMinorUnits,
        lineVarianceMinor: e.actualLineTotalMinorUnits,
        variancePercent: null,
        discountMinor: e.discountMinorUnits,
        groups: {ItemResultGroup.unplanned},
        notTaken: false,
        isUnplanned: true,
        userConfirmed: e.userConfirmed,
        actualKnown: e.grossTotalMinorUnits != null || e.actualLineTotalMinorUnits != 0 || e.source == 'receiptOcr',
        plannedKnown: false,
      ));
    }

    final actualTotal =
        entries.fold<int>(0, (s, e) => s + e.actualLineTotalMinorUnits);
    final totalDiscount =
        entries.fold<int>(0, (s, e) => s + e.discountMinorUnits);

    return ListResult(
      currencyCode: list.currencyCode,
      plannedTotalMinor: plannedTotal,
      actualTotalMinor: actualTotal,
      unplannedTotalMinor: unplannedTotal,
      unpurchasedPlannedMinor: unpurchasedPlanned,
      totalDiscountMinor: totalDiscount,
      variancePercent: _percent(
          comparedActual - comparedPlanned, comparedPlanned, digits),
      accuracy: _accuracy(comparedPlanned, comparedActual, list.currencyCode),
      comparedPlannedMinor: comparedPlanned,
      comparedActualMinor: comparedActual,
      rows: rows,
      budgetMinor: list.budgetMinorUnits,
    );
  }

  ItemResultGroup _direction(int varianceMinor, DecimalFixed? percent,
      String currencyCode) {
    final money =
        Money.fromMinorUnits(varianceMinor, Currency.fromCode(currencyCode));
    return switch (threshold.classify(percent ?? DecimalFixed.zero(), money)) {
      VarianceDirection.pricier => ItemResultGroup.pricier,
      VarianceDirection.cheaper => ItemResultGroup.cheaper,
      VarianceDirection.close => ItemResultGroup.close,
    };
  }

  DecimalFixed? _percent(int variance, int planned, int digits) {
    final v = DecimalFixed.fromMinorUnits(variance, digits);
    final p = DecimalFixed.fromMinorUnits(planned, digits);
    return LineCalc.lineVariancePercent(v, p);
  }

  DecimalFixed? _accuracy(int planned, int actual, String currencyCode) {
    final c = Currency.fromCode(currencyCode);
    return ListCalc.estimateAccuracy(
        Money.fromMinorUnits(planned, c), Money.fromMinorUnits(actual, c));
  }

  DecimalFixed? _parseD(String? value) =>
      value == null ? null : DecimalFixed.tryParse(value);

}
