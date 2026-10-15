import 'package:drift/drift.dart';

import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';
import '../../../core/quantity/unit_conversion.dart';
import '../../../data/db/app_database.dart';

/// Fiyat geçmişi istatistikleri (spec §6.10).
///
/// KURAL: istatistikler YALNIZ aynı para birimindeki gözlemler üzerinden
/// hesaplanır; farklı para birimi tek başına listede gösterilir ama
/// min/medyan/max/ortalama hesabına katılmaz. Birim fiyat dönüştürülemeyen
/// ambalaj/ölçü karşılaştırması yapılmaz — gözlem olduğu gibi listelenir.
class PriceStats {
  const PriceStats({
    required this.currencyCode,
    required this.minMinor,
    required this.medianMinor,
    required this.maxMinor,
    required this.averageMinor,
    required this.sampleCount,
  });

  final String currencyCode;
  final int minMinor;
  final int medianMinor;
  final int maxMinor;
  final int averageMinor;
  final int sampleCount;
}

class NormalizedPricePoint {
  const NormalizedPricePoint({
    required this.observation,
    required this.unitPrice,
    required this.unitCode,
  });

  final PriceObservation observation;
  final DecimalFixed unitPrice;
  final String unitCode;
}

class PriceHistoryRepository {
  PriceHistoryRepository(this._db);

  final AppDatabase _db;

  /// Ürünün tüm gözlemleri, en yeniden eskiye.
  Future<List<PriceObservation>> history(int productId) =>
      (_db.select(_db.priceObservations)
            ..where((t) => t.productId.equals(productId))
            ..orderBy([
              (t) => OrderingTerm.desc(t.observedAt),
              (t) => OrderingTerm.desc(t.id),
            ]))
          .get();

  /// Gerçek satın alım gözlemlerini ortak temel birimde, eskiden yeniye
  /// döndürür. Ambalaj içeriği bilinmeyen birimler karşılaştırılmaz.
  Future<List<NormalizedPricePoint>> normalizedHistory(
    int productId, {
    String? currencyCode,
    String? unitCode,
  }) async {
    final rows = await history(productId);
    final points = <NormalizedPricePoint>[];
    for (final row in rows) {
      if (currencyCode != null && row.currencyCode != currencyCode) continue;
      final point = _normalize(row);
      if (point == null || unitCode != null && point.unitCode != unitCode) {
        continue;
      }
      points.add(point);
    }
    return points.reversed.toList();
  }

  /// Ürünün gözlemlerinin para birimlerini (tek para birimi beklenir).
  Future<Set<String>> currenciesOf(int productId) async {
    final rows = await (_db.select(
      _db.priceObservations,
    )..where((t) => t.productId.equals(productId))).get();
    return rows.map((r) => r.currencyCode).toSet();
  }

  /// Son [n] gözlemin min/medyan/max/ortalama birim fiyatı (minor unit,
  /// fiyat dizgesinden minor'a çevrilerek). Para birimi karışıksa en çok
  /// görülen para birimi esas alınır ve yalnız o gözlemler hesaplanır.
  Future<PriceStats?> stats(int productId, {int n = 5}) async {
    final rows = await normalizedHistory(productId);
    if (rows.isEmpty) return null;
    final newest = rows.reversed;

    // Para birimi karışımında en baskın olanı seç (diğerleri hesaba girmez).
    final dominant = _dominantCurrency(
      rows.map((point) => point.observation).toList(),
    );
    final dominantUnit = _dominantUnit(
      rows
          .where((point) => point.observation.currencyCode == dominant)
          .toList(),
    );
    final group = newest
        .where(
          (point) =>
              point.observation.currencyCode == dominant &&
              point.unitCode == dominantUnit,
        )
        .take(n)
        .toList();
    if (group.isEmpty) return null;

    final prices =
        group
            .map(
              (point) => point.unitPrice.toMinorUnits(
                _digitsOf(point.observation.currencyCode),
              ),
            )
            .toList()
          ..sort();
    if (prices.isEmpty) return null;

    final median = prices.length.isOdd
        ? prices[prices.length ~/ 2]
        : (prices[prices.length ~/ 2 - 1] + prices[prices.length ~/ 2]) ~/ 2;

    return PriceStats(
      currencyCode: dominant,
      minMinor: prices.first,
      medianMinor: median,
      maxMinor: prices.last,
      averageMinor: prices.fold<int>(0, (s, v) => s + v) ~/ prices.length,
      sampleCount: prices.length,
    );
  }

