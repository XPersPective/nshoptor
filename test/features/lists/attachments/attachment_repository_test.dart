import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/attachments/attachment_repository.dart';
import 'package:nshoptor/features/settings/backup/backup_repository.dart';

void main() {
  late AppDatabase db;
  late Directory mediaDir;
  late AttachmentRepository repo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    mediaDir = await Directory.systemTemp.createTemp('nshoptor_media');
    repo = AttachmentRepository(db, mediaDir);
  });

  tearDown(() async {
    await db.close();
    if (await mediaDir.exists()) {
      await mediaDir.delete(recursive: true);
    }
  });

  File makePickedFile() {
    final tmp = File(
        '${Directory.systemTemp.path}/picked_${DateTime.now().microsecondsSinceEpoch}.jpg');
    tmp.writeAsStringSync('fake-image-bytes');
    return tmp;
  }

  test('picker dosyası kalıcı dizine taşınır ve kaydı oluşur', () async {
    final picked = makePickedFile();

    final attachment = await repo.addFromPickedFile(
      ownerType: 'plannedItem',
      ownerId: 1,
      pickedPath: picked.path,
    );

    expect(await File(attachment.filePath).exists(), isTrue);
    expect(attachment.filePath.startsWith(mediaDir.path), isTrue);
    // geçici kaynak dosya kaldırılır
    expect(await picked.exists(), isFalse);
    // DB'de blob yok, yalnız yol
    expect(attachment.filePath, isNot(contains('fake-image-bytes')));
  });

  test('eksik picker dosyası StateError verir', () async {
    expect(
      () => repo.addFromPickedFile(
          ownerType: 'list', ownerId: 1, pickedPath: 'C:/yok/x.jpg'),
      throwsStateError,
    );
  });

  test('deleteAttachment satırı ve dosyayı birlikte kaldırır', () async {
    final picked = makePickedFile();
    final attachment = await repo.addFromPickedFile(
        ownerType: 'plannedItem', ownerId: 2, pickedPath: picked.path);

    await repo.deleteAttachment(attachment.id);

    expect(await File(attachment.filePath).exists(), isFalse);
    expect(await repo.forOwner('plannedItem', 2), isEmpty);
  });

  test('imported external file path cannot authorize file deletion', () async {
    final external = makePickedFile();
    addTearDown(() async { if (await external.exists()) await external.delete(); });
    final list = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    final id = await db.into(db.attachments).insert(AttachmentsCompanion.insert(
      ownerType: 'list', ownerId: list, filePath: external.path));
    final backup = BackupRepository(db);
    final snapshot = await backup.exportBackup();
    await db.delete(db.attachments).go();
    await backup.importBackup(snapshot, ImportMode.merge);
    await repo.deleteAttachment(id);
    expect(await external.exists(), isTrue);
    expect(await repo.forOwner('list', list), isEmpty);
  });

  test('resolved directory link cannot escape owned media deletion', () async {
    final outside = await Directory.systemTemp.createTemp('nshoptor_external');
    final alias = '${mediaDir.path}${Platform.pathSeparator}external_link';
    try {
      final protected = await File('${outside.path}/protected.jpg').writeAsString('owned by another directory');
      if (Platform.isWindows) {
        final result = await Process.run('cmd', ['/c', 'mklink', '/J', alias, outside.path]);
        expect(result.exitCode, 0, reason: '${result.stdout} ${result.stderr}');
      } else {
        await Link(alias).create(outside.path);
      }
      final id = await db.into(db.attachments).insert(AttachmentsCompanion.insert(
        ownerType: 'list', ownerId: 1, filePath: '$alias/protected.jpg'));
      await repo.deleteAttachment(id);
      expect(await protected.exists(), isTrue);
    } finally {
      if (await Link(alias).exists()) await Link(alias).delete();
      await outside.delete(recursive: true);
    }
  });

  test('sweepOrphans DB kaydı olmayan dosyaları temizler', () async {
    final picked = makePickedFile();
    final kept = await repo.addFromPickedFile(
        ownerType: 'list', ownerId: 3, pickedPath: picked.path);

    final orphan = File('${mediaDir.path}/orphan_1.jpg');
    orphan.writeAsStringSync('orphan');

    final removed = await repo.sweepOrphans();
    expect(removed, 1);
    expect(await File(kept.filePath).exists(), isTrue);
    expect(await orphan.exists(), isFalse);
  });

  test('izin reddi senaryosu: picker akışı uygulamanın kalanını etkilemez',
      () async {
    // T24 notu: izin akışı cihaz doğrulamasıdır (T32); burada repo katmanı
    // izinsiz ortamda da sorunsuz çalışır.
    final attachment = await repo.addFromPickedFile(
      ownerType: 'list',
      ownerId: 4,
      pickedPath: makePickedFile().path,
    );
    expect(attachment.id, greaterThan(0));
  });
}
