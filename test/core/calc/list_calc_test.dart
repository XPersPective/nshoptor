import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/calc/list_calc.dart';
import 'package:nshoptor/core/calc/variance.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/money.dart';

void main() {
  final tl = Currency.fromCode('TRY');
  Money m(int minor) => Money.fromMinorUnits(minor, tl);
  final d = DecimalFixed.parse;

  group('liste toplamları', () {
    test('plannedTotal ve actualTotal aynı para biriminde toplar', () {
      expect(ListCalc.plannedTotal([m(1000), m(2500)], tl), m(3500));
      expect(ListCalc.actualTotal([m(900), m(2600)], tl), m(3500));
    });

    test('farklı para birimi toplamaz', () {
      final usd = Money.fromMinorUnits(100, Currency.fromCode('USD'));
      expect(
          () => ListCalc.plannedTotal([m(100), usd], tl), throwsArgumentError);
    });

    test('totalVariance = actual − planned', () {
      expect(ListCalc.totalVariance(m(3600), m(3500)), m(100));
      expect(ListCalc.totalVariance(m(3400), m(3500)), m(-100));
    });

    test('plansız ve alınmayan toplamları ayrıdır', () {
      expect(ListCalc.unplannedTotal([m(500), m(300)], tl), m(800));
      expect(ListCalc.unpurchasedPlannedTotal([m(1000), m(2500)], tl), m(3500));
    });

    test('boş liste sıfır döner', () {
      expect(ListCalc.plannedTotal(const [], tl), m(0));
    });
  });

  group('projeksiyon ve bütçe', () {
    test('projectedCheckoutTotal = sepet + kalan plan', () {
      expect(ListCalc.projectedCheckoutTotal(m(10000), m(5000)), m(15000));
    });

    test('budgetRemaining: bütçe yoksa null', () {
      expect(ListCalc.budgetRemaining(null, m(15000)), isNull);
    });

    test('budgetRemaining: kalan ve aşım', () {
      expect(ListCalc.budgetRemaining(m(20000), m(15000)), m(5000));
      expect(ListCalc.budgetRemaining(m(12000), m(15000)), m(-3000));
    });
  });

  group('eşikler', () {
    final t = VarianceThreshold();

    test('varsayılan eşik: %10 veya 2,00', () {
      // %8 fark → yakın.
      expect(t.isClose(d('8'), m(800)), isTrue);
      // %15 fark + 30 kuruş → yakın (mutlak eşik 200 minor altı).
      expect(t.isClose(d('15'), m(30)), isTrue);
      // %15 fark + 300 kuruş → yakın değil.
      expect(t.isClose(d('15'), m(300)), isFalse);
      // %5 fark ama 500 kuruş → yüzde eşiği yakalar.
      expect(t.isClose(d('5'), m(500)), isTrue);
    });

    test('classify: pahalı/ucuz/yakın', () {
      expect(t.classify(d('20'), m(250)), VarianceDirection.pricier);
      expect(t.classify(d('-20'), m(-250)), VarianceDirection.cheaper);
      expect(t.classify(d('2'), m(20)), VarianceDirection.close);
      expect(t.classify(DecimalFixed.zero(), m(0)), VarianceDirection.close);
      // Mutlak eşik sınırı: tam 200 minor hâlâ yakındır.
      expect(t.classify(d('20'), m(200)), VarianceDirection.close);
    });

    test('uzlaştırma toleransı ±2 minor', () {
      expect(ReconciliationTolerance.withinTolerance(m(2)), isTrue);
      expect(ReconciliationTolerance.withinTolerance(m(-2)), isTrue);
      expect(ReconciliationTolerance.withinTolerance(m(3)), isFalse);
    });
  });
}
