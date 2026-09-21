import 'package:drift/drift.dart';

import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
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

class PriceHistoryRepository {
  PriceHistoryRepository(this._db);

  final AppDatabase _db;

  /// Ürünün tüm gözlemleri, en yeniden eskiye.
  Future<List<PriceObservation>> history(int productId) =>
      (_db.select(_db.priceObservations)
            ..where((t) => t.productId.equals(productId))
            ..orderBy([(t) => OrderingTerm.desc(t.observedAt)]))
          .get();

  /// Ürünün gözlemlerinin para birimlerini (tek para birimi beklenir).
  Future<Set<String>> currenciesOf(int productId) async {
    final rows = await (_db.select(_db.priceObservations)
          ..where((t) => t.productId.equals(productId)))
        .get();
    return rows.map((r) => r.currencyCode).toSet();
  }

  /// Son [n] gözlemin min/medyan/max/ortalama birim fiyatı (minor unit,
  /// fiyat dizgesinden minor'a çevrilerek). Para birimi karışıksa en çok
  /// görülen para birimi esas alınır ve yalnız o gözlemler hesaplanır.
  Future<PriceStats?> stats(int productId, {int n = 5}) async {
    final rows = await history(productId);
    if (rows.isEmpty) return null;

    // Para birimi karışımında en baskın olanı seç (diğerleri hesaba girmez).
    final dominant = _dominantCurrency(rows);
    final group = rows.where((r) => r.currencyCode == dominant).take(n).toList();
    if (group.isEmpty) return null;

    final prices = group
        .map((r) => _unitPriceToMinor(r))
        .where((v) => v != null)
        .cast<int>()
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
    final rows = await history(productId);
    final eligible = rows.where((r) => r.storeId != null).toList();
    if (eligible.isEmpty) return null;
    PriceObservation? best;
    for (final r in eligible) {
      if (best == null || _unitPriceToMinor(r)! < _unitPriceToMinor(best)!) {
        best = r;
      }
    }
    return best!.storeId;
  }

  /// Basit eğilim: son iki gözlemin birim fiyat karşılaştırması (aynı para
  /// biriminde). Yetersiz veri null döner — yanıltıcı trend üretilmez.
  Future<PriceTrend?> trend(int productId) async {
    final rows = await history(productId);
    if (rows.length < 2) return null;
    if (rows[0].currencyCode != rows[1].currencyCode) return null;
    final a = _unitPriceToMinor(rows[0])!;
    final b = _unitPriceToMinor(rows[1])!;
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

  /// Gözlemin birim fiyatını minor unit'e çevirir; ayrıştırılamıyorsa null.
  int? _unitPriceToMinor(PriceObservation r) {
    final value = DecimalFixed.tryParse(r.unitPrice);
    if (value == null) return null;
    final digits = _digitsOf(r.currencyCode);
    return value.toMinorUnits(digits);
  }

  static int _digitsOf(String code) =>
      Currency.fromCode(code).minorUnitDigits;
}

enum PriceTrend { rising, falling, stable }
