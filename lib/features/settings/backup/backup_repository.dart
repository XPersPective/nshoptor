import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';

/// Yedek formatı: sürümlenmiş JSON (spec §6.14).
class BackupFormat {
  BackupFormat._();

  static const String marker = 'nshoptor-backup';

  /// Şema sürümü değişirse artar; eski sürümler ileri taşınarak okunur.
  static const int version = 1;
}

/// İçe aktarma öncesi doğrulama özeti (spec §6.14: önce tam doğrulama).
class BackupPreview {
  const BackupPreview({
    required this.version,
    required this.listCount,
    required this.itemCount,
    required this.entryCount,
  });

  final int version;
  final int listCount;
  final int itemCount;
  final int entryCount;
}

/// İçe aktarma modu (spec §6.14: çakışmada birleştir/ayrı seçenek).
enum ImportMode {
  /// Aynı kimlikler üzerine yazılır (birleştir).
  merge,

  /// Tüm içerik YENİ kimliklerle ayrı listeler olarak eklenir; mevcut
  /// veriye dokunulmaz.
  separate,
}

class BackupRepository {
  BackupRepository(this._db);

  final AppDatabase _db;

  /// Tüm tabloları sürümlenmiş JSON'a döker. Fotoğraf dosyaları (binary)
  /// dahil değildir; yalnız yollar taşınır — "büyük yedek" uyarısı UI'dadır.
  Future<String> exportBackup() async {
    final lists = await _db.select(_db.shoppingLists).get();
    final items = await _db.select(_db.plannedItems).get();
    final entries = await _db.select(_db.purchaseEntries).get();
    final stores = await _db.select(_db.stores).get();
    final categories = await _db.select(_db.categories).get();
    final aisles = await _db.select(_db.aisles).get();
    final memory = await _db.select(_db.productMemory).get();
    final aliases = await _db.select(_db.productAliases).get();
    final observations = await _db.select(_db.priceObservations).get();
    final receipts = await _db.select(_db.receipts).get();
    final candidates = await _db.select(_db.receiptCandidateLines).get();
    final attachments = await _db.select(_db.attachments).get();
    final reminders = await _db.select(_db.reminders).get();

    final payload = {
      'format': BackupFormat.marker,
      'version': BackupFormat.version,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'stores': [for (final r in stores) r.toJson()],
      'categories': [for (final r in categories) r.toJson()],
      'aisles': [for (final r in aisles) r.toJson()],
      'lists': [for (final r in lists) r.toJson()],
      'plannedItems': [for (final r in items) r.toJson()],
      'purchaseEntries': [for (final r in entries) r.toJson()],
      'productMemory': [for (final r in memory) r.toJson()],
      'productAliases': [for (final r in aliases) r.toJson()],
      'priceObservations': [for (final r in observations) r.toJson()],
      'receipts': [for (final r in receipts) r.toJson()],
      'receiptCandidateLines': [for (final r in candidates) r.toJson()],
      'attachments': [for (final r in attachments) r.toJson()],
      'reminders': [for (final r in reminders) r.toJson()],
    };
    return jsonEncode(payload);
  }

