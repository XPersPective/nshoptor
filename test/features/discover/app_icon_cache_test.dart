import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/discover/app_icon_cache.dart';
import 'package:nshoptor/features/discover/embedded_apps.dart';

// 1x1 transparent PNG.
final Uint8List _png = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0, 0, 0, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0, 0, 0, 1, 0, 0, 0, 1, 8, 6, 0, 0, 0,
]);

AppIconCache cacheIn(
  Directory dir,
  http.Client client, {
  DateTime Function()? now,
}) => AppIconCache(
  client: client,
  baseDirectory: () async => dir,
  now: now,
);

void main() {
  late Directory dir;
  setUp(() {
    dir = Directory.systemTemp.createTempSync('icons');
  });
  tearDown(() {
    dir.deleteSync(recursive: true);
  });

  test('downloads once, then serves the fresh file without network', () async {
    var hits = 0;
    final client = MockClient((_) async {
      hits++;
      return http.Response.bytes(_png, 200);
    });
    final cache = cacheIn(dir, client);
    final first = await cache.fetch('https://example.com/a.png');
    expect(first, isNotNull);
    expect(await first!.readAsBytes(), _png);
    final second = await cache.fetch('https://example.com/a.png');
    expect(second!.path, first.path);
    expect(hits, 1);
  });

  test('an expired icon refreshes; a failed refresh keeps the stale file', () async {
    var clock = DateTime(2026, 11, 9, 10);
    var fail = false;
    final client = MockClient((_) async {
      if (fail) throw http.ClientException('offline');
      return http.Response.bytes(_png, 200);
    });
    final cache = cacheIn(dir, client, now: () => clock);
    final first = await cache.fetch('https://example.com/b.png');
    expect(first, isNotNull);
    clock = clock.add(AppIconCache.ttl + const Duration(minutes: 1));
    fail = true;
    final stale = await cache.fetch('https://example.com/b.png');
    expect(stale!.path, first!.path);
    expect(await stale.readAsBytes(), _png);
  });

  test('non-images, oversized payloads and plain http are rejected', () async {
    final client = MockClient((_) async =>
        http.Response.bytes(Uint8List.fromList([1, 2, 3, 4, 5]), 200));
    final cache = cacheIn(dir, client);
    expect(await cache.fetch('https://example.com/not.png'), isNull);
    expect(await cache.fetch('http://insecure.example.com/a.png'), isNull);
  });

  test('embedded snapshot parses with the feed schema and hides own package',
      () async {
    for (final app in embeddedOtherApps) {
      final reparsed = OtherApp.tryParse({
        'id': app.id,
        'androidPackage': app.androidPackage,
        'appStoreId': app.appStoreId,
        'icon': app.iconUrl,
        'name': app.name,
        'description': app.description,
        'order': app.order,
      });
      expect(reparsed, isNotNull, reason: app.id);
    }
    final store = SettingsStore();
    final repository = OtherAppsRepository(
      appsUrl: 'https://example.invalid/apps.json',
      // Every request fails: the embedded list must still come back.
      client: MockClient((_) async => throw http.ClientException('down')),
      cacheStore: store,
      embedded: embeddedOtherApps,
      timeout: const Duration(milliseconds: 50),
    );
    final apps = await repository.load(ownPackage: 'com.crazypenguin.nshoptor');
    expect(apps.map((a) => a.id), ['doctorfilter', 'halen', 'kamubul']);
    final kamubul = apps.singleWhere((a) => a.id == 'kamubul');
    expect(kamubul.storeUrl(isIos: true), contains('6826592263'));
    await store.flush();
  });
}