  /// Görülen en ucuz mağaza: en düşük birim fiyatlı gözlemin mağazası
  /// (aynı para birimi içinde).
  Future<int?> cheapestStore(int productId, {int? withinStore}) async {
    final rows = await normalizedHistory(productId);
    if (rows.isEmpty) return null;
    final currency = _dominantCurrency(
      rows.map((point) => point.observation).toList(),
    );
    final dominantUnit = _dominantUnit(
      rows
          .where((point) => point.observation.currencyCode == currency)
          .toList(),
    );
    final eligible = rows
        .where(
          (point) =>
              point.observation.currencyCode == currency &&
              point.unitCode == dominantUnit &&
              point.observation.storeId != null &&
              (withinStore == null || point.observation.storeId == withinStore),
        )
        .toList();
    if (eligible.isEmpty) return null;
    NormalizedPricePoint? best;
    for (final point in eligible) {
      if (best == null || point.unitPrice.compareTo(best.unitPrice) < 0) {
        best = point;
      }
    }
    return best!.observation.storeId;
  }

  /// Basit eğilim: son iki gözlemin birim fiyat karşılaştırması (aynı para
  /// biriminde). Yetersiz veri null döner — yanıltıcı trend üretilmez.
  Future<PriceTrend?> trend(int productId) async {
    final rows = await normalizedHistory(productId);
    if (rows.length < 2) return null;
    final newest = rows.reversed.toList();
    if (newest[0].observation.currencyCode !=
            newest[1].observation.currencyCode ||
        newest[0].unitCode != newest[1].unitCode) {
      return null;
    }
    final a = newest[0].unitPrice.toMinorUnits(
      _digitsOf(newest[0].observation.currencyCode),
    );
    final b = newest[1].unitPrice.toMinorUnits(
      _digitsOf(newest[1].observation.currencyCode),
    );
    if (a == b) return PriceTrend.stable;
    return a > b ? PriceTrend.rising : PriceTrend.falling;
  }

  /// Fiyat eskiliği: son gözlem bu kadar günden eskiyse kullanıcıya
  /// "fiyat eski olabilir" göstergesi çıkar (spec §6.10).
  static const int stalenessDays = 30;

  bool isStale(PriceObservation? latest, {DateTime? now}) {
    if (latest == null) return true;
    final reference = now ?? DateTime.now();
    return reference.difference(latest.observedAt).inDays > stalenessDays;
  }

  String _dominantCurrency(List<PriceObservation> rows) {
    final counts = <String, int>{};
    for (final r in rows) {
      counts[r.currencyCode] = (counts[r.currencyCode] ?? 0) + 1;
    }
    String best = rows.first.currencyCode;
    for (final e in counts.entries) {
      if (e.value > counts[best]!) best = e.key;
    }
    return best;
  }

  String _dominantUnit(List<NormalizedPricePoint> rows) {
    final counts = <String, int>{};
    for (final point in rows) {
      counts[point.unitCode] = (counts[point.unitCode] ?? 0) + 1;
    }
    var best = rows.first.unitCode;
    for (final entry in counts.entries) {
      if (entry.value > counts[best]!) best = entry.key;
    }
    return best;
  }

  static int _digitsOf(String code) => Currency.fromCode(code).minorUnitDigits;

  NormalizedPricePoint? _normalize(PriceObservation row) {
    final sourceUnit = UnitCode.values
        .where(
          (unit) => unit.dbCode == row.unitCode || unit.name == row.unitCode,
        )
        .firstOrNull;
    final quantity = DecimalFixed.tryParse(row.quantity);
    if (sourceUnit == null || quantity == null || !quantity.isPositive) {
      return null;
    }
    final baseQuantity =
        DecimalFixed.tryParse(row.normalizedBaseQuantity ?? '') ??
        UnitConversion.tryConvertToBase(quantity, sourceUnit, allowCount: true);
    if (baseQuantity == null || !baseQuantity.isPositive) return null;
    final baseUnit = switch (sourceUnit.dimension) {
      UnitDimension.mass => UnitCode.kilogram,
      UnitDimension.volume => UnitCode.litre,
      UnitDimension.count => UnitCode.adet,
      UnitDimension.length => UnitCode.metre,
      UnitDimension.unknown => null,
    };
    if (baseUnit == null) return null;

    final sourcePrice = DecimalFixed.tryParse(row.unitPrice);
    if (sourcePrice == null) return null;
    final basePrice =
        row.normalizedBaseQuantity != null || row.lineTotalMinorUnits != 0
        ? DecimalFixed.fromMinorUnits(
            row.lineTotalMinorUnits,
            _digitsOf(row.currencyCode),
          ).divide(baseQuantity, scale: DecimalFixed.maxFractionDigits)
        : switch (sourceUnit) {
            UnitCode.gram ||
            UnitCode.mililitre => sourcePrice * DecimalFixed.fromInt(1000),
            UnitCode.duzine => sourcePrice.divide(
              DecimalFixed.fromInt(12),
              scale: DecimalFixed.maxFractionDigits,
            ),
            _ => sourcePrice,
          };
    return NormalizedPricePoint(
      observation: row,
      unitPrice: basePrice,
      unitCode: baseUnit.dbCode,
    );
  }
}

enum PriceTrend { rising, falling, stable }
