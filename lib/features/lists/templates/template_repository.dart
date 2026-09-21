import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';

/// Önceki alışverişten yeni plan üretimi ve sık kullanılan şablonlar
/// (spec §6.1, §6.4).
///
/// Şablon işareti: şemayı büyütmmeden AppSettings'te JSON dizi olarak
/// tutulur (`[listeId, ...]`). Liste silindiğinde artık işaret etmese de
/// zarar vermez; okuma sırasında olmayan id'ler filtrelenir.
class TemplateRepository {
  TemplateRepository(this._db);

  final AppDatabase _db;

  static const String _templateKey = 'template.list_ids';

  Future<List<int>> templateIds() async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(_templateKey)))
        .getSingleOrNull();
    if (row == null || row.value == null || row.value!.isEmpty) return [];
    final decoded = jsonDecodeIds(row.value!);
    return decoded;
  }

  /// `"[1,2,3]"` → `[1,2,3]`; bozuk içerik güvenli şekilde boş olur.
  static List<int> jsonDecodeIds(String json) {
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list.whereType<int>().toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveTemplateIds(List<int> ids) async {
    final existing = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(_templateKey)))
        .getSingleOrNull();
    final encoded = jsonEncode(ids);
    if (existing == null) {
      await _db.into(_db.appSettings).insert(
            AppSettingsCompanion.insert(
              key: _templateKey,
              value: Value(encoded),
            ),
          );
    } else {
      await (_db.update(_db.appSettings)
            ..where((t) => t.key.equals(_templateKey)))
          .write(AppSettingsCompanion(value: Value(encoded)));
    }
  }

  Future<void> markTemplate(int listId) async {
    final ids = await templateIds();
    if (!ids.contains(listId)) {
      await _saveTemplateIds([...ids, listId]);
    }
  }

  Future<void> unmarkTemplate(int listId) async {
    final ids = await templateIds();
    await _saveTemplateIds(ids.where((id) => id != listId).toList());
  }

  /// Tamamlanmış (veya herhangi) bir listenin GERÇEK satır alımlarından yeni
  /// bir taslak plan üretir (spec §6.1): gerçek miktar/birim fiyat tahmine
  /// dönüşür; kayıtsız ürünler plan değerleriyle kopyalanır.
  Future<int> createPlanFromActuals(int sourceListId,
      {String? title, String? generatedTitle}) async {
    final source = await (_db.select(_db.shoppingLists)
          ..where((t) => t.id.equals(sourceListId)))
        .getSingle();
    final items = await (_db.select(_db.plannedItems)
          ..where((t) => t.listId.equals(sourceListId)))
        .get();

    return _db.transaction(() async {
      final newId = await _db.into(_db.shoppingLists).insert(
            ShoppingListsCompanion.insert(
              title: Value(title ?? source.title),
              generatedTitle: Value(generatedTitle ?? source.generatedTitle),
              currencyCode: source.currencyCode,
              storeId: Value(source.storeId),
              note: Value(source.note),
              colorToken: Value(source.colorToken),
              iconToken: Value(source.iconToken),
            ),
          );
      for (final item in items) {
        final entry = await _latestEntry(item.id);
        await _db.into(_db.plannedItems).insert(
              PlannedItemsCompanion.insert(
                listId: newId,
                productId: Value(item.productId),
                name: item.name,
                normalizedName: item.normalizedName,
                brand: Value(item.brand),
                categoryId: Value(item.categoryId),
                aisleId: Value(item.aisleId),
                plannedQuantity: entry?.actualQuantity ?? item.plannedQuantity,
                plannedUnitCode:
                    entry?.actualUnitCode ?? item.plannedUnitCode,
                pricingInputMode: 'unitPrice',
                plannedUnitPrice:
                    Value(entry?.actualUnitPrice ?? item.plannedUnitPrice),
                plannedLineTotalMinorUnits: Value(entry == null
                    ? item.plannedLineTotalMinorUnits
                    : entry.actualLineTotalMinorUnits),
                maxAcceptablePrice: Value(item.maxAcceptablePrice),
                requiredFlag: Value(item.requiredFlag),
                note: Value(item.note),
                sortOrder: Value(item.sortOrder),
              ),
            );
      }
      return newId;
    });
  }

  Future<PurchaseEntry?> _latestEntry(int plannedItemId) {
    return (_db.select(_db.purchaseEntries)
          ..where((t) => t.plannedItemId.equals(plannedItemId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .getSingleOrNull();
  }
}
