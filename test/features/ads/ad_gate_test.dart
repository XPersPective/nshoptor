import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ads/ad_gate.dart';

void main() {
  test('ilk 7 gün reklamsız, 8. gün reklam; ilk açılış bir kez kaydedilir', () {
    final store = SettingsStore();
    final day0 = DateTime(2026, 10, 1, 9);
    expect(AdGate.inGrace(store, day0), isTrue);
    expect(AdGate.inGrace(store, day0.add(const Duration(days: 6, hours: 23))), isTrue);
    expect(AdGate.inGrace(store, day0.add(const Duration(days: 7, minutes: 1))), isFalse);
    expect(AdGate.firstOpen(store, DateTime(2030)), day0);
  });
}
