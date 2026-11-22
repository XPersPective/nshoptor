import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/ads/ios_tracking_permission.dart';

void main() {
  test('a foreground request is shared with advertising startup', () async {
    final response = Completer<TrackingStatus>();
    var requests = 0;
    final permission = IosTrackingPermission(
      isActive: () => true,
      readStatus: () async => TrackingStatus.notDetermined,
      request: () {
        requests++;
        return response.future;
      },
    );

    final foreground = permission.resolve();
    final advertising = permission.resolve();
    expect(advertising, same(foreground));
    response.complete(TrackingStatus.denied);
    expect(await advertising, isTrue);
    expect(requests, 1);
  });

  test('an unresolved request retries only once active again', () async {
    var active = false;
    var requests = 0;
    final permission = IosTrackingPermission(
      isActive: () => active,
      readStatus: () async => TrackingStatus.notDetermined,
      request: () async {
        requests++;
        return requests == 1
            ? TrackingStatus.notDetermined
            : TrackingStatus.authorized;
      },
    );

    expect(await permission.resolve(), isFalse);
    expect(requests, 0);
    active = true;
    expect(await permission.resolve(), isFalse);
    expect(await permission.resolve(), isTrue);
    expect(requests, 2);
  });

  test('a restricted device does not request permission', () async {
    final permission = IosTrackingPermission(
      isActive: () => true,
      readStatus: () async => TrackingStatus.restricted,
      request: () async => fail('A resolved state cannot show the prompt'),
    );

    expect(await permission.resolve(), isTrue);
  });
}
