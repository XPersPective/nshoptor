import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

/// Copies picker cache files into app-owned storage before saving a draft.
class ReceiptImageStore {
  ReceiptImageStore({this.directoryOverride});
  final Directory? directoryOverride;

  static Future<Directory> directory() async => Directory(
    '${(await getApplicationDocumentsDirectory()).path}/receipt_media',
  );

  Future<String?> keep(String sourcePath) async {
    final source = File(sourcePath);
    // Injected synthetic OCR has no backing file. Its text evidence still
    // persists; native captures always provide an existing picker file.
    if (!await source.exists()) return null;
    if (await source.length() > 30 * 1024 * 1024) {
      throw const FormatException('Receipt image exceeds local limit');
    }
    final target = directoryOverride ?? await directory();
    await target.create(recursive: true);
    final name =
        '${DateTime.now().microsecondsSinceEpoch}-'
        '${Random.secure().nextInt(0x7fffffff)}.img';
    final destination = File('${target.path}/$name');
    try {
      return (await source.copy(destination.path)).path;
    } catch (_) {
      try {
        await removeOwned(destination.path);
      } catch (_) {}
      rethrow;
    }
  }

  /// Only this store's flat, generated file names may be removed. Paths loaded
  /// from backups never authorize deleting arbitrary files outside app media.
  Future<bool> removeOwned(String path) async {
    final file = File(path);
    if (!RegExp(r'^\d{13,20}-\d+\.img$').hasMatch(file.uri.pathSegments.last)) {
      return false;
    }
    if (!await file.exists()) return true;
    final root = directoryOverride ?? await directory();
    if (!await root.exists()) return false;
    final resolved = File(await file.resolveSymbolicLinks());
    if (resolved.parent.path != await root.resolveSymbolicLinks()) return false;
    await file.delete();
    return true;
  }
}
