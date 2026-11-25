import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/calc/line_calc.dart';
import '../../receipts/receipt_document.dart';

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

/// Importing the same receipt under another row would duplicate its purchases.
class BackupReceiptIdentityConflict extends FormatException {
  const BackupReceiptIdentityConflict(this.identityKey)
    : super('A receipt with this document identity already exists');

  final String identityKey;
}

class BackupRepository {
  BackupRepository(this._db);

  final AppDatabase _db;

  /// Tüm tabloları sürümlenmiş JSON'a döker. Fotoğraf dosyaları (binary)
  /// dahil değildir; yalnız kayıtlar ve dosya yolları taşınır.
  Future<String> exportBackup() => _db.transaction(() async {
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
  });

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
    if (version is! int || version != BackupFormat.version) {
      throw const FormatException('yedek sürümü desteklenmiyor');
    }
    for (final key in const ['lists', 'plannedItems', 'purchaseEntries']) {
      if (data[key] is! List) {
        throw FormatException('eksik bölüm: $key');
      }
    }
    try {
      final sections = <String, Map<int, Map<String, dynamic>>>{};
      void check<R extends Table, D>(
        String key,
        TableInfo<R, D> table,
        Insertable<D> Function(Map<String, dynamic>) read,
      ) {
        if (data.containsKey(key) && data[key] is! List) {
          throw const FormatException('invalid section');
        }
        final indexed = sections[key] = {};
        for (final value in data[key] ?? []) {
          final row = value as Map<String, dynamic>;
          final id = row['id'] as int;
          if (id <= 0 ||
              indexed.containsKey(id) ||
              !table
                  .validateIntegrity(read(row), isInserting: true)
                  .dataValid) {
            throw const FormatException('invalid row');
          }
          indexed[id] = row;
        }
      }

      check('stores', _db.stores, Store.fromJson);
      check('categories', _db.categories, Category.fromJson);
      check('aisles', _db.aisles, Aisle.fromJson);
      check('lists', _db.shoppingLists, ShoppingList.fromJson);
      check('plannedItems', _db.plannedItems, PlannedItem.fromJson);
      check('purchaseEntries', _db.purchaseEntries, PurchaseEntry.fromJson);
      check('productMemory', _db.productMemory, ProductMemoryData.fromJson);
      check('productAliases', _db.productAliases, ProductAliase.fromJson);
      check(
        'priceObservations',
        _db.priceObservations,
        PriceObservation.fromJson,
      );
      check('receipts', _db.receipts, _receiptFromJson);
      final receiptIdentities = <String>{};
      for (final receipt in sections['receipts']!.values) {
        final capture = receipt['captureDataJson'] as String?;
        if (capture != null) ReceiptDocument.decode(capture);
        final identity = receipt['identityKey'] as String?;
        if (identity != null && !receiptIdentities.add(identity)) {
          throw BackupReceiptIdentityConflict(identity);
        }
      }
      check(
        'receiptCandidateLines',
        _db.receiptCandidateLines,
        ReceiptCandidateLine.fromJson,
      );
      check('attachments', _db.attachments, Attachment.fromJson);
      check('reminders', _db.reminders, Reminder.fromJson);
      const references = {
        'storeId': 'stores',
        'categoryId': 'categories',
        'defaultCategoryId': 'categories',
        'aisleId': 'aisles',
        'listId': 'lists',
        'productId': 'productMemory',
        'plannedItemId': 'plannedItems',
        'linkedPlannedItemId': 'plannedItems',
        'receiptId': 'receipts',
        'createdByReceiptId': 'receipts',
        'purchaseEntryId': 'purchaseEntries',
      };
      const decimals = {
        'plannedQuantity',
        'plannedUnitPrice',
        'maxAcceptablePrice',
        'actualQuantity',
        'actualUnitPrice',
        'quantity',
        'normalizedBaseQuantity',
        'unitPrice',
        'parsedQuantity',
        'parsedUnitPrice',
      };
      for (final rows in sections.values) {
        for (final row in rows.values) {
          if (row['pricingInputMode'] != null &&
              !{'unitPrice', 'lineTotal'}.contains(row['pricingInputMode'])) {
            throw const FormatException('invalid price input mode');
          }
          for (final field in decimals) {
            if (row[field] != null) DecimalFixed.parse(row[field] as String);
          }
          for (final field in [
            'currencyCode',
            'detectedCurrency',
            'confirmedCurrency',
          ]) {
            if (row[field] != null) Currency.fromCode(row[field] as String);
          }
          for (final reference in references.entries) {
            if (row[reference.key] != null &&
                !sections[reference.value]!.containsKey(row[reference.key])) {
              throw const FormatException('missing relation');
            }
          }
          final receipt = sections['receipts']?[row['receiptId']];
          final listId = row['listId'] ?? receipt?['listId'];
          final creator = sections['receipts']?[row['createdByReceiptId']];
          if (row['createdByReceiptId'] != null &&
              creator?['listId'] != listId) {
            throw const FormatException('receipt creator must own the list');
          }
          for (final field in [
            'plannedItemId',
            'linkedPlannedItemId',
            'receiptId',
            'createdByReceiptId',
          ]) {
            final parent = sections[references[field]]?[row[field]];
            if (listId != null &&
                parent?['listId'] != null &&
                listId != parent!['listId']) {
              throw const FormatException('cross-list relation');
            }
          }
          final currencyCode =
              row['currencyCode'] ??
              receipt?['confirmedCurrency'] ??
              receipt?['detectedCurrency'] ??
              sections['lists']?[listId]?['currencyCode'];
          for (final (quantity, price) in [
            ('plannedQuantity', 'plannedUnitPrice'),
            ('actualQuantity', 'actualUnitPrice'),
            ('quantity', 'unitPrice'),
            ('parsedQuantity', 'parsedUnitPrice'),
          ]) {
            if (currencyCode != null &&
                row[quantity] != null &&
                row[price] != null) {
              LineCalc.actualGrossTotal(
                DecimalFixed.parse(row[quantity]),
                DecimalFixed.parse(row[price]),
              ).toMinorUnits(Currency.fromCode(currencyCode).minorUnitDigits);
            }
          }
        }
      }
      const owners = {
        'list': 'lists',
        'plannedItem': 'plannedItems',
        'purchaseEntry': 'purchaseEntries',
        'receipt': 'receipts',
      };
      for (final row in sections['attachments']!.values) {
        if (!(sections[owners[row['ownerType']]]?.containsKey(row['ownerId']) ??
            false)) {
          throw const FormatException('invalid attachment owner');
        }
      }
    } on BackupReceiptIdentityConflict {
      rethrow;
    } catch (_) {
      throw const FormatException('invalid backup data');
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
      // Check before any parent or child writes, while retaining the unique DB
      // constraint as the final boundary for concurrent importers.
      for (final receipt in _asMaps(data['receipts'])) {
        final identity = receipt['identityKey'] as String?;
        if (mode == ImportMode.merge) {
          final current = await (_db.select(
            _db.receipts,
          )..where((t) => t.id.equals(receipt['id'] as int))).getSingleOrNull();
          if (current?.identityKey != null &&
              (identity != current!.identityKey ||
                  receipt['processingStatus'] != current.processingStatus ||
                  receipt['listId'] != current.listId ||
                  receipt['captureDataJson'] != current.captureDataJson)) {
            // A pending/legacy snapshot must never clear a committed document
            // claim while merge retains its newer purchases.
            throw BackupReceiptIdentityConflict(current.identityKey!);
          }
        }
        if (identity == null) continue;
        final existing = await (_db.select(
          _db.receipts,
        )..where((t) => t.identityKey.equals(identity))).getSingleOrNull();
        if (existing != null &&
            (mode == ImportMode.separate || existing.id != receipt['id'])) {
          throw BackupReceiptIdentityConflict(identity);
        }
      }
      if (mode == ImportMode.merge) {
        await _importMerge(data);
      } else {
        await _importSeparate(data);
      }
      // Merge retains local-only children. Validate the resulting relation,
      // not just the incoming snapshot, before committing any writes.
      final foreignCreators = await _db
          .customSelect(
            'SELECT p.id FROM planned_items p JOIN receipts r '
            'ON r.id = p.created_by_receipt_id '
            'WHERE r.list_id IS NULL OR r.list_id != p.list_id LIMIT 1',
          )
          .get();
      if (foreignCreators.isNotEmpty) {
        throw const FormatException('cross-list receipt creator after restore');
      }
    });
    return preview;
  }

  /// Birleştir: kimlikler ve yedekte olmayan çocuk kayıtlar korunur.
  /// FK'ya saygı için ebeveyn tablolar önce yazılır.
  Future<void> _importMerge(Map<String, dynamic> data) async {
    Future<void> put<R extends Table, D>(
      TableInfo<R, D> table,
      List<dynamic>? rows,
      Insertable<D> Function(Map<String, dynamic>) fromJson,
    ) async {
      for (final row in rows ?? <Map<String, dynamic>>[]) {
        await _db
            .into(table)
            .insertOnConflictUpdate(fromJson(row as Map<String, dynamic>));
      }
    }

    await put(_db.stores, data['stores'] as List<dynamic>?, Store.fromJson);
    await put(
      _db.categories,
      data['categories'] as List<dynamic>?,
      Category.fromJson,
    );
    await put(_db.aisles, data['aisles'] as List<dynamic>?, Aisle.fromJson);
    await put(
      _db.productMemory,
      data['productMemory'] as List<dynamic>?,
      ProductMemoryData.fromJson,
    );
    await put(
      _db.shoppingLists,
      data['lists'] as List<dynamic>?,
      ShoppingList.fromJson,
    );
    await put(
      _db.receipts,
      data['receipts'] as List<dynamic>?,
      _receiptFromJson,
    );
    await put(
      _db.plannedItems,
      data['plannedItems'] as List<dynamic>?,
      (json) => PlannedItem.fromJson(json)
          .toCompanion(false)
          .copyWith(
            createdByReceiptId: json.containsKey('createdByReceiptId')
                ? Value(json['createdByReceiptId'] as int?)
                : const Value.absent(),
          ),
    );
    await put(
      _db.purchaseEntries,
      data['purchaseEntries'] as List<dynamic>?,
      PurchaseEntry.fromJson,
    );
    await put(
      _db.productAliases,
      data['productAliases'] as List<dynamic>?,
      ProductAliase.fromJson,
    );
    await put(
      _db.priceObservations,
      data['priceObservations'] as List<dynamic>?,
      PriceObservation.fromJson,
    );
    await put(
      _db.receiptCandidateLines,
      data['receiptCandidateLines'] as List<dynamic>?,
      ReceiptCandidateLine.fromJson,
    );
    await put(
      _db.attachments,
      data['attachments'] as List<dynamic>?,
      Attachment.fromJson,
    );
    await _importReminders(_asMaps(data['reminders']));
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

    int? remap(Map<int, int> map, dynamic oldId) {
      if (oldId == null) return null;
      final mapped = map[oldId as int];
      if (mapped == null) {
        throw const FormatException('missing backup relation');
      }
      return mapped;
    }

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
      json['defaultCategoryId'] = remap(categoryIds, json['defaultCategoryId']);
      await _db
          .into(_db.productMemory)
          .insert(ProductMemoryData.fromJson(json));
    }

    // 2) listeler
    next = await _nextId(_db.shoppingLists);
    for (final json in _asMaps(data['lists'])) {
      allocate(listIds, json, next);
      next++;
      json['storeId'] = remap(storeIds, json['storeId']);
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

    // Receipt creators must exist before their planned rows.
    next = await _nextId(_db.receipts);
    for (final json in _asMaps(data['receipts'])) {
      allocate(receiptIds, json, next++);
      json['listId'] = remap(listIds, json['listId']);
      await _db.into(_db.receipts).insert(_receiptFromJson(json));
    }

    // 4) planlanan ürünler
    next = await _nextId(_db.plannedItems);
    for (final json in _asMaps(data['plannedItems'])) {
      allocate(itemIds, json, next);
      next++;
      json['listId'] = remap(listIds, json['listId']);
      json['productId'] = remap(productIds, json['productId']);
      json['categoryId'] = remap(categoryIds, json['categoryId']);
      json['aisleId'] = remap(aisleIds, json['aisleId']);
      json['createdByReceiptId'] = remap(
        receiptIds,
        json['createdByReceiptId'],
      );
      await _db.into(_db.plannedItems).insert(PlannedItem.fromJson(json));
    }

    // 5) satın alım kayıtları (yeni id tahsisi ile)
    next = await _nextId(_db.purchaseEntries);
    for (final json in _asMaps(data['purchaseEntries'])) {
      allocate(entryIds, json, next);
      next++;
      json['listId'] = remap(listIds, json['listId']);
      json['plannedItemId'] = remap(itemIds, json['plannedItemId']);
      json['receiptId'] = remap(receiptIds, json['receiptId']);
      await _db.into(_db.purchaseEntries).insert(PurchaseEntry.fromJson(json));
    }

    // 6) alias + gözlemler
    next = await _nextId(_db.productAliases);
    for (final json in _asMaps(data['productAliases'])) {
      json['id'] = next++;
      json['productId'] = remap(productIds, json['productId']);
      json['storeId'] = remap(storeIds, json['storeId']);
      await _db.into(_db.productAliases).insert(ProductAliase.fromJson(json));
    }
    next = await _nextId(_db.priceObservations);
    for (final json in _asMaps(data['priceObservations'])) {
      json['id'] = next++;
      json['productId'] = remap(productIds, json['productId']);
      json['purchaseEntryId'] = remap(entryIds, json['purchaseEntryId']);
      json['storeId'] = remap(storeIds, json['storeId']);
      await _db
          .into(_db.priceObservations)
          .insert(PriceObservation.fromJson(json));
    }

    // 7) fiş aday satırları
    next = await _nextId(_db.receiptCandidateLines);
    for (final json in _asMaps(data['receiptCandidateLines'])) {
      json['id'] = next++;
      json['receiptId'] = remap(receiptIds, json['receiptId']);
      json['linkedPlannedItemId'] = remap(itemIds, json['linkedPlannedItemId']);
      await _db
          .into(_db.receiptCandidateLines)
          .insert(ReceiptCandidateLine.fromJson(json));
    }

    // 8) ekler + hatırlatmalar
    next = await _nextId(_db.attachments);
    for (final json in _asMaps(data['attachments'])) {
      json['id'] = next++;
      final owners = switch (json['ownerType']) {
        'list' => listIds,
        'plannedItem' => itemIds,
        'purchaseEntry' => entryIds,
        'receipt' => receiptIds,
        _ => throw const FormatException('unsupported attachment owner'),
      };
      json['ownerId'] = remap(owners, json['ownerId']);
      await _db.into(_db.attachments).insert(Attachment.fromJson(json));
    }
    next = await _nextId(_db.reminders);
    for (final json in _asMaps(data['reminders'])) {
      json['id'] = next++;
      json['listId'] = remap(listIds, json['listId']);
      await _db.into(_db.reminders).insert(_restorableReminder(json));
    }
  }

  // A database snapshot cannot restore the OS notification queue. Never claim
  // active until the user explicitly activates the imported schedule.
  Reminder _restorableReminder(Map<String, dynamic> json) {
    final row = Reminder.fromJson(json);
    return row.copyWith(
      status: {'active', 'pending', 'pendingRestore'}.contains(row.status)
          ? 'pendingRestore'
          : 'cancelled',
    );
  }

  Future<void> _importReminders(List<Map<String, dynamic>> rows) async {
    for (final json in rows) {
      final incoming = _restorableReminder(json);
      final existing = await (_db.select(
        _db.reminders,
      )..where((t) => t.id.equals(incoming.id))).getSingleOrNull();
      // An existing ID may own a native alarm. Its target/time must remain
      // intact; a different imported schedule receives a new, inactive ID.
      if (existing != null &&
          existing.listId == incoming.listId &&
          existing.scheduledAt == incoming.scheduledAt) {
        continue;
      }
      final duplicate =
          await (_db.select(_db.reminders)..where(
                (t) =>
                    t.listId.equals(incoming.listId) &
                    t.scheduledAt.equals(incoming.scheduledAt) &
                    t.status.equals(incoming.status),
              ))
              .get();
      if (duplicate.isNotEmpty) continue;
      await _db
          .into(_db.reminders)
          .insert(
            incoming
                .toCompanion(false)
                .copyWith(
                  id: existing == null
                      ? Value(incoming.id)
                      : const Value.absent(),
                ),
          );
    }
  }

  /// Tablodaki mevcut en büyük otomatik kimlik + 1.
  Future<int> _nextId(TableInfo table) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(MAX(rowid), 0) + 1 AS next FROM ${table.actualTableName}',
        )
        .getSingle();
    return row.read<int>('next');
  }

  List<Map<String, dynamic>> _asMaps(dynamic value) => [
    if (value is List)
      for (final v in value) v as Map<String, dynamic>,
  ];

  // Drift's default serializer casts this converted column to List<String>.
  Receipt _receiptFromJson(Map<String, dynamic> json) => Receipt.fromJson({
    ...json,
    'imagePaths': (json['imagePaths'] as List).cast<String>().toList(),
  });
}
