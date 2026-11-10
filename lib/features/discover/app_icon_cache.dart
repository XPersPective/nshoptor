import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Disk cache for "Other apps" icons (PB-209). The feed refreshes once a day
/// and so do the icons: a fresh file (< 24 h) never touches the network, an
/// expired one re-downloads once, and a failed refresh keeps the last good
/// file so the list stays usable offline.
class AppIconCache {
  AppIconCache({
    this.client,
    Future<Directory> Function()? baseDirectory,
    DateTime Function()? now,
  }) : baseDirectory = baseDirectory ?? getApplicationSupportDirectory,
       now = now ?? DateTime.now;

  static const ttl = Duration(hours: 24);
  static const maxBytes = 512 * 1024;

  final http.Client? client;
  final Future<Directory> Function() baseDirectory;
  final DateTime Function() now;
  http.Client? _owned;

  Future<File?> fetch(String url) async {
    if (!url.startsWith('https://')) return null;
    final dir = Directory(
      '${(await baseDirectory()).path}${Platform.pathSeparator}discover_icons',
    );
    final name = _cacheKey(url);
    final file = File('${dir.path}${Platform.pathSeparator}$name.img');
    final stamp = File('${dir.path}${Platform.pathSeparator}$name.at');
    await dir.create(recursive: true);
    if (await file.exists()) {
      final savedAt = _readStamp(stamp);
      if (savedAt != null && now().difference(savedAt) < ttl) return file;
    }
    try {
      final effective = client ?? (_owned ??= http.Client());
      final response = await effective
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      final bytes = response.bodyBytes;
      if (response.statusCode != 200 ||
          bytes.isEmpty ||
          bytes.length > maxBytes ||
          !_looksLikeImage(bytes)) {
        throw const HttpException('invalid icon');
      }
      await file.writeAsBytes(bytes, flush: true);
      await stamp.writeAsString(
        '${now().millisecondsSinceEpoch}',
        flush: true,
      );
      return file;
    } catch (_) {
      // Offline or rejected: the last good icon stays usable indefinitely.
      return await file.exists() ? file : null;
    }
  }

  void dispose() => _owned?.close();

  static DateTime? _readStamp(File stamp) {
    try {
      final raw = int.parse(stamp.readAsStringSync());
      final at = DateTime.fromMillisecondsSinceEpoch(raw);
      return at.isBefore(DateTime(2000)) || at.isAfter(DateTime(2200))
          ? null
          : at;
    } catch (_) {
      return null;
    }
  }

  /// Stable, filesystem-safe cache key (djb2 over the URL).
  static String _cacheKey(String url) {
    var hash = 5381;
    for (final byte in url.codeUnits) {
      hash = ((hash << 5) + hash + byte) & 0x7FFFFFFF;
    }
    return hash.toRadixString(16);
  }

  static bool _looksLikeImage(Uint8List bytes) =>
      bytes.length > 4 &&
      (bytes[0] == 0x89 && bytes[1] == 0x50 || // PNG
          bytes[0] == 0xFF && bytes[1] == 0xD8 || // JPEG
          bytes[0] == 0x47 && bytes[1] == 0x49); // GIF
}

/// Icon tile for the Discover list: cached file first, network only when the
/// cache misses, plain icon as the final fallback.
class DiscoverAppIcon extends StatefulWidget {
  const DiscoverAppIcon({super.key, required this.url, this.cache});

  final String? url;
  final AppIconCache? cache;

  @override
  State<DiscoverAppIcon> createState() => _DiscoverAppIconState();
}

class _DiscoverAppIconState extends State<DiscoverAppIcon> {
  static final AppIconCache _defaultCache = AppIconCache();
  File? _file;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final url = widget.url;
    if (url == null) {
      _done = true;
      return;
    }
    final file = await (widget.cache ?? _defaultCache).fetch(url);
    if (!mounted) return;
    setState(() {
      _done = true;
      _file = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == null || _done && _file == null) {
      return const Icon(Icons.apps_outlined);
    }
    final file = _file;
    if (file == null) {
      // Placeholder while the disk/network lookup resolves: no direct
      // network rendering bypassing the cache.
      return const SizedBox.shrink();
    }
    return Image.file(
      file,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const Icon(Icons.apps_outlined),
    );
  }
}
