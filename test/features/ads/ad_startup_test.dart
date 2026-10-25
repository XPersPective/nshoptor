import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/ads/ad_startup.dart';

void main() {
  test(
    'ad-free trial or subscription never starts consent or ad SDK',
    () async {
      var initializes = 0, loads = 0;
      final startup = AdStartup(
        isAdFree: () => true,
        initialize: () async {
          initializes++;
          return true;
        },
        onReady: () {},
        load: () {
          loads++;
        },
      );
      await startup.ensureReady();
      await startup.ensureReady();
      expect(initializes, 0);
      expect(loads, 0);
    },
  );
  test('concurrent free requests share consent and load once', () async {
    final consent = Completer<bool>();
    var initializes = 0, loads = 0, ready = 0;
    final startup = AdStartup(
      isAdFree: () => false,
      initialize: () {
        initializes++;
        return consent.future;
      },
      onReady: () {
        ready++;
      },
      load: () {
        loads++;
      },
    );
    final first = startup.ensureReady();
    final second = startup.ensureReady();
    consent.complete(true);
    await Future.wait([first, second]);
    expect(initializes, 1);
    expect(ready, 1);
    expect(loads, 1);
  });
  test(
    'subscription activated during consent suppresses advertising',
    () async {
      final consent = Completer<bool>();
      var free = false, loads = 0;
      final startup = AdStartup(
        isAdFree: () => free,
        initialize: () => consent.future,
        onReady: () {},
        load: () {
          loads++;
        },
      );
      final pending = startup.ensureReady();
      free = true;
      consent.complete(true);
      await pending;
      expect(loads, 0);
    },
  );
  test(
    'consent failure stays ad-free and a later attempt may recover',
    () async {
      var attempts = 0, loads = 0;
      final startup = AdStartup(
        isAdFree: () => false,
        initialize: () async {
          attempts++;
          return attempts > 1;
        },
        onReady: () {},
        load: () {
          loads++;
        },
      );
      await startup.ensureReady();
      expect(loads, 0);
      await startup.ensureReady();
      expect(loads, 1);
    },
  );
  test('SDK exceptions do not escape into the shopping startup', () async {
    final startup = AdStartup(
      isAdFree: () => false,
      initialize: () async => throw StateError('synthetic SDK failure'),
      onReady: () {},
      load: () => fail('must remain ad-free'),
    );
    await startup.ensureReady();
  });
}
