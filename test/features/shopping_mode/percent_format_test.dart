import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/features/shopping_mode/summary/summary_screen.dart';

void main() {
  test('yüzde bir ondalığa yuvarlanır, dile göre yazılır', () {
    final neg = DecimalFixed.parse('-84.886528');
    final pos = DecimalFixed.parse('15.113500');
    final whole = DecimalFixed.parse('4.000000');
    expect(formatPercentText(neg, 'en'), '-84.9%');
    expect(formatPercentText(neg, 'tr'), '-%84,9');
    expect(formatPercentText(pos, 'en'), '15.1%');
    expect(formatPercentText(whole, 'tr'), '%4');
  });
}
