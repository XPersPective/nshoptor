import 'dart:convert';

import 'package:drift/drift.dart';

part 'app_database.g.dart';

/// NShoptor yerel veri şeması v1 (spec §8).
///
/// Kurallar:
/// - Para: minor unit (kuruş) **int**; miktar ve birim fiyat **DecimalFixed
///   dizesi** (ör. `1.5`, `42.90`) — hiçbir yerde double yoktur.
/// - Kanonik değerler (durum, birim, kaynak) kod dizesi olarak saklanır;
///   görünen adlar UI/l10n katmanında üretilir.
/// - Fotoğraf yolları dosya olarak cihazda; veritabanında yalnız yol.
/// - Tüm silmeler FK kurallarıyla tanımlıdır: cascade (çocuklar da silinir)
///   veya set null (ilişki kopar, kayıt kalır).

/// Mağazalar.
class Stores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Kullanıcı kategorileri; ilk açılışta başlangıç kümesi eklenir (T9).
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get iconToken => text().nullable()();
}

/// Mağaza reyonları (kullanıcı düzenleyebilir sıra).
class Aisles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  IntColumn get storeId => integer().nullable().references(
      Stores, #id, onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

/// Alışveriş listeleri.
class ShoppingLists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get generatedTitle => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get plannedAt => dateTime().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get storeId =>
      integer().nullable().references(Stores, #id)();
  /// ISO 4217 kodu; liste başına tek para birimi (spec §7.1).
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get budgetMinorUnits => integer().nullable()();
  /// draft | planned | shopping | completed | archived
  TextColumn get status =>
      text().withDefault(const Constant('draft'))();
  TextColumn get note => text().nullable()();
  TextColumn get colorToken => text().nullable()();
  TextColumn get iconToken => text().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
}

/// Planlanan ürünler.
class PlannedItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get listId => integer().references(ShoppingLists, #id,
      onDelete: KeyAction.cascade)();
  IntColumn get productId =>
      integer().nullable().references(ProductMemory, #id)();
  TextColumn get name => text().withLength(min: 1, max: 500)();
  TextColumn get normalizedName => text()();
  TextColumn get brand => text().nullable()();
  IntColumn get categoryId =>
      integer().nullable().references(Categories, #id)();
  IntColumn get aisleId => integer().nullable().references(Aisles, #id)();
  /// DecimalFixed dizesi (ondalıklı miktar, örn. `1.5`).
  TextColumn get plannedQuantity => text()();
  TextColumn get plannedUnitCode => text()();
  /// unitPrice | lineTotal — kullanıcının girdiği taraf (spec §6.2).
  TextColumn get pricingInputMode => text()();
  TextColumn get plannedUnitPrice => text().nullable()();
  IntColumn get plannedLineTotalMinorUnits => integer().nullable()();
  TextColumn get maxAcceptablePrice => text().nullable()();
  BoolColumn get requiredFlag => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  /// pending | inCart | notFound | gaveUp | alternativeBought
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Gerçek satın alım kayıtları.
class PurchaseEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get listId => integer().references(ShoppingLists, #id,
      onDelete: KeyAction.cascade)();
  IntColumn get plannedItemId => integer().nullable().references(
      PlannedItems, #id, onDelete: KeyAction.setNull)();
  IntColumn get receiptId => integer().nullable().references(
      Receipts, #id, onDelete: KeyAction.setNull)();
  TextColumn get name => text().withLength(min: 1, max: 500)();
  TextColumn get normalizedName => text()();
  TextColumn get actualQuantity => text()();
  TextColumn get actualUnitCode => text()();
  TextColumn get actualUnitPrice => text().nullable()();
  IntColumn get grossTotalMinorUnits => integer().nullable()();
  IntColumn get discountMinorUnits => integer().withDefault(const Constant(0))();
  IntColumn get actualLineTotalMinorUnits => integer()();
  /// manual | voice | shelfOcr | receiptOcr
  TextColumn get source => text().withDefault(const Constant('manual'))();
  /// high | medium | low — null = elle giriş
  TextColumn get confidence => text().nullable()();
  BoolColumn get userConfirmed => boolean().withDefault(const Constant(false))();
  BoolColumn get alternativeFlag =>
      boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Ürün hafızası: öneri ve favoriler (spec §6.10).
class ProductMemory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get canonicalName => text().withLength(min: 1, max: 500)();
  TextColumn get normalizedName => text()();
  IntColumn get defaultCategoryId =>
      integer().nullable().references(Categories, #id)();
  TextColumn get defaultUnitCode => text().nullable()();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  IntColumn get useCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUsedAt => dateTime().nullable()();
}

/// Mağaza bazlı ürün takma adları (fiş kodları dahil).
class ProductAliases extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(ProductMemory, #id,
      onDelete: KeyAction.cascade)();
  TextColumn get alias => text()();
  TextColumn get normalizedAlias => text()();
  IntColumn get storeId =>
      integer().nullable().references(Stores, #id)();
  /// manual | receipt | voice
  TextColumn get source => text().withDefault(const Constant('manual'))();
}

/// Doğrulanmış satın alımdan üretilen fiyat gözlemleri (spec §6.10).
class PriceObservations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId =>
      integer().nullable().references(ProductMemory, #id)();
  IntColumn get purchaseEntryId => integer().nullable().references(
      PurchaseEntries, #id, onDelete: KeyAction.setNull)();
  IntColumn get storeId =>
      integer().nullable().references(Stores, #id)();
  DateTimeColumn get observedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get quantity => text()();
  TextColumn get unitCode => text()();
  /// Ortak temel birime indirilmiş değer; güvenli değilse null (spec §7.2).
  TextColumn get normalizedBaseQuantity => text().nullable()();
  TextColumn get unitPrice => text()();
  IntColumn get lineTotalMinorUnits => integer()();
  IntColumn get discountMinorUnits => integer().withDefault(const Constant(0))();
  TextColumn get currencyCode => text()();
  /// manual | voice | shelfOcr | receiptOcr
  TextColumn get source => text()();
}

/// Fişler; görseller dosya yolu olarak (spec §6.9).
class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get listId => integer().nullable().references(ShoppingLists, #id,
      onDelete: KeyAction.setNull)();
  /// JSON dizisi: ["path1", "path2", ...] (uzun fiş: çok fotoğraf).
  TextColumn get imagePaths =>
      text().withDefault(const Constant('[]'))
          .map(const _StringListConverter())();
  TextColumn get rawOcrText => text().nullable()();
  TextColumn get detectedStore => text().nullable()();
  TextColumn get confirmedStore => text().nullable()();
  DateTimeColumn get detectedAt => dateTime().nullable()();
  DateTimeColumn get confirmedAt => dateTime().nullable()();
  TextColumn get detectedCurrency => text().nullable()();
  TextColumn get confirmedCurrency => text().nullable()();
  IntColumn get detectedTotalMinorUnits => integer().nullable()();
  IntColumn get confirmedTotalMinorUnits => integer().nullable()();
  TextColumn get parserVersion => text().nullable()();
  /// pending | ocrDone | reviewed | error
  TextColumn get processingStatus =>
      text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Fiş ayrıştırıcı aday satırları; onay akışı bunları işler (spec §6.9).
class ReceiptCandidateLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get receiptId => integer().references(Receipts, #id,
      onDelete: KeyAction.cascade)();
  TextColumn get rawText => text()();
  TextColumn get bboxMetadata => text().nullable()();
  TextColumn get parsedName => text().nullable()();
  TextColumn get parsedQuantity => text().nullable()();
  TextColumn get parsedUnitCode => text().nullable()();
  TextColumn get parsedUnitPrice => text().nullable()();
  IntColumn get parsedLineTotalMinorUnits => integer().nullable()();
  /// high | medium | low
  TextColumn get confidence => text().nullable()();
  IntColumn get linkedPlannedItemId => integer().nullable().references(
      PlannedItems, #id, onDelete: KeyAction.setNull)();
  /// pending | accepted | ignored | edited
  TextColumn get reviewStatus =>
      text().withDefault(const Constant('pending'))();
}

/// Fotoğraf/ek dosya yolları (sahipsiz dosya temizliği T24 ile).
class Attachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  /// plannedItem | purchaseEntry | list | receipt
  TextColumn get ownerType => text()();
  IntColumn get ownerId => integer()();
  TextColumn get filePath => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Yerel bildirim hatırlatmaları (spec §6.13).
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get listId => integer().references(ShoppingLists, #id,
      onDelete: KeyAction.cascade)();
  DateTimeColumn get scheduledAt => dateTime()();
  /// active | cancelled | done
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Anahtar-değer uygulama ayarları (tablo; ayrıca napp SettingsStore kullanıcı
/// tercihleri için kullanılır — bunlar analiz/rapor tercihleri gibi app
/// düzeyi ayarlar içindir).
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}

/// JSON dizisi ↔ `List<String>` dönüşümü (ör. `["a","b"]`).
class _StringListConverter extends TypeConverter<List<String>, String> {
  const _StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb);
    return (decoded as List).cast<String>();
  }

  @override
  String toSql(List<String> value) => jsonEncode(value);
}

@DriftDatabase(
  tables: [
    Stores,
    Categories,
    Aisles,
    ShoppingLists,
    PlannedItems,
    PurchaseEntries,
    ProductMemory,
    ProductAliases,
    PriceObservations,
    Receipts,
    ReceiptCandidateLines,
    Attachments,
    Reminders,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement(
              'PRAGMA foreign_keys = ON');
        },
        onUpgrade: (m, from, to) async {
          // v0→v1: ilk sürüm; ileride ALTER'lar buraya eklenir.
          assert(from < to);
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
