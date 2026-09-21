import 'dart:io';

import '../../../data/db/app_database.dart';

/// Ürün/liste fotoğraflarının kaydı ve dosya temizliği (spec §6.8).
///
/// Görseller uygulama özel dizinde DOSYA olarak tutulur; veritabanında
/// yalnız yol saklanır (blob yok). Kayıt silinince sahipsiz dosya kalmaması
/// için [deleteAttachment] dosyayı da kaldırır; [sweepOrphans] dönemsel
/// temizliktir (spec §6.8, §12).
class AttachmentRepository {
  AttachmentRepository(this._db, this.mediaDirectory);

  final AppDatabase _db;

  /// Görsellerin yazılacağı uygulama özel dizini (media/).
  final Directory mediaDirectory;

  /// Kamera/galeriden gelen geçici dosyayı kalıcı dizine kopyalayıp
  /// ek olarak kaydeder. Kaynak dosya kaldırılır (picker geçici yoludur).
  Future<Attachment> addFromPickedFile({
    required String ownerType,
    required int ownerId,
    required String pickedPath,
  }) async {
    final source = File(pickedPath);
    if (!await source.exists()) {
      throw StateError('seçilen görsel bulunamadı: $pickedPath');
    }
    await mediaDirectory.create(recursive: true);
    final extension = pickedPath.contains('.')
        ? pickedPath.substring(pickedPath.lastIndexOf('.'))
        : '.jpg';
    final fileName =
        '${DateTime.now().microsecondsSinceEpoch}_$ownerId$extension';
    final target = File('${mediaDirectory.path}${Platform.pathSeparator}$fileName');
    await source.copy(target.path);
    await source.delete().catchError((_) => source);

    final id = await _db.into(_db.attachments).insert(
          AttachmentsCompanion.insert(
            ownerType: ownerType,
            ownerId: ownerId,
            filePath: target.path,
          ),
        );
    return (await (_db.select(_db.attachments)
              ..where((t) => t.id.equals(id)))
            .getSingle());
  }

  Future<List<Attachment>> forOwner(String ownerType, int ownerId) =>
      (_db.select(_db.attachments)
            ..where((t) => t.ownerType.equals(ownerType))
            ..where((t) => t.ownerId.equals(ownerId)))
          .get();

  /// Ek satırını ve dosyasını birlikte siler.
  Future<void> deleteAttachment(int attachmentId) async {
    final row = await (_db.select(_db.attachments)
          ..where((t) => t.id.equals(attachmentId)))
        .getSingleOrNull();
    await (_db.delete(_db.attachments)
          ..where((t) => t.id.equals(attachmentId)))
        .go();
    if (row != null) {
      final file = File(row.filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  /// Sahipsiz dosya temizliği: DB'de karşılığı olmayan media/ dosyaları
  /// silinir; dönen sayı temizlenen dosya sayısıdır (spec §6.8).
  Future<int> sweepOrphans() async {
    if (!await mediaDirectory.exists()) return 0;
    final known = (await _db.select(_db.attachments).get())
        .map((a) => a.filePath)
        .toSet();
    var removed = 0;
    await for (final entity in mediaDirectory.list()) {
      if (entity is File && !known.contains(entity.path)) {
        await entity.delete();
        removed++;
      }
    }
    return removed;
  }
}
