import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/app_version.dart';

void main() {
  test('visible app version matches the actual package release version', () {
    final version = RegExp(r'^version: ([^+\s]+)', multiLine: true)
        .firstMatch(File('pubspec.yaml').readAsStringSync())!.group(1);
    expect(appVersion, version);
  });
}
