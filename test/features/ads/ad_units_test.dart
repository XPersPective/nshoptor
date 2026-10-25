import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/ads/ad_units.dart';

void main() {
  // Synthetic non-Google identifiers; no real publisher IDs in test source.
  const android = 'ca-app-pub-1111111111111111/1111111111';
  const ios = 'ca-app-pub-2222222222222222/2222222222';
  bool enabled(
    TargetPlatform platform,
    String a,
    String i, {
    bool release = true,
  }) => adUnitEnabled(
    platform: platform,
    releaseMode: release,
    androidUnit: a,
    iosUnit: i,
  );
  test('iOS release uses iOS units independently of Android', () {
    expect(enabled(TargetPlatform.iOS, '', ios), isTrue);
    expect(enabled(TargetPlatform.iOS, android, ''), isFalse);
    expect(enabled(TargetPlatform.android, android, ''), isTrue);
    expect(enabled(TargetPlatform.android, '', ios), isFalse);
  });
  test('release refuses empty, malformed and Google test units', () {
    for (final unit in ['', 'test', 'ca-app-pub-3940256099942544/4411468910']) {
      expect(enabled(TargetPlatform.iOS, android, unit), isFalse);
    }
  });
  test('debug uses SDK test defaults on mobile only', () {
    expect(enabled(TargetPlatform.iOS, '', '', release: false), isTrue);
    expect(enabled(TargetPlatform.android, '', '', release: false), isTrue);
    expect(
      enabled(TargetPlatform.linux, android, ios, release: false),
      isFalse,
    );
  });
}
