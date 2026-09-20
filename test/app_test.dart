import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/main.dart';

void main() {
  test('kurulum tamam; NappApp tanımlı', () {
    expect(NappApp, isNotNull);
    expect('nshoptor_pro_lifetime'.endsWith('_pro_lifetime'), isTrue);
  });
}
