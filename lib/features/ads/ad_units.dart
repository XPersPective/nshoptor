import 'package:flutter/foundation.dart';

/// Each mobile platform must use its own configured release unit. Missing,
/// malformed and Google's test units stay disabled in a production build.
bool adUnitEnabled({
  required TargetPlatform platform,
  required bool releaseMode,
  required String androidUnit,
  required String iosUnit,
}) {
  if (platform != TargetPlatform.android && platform != TargetPlatform.iOS) {
    return false;
  }
  if (!releaseMode) return true;
  final unit = platform == TargetPlatform.iOS ? iosUnit : androidUnit;
  return RegExp(r'^ca-app-pub-\d{16}/\d{10}$').hasMatch(unit) &&
      !unit.startsWith('ca-app-pub-3940256099942544/');
}
