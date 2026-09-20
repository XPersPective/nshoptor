import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/calc/line_calc.dart';
import 'package:nshoptor/core/calc/list_calc.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/money.dart';

void main() {
  final tl = Currency.fromCode('TRY');
  final d = DecimalFixed.parse;

  group('satır formülleri', () {
    test('plannedLineTotal: 1,5 × 42,90 = 64,35', () {
      expect(LineCalc.plannedLineTotal(d('1.5'), d('42.90')), d('64.35'));
    });

    test('actualLineTotal: indirim düşülür', () {
      final gross = LineCalc.actualGrossTotal(d('2'), d('42.90'));
      expect(gross, d('85.80'));
      expect(LineCalc.actualLineTotal(gross, d('5.80')), d('80.00'));
    });

    test('lineVariance', () {
      expect(
        LineCalc.lineVariance(d('80.00'), d('64.35')),
        d('15.65'),
      );
    });

    test('lineVariancePercent: plan sıfırken null', () {
      expect(LineCalc.lineVariancePercent(d('10'), DecimalFixed.zero()), isNull);
      expect(
        LineCalc.lineVariancePercent(d('15.65'), d('64.35'))!.toDbString(),
        '24.320124',
      );
    });
  });

  group('etki ayrıştırması', () {
    test('fiyat ve miktar etkisi ayrıdır ve toplanır', () {
      // Plan: 2 kg × 50 = 100; gerçek: 3 kg × 45 = 135; fark: +35.
      final split = EffectSplit.compute(
        plannedQuantity: d('2'),
        plannedUnitPrice: d('50'),
        actualQuantity: d('3'),
        actualUnitPrice: d('45'),
        sameUnit: true,
      );
      expect(split.priceEffect, d('-15')); // 3 × (45−50)
      expect(split.quantityEffect, d('50')); // (3−2) × 50
      expect(split.priceEffect! + split.quantityEffect!, d('35'));
      // Not: 135 − 100 = 35 = fiyat etkisi + miktar etkisi (indirim 0).
    });

    test('ortak birim yoksa etkiler hesaplanamaz', () {
      final split = EffectSplit.compute(
        plannedQuantity: d('2'),
        plannedUnitPrice: d('50'),
        actualQuantity: d('1'),
        actualUnitPrice: d('45'),
        sameUnit: false,
      );
      expect(split.computable, isFalse);
      expect(split.priceEffect, isNull);
      expect(split.quantityEffect, isNull);
    });

    test('miktar değişse bile birim fiyat aynıysa pahalandı denmez', () {
      // Plan: 2 kg × 50; gerçek: 3 kg × 50. Fark tamamen miktar etkisi.
      final split = EffectSplit.compute(
        plannedQuantity: d('2'),
        plannedUnitPrice: d('50'),
        actualQuantity: d('3'),
        actualUnitPrice: d('50'),
        sameUnit: true,
      );
      expect(split.priceEffect, DecimalFixed.zero());
      expect(split.quantityEffect, d('50'));
    });
  });

  group('tahmin doğruluk oranı', () {
    test('plan 100, gerçek 90 → %90', () {
      final accuracy =
          ListCalc.estimateAccuracy(Money.fromMinorUnits(10000, tl),
              Money.fromMinorUnits(9000, tl));
      expect(accuracy!.toDbString(), '90.000000');
    });

    test('plan 0 iken null', () {
      expect(
        ListCalc.estimateAccuracy(
            Money.zero(tl), Money.fromMinorUnits(100, tl)),
        isNull,
      );
    });

    test('fazla harcama doğruluğu düşürür', () {
      final accuracy = ListCalc.estimateAccuracy(
          Money.fromMinorUnits(10000, tl),
          Money.fromMinorUnits(12500, tl));
      expect(accuracy!.toDbString(), '75.000000');
    });
  });
}