  /// İçe aktarmadan önce tam doğrulama: format, sürüm ve ana bölümler.
  /// Geçersizse [FormatException]; bozuk dosya mevcut veriye ASLA dokunmaz.
  BackupPreview validate(String json) {
    Map<String, dynamic> data;
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('kök nesne değil');
      }
      data = decoded;
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('JSON okunamadı');
    }
    if (data['format'] != BackupFormat.marker) {
      throw const FormatException('bu dosya bir NShoptor yedeği değil');
    }
    final version = data['version'];
    if (version is! int || version > BackupFormat.version) {
      throw const FormatException('yedek sürümü desteklenmiyor');
    }
    for (final key in const ['lists', 'plannedItems', 'purchaseEntries']) {
      if (data[key] is! List) {
        throw FormatException('eksik bölüm: $key');
      }
    }
    return BackupPreview(
      version: version,
      listCount: (data['lists'] as List).length,
      itemCount: (data['plannedItems'] as List).length,
      entryCount: (data['purchaseEntries'] as List).length,
    );
  }

  /// Doğrulanmış yedeği tek transaction'da içe aktarır.
  Future<BackupPreview> importBackup(String json, ImportMode mode) async {
    final preview = validate(json); // bozuksa hiçbir şey yazılmaz
    final data = jsonDecode(json) as Map<String, dynamic>;

    await _db.transaction(() async {
      if (mode == ImportMode.merge) {
        await _importMerge(data);
      } else {
        await _importSeparate(data);
      }
    });
    return preview;
  }

  /// Birleştir: kimlikler korunur; insertOrReplace ile üzerine yazılır.
  /// FK'ya saygı için ebeveyn tablolar önce yazılır.
  Future<void> _importMerge(Map<String, dynamic> data) async {
    Future<void> put<R extends Table, D>(
        TableInfo<R, D> table,
        List<dynamic>? rows,
        Insertable<D> Function(Map<String, dynamic>) fromJson) async {
      for (final row in rows ?? <Map<String, dynamic>>[]) {
        await _db
            .into(table)
            .insert(fromJson(row as Map<String, dynamic>),
                mode: InsertMode.insertOrReplace);
      }
    }

    await put(_db.stores, data['stores'] as List<dynamic>?, Store.fromJson);
    await put(_db.categories, data['categories'] as List<dynamic>?, Category.fromJson);
    await put(_db.aisles, data['aisles'] as List<dynamic>?, Aisle.fromJson);
    await put(_db.shoppingLists, data['lists'] as List<dynamic>?, ShoppingList.fromJson);
    await put(_db.plannedItems, data['plannedItems'] as List<dynamic>?, PlannedItem.fromJson);
    await put(_db.purchaseEntries, data['purchaseEntries'] as List<dynamic>?, PurchaseEntry.fromJson);
    await put(_db.productMemory, data['productMemory'] as List<dynamic>?, ProductMemoryData.fromJson);
    await put(_db.productAliases, data['productAliases'] as List<dynamic>?, ProductAliase.fromJson);
    await put(_db.priceObservations, data['priceObservations'] as List<dynamic>?, PriceObservation.fromJson);
    await put(_db.receipts, data['receipts'] as List<dynamic>?, Receipt.fromJson);
    await put(_db.receiptCandidateLines, data['receiptCandidateLines'] as List<dynamic>?, ReceiptCandidateLine.fromJson);
    await put(_db.attachments, data['attachments'] as List<dynamic>?, Attachment.fromJson);
    await put(_db.reminders, data['reminders'] as List<dynamic>?, Reminder.fromJson);
  }

  Future<void> _importSeparate(Map<String, dynamic> data) async {
    final storeIds = <int, int>{};
    final categoryIds = <int, int>{};
    final aisleIds = <int, int>{};
    final listIds = <int, int>{};
    final productIds = <int, int>{};
    final itemIds = <int, int>{};
    final entryIds = <int, int>{};
    final receiptIds = <int, int>{};

    // JSON satırlarında id alanını yeniden atayan yardımcı.
    int allocate(Map<int, int> map, Map<String, dynamic> json, int next) {
      final oldId = json['id'] as int;
      map[oldId] = next;
      json['id'] = next;
      return next + 1;
    }

    int? remap(Map<int, int> map, dynamic oldId) =>
        oldId == null ? null : map[oldId as int];

    // 1) bağımsız tablolar
    var next = await _nextId(_db.stores);
    for (final json in _asMaps(data['stores'])) {
      allocate(storeIds, json, next);
      next++;
      await _db.into(_db.stores).insert(Store.fromJson(json));
    }
    next = await _nextId(_db.categories);
    for (final json in _asMaps(data['categories'])) {
      allocate(categoryIds, json, next);
      next++;
      await _db.into(_db.categories).insert(Category.fromJson(json));
    }
    next = await _nextId(_db.productMemory);
    for (final json in _asMaps(data['productMemory'])) {
      allocate(productIds, json, next);
      next++;
      await _db.into(_db.productMemory).insert(ProductMemoryData.fromJson(json));
    }

    // 2) listeler
    next = await _nextId(_db.shoppingLists);
    for (final json in _asMaps(data['lists'])) {
      allocate(listIds, json, next);
      next++;
      await _db.into(_db.shoppingLists).insert(ShoppingList.fromJson(json));
    }

    // 3) reyonlar: storeId yeni mağazaya çevrilir
    next = await _nextId(_db.aisles);
    for (final json in _asMaps(data['aisles'])) {
      allocate(aisleIds, json, next);
      next++;
      json['storeId'] = remap(storeIds, json['storeId']);
      await _db.into(_db.aisles).insert(Aisle.fromJson(json));
    }

    // 4) planlanan ürünler
    next = await _nextId(_db.plannedItems);
    for (final json in _asMaps(data['plannedItems'])) {
      allocate(itemIds, json, next);
      next++;
      json['listId'] = listIds[json['listId'] as int];
      json['productId'] = remap(productIds, json['productId']);
      json['categoryId'] = remap(categoryIds, json['categoryId']);
      json['aisleId'] = remap(aisleIds, json['aisleId']);
      await _db.into(_db.plannedItems).insert(PlannedItem.fromJson(json));
    }

    // 5) satın alım kayıtları (yeni id tahsisi ile)
    next = await _nextId(_db.purchaseEntries);
    for (final json in _asMaps(data['purchaseEntries'])) {
      allocate(entryIds, json, next);
      next++;
      json['listId'] = listIds[json['listId'] as int];
      json['plannedItemId'] = remap(itemIds, json['plannedItemId']);
      json['receiptId'] = remap(receiptIds, json['receiptId']);
      await _db.into(_db.purchaseEntries).insert(PurchaseEntry.fromJson(json));
    }

    // 6) alias + gözlemler
    for (final json in _asMaps(data['productAliases'])) {
      json['productId'] = productIds[json['productId'] as int];
      json['storeId'] = remap(storeIds, json['storeId']);
      await _db.into(_db.productAliases).insert(ProductAliase.fromJson(json));
    }
    for (final json in _asMaps(data['priceObservations'])) {
      json['productId'] = remap(productIds, json['productId']);
      json['purchaseEntryId'] = remap(entryIds, json['purchaseEntryId']);
      json['storeId'] = remap(storeIds, json['storeId']);
      await _db.into(_db.priceObservations).insert(PriceObservation.fromJson(json));
    }

    // 7) fişler + aday satırlar
    next = await _nextId(_db.receipts);
    for (final json in _asMaps(data['receipts'])) {
      allocate(receiptIds, json, next);
      next++;
      json['listId'] = remap(listIds, json['listId']);
      await _db.into(_db.receipts).insert(Receipt.fromJson(json));
    }
    for (final json in _asMaps(data['receiptCandidateLines'])) {
      json['receiptId'] = receiptIds[json['receiptId'] as int];
      json['linkedPlannedItemId'] = remap(itemIds, json['linkedPlannedItemId']);
      await _db
          .into(_db.receiptCandidateLines)
          .insert(ReceiptCandidateLine.fromJson(json));
    }

    // 8) ekler + hatırlatmalar
    for (final json in _asMaps(data['attachments'])) {
      await _db.into(_db.attachments).insert(Attachment.fromJson(json));
    }
    for (final json in _asMaps(data['reminders'])) {
      json['listId'] = listIds[json['listId'] as int];
      await _db.into(_db.reminders).insert(Reminder.fromJson(json));
    }
  }

  /// Tablodaki mevcut en büyük otomatik kimlik + 1.
  Future<int> _nextId(TableInfo table) async {
    final row = await _db
        .customSelect('SELECT COALESCE(MAX(rowid), 0) + 1 AS next FROM ${table.actualTableName}')
        .getSingle();
    return row.read<int>('next');
  }

  List<Map<String, dynamic>> _asMaps(dynamic value) =>
      [if (value is List) for (final v in value) v as Map<String, dynamic>];
}
