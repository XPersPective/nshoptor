// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StoresTable extends Stores with TableInfo<$StoresTable, Store> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, sortOrder, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stores';
  @override
  VerificationContext validateIntegrity(
    Insertable<Store> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Store map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Store(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(attachedDatabase, alias);
  }
}

class Store extends DataClass implements Insertable<Store> {
  final int id;
  final String name;
  final int sortOrder;
  final DateTime createdAt;
  const Store({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory Store.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Store(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Store copyWith({
    int? id,
    String? name,
    int? sortOrder,
    DateTime? createdAt,
  }) => Store(
    id: id ?? this.id,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  Store copyWithCompanion(StoresCompanion data) {
    return Store(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Store(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Store &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class StoresCompanion extends UpdateCompanion<Store> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StoresCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Store> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StoresCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return StoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _iconTokenMeta = const VerificationMeta(
    'iconToken',
  );
  @override
  late final GeneratedColumn<String> iconToken = GeneratedColumn<String>(
    'icon_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, sortOrder, iconToken];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('icon_token')) {
      context.handle(
        _iconTokenMeta,
        iconToken.isAcceptableOrUnknown(data['icon_token']!, _iconTokenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      iconToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_token'],
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final int sortOrder;
  final String? iconToken;
  const Category({
    required this.id,
    required this.name,
    required this.sortOrder,
    this.iconToken,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || iconToken != null) {
      map['icon_token'] = Variable<String>(iconToken);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
      iconToken: iconToken == null && nullToAbsent
          ? const Value.absent()
          : Value(iconToken),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      iconToken: serializer.fromJson<String?>(json['iconToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'iconToken': serializer.toJson<String?>(iconToken),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    int? sortOrder,
    Value<String?> iconToken = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    iconToken: iconToken.present ? iconToken.value : this.iconToken,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      iconToken: data.iconToken.present ? data.iconToken.value : this.iconToken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('iconToken: $iconToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder, iconToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.iconToken == this.iconToken);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<String?> iconToken;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.iconToken = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.sortOrder = const Value.absent(),
    this.iconToken = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<String>? iconToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (iconToken != null) 'icon_token': iconToken,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<String?>? iconToken,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      iconToken: iconToken ?? this.iconToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (iconToken.present) {
      map['icon_token'] = Variable<String>(iconToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('iconToken: $iconToken')
          ..write(')'))
        .toString();
  }
}

class $AislesTable extends Aisles with TableInfo<$AislesTable, Aisle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AislesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storeIdMeta = const VerificationMeta(
    'storeId',
  );
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
    'store_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stores (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, storeId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aisles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Aisle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(
        _storeIdMeta,
        storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Aisle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Aisle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      storeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}store_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $AislesTable createAlias(String alias) {
    return $AislesTable(attachedDatabase, alias);
  }
}

class Aisle extends DataClass implements Insertable<Aisle> {
  final int id;
  final String name;
  final int? storeId;
  final int sortOrder;
  const Aisle({
    required this.id,
    required this.name,
    this.storeId,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  AislesCompanion toCompanion(bool nullToAbsent) {
    return AislesCompanion(
      id: Value(id),
      name: Value(name),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      sortOrder: Value(sortOrder),
    );
  }

  factory Aisle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Aisle(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'storeId': serializer.toJson<int?>(storeId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Aisle copyWith({
    int? id,
    String? name,
    Value<int?> storeId = const Value.absent(),
    int? sortOrder,
  }) => Aisle(
    id: id ?? this.id,
    name: name ?? this.name,
    storeId: storeId.present ? storeId.value : this.storeId,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Aisle copyWithCompanion(AislesCompanion data) {
    return Aisle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Aisle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('storeId: $storeId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, storeId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Aisle &&
          other.id == this.id &&
          other.name == this.name &&
          other.storeId == this.storeId &&
          other.sortOrder == this.sortOrder);
}

class AislesCompanion extends UpdateCompanion<Aisle> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> storeId;
  final Value<int> sortOrder;
  const AislesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.storeId = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  AislesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.storeId = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Aisle> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? storeId,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (storeId != null) 'store_id': storeId,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  AislesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? storeId,
    Value<int>? sortOrder,
  }) {
    return AislesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      storeId: storeId ?? this.storeId,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AislesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('storeId: $storeId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ShoppingListsTable extends ShoppingLists
    with TableInfo<$ShoppingListsTable, ShoppingList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generatedTitleMeta = const VerificationMeta(
    'generatedTitle',
  );
  @override
  late final GeneratedColumn<String> generatedTitle = GeneratedColumn<String>(
    'generated_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _plannedAtMeta = const VerificationMeta(
    'plannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> plannedAt = GeneratedColumn<DateTime>(
    'planned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storeIdMeta = const VerificationMeta(
    'storeId',
  );
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
    'store_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stores (id)',
    ),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _budgetMinorUnitsMeta = const VerificationMeta(
    'budgetMinorUnits',
  );
  @override
  late final GeneratedColumn<int> budgetMinorUnits = GeneratedColumn<int>(
    'budget_minor_units',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorTokenMeta = const VerificationMeta(
    'colorToken',
  );
  @override
  late final GeneratedColumn<String> colorToken = GeneratedColumn<String>(
    'color_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconTokenMeta = const VerificationMeta(
    'iconToken',
  );
  @override
  late final GeneratedColumn<String> iconToken = GeneratedColumn<String>(
    'icon_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    generatedTitle,
    createdAt,
    updatedAt,
    plannedAt,
    startedAt,
    completedAt,
    storeId,
    currencyCode,
    budgetMinorUnits,
    status,
    note,
    colorToken,
    iconToken,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_lists';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingList> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('generated_title')) {
      context.handle(
        _generatedTitleMeta,
        generatedTitle.isAcceptableOrUnknown(
          data['generated_title']!,
          _generatedTitleMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('planned_at')) {
      context.handle(
        _plannedAtMeta,
        plannedAt.isAcceptableOrUnknown(data['planned_at']!, _plannedAtMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('store_id')) {
      context.handle(
        _storeIdMeta,
        storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('budget_minor_units')) {
      context.handle(
        _budgetMinorUnitsMeta,
        budgetMinorUnits.isAcceptableOrUnknown(
          data['budget_minor_units']!,
          _budgetMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('color_token')) {
      context.handle(
        _colorTokenMeta,
        colorToken.isAcceptableOrUnknown(data['color_token']!, _colorTokenMeta),
      );
    }
    if (data.containsKey('icon_token')) {
      context.handle(
        _iconTokenMeta,
        iconToken.isAcceptableOrUnknown(data['icon_token']!, _iconTokenMeta),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingList(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      generatedTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generated_title'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      plannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planned_at'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      storeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}store_id'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      budgetMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}budget_minor_units'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      colorToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_token'],
      ),
      iconToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_token'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $ShoppingListsTable createAlias(String alias) {
    return $ShoppingListsTable(attachedDatabase, alias);
  }
}

class ShoppingList extends DataClass implements Insertable<ShoppingList> {
  final int id;
  final String? title;
  final String? generatedTitle;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? plannedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int? storeId;

  /// ISO 4217 kodu; liste başına tek para birimi (spec §7.1).
  final String currencyCode;
  final int? budgetMinorUnits;

  /// draft | planned | shopping | completed | archived
  final String status;
  final String? note;
  final String? colorToken;
  final String? iconToken;
  final DateTime? archivedAt;
  const ShoppingList({
    required this.id,
    this.title,
    this.generatedTitle,
    required this.createdAt,
    required this.updatedAt,
    this.plannedAt,
    this.startedAt,
    this.completedAt,
    this.storeId,
    required this.currencyCode,
    this.budgetMinorUnits,
    required this.status,
    this.note,
    this.colorToken,
    this.iconToken,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || generatedTitle != null) {
      map['generated_title'] = Variable<String>(generatedTitle);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || plannedAt != null) {
      map['planned_at'] = Variable<DateTime>(plannedAt);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || budgetMinorUnits != null) {
      map['budget_minor_units'] = Variable<int>(budgetMinorUnits);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || colorToken != null) {
      map['color_token'] = Variable<String>(colorToken);
    }
    if (!nullToAbsent || iconToken != null) {
      map['icon_token'] = Variable<String>(iconToken);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  ShoppingListsCompanion toCompanion(bool nullToAbsent) {
    return ShoppingListsCompanion(
      id: Value(id),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      generatedTitle: generatedTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(generatedTitle),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      plannedAt: plannedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      currencyCode: Value(currencyCode),
      budgetMinorUnits: budgetMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetMinorUnits),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      colorToken: colorToken == null && nullToAbsent
          ? const Value.absent()
          : Value(colorToken),
      iconToken: iconToken == null && nullToAbsent
          ? const Value.absent()
          : Value(iconToken),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory ShoppingList.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingList(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      generatedTitle: serializer.fromJson<String?>(json['generatedTitle']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      plannedAt: serializer.fromJson<DateTime?>(json['plannedAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      budgetMinorUnits: serializer.fromJson<int?>(json['budgetMinorUnits']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      colorToken: serializer.fromJson<String?>(json['colorToken']),
      iconToken: serializer.fromJson<String?>(json['iconToken']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'generatedTitle': serializer.toJson<String?>(generatedTitle),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'plannedAt': serializer.toJson<DateTime?>(plannedAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'storeId': serializer.toJson<int?>(storeId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'budgetMinorUnits': serializer.toJson<int?>(budgetMinorUnits),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'colorToken': serializer.toJson<String?>(colorToken),
      'iconToken': serializer.toJson<String?>(iconToken),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  ShoppingList copyWith({
    int? id,
    Value<String?> title = const Value.absent(),
    Value<String?> generatedTitle = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> plannedAt = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<int?> storeId = const Value.absent(),
    String? currencyCode,
    Value<int?> budgetMinorUnits = const Value.absent(),
    String? status,
    Value<String?> note = const Value.absent(),
    Value<String?> colorToken = const Value.absent(),
    Value<String?> iconToken = const Value.absent(),
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => ShoppingList(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    generatedTitle: generatedTitle.present
        ? generatedTitle.value
        : this.generatedTitle,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    plannedAt: plannedAt.present ? plannedAt.value : this.plannedAt,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    storeId: storeId.present ? storeId.value : this.storeId,
    currencyCode: currencyCode ?? this.currencyCode,
    budgetMinorUnits: budgetMinorUnits.present
        ? budgetMinorUnits.value
        : this.budgetMinorUnits,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    colorToken: colorToken.present ? colorToken.value : this.colorToken,
    iconToken: iconToken.present ? iconToken.value : this.iconToken,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  ShoppingList copyWithCompanion(ShoppingListsCompanion data) {
    return ShoppingList(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      generatedTitle: data.generatedTitle.present
          ? data.generatedTitle.value
          : this.generatedTitle,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      plannedAt: data.plannedAt.present ? data.plannedAt.value : this.plannedAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      budgetMinorUnits: data.budgetMinorUnits.present
          ? data.budgetMinorUnits.value
          : this.budgetMinorUnits,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      colorToken: data.colorToken.present
          ? data.colorToken.value
          : this.colorToken,
      iconToken: data.iconToken.present ? data.iconToken.value : this.iconToken,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingList(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('generatedTitle: $generatedTitle, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('plannedAt: $plannedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('storeId: $storeId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('budgetMinorUnits: $budgetMinorUnits, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('colorToken: $colorToken, ')
          ..write('iconToken: $iconToken, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    generatedTitle,
    createdAt,
    updatedAt,
    plannedAt,
    startedAt,
    completedAt,
    storeId,
    currencyCode,
    budgetMinorUnits,
    status,
    note,
    colorToken,
    iconToken,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingList &&
          other.id == this.id &&
          other.title == this.title &&
          other.generatedTitle == this.generatedTitle &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.plannedAt == this.plannedAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.storeId == this.storeId &&
          other.currencyCode == this.currencyCode &&
          other.budgetMinorUnits == this.budgetMinorUnits &&
          other.status == this.status &&
          other.note == this.note &&
          other.colorToken == this.colorToken &&
          other.iconToken == this.iconToken &&
          other.archivedAt == this.archivedAt);
}

class ShoppingListsCompanion extends UpdateCompanion<ShoppingList> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> generatedTitle;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> plannedAt;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int?> storeId;
  final Value<String> currencyCode;
  final Value<int?> budgetMinorUnits;
  final Value<String> status;
  final Value<String?> note;
  final Value<String?> colorToken;
  final Value<String?> iconToken;
  final Value<DateTime?> archivedAt;
  const ShoppingListsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.generatedTitle = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.plannedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.storeId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.budgetMinorUnits = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.colorToken = const Value.absent(),
    this.iconToken = const Value.absent(),
    this.archivedAt = const Value.absent(),
  });
  ShoppingListsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.generatedTitle = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.plannedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.storeId = const Value.absent(),
    required String currencyCode,
    this.budgetMinorUnits = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.colorToken = const Value.absent(),
    this.iconToken = const Value.absent(),
    this.archivedAt = const Value.absent(),
  }) : currencyCode = Value(currencyCode);
  static Insertable<ShoppingList> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? generatedTitle,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? plannedAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? storeId,
    Expression<String>? currencyCode,
    Expression<int>? budgetMinorUnits,
    Expression<String>? status,
    Expression<String>? note,
    Expression<String>? colorToken,
    Expression<String>? iconToken,
    Expression<DateTime>? archivedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (generatedTitle != null) 'generated_title': generatedTitle,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (plannedAt != null) 'planned_at': plannedAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (storeId != null) 'store_id': storeId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (budgetMinorUnits != null) 'budget_minor_units': budgetMinorUnits,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (colorToken != null) 'color_token': colorToken,
      if (iconToken != null) 'icon_token': iconToken,
      if (archivedAt != null) 'archived_at': archivedAt,
    });
  }

  ShoppingListsCompanion copyWith({
    Value<int>? id,
    Value<String?>? title,
    Value<String?>? generatedTitle,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? plannedAt,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int?>? storeId,
    Value<String>? currencyCode,
    Value<int?>? budgetMinorUnits,
    Value<String>? status,
    Value<String?>? note,
    Value<String?>? colorToken,
    Value<String?>? iconToken,
    Value<DateTime?>? archivedAt,
  }) {
    return ShoppingListsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      generatedTitle: generatedTitle ?? this.generatedTitle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      plannedAt: plannedAt ?? this.plannedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      storeId: storeId ?? this.storeId,
      currencyCode: currencyCode ?? this.currencyCode,
      budgetMinorUnits: budgetMinorUnits ?? this.budgetMinorUnits,
      status: status ?? this.status,
      note: note ?? this.note,
      colorToken: colorToken ?? this.colorToken,
      iconToken: iconToken ?? this.iconToken,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (generatedTitle.present) {
      map['generated_title'] = Variable<String>(generatedTitle.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (plannedAt.present) {
      map['planned_at'] = Variable<DateTime>(plannedAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (budgetMinorUnits.present) {
      map['budget_minor_units'] = Variable<int>(budgetMinorUnits.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (colorToken.present) {
      map['color_token'] = Variable<String>(colorToken.value);
    }
    if (iconToken.present) {
      map['icon_token'] = Variable<String>(iconToken.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('generatedTitle: $generatedTitle, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('plannedAt: $plannedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('storeId: $storeId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('budgetMinorUnits: $budgetMinorUnits, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('colorToken: $colorToken, ')
          ..write('iconToken: $iconToken, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductMemoryTable extends ProductMemory
    with TableInfo<$ProductMemoryTable, ProductMemoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductMemoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _canonicalNameMeta = const VerificationMeta(
    'canonicalName',
  );
  @override
  late final GeneratedColumn<String> canonicalName = GeneratedColumn<String>(
    'canonical_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultCategoryIdMeta = const VerificationMeta(
    'defaultCategoryId',
  );
  @override
  late final GeneratedColumn<int> defaultCategoryId = GeneratedColumn<int>(
    'default_category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _defaultUnitCodeMeta = const VerificationMeta(
    'defaultUnitCode',
  );
  @override
  late final GeneratedColumn<String> defaultUnitCode = GeneratedColumn<String>(
    'default_unit_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _favoriteMeta = const VerificationMeta(
    'favorite',
  );
  @override
  late final GeneratedColumn<bool> favorite = GeneratedColumn<bool>(
    'favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _useCountMeta = const VerificationMeta(
    'useCount',
  );
  @override
  late final GeneratedColumn<int> useCount = GeneratedColumn<int>(
    'use_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    canonicalName,
    normalizedName,
    defaultCategoryId,
    defaultUnitCode,
    favorite,
    useCount,
    lastUsedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_memory';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductMemoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('canonical_name')) {
      context.handle(
        _canonicalNameMeta,
        canonicalName.isAcceptableOrUnknown(
          data['canonical_name']!,
          _canonicalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalNameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('default_category_id')) {
      context.handle(
        _defaultCategoryIdMeta,
        defaultCategoryId.isAcceptableOrUnknown(
          data['default_category_id']!,
          _defaultCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('default_unit_code')) {
      context.handle(
        _defaultUnitCodeMeta,
        defaultUnitCode.isAcceptableOrUnknown(
          data['default_unit_code']!,
          _defaultUnitCodeMeta,
        ),
      );
    }
    if (data.containsKey('favorite')) {
      context.handle(
        _favoriteMeta,
        favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta),
      );
    }
    if (data.containsKey('use_count')) {
      context.handle(
        _useCountMeta,
        useCount.isAcceptableOrUnknown(data['use_count']!, _useCountMeta),
      );
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductMemoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductMemoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      canonicalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      defaultCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_category_id'],
      ),
      defaultUnitCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_unit_code'],
      ),
      favorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}favorite'],
      )!,
      useCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}use_count'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      ),
    );
  }

  @override
  $ProductMemoryTable createAlias(String alias) {
    return $ProductMemoryTable(attachedDatabase, alias);
  }
}

class ProductMemoryData extends DataClass
    implements Insertable<ProductMemoryData> {
  final int id;
  final String canonicalName;
  final String normalizedName;
  final int? defaultCategoryId;
  final String? defaultUnitCode;
  final bool favorite;
  final int useCount;
  final DateTime? lastUsedAt;
  const ProductMemoryData({
    required this.id,
    required this.canonicalName,
    required this.normalizedName,
    this.defaultCategoryId,
    this.defaultUnitCode,
    required this.favorite,
    required this.useCount,
    this.lastUsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['canonical_name'] = Variable<String>(canonicalName);
    map['normalized_name'] = Variable<String>(normalizedName);
    if (!nullToAbsent || defaultCategoryId != null) {
      map['default_category_id'] = Variable<int>(defaultCategoryId);
    }
    if (!nullToAbsent || defaultUnitCode != null) {
      map['default_unit_code'] = Variable<String>(defaultUnitCode);
    }
    map['favorite'] = Variable<bool>(favorite);
    map['use_count'] = Variable<int>(useCount);
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    return map;
  }

  ProductMemoryCompanion toCompanion(bool nullToAbsent) {
    return ProductMemoryCompanion(
      id: Value(id),
      canonicalName: Value(canonicalName),
      normalizedName: Value(normalizedName),
      defaultCategoryId: defaultCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultCategoryId),
      defaultUnitCode: defaultUnitCode == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultUnitCode),
      favorite: Value(favorite),
      useCount: Value(useCount),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
    );
  }

  factory ProductMemoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductMemoryData(
      id: serializer.fromJson<int>(json['id']),
      canonicalName: serializer.fromJson<String>(json['canonicalName']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      defaultCategoryId: serializer.fromJson<int?>(json['defaultCategoryId']),
      defaultUnitCode: serializer.fromJson<String?>(json['defaultUnitCode']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      useCount: serializer.fromJson<int>(json['useCount']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'canonicalName': serializer.toJson<String>(canonicalName),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'defaultCategoryId': serializer.toJson<int?>(defaultCategoryId),
      'defaultUnitCode': serializer.toJson<String?>(defaultUnitCode),
      'favorite': serializer.toJson<bool>(favorite),
      'useCount': serializer.toJson<int>(useCount),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
    };
  }

  ProductMemoryData copyWith({
    int? id,
    String? canonicalName,
    String? normalizedName,
    Value<int?> defaultCategoryId = const Value.absent(),
    Value<String?> defaultUnitCode = const Value.absent(),
    bool? favorite,
    int? useCount,
    Value<DateTime?> lastUsedAt = const Value.absent(),
  }) => ProductMemoryData(
    id: id ?? this.id,
    canonicalName: canonicalName ?? this.canonicalName,
    normalizedName: normalizedName ?? this.normalizedName,
    defaultCategoryId: defaultCategoryId.present
        ? defaultCategoryId.value
        : this.defaultCategoryId,
    defaultUnitCode: defaultUnitCode.present
        ? defaultUnitCode.value
        : this.defaultUnitCode,
    favorite: favorite ?? this.favorite,
    useCount: useCount ?? this.useCount,
    lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
  );
  ProductMemoryData copyWithCompanion(ProductMemoryCompanion data) {
    return ProductMemoryData(
      id: data.id.present ? data.id.value : this.id,
      canonicalName: data.canonicalName.present
          ? data.canonicalName.value
          : this.canonicalName,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      defaultCategoryId: data.defaultCategoryId.present
          ? data.defaultCategoryId.value
          : this.defaultCategoryId,
      defaultUnitCode: data.defaultUnitCode.present
          ? data.defaultUnitCode.value
          : this.defaultUnitCode,
      favorite: data.favorite.present ? data.favorite.value : this.favorite,
      useCount: data.useCount.present ? data.useCount.value : this.useCount,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductMemoryData(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultUnitCode: $defaultUnitCode, ')
          ..write('favorite: $favorite, ')
          ..write('useCount: $useCount, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    canonicalName,
    normalizedName,
    defaultCategoryId,
    defaultUnitCode,
    favorite,
    useCount,
    lastUsedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductMemoryData &&
          other.id == this.id &&
          other.canonicalName == this.canonicalName &&
          other.normalizedName == this.normalizedName &&
          other.defaultCategoryId == this.defaultCategoryId &&
          other.defaultUnitCode == this.defaultUnitCode &&
          other.favorite == this.favorite &&
          other.useCount == this.useCount &&
          other.lastUsedAt == this.lastUsedAt);
}

class ProductMemoryCompanion extends UpdateCompanion<ProductMemoryData> {
  final Value<int> id;
  final Value<String> canonicalName;
  final Value<String> normalizedName;
  final Value<int?> defaultCategoryId;
  final Value<String?> defaultUnitCode;
  final Value<bool> favorite;
  final Value<int> useCount;
  final Value<DateTime?> lastUsedAt;
  const ProductMemoryCompanion({
    this.id = const Value.absent(),
    this.canonicalName = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.defaultCategoryId = const Value.absent(),
    this.defaultUnitCode = const Value.absent(),
    this.favorite = const Value.absent(),
    this.useCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
  });
  ProductMemoryCompanion.insert({
    this.id = const Value.absent(),
    required String canonicalName,
    required String normalizedName,
    this.defaultCategoryId = const Value.absent(),
    this.defaultUnitCode = const Value.absent(),
    this.favorite = const Value.absent(),
    this.useCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
  }) : canonicalName = Value(canonicalName),
       normalizedName = Value(normalizedName);
  static Insertable<ProductMemoryData> custom({
    Expression<int>? id,
    Expression<String>? canonicalName,
    Expression<String>? normalizedName,
    Expression<int>? defaultCategoryId,
    Expression<String>? defaultUnitCode,
    Expression<bool>? favorite,
    Expression<int>? useCount,
    Expression<DateTime>? lastUsedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (canonicalName != null) 'canonical_name': canonicalName,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (defaultCategoryId != null) 'default_category_id': defaultCategoryId,
      if (defaultUnitCode != null) 'default_unit_code': defaultUnitCode,
      if (favorite != null) 'favorite': favorite,
      if (useCount != null) 'use_count': useCount,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
    });
  }

  ProductMemoryCompanion copyWith({
    Value<int>? id,
    Value<String>? canonicalName,
    Value<String>? normalizedName,
    Value<int?>? defaultCategoryId,
    Value<String?>? defaultUnitCode,
    Value<bool>? favorite,
    Value<int>? useCount,
    Value<DateTime?>? lastUsedAt,
  }) {
    return ProductMemoryCompanion(
      id: id ?? this.id,
      canonicalName: canonicalName ?? this.canonicalName,
      normalizedName: normalizedName ?? this.normalizedName,
      defaultCategoryId: defaultCategoryId ?? this.defaultCategoryId,
      defaultUnitCode: defaultUnitCode ?? this.defaultUnitCode,
      favorite: favorite ?? this.favorite,
      useCount: useCount ?? this.useCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (canonicalName.present) {
      map['canonical_name'] = Variable<String>(canonicalName.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (defaultCategoryId.present) {
      map['default_category_id'] = Variable<int>(defaultCategoryId.value);
    }
    if (defaultUnitCode.present) {
      map['default_unit_code'] = Variable<String>(defaultUnitCode.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (useCount.present) {
      map['use_count'] = Variable<int>(useCount.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductMemoryCompanion(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultUnitCode: $defaultUnitCode, ')
          ..write('favorite: $favorite, ')
          ..write('useCount: $useCount, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }
}

class $PlannedItemsTable extends PlannedItems
    with TableInfo<$PlannedItemsTable, PlannedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlannedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _listIdMeta = const VerificationMeta('listId');
  @override
  late final GeneratedColumn<int> listId = GeneratedColumn<int>(
    'list_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shopping_lists (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_memory (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _aisleIdMeta = const VerificationMeta(
    'aisleId',
  );
  @override
  late final GeneratedColumn<int> aisleId = GeneratedColumn<int>(
    'aisle_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES aisles (id)',
    ),
  );
  static const VerificationMeta _plannedQuantityMeta = const VerificationMeta(
    'plannedQuantity',
  );
  @override
  late final GeneratedColumn<String> plannedQuantity = GeneratedColumn<String>(
    'planned_quantity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedUnitCodeMeta = const VerificationMeta(
    'plannedUnitCode',
  );
  @override
  late final GeneratedColumn<String> plannedUnitCode = GeneratedColumn<String>(
    'planned_unit_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricingInputModeMeta = const VerificationMeta(
    'pricingInputMode',
  );
  @override
  late final GeneratedColumn<String> pricingInputMode = GeneratedColumn<String>(
    'pricing_input_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedUnitPriceMeta = const VerificationMeta(
    'plannedUnitPrice',
  );
  @override
  late final GeneratedColumn<String> plannedUnitPrice = GeneratedColumn<String>(
    'planned_unit_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedLineTotalMinorUnitsMeta =
      const VerificationMeta('plannedLineTotalMinorUnits');
  @override
  late final GeneratedColumn<int> plannedLineTotalMinorUnits =
      GeneratedColumn<int>(
        'planned_line_total_minor_units',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _maxAcceptablePriceMeta =
      const VerificationMeta('maxAcceptablePrice');
  @override
  late final GeneratedColumn<String> maxAcceptablePrice =
      GeneratedColumn<String>(
        'max_acceptable_price',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _requiredFlagMeta = const VerificationMeta(
    'requiredFlag',
  );
  @override
  late final GeneratedColumn<bool> requiredFlag = GeneratedColumn<bool>(
    'required_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("required_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listId,
    productId,
    name,
    normalizedName,
    brand,
    categoryId,
    aisleId,
    plannedQuantity,
    plannedUnitCode,
    pricingInputMode,
    plannedUnitPrice,
    plannedLineTotalMinorUnits,
    maxAcceptablePrice,
    requiredFlag,
    note,
    sortOrder,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planned_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlannedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('list_id')) {
      context.handle(
        _listIdMeta,
        listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('aisle_id')) {
      context.handle(
        _aisleIdMeta,
        aisleId.isAcceptableOrUnknown(data['aisle_id']!, _aisleIdMeta),
      );
    }
    if (data.containsKey('planned_quantity')) {
      context.handle(
        _plannedQuantityMeta,
        plannedQuantity.isAcceptableOrUnknown(
          data['planned_quantity']!,
          _plannedQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedQuantityMeta);
    }
    if (data.containsKey('planned_unit_code')) {
      context.handle(
        _plannedUnitCodeMeta,
        plannedUnitCode.isAcceptableOrUnknown(
          data['planned_unit_code']!,
          _plannedUnitCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedUnitCodeMeta);
    }
    if (data.containsKey('pricing_input_mode')) {
      context.handle(
        _pricingInputModeMeta,
        pricingInputMode.isAcceptableOrUnknown(
          data['pricing_input_mode']!,
          _pricingInputModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricingInputModeMeta);
    }
    if (data.containsKey('planned_unit_price')) {
      context.handle(
        _plannedUnitPriceMeta,
        plannedUnitPrice.isAcceptableOrUnknown(
          data['planned_unit_price']!,
          _plannedUnitPriceMeta,
        ),
      );
    }
    if (data.containsKey('planned_line_total_minor_units')) {
      context.handle(
        _plannedLineTotalMinorUnitsMeta,
        plannedLineTotalMinorUnits.isAcceptableOrUnknown(
          data['planned_line_total_minor_units']!,
          _plannedLineTotalMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('max_acceptable_price')) {
      context.handle(
        _maxAcceptablePriceMeta,
        maxAcceptablePrice.isAcceptableOrUnknown(
          data['max_acceptable_price']!,
          _maxAcceptablePriceMeta,
        ),
      );
    }
    if (data.containsKey('required_flag')) {
      context.handle(
        _requiredFlagMeta,
        requiredFlag.isAcceptableOrUnknown(
          data['required_flag']!,
          _requiredFlagMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlannedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlannedItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      listId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}list_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      aisleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aisle_id'],
      ),
      plannedQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planned_quantity'],
      )!,
      plannedUnitCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planned_unit_code'],
      )!,
      pricingInputMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pricing_input_mode'],
      )!,
      plannedUnitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planned_unit_price'],
      ),
      plannedLineTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_line_total_minor_units'],
      ),
      maxAcceptablePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}max_acceptable_price'],
      ),
      requiredFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}required_flag'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PlannedItemsTable createAlias(String alias) {
    return $PlannedItemsTable(attachedDatabase, alias);
  }
}

class PlannedItem extends DataClass implements Insertable<PlannedItem> {
  final int id;
  final int listId;
  final int? productId;
  final String name;
  final String normalizedName;
  final String? brand;
  final int? categoryId;
  final int? aisleId;

  /// DecimalFixed dizesi (ondalıklı miktar, örn. `1.5`).
  final String plannedQuantity;
  final String plannedUnitCode;

  /// unitPrice | lineTotal — kullanıcının girdiği taraf (spec §6.2).
  final String pricingInputMode;
  final String? plannedUnitPrice;
  final int? plannedLineTotalMinorUnits;
  final String? maxAcceptablePrice;
  final bool requiredFlag;
  final String? note;
  final int sortOrder;

  /// pending | inCart | notFound | gaveUp | alternativeBought
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PlannedItem({
    required this.id,
    required this.listId,
    this.productId,
    required this.name,
    required this.normalizedName,
    this.brand,
    this.categoryId,
    this.aisleId,
    required this.plannedQuantity,
    required this.plannedUnitCode,
    required this.pricingInputMode,
    this.plannedUnitPrice,
    this.plannedLineTotalMinorUnits,
    this.maxAcceptablePrice,
    required this.requiredFlag,
    this.note,
    required this.sortOrder,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['list_id'] = Variable<int>(listId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    map['name'] = Variable<String>(name);
    map['normalized_name'] = Variable<String>(normalizedName);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || aisleId != null) {
      map['aisle_id'] = Variable<int>(aisleId);
    }
    map['planned_quantity'] = Variable<String>(plannedQuantity);
    map['planned_unit_code'] = Variable<String>(plannedUnitCode);
    map['pricing_input_mode'] = Variable<String>(pricingInputMode);
    if (!nullToAbsent || plannedUnitPrice != null) {
      map['planned_unit_price'] = Variable<String>(plannedUnitPrice);
    }
    if (!nullToAbsent || plannedLineTotalMinorUnits != null) {
      map['planned_line_total_minor_units'] = Variable<int>(
        plannedLineTotalMinorUnits,
      );
    }
    if (!nullToAbsent || maxAcceptablePrice != null) {
      map['max_acceptable_price'] = Variable<String>(maxAcceptablePrice);
    }
    map['required_flag'] = Variable<bool>(requiredFlag);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlannedItemsCompanion toCompanion(bool nullToAbsent) {
    return PlannedItemsCompanion(
      id: Value(id),
      listId: Value(listId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      name: Value(name),
      normalizedName: Value(normalizedName),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      aisleId: aisleId == null && nullToAbsent
          ? const Value.absent()
          : Value(aisleId),
      plannedQuantity: Value(plannedQuantity),
      plannedUnitCode: Value(plannedUnitCode),
      pricingInputMode: Value(pricingInputMode),
      plannedUnitPrice: plannedUnitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedUnitPrice),
      plannedLineTotalMinorUnits:
          plannedLineTotalMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedLineTotalMinorUnits),
      maxAcceptablePrice: maxAcceptablePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(maxAcceptablePrice),
      requiredFlag: Value(requiredFlag),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      sortOrder: Value(sortOrder),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlannedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlannedItem(
      id: serializer.fromJson<int>(json['id']),
      listId: serializer.fromJson<int>(json['listId']),
      productId: serializer.fromJson<int?>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      brand: serializer.fromJson<String?>(json['brand']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      aisleId: serializer.fromJson<int?>(json['aisleId']),
      plannedQuantity: serializer.fromJson<String>(json['plannedQuantity']),
      plannedUnitCode: serializer.fromJson<String>(json['plannedUnitCode']),
      pricingInputMode: serializer.fromJson<String>(json['pricingInputMode']),
      plannedUnitPrice: serializer.fromJson<String?>(json['plannedUnitPrice']),
      plannedLineTotalMinorUnits: serializer.fromJson<int?>(
        json['plannedLineTotalMinorUnits'],
      ),
      maxAcceptablePrice: serializer.fromJson<String?>(
        json['maxAcceptablePrice'],
      ),
      requiredFlag: serializer.fromJson<bool>(json['requiredFlag']),
      note: serializer.fromJson<String?>(json['note']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'listId': serializer.toJson<int>(listId),
      'productId': serializer.toJson<int?>(productId),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'brand': serializer.toJson<String?>(brand),
      'categoryId': serializer.toJson<int?>(categoryId),
      'aisleId': serializer.toJson<int?>(aisleId),
      'plannedQuantity': serializer.toJson<String>(plannedQuantity),
      'plannedUnitCode': serializer.toJson<String>(plannedUnitCode),
      'pricingInputMode': serializer.toJson<String>(pricingInputMode),
      'plannedUnitPrice': serializer.toJson<String?>(plannedUnitPrice),
      'plannedLineTotalMinorUnits': serializer.toJson<int?>(
        plannedLineTotalMinorUnits,
      ),
      'maxAcceptablePrice': serializer.toJson<String?>(maxAcceptablePrice),
      'requiredFlag': serializer.toJson<bool>(requiredFlag),
      'note': serializer.toJson<String?>(note),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlannedItem copyWith({
    int? id,
    int? listId,
    Value<int?> productId = const Value.absent(),
    String? name,
    String? normalizedName,
    Value<String?> brand = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    Value<int?> aisleId = const Value.absent(),
    String? plannedQuantity,
    String? plannedUnitCode,
    String? pricingInputMode,
    Value<String?> plannedUnitPrice = const Value.absent(),
    Value<int?> plannedLineTotalMinorUnits = const Value.absent(),
    Value<String?> maxAcceptablePrice = const Value.absent(),
    bool? requiredFlag,
    Value<String?> note = const Value.absent(),
    int? sortOrder,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PlannedItem(
    id: id ?? this.id,
    listId: listId ?? this.listId,
    productId: productId.present ? productId.value : this.productId,
    name: name ?? this.name,
    normalizedName: normalizedName ?? this.normalizedName,
    brand: brand.present ? brand.value : this.brand,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    aisleId: aisleId.present ? aisleId.value : this.aisleId,
    plannedQuantity: plannedQuantity ?? this.plannedQuantity,
    plannedUnitCode: plannedUnitCode ?? this.plannedUnitCode,
    pricingInputMode: pricingInputMode ?? this.pricingInputMode,
    plannedUnitPrice: plannedUnitPrice.present
        ? plannedUnitPrice.value
        : this.plannedUnitPrice,
    plannedLineTotalMinorUnits: plannedLineTotalMinorUnits.present
        ? plannedLineTotalMinorUnits.value
        : this.plannedLineTotalMinorUnits,
    maxAcceptablePrice: maxAcceptablePrice.present
        ? maxAcceptablePrice.value
        : this.maxAcceptablePrice,
    requiredFlag: requiredFlag ?? this.requiredFlag,
    note: note.present ? note.value : this.note,
    sortOrder: sortOrder ?? this.sortOrder,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PlannedItem copyWithCompanion(PlannedItemsCompanion data) {
    return PlannedItem(
      id: data.id.present ? data.id.value : this.id,
      listId: data.listId.present ? data.listId.value : this.listId,
      productId: data.productId.present ? data.productId.value : this.productId,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      brand: data.brand.present ? data.brand.value : this.brand,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      aisleId: data.aisleId.present ? data.aisleId.value : this.aisleId,
      plannedQuantity: data.plannedQuantity.present
          ? data.plannedQuantity.value
          : this.plannedQuantity,
      plannedUnitCode: data.plannedUnitCode.present
          ? data.plannedUnitCode.value
          : this.plannedUnitCode,
      pricingInputMode: data.pricingInputMode.present
          ? data.pricingInputMode.value
          : this.pricingInputMode,
      plannedUnitPrice: data.plannedUnitPrice.present
          ? data.plannedUnitPrice.value
          : this.plannedUnitPrice,
      plannedLineTotalMinorUnits: data.plannedLineTotalMinorUnits.present
          ? data.plannedLineTotalMinorUnits.value
          : this.plannedLineTotalMinorUnits,
      maxAcceptablePrice: data.maxAcceptablePrice.present
          ? data.maxAcceptablePrice.value
          : this.maxAcceptablePrice,
      requiredFlag: data.requiredFlag.present
          ? data.requiredFlag.value
          : this.requiredFlag,
      note: data.note.present ? data.note.value : this.note,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlannedItem(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('brand: $brand, ')
          ..write('categoryId: $categoryId, ')
          ..write('aisleId: $aisleId, ')
          ..write('plannedQuantity: $plannedQuantity, ')
          ..write('plannedUnitCode: $plannedUnitCode, ')
          ..write('pricingInputMode: $pricingInputMode, ')
          ..write('plannedUnitPrice: $plannedUnitPrice, ')
          ..write('plannedLineTotalMinorUnits: $plannedLineTotalMinorUnits, ')
          ..write('maxAcceptablePrice: $maxAcceptablePrice, ')
          ..write('requiredFlag: $requiredFlag, ')
          ..write('note: $note, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    listId,
    productId,
    name,
    normalizedName,
    brand,
    categoryId,
    aisleId,
    plannedQuantity,
    plannedUnitCode,
    pricingInputMode,
    plannedUnitPrice,
    plannedLineTotalMinorUnits,
    maxAcceptablePrice,
    requiredFlag,
    note,
    sortOrder,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlannedItem &&
          other.id == this.id &&
          other.listId == this.listId &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.brand == this.brand &&
          other.categoryId == this.categoryId &&
          other.aisleId == this.aisleId &&
          other.plannedQuantity == this.plannedQuantity &&
          other.plannedUnitCode == this.plannedUnitCode &&
          other.pricingInputMode == this.pricingInputMode &&
          other.plannedUnitPrice == this.plannedUnitPrice &&
          other.plannedLineTotalMinorUnits == this.plannedLineTotalMinorUnits &&
          other.maxAcceptablePrice == this.maxAcceptablePrice &&
          other.requiredFlag == this.requiredFlag &&
          other.note == this.note &&
          other.sortOrder == this.sortOrder &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlannedItemsCompanion extends UpdateCompanion<PlannedItem> {
  final Value<int> id;
  final Value<int> listId;
  final Value<int?> productId;
  final Value<String> name;
  final Value<String> normalizedName;
  final Value<String?> brand;
  final Value<int?> categoryId;
  final Value<int?> aisleId;
  final Value<String> plannedQuantity;
  final Value<String> plannedUnitCode;
  final Value<String> pricingInputMode;
  final Value<String?> plannedUnitPrice;
  final Value<int?> plannedLineTotalMinorUnits;
  final Value<String?> maxAcceptablePrice;
  final Value<bool> requiredFlag;
  final Value<String?> note;
  final Value<int> sortOrder;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PlannedItemsCompanion({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.brand = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.aisleId = const Value.absent(),
    this.plannedQuantity = const Value.absent(),
    this.plannedUnitCode = const Value.absent(),
    this.pricingInputMode = const Value.absent(),
    this.plannedUnitPrice = const Value.absent(),
    this.plannedLineTotalMinorUnits = const Value.absent(),
    this.maxAcceptablePrice = const Value.absent(),
    this.requiredFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlannedItemsCompanion.insert({
    this.id = const Value.absent(),
    required int listId,
    this.productId = const Value.absent(),
    required String name,
    required String normalizedName,
    this.brand = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.aisleId = const Value.absent(),
    required String plannedQuantity,
    required String plannedUnitCode,
    required String pricingInputMode,
    this.plannedUnitPrice = const Value.absent(),
    this.plannedLineTotalMinorUnits = const Value.absent(),
    this.maxAcceptablePrice = const Value.absent(),
    this.requiredFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : listId = Value(listId),
       name = Value(name),
       normalizedName = Value(normalizedName),
       plannedQuantity = Value(plannedQuantity),
       plannedUnitCode = Value(plannedUnitCode),
       pricingInputMode = Value(pricingInputMode);
  static Insertable<PlannedItem> custom({
    Expression<int>? id,
    Expression<int>? listId,
    Expression<int>? productId,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? brand,
    Expression<int>? categoryId,
    Expression<int>? aisleId,
    Expression<String>? plannedQuantity,
    Expression<String>? plannedUnitCode,
    Expression<String>? pricingInputMode,
    Expression<String>? plannedUnitPrice,
    Expression<int>? plannedLineTotalMinorUnits,
    Expression<String>? maxAcceptablePrice,
    Expression<bool>? requiredFlag,
    Expression<String>? note,
    Expression<int>? sortOrder,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listId != null) 'list_id': listId,
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (brand != null) 'brand': brand,
      if (categoryId != null) 'category_id': categoryId,
      if (aisleId != null) 'aisle_id': aisleId,
      if (plannedQuantity != null) 'planned_quantity': plannedQuantity,
      if (plannedUnitCode != null) 'planned_unit_code': plannedUnitCode,
      if (pricingInputMode != null) 'pricing_input_mode': pricingInputMode,
      if (plannedUnitPrice != null) 'planned_unit_price': plannedUnitPrice,
      if (plannedLineTotalMinorUnits != null)
        'planned_line_total_minor_units': plannedLineTotalMinorUnits,
      if (maxAcceptablePrice != null)
        'max_acceptable_price': maxAcceptablePrice,
      if (requiredFlag != null) 'required_flag': requiredFlag,
      if (note != null) 'note': note,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlannedItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? listId,
    Value<int?>? productId,
    Value<String>? name,
    Value<String>? normalizedName,
    Value<String?>? brand,
    Value<int?>? categoryId,
    Value<int?>? aisleId,
    Value<String>? plannedQuantity,
    Value<String>? plannedUnitCode,
    Value<String>? pricingInputMode,
    Value<String?>? plannedUnitPrice,
    Value<int?>? plannedLineTotalMinorUnits,
    Value<String?>? maxAcceptablePrice,
    Value<bool>? requiredFlag,
    Value<String?>? note,
    Value<int>? sortOrder,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PlannedItemsCompanion(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      brand: brand ?? this.brand,
      categoryId: categoryId ?? this.categoryId,
      aisleId: aisleId ?? this.aisleId,
      plannedQuantity: plannedQuantity ?? this.plannedQuantity,
      plannedUnitCode: plannedUnitCode ?? this.plannedUnitCode,
      pricingInputMode: pricingInputMode ?? this.pricingInputMode,
      plannedUnitPrice: plannedUnitPrice ?? this.plannedUnitPrice,
      plannedLineTotalMinorUnits:
          plannedLineTotalMinorUnits ?? this.plannedLineTotalMinorUnits,
      maxAcceptablePrice: maxAcceptablePrice ?? this.maxAcceptablePrice,
      requiredFlag: requiredFlag ?? this.requiredFlag,
      note: note ?? this.note,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<int>(listId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (aisleId.present) {
      map['aisle_id'] = Variable<int>(aisleId.value);
    }
    if (plannedQuantity.present) {
      map['planned_quantity'] = Variable<String>(plannedQuantity.value);
    }
    if (plannedUnitCode.present) {
      map['planned_unit_code'] = Variable<String>(plannedUnitCode.value);
    }
    if (pricingInputMode.present) {
      map['pricing_input_mode'] = Variable<String>(pricingInputMode.value);
    }
    if (plannedUnitPrice.present) {
      map['planned_unit_price'] = Variable<String>(plannedUnitPrice.value);
    }
    if (plannedLineTotalMinorUnits.present) {
      map['planned_line_total_minor_units'] = Variable<int>(
        plannedLineTotalMinorUnits.value,
      );
    }
    if (maxAcceptablePrice.present) {
      map['max_acceptable_price'] = Variable<String>(maxAcceptablePrice.value);
    }
    if (requiredFlag.present) {
      map['required_flag'] = Variable<bool>(requiredFlag.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlannedItemsCompanion(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('brand: $brand, ')
          ..write('categoryId: $categoryId, ')
          ..write('aisleId: $aisleId, ')
          ..write('plannedQuantity: $plannedQuantity, ')
          ..write('plannedUnitCode: $plannedUnitCode, ')
          ..write('pricingInputMode: $pricingInputMode, ')
          ..write('plannedUnitPrice: $plannedUnitPrice, ')
          ..write('plannedLineTotalMinorUnits: $plannedLineTotalMinorUnits, ')
          ..write('maxAcceptablePrice: $maxAcceptablePrice, ')
          ..write('requiredFlag: $requiredFlag, ')
          ..write('note: $note, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _listIdMeta = const VerificationMeta('listId');
  @override
  late final GeneratedColumn<int> listId = GeneratedColumn<int>(
    'list_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shopping_lists (id) ON DELETE SET NULL',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> imagePaths =
      GeneratedColumn<String>(
        'image_paths',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<String>>($ReceiptsTable.$converterimagePaths);
  static const VerificationMeta _rawOcrTextMeta = const VerificationMeta(
    'rawOcrText',
  );
  @override
  late final GeneratedColumn<String> rawOcrText = GeneratedColumn<String>(
    'raw_ocr_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detectedStoreMeta = const VerificationMeta(
    'detectedStore',
  );
  @override
  late final GeneratedColumn<String> detectedStore = GeneratedColumn<String>(
    'detected_store',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confirmedStoreMeta = const VerificationMeta(
    'confirmedStore',
  );
  @override
  late final GeneratedColumn<String> confirmedStore = GeneratedColumn<String>(
    'confirmed_store',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detectedAtMeta = const VerificationMeta(
    'detectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> detectedAt = GeneratedColumn<DateTime>(
    'detected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confirmedAtMeta = const VerificationMeta(
    'confirmedAt',
  );
  @override
  late final GeneratedColumn<DateTime> confirmedAt = GeneratedColumn<DateTime>(
    'confirmed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detectedCurrencyMeta = const VerificationMeta(
    'detectedCurrency',
  );
  @override
  late final GeneratedColumn<String> detectedCurrency = GeneratedColumn<String>(
    'detected_currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confirmedCurrencyMeta = const VerificationMeta(
    'confirmedCurrency',
  );
  @override
  late final GeneratedColumn<String> confirmedCurrency =
      GeneratedColumn<String>(
        'confirmed_currency',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _detectedTotalMinorUnitsMeta =
      const VerificationMeta('detectedTotalMinorUnits');
  @override
  late final GeneratedColumn<int> detectedTotalMinorUnits =
      GeneratedColumn<int>(
        'detected_total_minor_units',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _confirmedTotalMinorUnitsMeta =
      const VerificationMeta('confirmedTotalMinorUnits');
  @override
  late final GeneratedColumn<int> confirmedTotalMinorUnits =
      GeneratedColumn<int>(
        'confirmed_total_minor_units',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _parserVersionMeta = const VerificationMeta(
    'parserVersion',
  );
  @override
  late final GeneratedColumn<String> parserVersion = GeneratedColumn<String>(
    'parser_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processingStatusMeta = const VerificationMeta(
    'processingStatus',
  );
  @override
  late final GeneratedColumn<String> processingStatus = GeneratedColumn<String>(
    'processing_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listId,
    imagePaths,
    rawOcrText,
    detectedStore,
    confirmedStore,
    detectedAt,
    confirmedAt,
    detectedCurrency,
    confirmedCurrency,
    detectedTotalMinorUnits,
    confirmedTotalMinorUnits,
    parserVersion,
    processingStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('list_id')) {
      context.handle(
        _listIdMeta,
        listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta),
      );
    }
    if (data.containsKey('raw_ocr_text')) {
      context.handle(
        _rawOcrTextMeta,
        rawOcrText.isAcceptableOrUnknown(
          data['raw_ocr_text']!,
          _rawOcrTextMeta,
        ),
      );
    }
    if (data.containsKey('detected_store')) {
      context.handle(
        _detectedStoreMeta,
        detectedStore.isAcceptableOrUnknown(
          data['detected_store']!,
          _detectedStoreMeta,
        ),
      );
    }
    if (data.containsKey('confirmed_store')) {
      context.handle(
        _confirmedStoreMeta,
        confirmedStore.isAcceptableOrUnknown(
          data['confirmed_store']!,
          _confirmedStoreMeta,
        ),
      );
    }
    if (data.containsKey('detected_at')) {
      context.handle(
        _detectedAtMeta,
        detectedAt.isAcceptableOrUnknown(data['detected_at']!, _detectedAtMeta),
      );
    }
    if (data.containsKey('confirmed_at')) {
      context.handle(
        _confirmedAtMeta,
        confirmedAt.isAcceptableOrUnknown(
          data['confirmed_at']!,
          _confirmedAtMeta,
        ),
      );
    }
    if (data.containsKey('detected_currency')) {
      context.handle(
        _detectedCurrencyMeta,
        detectedCurrency.isAcceptableOrUnknown(
          data['detected_currency']!,
          _detectedCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('confirmed_currency')) {
      context.handle(
        _confirmedCurrencyMeta,
        confirmedCurrency.isAcceptableOrUnknown(
          data['confirmed_currency']!,
          _confirmedCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('detected_total_minor_units')) {
      context.handle(
        _detectedTotalMinorUnitsMeta,
        detectedTotalMinorUnits.isAcceptableOrUnknown(
          data['detected_total_minor_units']!,
          _detectedTotalMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('confirmed_total_minor_units')) {
      context.handle(
        _confirmedTotalMinorUnitsMeta,
        confirmedTotalMinorUnits.isAcceptableOrUnknown(
          data['confirmed_total_minor_units']!,
          _confirmedTotalMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('parser_version')) {
      context.handle(
        _parserVersionMeta,
        parserVersion.isAcceptableOrUnknown(
          data['parser_version']!,
          _parserVersionMeta,
        ),
      );
    }
    if (data.containsKey('processing_status')) {
      context.handle(
        _processingStatusMeta,
        processingStatus.isAcceptableOrUnknown(
          data['processing_status']!,
          _processingStatusMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      listId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}list_id'],
      ),
      imagePaths: $ReceiptsTable.$converterimagePaths.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}image_paths'],
        )!,
      ),
      rawOcrText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_ocr_text'],
      ),
      detectedStore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detected_store'],
      ),
      confirmedStore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confirmed_store'],
      ),
      detectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}detected_at'],
      ),
      confirmedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}confirmed_at'],
      ),
      detectedCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detected_currency'],
      ),
      confirmedCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confirmed_currency'],
      ),
      detectedTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}detected_total_minor_units'],
      ),
      confirmedTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confirmed_total_minor_units'],
      ),
      parserVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parser_version'],
      ),
      processingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterimagePaths =
      const _StringListConverter();
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final int? listId;

  /// JSON dizisi: ["path1", "path2", ...] (uzun fiş: çok fotoğraf).
  final List<String> imagePaths;
  final String? rawOcrText;
  final String? detectedStore;
  final String? confirmedStore;
  final DateTime? detectedAt;
  final DateTime? confirmedAt;
  final String? detectedCurrency;
  final String? confirmedCurrency;
  final int? detectedTotalMinorUnits;
  final int? confirmedTotalMinorUnits;
  final String? parserVersion;

  /// pending | ocrDone | reviewed | error
  final String processingStatus;
  final DateTime createdAt;
  const Receipt({
    required this.id,
    this.listId,
    required this.imagePaths,
    this.rawOcrText,
    this.detectedStore,
    this.confirmedStore,
    this.detectedAt,
    this.confirmedAt,
    this.detectedCurrency,
    this.confirmedCurrency,
    this.detectedTotalMinorUnits,
    this.confirmedTotalMinorUnits,
    this.parserVersion,
    required this.processingStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || listId != null) {
      map['list_id'] = Variable<int>(listId);
    }
    {
      map['image_paths'] = Variable<String>(
        $ReceiptsTable.$converterimagePaths.toSql(imagePaths),
      );
    }
    if (!nullToAbsent || rawOcrText != null) {
      map['raw_ocr_text'] = Variable<String>(rawOcrText);
    }
    if (!nullToAbsent || detectedStore != null) {
      map['detected_store'] = Variable<String>(detectedStore);
    }
    if (!nullToAbsent || confirmedStore != null) {
      map['confirmed_store'] = Variable<String>(confirmedStore);
    }
    if (!nullToAbsent || detectedAt != null) {
      map['detected_at'] = Variable<DateTime>(detectedAt);
    }
    if (!nullToAbsent || confirmedAt != null) {
      map['confirmed_at'] = Variable<DateTime>(confirmedAt);
    }
    if (!nullToAbsent || detectedCurrency != null) {
      map['detected_currency'] = Variable<String>(detectedCurrency);
    }
    if (!nullToAbsent || confirmedCurrency != null) {
      map['confirmed_currency'] = Variable<String>(confirmedCurrency);
    }
    if (!nullToAbsent || detectedTotalMinorUnits != null) {
      map['detected_total_minor_units'] = Variable<int>(
        detectedTotalMinorUnits,
      );
    }
    if (!nullToAbsent || confirmedTotalMinorUnits != null) {
      map['confirmed_total_minor_units'] = Variable<int>(
        confirmedTotalMinorUnits,
      );
    }
    if (!nullToAbsent || parserVersion != null) {
      map['parser_version'] = Variable<String>(parserVersion);
    }
    map['processing_status'] = Variable<String>(processingStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      listId: listId == null && nullToAbsent
          ? const Value.absent()
          : Value(listId),
      imagePaths: Value(imagePaths),
      rawOcrText: rawOcrText == null && nullToAbsent
          ? const Value.absent()
          : Value(rawOcrText),
      detectedStore: detectedStore == null && nullToAbsent
          ? const Value.absent()
          : Value(detectedStore),
      confirmedStore: confirmedStore == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedStore),
      detectedAt: detectedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(detectedAt),
      confirmedAt: confirmedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedAt),
      detectedCurrency: detectedCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(detectedCurrency),
      confirmedCurrency: confirmedCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedCurrency),
      detectedTotalMinorUnits: detectedTotalMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(detectedTotalMinorUnits),
      confirmedTotalMinorUnits: confirmedTotalMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedTotalMinorUnits),
      parserVersion: parserVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(parserVersion),
      processingStatus: Value(processingStatus),
      createdAt: Value(createdAt),
    );
  }

  factory Receipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      listId: serializer.fromJson<int?>(json['listId']),
      imagePaths: serializer.fromJson<List<String>>(json['imagePaths']),
      rawOcrText: serializer.fromJson<String?>(json['rawOcrText']),
      detectedStore: serializer.fromJson<String?>(json['detectedStore']),
      confirmedStore: serializer.fromJson<String?>(json['confirmedStore']),
      detectedAt: serializer.fromJson<DateTime?>(json['detectedAt']),
      confirmedAt: serializer.fromJson<DateTime?>(json['confirmedAt']),
      detectedCurrency: serializer.fromJson<String?>(json['detectedCurrency']),
      confirmedCurrency: serializer.fromJson<String?>(
        json['confirmedCurrency'],
      ),
      detectedTotalMinorUnits: serializer.fromJson<int?>(
        json['detectedTotalMinorUnits'],
      ),
      confirmedTotalMinorUnits: serializer.fromJson<int?>(
        json['confirmedTotalMinorUnits'],
      ),
      parserVersion: serializer.fromJson<String?>(json['parserVersion']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'listId': serializer.toJson<int?>(listId),
      'imagePaths': serializer.toJson<List<String>>(imagePaths),
      'rawOcrText': serializer.toJson<String?>(rawOcrText),
      'detectedStore': serializer.toJson<String?>(detectedStore),
      'confirmedStore': serializer.toJson<String?>(confirmedStore),
      'detectedAt': serializer.toJson<DateTime?>(detectedAt),
      'confirmedAt': serializer.toJson<DateTime?>(confirmedAt),
      'detectedCurrency': serializer.toJson<String?>(detectedCurrency),
      'confirmedCurrency': serializer.toJson<String?>(confirmedCurrency),
      'detectedTotalMinorUnits': serializer.toJson<int?>(
        detectedTotalMinorUnits,
      ),
      'confirmedTotalMinorUnits': serializer.toJson<int?>(
        confirmedTotalMinorUnits,
      ),
      'parserVersion': serializer.toJson<String?>(parserVersion),
      'processingStatus': serializer.toJson<String>(processingStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Receipt copyWith({
    int? id,
    Value<int?> listId = const Value.absent(),
    List<String>? imagePaths,
    Value<String?> rawOcrText = const Value.absent(),
    Value<String?> detectedStore = const Value.absent(),
    Value<String?> confirmedStore = const Value.absent(),
    Value<DateTime?> detectedAt = const Value.absent(),
    Value<DateTime?> confirmedAt = const Value.absent(),
    Value<String?> detectedCurrency = const Value.absent(),
    Value<String?> confirmedCurrency = const Value.absent(),
    Value<int?> detectedTotalMinorUnits = const Value.absent(),
    Value<int?> confirmedTotalMinorUnits = const Value.absent(),
    Value<String?> parserVersion = const Value.absent(),
    String? processingStatus,
    DateTime? createdAt,
  }) => Receipt(
    id: id ?? this.id,
    listId: listId.present ? listId.value : this.listId,
    imagePaths: imagePaths ?? this.imagePaths,
    rawOcrText: rawOcrText.present ? rawOcrText.value : this.rawOcrText,
    detectedStore: detectedStore.present
        ? detectedStore.value
        : this.detectedStore,
    confirmedStore: confirmedStore.present
        ? confirmedStore.value
        : this.confirmedStore,
    detectedAt: detectedAt.present ? detectedAt.value : this.detectedAt,
    confirmedAt: confirmedAt.present ? confirmedAt.value : this.confirmedAt,
    detectedCurrency: detectedCurrency.present
        ? detectedCurrency.value
        : this.detectedCurrency,
    confirmedCurrency: confirmedCurrency.present
        ? confirmedCurrency.value
        : this.confirmedCurrency,
    detectedTotalMinorUnits: detectedTotalMinorUnits.present
        ? detectedTotalMinorUnits.value
        : this.detectedTotalMinorUnits,
    confirmedTotalMinorUnits: confirmedTotalMinorUnits.present
        ? confirmedTotalMinorUnits.value
        : this.confirmedTotalMinorUnits,
    parserVersion: parserVersion.present
        ? parserVersion.value
        : this.parserVersion,
    processingStatus: processingStatus ?? this.processingStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      listId: data.listId.present ? data.listId.value : this.listId,
      imagePaths: data.imagePaths.present
          ? data.imagePaths.value
          : this.imagePaths,
      rawOcrText: data.rawOcrText.present
          ? data.rawOcrText.value
          : this.rawOcrText,
      detectedStore: data.detectedStore.present
          ? data.detectedStore.value
          : this.detectedStore,
      confirmedStore: data.confirmedStore.present
          ? data.confirmedStore.value
          : this.confirmedStore,
      detectedAt: data.detectedAt.present
          ? data.detectedAt.value
          : this.detectedAt,
      confirmedAt: data.confirmedAt.present
          ? data.confirmedAt.value
          : this.confirmedAt,
      detectedCurrency: data.detectedCurrency.present
          ? data.detectedCurrency.value
          : this.detectedCurrency,
      confirmedCurrency: data.confirmedCurrency.present
          ? data.confirmedCurrency.value
          : this.confirmedCurrency,
      detectedTotalMinorUnits: data.detectedTotalMinorUnits.present
          ? data.detectedTotalMinorUnits.value
          : this.detectedTotalMinorUnits,
      confirmedTotalMinorUnits: data.confirmedTotalMinorUnits.present
          ? data.confirmedTotalMinorUnits.value
          : this.confirmedTotalMinorUnits,
      parserVersion: data.parserVersion.present
          ? data.parserVersion.value
          : this.parserVersion,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('imagePaths: $imagePaths, ')
          ..write('rawOcrText: $rawOcrText, ')
          ..write('detectedStore: $detectedStore, ')
          ..write('confirmedStore: $confirmedStore, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('detectedCurrency: $detectedCurrency, ')
          ..write('confirmedCurrency: $confirmedCurrency, ')
          ..write('detectedTotalMinorUnits: $detectedTotalMinorUnits, ')
          ..write('confirmedTotalMinorUnits: $confirmedTotalMinorUnits, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    listId,
    imagePaths,
    rawOcrText,
    detectedStore,
    confirmedStore,
    detectedAt,
    confirmedAt,
    detectedCurrency,
    confirmedCurrency,
    detectedTotalMinorUnits,
    confirmedTotalMinorUnits,
    parserVersion,
    processingStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.listId == this.listId &&
          other.imagePaths == this.imagePaths &&
          other.rawOcrText == this.rawOcrText &&
          other.detectedStore == this.detectedStore &&
          other.confirmedStore == this.confirmedStore &&
          other.detectedAt == this.detectedAt &&
          other.confirmedAt == this.confirmedAt &&
          other.detectedCurrency == this.detectedCurrency &&
          other.confirmedCurrency == this.confirmedCurrency &&
          other.detectedTotalMinorUnits == this.detectedTotalMinorUnits &&
          other.confirmedTotalMinorUnits == this.confirmedTotalMinorUnits &&
          other.parserVersion == this.parserVersion &&
          other.processingStatus == this.processingStatus &&
          other.createdAt == this.createdAt);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<int?> listId;
  final Value<List<String>> imagePaths;
  final Value<String?> rawOcrText;
  final Value<String?> detectedStore;
  final Value<String?> confirmedStore;
  final Value<DateTime?> detectedAt;
  final Value<DateTime?> confirmedAt;
  final Value<String?> detectedCurrency;
  final Value<String?> confirmedCurrency;
  final Value<int?> detectedTotalMinorUnits;
  final Value<int?> confirmedTotalMinorUnits;
  final Value<String?> parserVersion;
  final Value<String> processingStatus;
  final Value<DateTime> createdAt;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.imagePaths = const Value.absent(),
    this.rawOcrText = const Value.absent(),
    this.detectedStore = const Value.absent(),
    this.confirmedStore = const Value.absent(),
    this.detectedAt = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    this.detectedCurrency = const Value.absent(),
    this.confirmedCurrency = const Value.absent(),
    this.detectedTotalMinorUnits = const Value.absent(),
    this.confirmedTotalMinorUnits = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.imagePaths = const Value.absent(),
    this.rawOcrText = const Value.absent(),
    this.detectedStore = const Value.absent(),
    this.confirmedStore = const Value.absent(),
    this.detectedAt = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    this.detectedCurrency = const Value.absent(),
    this.confirmedCurrency = const Value.absent(),
    this.detectedTotalMinorUnits = const Value.absent(),
    this.confirmedTotalMinorUnits = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Receipt> custom({
    Expression<int>? id,
    Expression<int>? listId,
    Expression<String>? imagePaths,
    Expression<String>? rawOcrText,
    Expression<String>? detectedStore,
    Expression<String>? confirmedStore,
    Expression<DateTime>? detectedAt,
    Expression<DateTime>? confirmedAt,
    Expression<String>? detectedCurrency,
    Expression<String>? confirmedCurrency,
    Expression<int>? detectedTotalMinorUnits,
    Expression<int>? confirmedTotalMinorUnits,
    Expression<String>? parserVersion,
    Expression<String>? processingStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listId != null) 'list_id': listId,
      if (imagePaths != null) 'image_paths': imagePaths,
      if (rawOcrText != null) 'raw_ocr_text': rawOcrText,
      if (detectedStore != null) 'detected_store': detectedStore,
      if (confirmedStore != null) 'confirmed_store': confirmedStore,
      if (detectedAt != null) 'detected_at': detectedAt,
      if (confirmedAt != null) 'confirmed_at': confirmedAt,
      if (detectedCurrency != null) 'detected_currency': detectedCurrency,
      if (confirmedCurrency != null) 'confirmed_currency': confirmedCurrency,
      if (detectedTotalMinorUnits != null)
        'detected_total_minor_units': detectedTotalMinorUnits,
      if (confirmedTotalMinorUnits != null)
        'confirmed_total_minor_units': confirmedTotalMinorUnits,
      if (parserVersion != null) 'parser_version': parserVersion,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReceiptsCompanion copyWith({
    Value<int>? id,
    Value<int?>? listId,
    Value<List<String>>? imagePaths,
    Value<String?>? rawOcrText,
    Value<String?>? detectedStore,
    Value<String?>? confirmedStore,
    Value<DateTime?>? detectedAt,
    Value<DateTime?>? confirmedAt,
    Value<String?>? detectedCurrency,
    Value<String?>? confirmedCurrency,
    Value<int?>? detectedTotalMinorUnits,
    Value<int?>? confirmedTotalMinorUnits,
    Value<String?>? parserVersion,
    Value<String>? processingStatus,
    Value<DateTime>? createdAt,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      imagePaths: imagePaths ?? this.imagePaths,
      rawOcrText: rawOcrText ?? this.rawOcrText,
      detectedStore: detectedStore ?? this.detectedStore,
      confirmedStore: confirmedStore ?? this.confirmedStore,
      detectedAt: detectedAt ?? this.detectedAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      detectedCurrency: detectedCurrency ?? this.detectedCurrency,
      confirmedCurrency: confirmedCurrency ?? this.confirmedCurrency,
      detectedTotalMinorUnits:
          detectedTotalMinorUnits ?? this.detectedTotalMinorUnits,
      confirmedTotalMinorUnits:
          confirmedTotalMinorUnits ?? this.confirmedTotalMinorUnits,
      parserVersion: parserVersion ?? this.parserVersion,
      processingStatus: processingStatus ?? this.processingStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<int>(listId.value);
    }
    if (imagePaths.present) {
      map['image_paths'] = Variable<String>(
        $ReceiptsTable.$converterimagePaths.toSql(imagePaths.value),
      );
    }
    if (rawOcrText.present) {
      map['raw_ocr_text'] = Variable<String>(rawOcrText.value);
    }
    if (detectedStore.present) {
      map['detected_store'] = Variable<String>(detectedStore.value);
    }
    if (confirmedStore.present) {
      map['confirmed_store'] = Variable<String>(confirmedStore.value);
    }
    if (detectedAt.present) {
      map['detected_at'] = Variable<DateTime>(detectedAt.value);
    }
    if (confirmedAt.present) {
      map['confirmed_at'] = Variable<DateTime>(confirmedAt.value);
    }
    if (detectedCurrency.present) {
      map['detected_currency'] = Variable<String>(detectedCurrency.value);
    }
    if (confirmedCurrency.present) {
      map['confirmed_currency'] = Variable<String>(confirmedCurrency.value);
    }
    if (detectedTotalMinorUnits.present) {
      map['detected_total_minor_units'] = Variable<int>(
        detectedTotalMinorUnits.value,
      );
    }
    if (confirmedTotalMinorUnits.present) {
      map['confirmed_total_minor_units'] = Variable<int>(
        confirmedTotalMinorUnits.value,
      );
    }
    if (parserVersion.present) {
      map['parser_version'] = Variable<String>(parserVersion.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = Variable<String>(processingStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('imagePaths: $imagePaths, ')
          ..write('rawOcrText: $rawOcrText, ')
          ..write('detectedStore: $detectedStore, ')
          ..write('confirmedStore: $confirmedStore, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('detectedCurrency: $detectedCurrency, ')
          ..write('confirmedCurrency: $confirmedCurrency, ')
          ..write('detectedTotalMinorUnits: $detectedTotalMinorUnits, ')
          ..write('confirmedTotalMinorUnits: $confirmedTotalMinorUnits, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseEntriesTable extends PurchaseEntries
    with TableInfo<$PurchaseEntriesTable, PurchaseEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _listIdMeta = const VerificationMeta('listId');
  @override
  late final GeneratedColumn<int> listId = GeneratedColumn<int>(
    'list_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shopping_lists (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _plannedItemIdMeta = const VerificationMeta(
    'plannedItemId',
  );
  @override
  late final GeneratedColumn<int> plannedItemId = GeneratedColumn<int>(
    'planned_item_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES planned_items (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _receiptIdMeta = const VerificationMeta(
    'receiptId',
  );
  @override
  late final GeneratedColumn<int> receiptId = GeneratedColumn<int>(
    'receipt_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES receipts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualQuantityMeta = const VerificationMeta(
    'actualQuantity',
  );
  @override
  late final GeneratedColumn<String> actualQuantity = GeneratedColumn<String>(
    'actual_quantity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualUnitCodeMeta = const VerificationMeta(
    'actualUnitCode',
  );
  @override
  late final GeneratedColumn<String> actualUnitCode = GeneratedColumn<String>(
    'actual_unit_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualUnitPriceMeta = const VerificationMeta(
    'actualUnitPrice',
  );
  @override
  late final GeneratedColumn<String> actualUnitPrice = GeneratedColumn<String>(
    'actual_unit_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grossTotalMinorUnitsMeta =
      const VerificationMeta('grossTotalMinorUnits');
  @override
  late final GeneratedColumn<int> grossTotalMinorUnits = GeneratedColumn<int>(
    'gross_total_minor_units',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discountMinorUnitsMeta =
      const VerificationMeta('discountMinorUnits');
  @override
  late final GeneratedColumn<int> discountMinorUnits = GeneratedColumn<int>(
    'discount_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _actualLineTotalMinorUnitsMeta =
      const VerificationMeta('actualLineTotalMinorUnits');
  @override
  late final GeneratedColumn<int> actualLineTotalMinorUnits =
      GeneratedColumn<int>(
        'actual_line_total_minor_units',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<String> confidence = GeneratedColumn<String>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userConfirmedMeta = const VerificationMeta(
    'userConfirmed',
  );
  @override
  late final GeneratedColumn<bool> userConfirmed = GeneratedColumn<bool>(
    'user_confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("user_confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _alternativeFlagMeta = const VerificationMeta(
    'alternativeFlag',
  );
  @override
  late final GeneratedColumn<bool> alternativeFlag = GeneratedColumn<bool>(
    'alternative_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("alternative_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listId,
    plannedItemId,
    receiptId,
    name,
    normalizedName,
    actualQuantity,
    actualUnitCode,
    actualUnitPrice,
    grossTotalMinorUnits,
    discountMinorUnits,
    actualLineTotalMinorUnits,
    source,
    confidence,
    userConfirmed,
    alternativeFlag,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('list_id')) {
      context.handle(
        _listIdMeta,
        listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listIdMeta);
    }
    if (data.containsKey('planned_item_id')) {
      context.handle(
        _plannedItemIdMeta,
        plannedItemId.isAcceptableOrUnknown(
          data['planned_item_id']!,
          _plannedItemIdMeta,
        ),
      );
    }
    if (data.containsKey('receipt_id')) {
      context.handle(
        _receiptIdMeta,
        receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('actual_quantity')) {
      context.handle(
        _actualQuantityMeta,
        actualQuantity.isAcceptableOrUnknown(
          data['actual_quantity']!,
          _actualQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualQuantityMeta);
    }
    if (data.containsKey('actual_unit_code')) {
      context.handle(
        _actualUnitCodeMeta,
        actualUnitCode.isAcceptableOrUnknown(
          data['actual_unit_code']!,
          _actualUnitCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualUnitCodeMeta);
    }
    if (data.containsKey('actual_unit_price')) {
      context.handle(
        _actualUnitPriceMeta,
        actualUnitPrice.isAcceptableOrUnknown(
          data['actual_unit_price']!,
          _actualUnitPriceMeta,
        ),
      );
    }
    if (data.containsKey('gross_total_minor_units')) {
      context.handle(
        _grossTotalMinorUnitsMeta,
        grossTotalMinorUnits.isAcceptableOrUnknown(
          data['gross_total_minor_units']!,
          _grossTotalMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('discount_minor_units')) {
      context.handle(
        _discountMinorUnitsMeta,
        discountMinorUnits.isAcceptableOrUnknown(
          data['discount_minor_units']!,
          _discountMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('actual_line_total_minor_units')) {
      context.handle(
        _actualLineTotalMinorUnitsMeta,
        actualLineTotalMinorUnits.isAcceptableOrUnknown(
          data['actual_line_total_minor_units']!,
          _actualLineTotalMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualLineTotalMinorUnitsMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('user_confirmed')) {
      context.handle(
        _userConfirmedMeta,
        userConfirmed.isAcceptableOrUnknown(
          data['user_confirmed']!,
          _userConfirmedMeta,
        ),
      );
    }
    if (data.containsKey('alternative_flag')) {
      context.handle(
        _alternativeFlagMeta,
        alternativeFlag.isAcceptableOrUnknown(
          data['alternative_flag']!,
          _alternativeFlagMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      listId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}list_id'],
      )!,
      plannedItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_item_id'],
      ),
      receiptId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receipt_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      actualQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actual_quantity'],
      )!,
      actualUnitCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actual_unit_code'],
      )!,
      actualUnitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actual_unit_price'],
      ),
      grossTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gross_total_minor_units'],
      ),
      discountMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_minor_units'],
      )!,
      actualLineTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_line_total_minor_units'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence'],
      ),
      userConfirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}user_confirmed'],
      )!,
      alternativeFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}alternative_flag'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PurchaseEntriesTable createAlias(String alias) {
    return $PurchaseEntriesTable(attachedDatabase, alias);
  }
}

class PurchaseEntry extends DataClass implements Insertable<PurchaseEntry> {
  final int id;
  final int listId;
  final int? plannedItemId;
  final int? receiptId;
  final String name;
  final String normalizedName;
  final String actualQuantity;
  final String actualUnitCode;
  final String? actualUnitPrice;
  final int? grossTotalMinorUnits;
  final int discountMinorUnits;
  final int actualLineTotalMinorUnits;

  /// manual | voice | shelfOcr | receiptOcr
  final String source;

  /// high | medium | low — null = elle giriş
  final String? confidence;
  final bool userConfirmed;
  final bool alternativeFlag;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PurchaseEntry({
    required this.id,
    required this.listId,
    this.plannedItemId,
    this.receiptId,
    required this.name,
    required this.normalizedName,
    required this.actualQuantity,
    required this.actualUnitCode,
    this.actualUnitPrice,
    this.grossTotalMinorUnits,
    required this.discountMinorUnits,
    required this.actualLineTotalMinorUnits,
    required this.source,
    this.confidence,
    required this.userConfirmed,
    required this.alternativeFlag,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['list_id'] = Variable<int>(listId);
    if (!nullToAbsent || plannedItemId != null) {
      map['planned_item_id'] = Variable<int>(plannedItemId);
    }
    if (!nullToAbsent || receiptId != null) {
      map['receipt_id'] = Variable<int>(receiptId);
    }
    map['name'] = Variable<String>(name);
    map['normalized_name'] = Variable<String>(normalizedName);
    map['actual_quantity'] = Variable<String>(actualQuantity);
    map['actual_unit_code'] = Variable<String>(actualUnitCode);
    if (!nullToAbsent || actualUnitPrice != null) {
      map['actual_unit_price'] = Variable<String>(actualUnitPrice);
    }
    if (!nullToAbsent || grossTotalMinorUnits != null) {
      map['gross_total_minor_units'] = Variable<int>(grossTotalMinorUnits);
    }
    map['discount_minor_units'] = Variable<int>(discountMinorUnits);
    map['actual_line_total_minor_units'] = Variable<int>(
      actualLineTotalMinorUnits,
    );
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<String>(confidence);
    }
    map['user_confirmed'] = Variable<bool>(userConfirmed);
    map['alternative_flag'] = Variable<bool>(alternativeFlag);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PurchaseEntriesCompanion toCompanion(bool nullToAbsent) {
    return PurchaseEntriesCompanion(
      id: Value(id),
      listId: Value(listId),
      plannedItemId: plannedItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedItemId),
      receiptId: receiptId == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptId),
      name: Value(name),
      normalizedName: Value(normalizedName),
      actualQuantity: Value(actualQuantity),
      actualUnitCode: Value(actualUnitCode),
      actualUnitPrice: actualUnitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(actualUnitPrice),
      grossTotalMinorUnits: grossTotalMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(grossTotalMinorUnits),
      discountMinorUnits: Value(discountMinorUnits),
      actualLineTotalMinorUnits: Value(actualLineTotalMinorUnits),
      source: Value(source),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      userConfirmed: Value(userConfirmed),
      alternativeFlag: Value(alternativeFlag),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PurchaseEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseEntry(
      id: serializer.fromJson<int>(json['id']),
      listId: serializer.fromJson<int>(json['listId']),
      plannedItemId: serializer.fromJson<int?>(json['plannedItemId']),
      receiptId: serializer.fromJson<int?>(json['receiptId']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      actualQuantity: serializer.fromJson<String>(json['actualQuantity']),
      actualUnitCode: serializer.fromJson<String>(json['actualUnitCode']),
      actualUnitPrice: serializer.fromJson<String?>(json['actualUnitPrice']),
      grossTotalMinorUnits: serializer.fromJson<int?>(
        json['grossTotalMinorUnits'],
      ),
      discountMinorUnits: serializer.fromJson<int>(json['discountMinorUnits']),
      actualLineTotalMinorUnits: serializer.fromJson<int>(
        json['actualLineTotalMinorUnits'],
      ),
      source: serializer.fromJson<String>(json['source']),
      confidence: serializer.fromJson<String?>(json['confidence']),
      userConfirmed: serializer.fromJson<bool>(json['userConfirmed']),
      alternativeFlag: serializer.fromJson<bool>(json['alternativeFlag']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'listId': serializer.toJson<int>(listId),
      'plannedItemId': serializer.toJson<int?>(plannedItemId),
      'receiptId': serializer.toJson<int?>(receiptId),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'actualQuantity': serializer.toJson<String>(actualQuantity),
      'actualUnitCode': serializer.toJson<String>(actualUnitCode),
      'actualUnitPrice': serializer.toJson<String?>(actualUnitPrice),
      'grossTotalMinorUnits': serializer.toJson<int?>(grossTotalMinorUnits),
      'discountMinorUnits': serializer.toJson<int>(discountMinorUnits),
      'actualLineTotalMinorUnits': serializer.toJson<int>(
        actualLineTotalMinorUnits,
      ),
      'source': serializer.toJson<String>(source),
      'confidence': serializer.toJson<String?>(confidence),
      'userConfirmed': serializer.toJson<bool>(userConfirmed),
      'alternativeFlag': serializer.toJson<bool>(alternativeFlag),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PurchaseEntry copyWith({
    int? id,
    int? listId,
    Value<int?> plannedItemId = const Value.absent(),
    Value<int?> receiptId = const Value.absent(),
    String? name,
    String? normalizedName,
    String? actualQuantity,
    String? actualUnitCode,
    Value<String?> actualUnitPrice = const Value.absent(),
    Value<int?> grossTotalMinorUnits = const Value.absent(),
    int? discountMinorUnits,
    int? actualLineTotalMinorUnits,
    String? source,
    Value<String?> confidence = const Value.absent(),
    bool? userConfirmed,
    bool? alternativeFlag,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PurchaseEntry(
    id: id ?? this.id,
    listId: listId ?? this.listId,
    plannedItemId: plannedItemId.present
        ? plannedItemId.value
        : this.plannedItemId,
    receiptId: receiptId.present ? receiptId.value : this.receiptId,
    name: name ?? this.name,
    normalizedName: normalizedName ?? this.normalizedName,
    actualQuantity: actualQuantity ?? this.actualQuantity,
    actualUnitCode: actualUnitCode ?? this.actualUnitCode,
    actualUnitPrice: actualUnitPrice.present
        ? actualUnitPrice.value
        : this.actualUnitPrice,
    grossTotalMinorUnits: grossTotalMinorUnits.present
        ? grossTotalMinorUnits.value
        : this.grossTotalMinorUnits,
    discountMinorUnits: discountMinorUnits ?? this.discountMinorUnits,
    actualLineTotalMinorUnits:
        actualLineTotalMinorUnits ?? this.actualLineTotalMinorUnits,
    source: source ?? this.source,
    confidence: confidence.present ? confidence.value : this.confidence,
    userConfirmed: userConfirmed ?? this.userConfirmed,
    alternativeFlag: alternativeFlag ?? this.alternativeFlag,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PurchaseEntry copyWithCompanion(PurchaseEntriesCompanion data) {
    return PurchaseEntry(
      id: data.id.present ? data.id.value : this.id,
      listId: data.listId.present ? data.listId.value : this.listId,
      plannedItemId: data.plannedItemId.present
          ? data.plannedItemId.value
          : this.plannedItemId,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      actualQuantity: data.actualQuantity.present
          ? data.actualQuantity.value
          : this.actualQuantity,
      actualUnitCode: data.actualUnitCode.present
          ? data.actualUnitCode.value
          : this.actualUnitCode,
      actualUnitPrice: data.actualUnitPrice.present
          ? data.actualUnitPrice.value
          : this.actualUnitPrice,
      grossTotalMinorUnits: data.grossTotalMinorUnits.present
          ? data.grossTotalMinorUnits.value
          : this.grossTotalMinorUnits,
      discountMinorUnits: data.discountMinorUnits.present
          ? data.discountMinorUnits.value
          : this.discountMinorUnits,
      actualLineTotalMinorUnits: data.actualLineTotalMinorUnits.present
          ? data.actualLineTotalMinorUnits.value
          : this.actualLineTotalMinorUnits,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      userConfirmed: data.userConfirmed.present
          ? data.userConfirmed.value
          : this.userConfirmed,
      alternativeFlag: data.alternativeFlag.present
          ? data.alternativeFlag.value
          : this.alternativeFlag,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseEntry(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('plannedItemId: $plannedItemId, ')
          ..write('receiptId: $receiptId, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('actualQuantity: $actualQuantity, ')
          ..write('actualUnitCode: $actualUnitCode, ')
          ..write('actualUnitPrice: $actualUnitPrice, ')
          ..write('grossTotalMinorUnits: $grossTotalMinorUnits, ')
          ..write('discountMinorUnits: $discountMinorUnits, ')
          ..write('actualLineTotalMinorUnits: $actualLineTotalMinorUnits, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('userConfirmed: $userConfirmed, ')
          ..write('alternativeFlag: $alternativeFlag, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    listId,
    plannedItemId,
    receiptId,
    name,
    normalizedName,
    actualQuantity,
    actualUnitCode,
    actualUnitPrice,
    grossTotalMinorUnits,
    discountMinorUnits,
    actualLineTotalMinorUnits,
    source,
    confidence,
    userConfirmed,
    alternativeFlag,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseEntry &&
          other.id == this.id &&
          other.listId == this.listId &&
          other.plannedItemId == this.plannedItemId &&
          other.receiptId == this.receiptId &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.actualQuantity == this.actualQuantity &&
          other.actualUnitCode == this.actualUnitCode &&
          other.actualUnitPrice == this.actualUnitPrice &&
          other.grossTotalMinorUnits == this.grossTotalMinorUnits &&
          other.discountMinorUnits == this.discountMinorUnits &&
          other.actualLineTotalMinorUnits == this.actualLineTotalMinorUnits &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.userConfirmed == this.userConfirmed &&
          other.alternativeFlag == this.alternativeFlag &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PurchaseEntriesCompanion extends UpdateCompanion<PurchaseEntry> {
  final Value<int> id;
  final Value<int> listId;
  final Value<int?> plannedItemId;
  final Value<int?> receiptId;
  final Value<String> name;
  final Value<String> normalizedName;
  final Value<String> actualQuantity;
  final Value<String> actualUnitCode;
  final Value<String?> actualUnitPrice;
  final Value<int?> grossTotalMinorUnits;
  final Value<int> discountMinorUnits;
  final Value<int> actualLineTotalMinorUnits;
  final Value<String> source;
  final Value<String?> confidence;
  final Value<bool> userConfirmed;
  final Value<bool> alternativeFlag;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PurchaseEntriesCompanion({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.plannedItemId = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.actualQuantity = const Value.absent(),
    this.actualUnitCode = const Value.absent(),
    this.actualUnitPrice = const Value.absent(),
    this.grossTotalMinorUnits = const Value.absent(),
    this.discountMinorUnits = const Value.absent(),
    this.actualLineTotalMinorUnits = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.userConfirmed = const Value.absent(),
    this.alternativeFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PurchaseEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int listId,
    this.plannedItemId = const Value.absent(),
    this.receiptId = const Value.absent(),
    required String name,
    required String normalizedName,
    required String actualQuantity,
    required String actualUnitCode,
    this.actualUnitPrice = const Value.absent(),
    this.grossTotalMinorUnits = const Value.absent(),
    this.discountMinorUnits = const Value.absent(),
    required int actualLineTotalMinorUnits,
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.userConfirmed = const Value.absent(),
    this.alternativeFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : listId = Value(listId),
       name = Value(name),
       normalizedName = Value(normalizedName),
       actualQuantity = Value(actualQuantity),
       actualUnitCode = Value(actualUnitCode),
       actualLineTotalMinorUnits = Value(actualLineTotalMinorUnits);
  static Insertable<PurchaseEntry> custom({
    Expression<int>? id,
    Expression<int>? listId,
    Expression<int>? plannedItemId,
    Expression<int>? receiptId,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? actualQuantity,
    Expression<String>? actualUnitCode,
    Expression<String>? actualUnitPrice,
    Expression<int>? grossTotalMinorUnits,
    Expression<int>? discountMinorUnits,
    Expression<int>? actualLineTotalMinorUnits,
    Expression<String>? source,
    Expression<String>? confidence,
    Expression<bool>? userConfirmed,
    Expression<bool>? alternativeFlag,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listId != null) 'list_id': listId,
      if (plannedItemId != null) 'planned_item_id': plannedItemId,
      if (receiptId != null) 'receipt_id': receiptId,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (actualQuantity != null) 'actual_quantity': actualQuantity,
      if (actualUnitCode != null) 'actual_unit_code': actualUnitCode,
      if (actualUnitPrice != null) 'actual_unit_price': actualUnitPrice,
      if (grossTotalMinorUnits != null)
        'gross_total_minor_units': grossTotalMinorUnits,
      if (discountMinorUnits != null)
        'discount_minor_units': discountMinorUnits,
      if (actualLineTotalMinorUnits != null)
        'actual_line_total_minor_units': actualLineTotalMinorUnits,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (userConfirmed != null) 'user_confirmed': userConfirmed,
      if (alternativeFlag != null) 'alternative_flag': alternativeFlag,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PurchaseEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? listId,
    Value<int?>? plannedItemId,
    Value<int?>? receiptId,
    Value<String>? name,
    Value<String>? normalizedName,
    Value<String>? actualQuantity,
    Value<String>? actualUnitCode,
    Value<String?>? actualUnitPrice,
    Value<int?>? grossTotalMinorUnits,
    Value<int>? discountMinorUnits,
    Value<int>? actualLineTotalMinorUnits,
    Value<String>? source,
    Value<String?>? confidence,
    Value<bool>? userConfirmed,
    Value<bool>? alternativeFlag,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PurchaseEntriesCompanion(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      plannedItemId: plannedItemId ?? this.plannedItemId,
      receiptId: receiptId ?? this.receiptId,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      actualQuantity: actualQuantity ?? this.actualQuantity,
      actualUnitCode: actualUnitCode ?? this.actualUnitCode,
      actualUnitPrice: actualUnitPrice ?? this.actualUnitPrice,
      grossTotalMinorUnits: grossTotalMinorUnits ?? this.grossTotalMinorUnits,
      discountMinorUnits: discountMinorUnits ?? this.discountMinorUnits,
      actualLineTotalMinorUnits:
          actualLineTotalMinorUnits ?? this.actualLineTotalMinorUnits,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      userConfirmed: userConfirmed ?? this.userConfirmed,
      alternativeFlag: alternativeFlag ?? this.alternativeFlag,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<int>(listId.value);
    }
    if (plannedItemId.present) {
      map['planned_item_id'] = Variable<int>(plannedItemId.value);
    }
    if (receiptId.present) {
      map['receipt_id'] = Variable<int>(receiptId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (actualQuantity.present) {
      map['actual_quantity'] = Variable<String>(actualQuantity.value);
    }
    if (actualUnitCode.present) {
      map['actual_unit_code'] = Variable<String>(actualUnitCode.value);
    }
    if (actualUnitPrice.present) {
      map['actual_unit_price'] = Variable<String>(actualUnitPrice.value);
    }
    if (grossTotalMinorUnits.present) {
      map['gross_total_minor_units'] = Variable<int>(
        grossTotalMinorUnits.value,
      );
    }
    if (discountMinorUnits.present) {
      map['discount_minor_units'] = Variable<int>(discountMinorUnits.value);
    }
    if (actualLineTotalMinorUnits.present) {
      map['actual_line_total_minor_units'] = Variable<int>(
        actualLineTotalMinorUnits.value,
      );
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (userConfirmed.present) {
      map['user_confirmed'] = Variable<bool>(userConfirmed.value);
    }
    if (alternativeFlag.present) {
      map['alternative_flag'] = Variable<bool>(alternativeFlag.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseEntriesCompanion(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('plannedItemId: $plannedItemId, ')
          ..write('receiptId: $receiptId, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('actualQuantity: $actualQuantity, ')
          ..write('actualUnitCode: $actualUnitCode, ')
          ..write('actualUnitPrice: $actualUnitPrice, ')
          ..write('grossTotalMinorUnits: $grossTotalMinorUnits, ')
          ..write('discountMinorUnits: $discountMinorUnits, ')
          ..write('actualLineTotalMinorUnits: $actualLineTotalMinorUnits, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('userConfirmed: $userConfirmed, ')
          ..write('alternativeFlag: $alternativeFlag, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductAliasesTable extends ProductAliases
    with TableInfo<$ProductAliasesTable, ProductAliase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductAliasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_memory (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedAliasMeta = const VerificationMeta(
    'normalizedAlias',
  );
  @override
  late final GeneratedColumn<String> normalizedAlias = GeneratedColumn<String>(
    'normalized_alias',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storeIdMeta = const VerificationMeta(
    'storeId',
  );
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
    'store_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stores (id)',
    ),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    alias,
    normalizedAlias,
    storeId,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_aliases';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductAliase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
      );
    } else if (isInserting) {
      context.missing(_aliasMeta);
    }
    if (data.containsKey('normalized_alias')) {
      context.handle(
        _normalizedAliasMeta,
        normalizedAlias.isAcceptableOrUnknown(
          data['normalized_alias']!,
          _normalizedAliasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedAliasMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(
        _storeIdMeta,
        storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductAliase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductAliase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      )!,
      normalizedAlias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_alias'],
      )!,
      storeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}store_id'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $ProductAliasesTable createAlias(String alias) {
    return $ProductAliasesTable(attachedDatabase, alias);
  }
}

class ProductAliase extends DataClass implements Insertable<ProductAliase> {
  final int id;
  final int productId;
  final String alias;
  final String normalizedAlias;
  final int? storeId;

  /// manual | receipt | voice
  final String source;
  const ProductAliase({
    required this.id,
    required this.productId,
    required this.alias,
    required this.normalizedAlias,
    this.storeId,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['alias'] = Variable<String>(alias);
    map['normalized_alias'] = Variable<String>(normalizedAlias);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['source'] = Variable<String>(source);
    return map;
  }

  ProductAliasesCompanion toCompanion(bool nullToAbsent) {
    return ProductAliasesCompanion(
      id: Value(id),
      productId: Value(productId),
      alias: Value(alias),
      normalizedAlias: Value(normalizedAlias),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      source: Value(source),
    );
  }

  factory ProductAliase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductAliase(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      alias: serializer.fromJson<String>(json['alias']),
      normalizedAlias: serializer.fromJson<String>(json['normalizedAlias']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'alias': serializer.toJson<String>(alias),
      'normalizedAlias': serializer.toJson<String>(normalizedAlias),
      'storeId': serializer.toJson<int?>(storeId),
      'source': serializer.toJson<String>(source),
    };
  }

  ProductAliase copyWith({
    int? id,
    int? productId,
    String? alias,
    String? normalizedAlias,
    Value<int?> storeId = const Value.absent(),
    String? source,
  }) => ProductAliase(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    alias: alias ?? this.alias,
    normalizedAlias: normalizedAlias ?? this.normalizedAlias,
    storeId: storeId.present ? storeId.value : this.storeId,
    source: source ?? this.source,
  );
  ProductAliase copyWithCompanion(ProductAliasesCompanion data) {
    return ProductAliase(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      alias: data.alias.present ? data.alias.value : this.alias,
      normalizedAlias: data.normalizedAlias.present
          ? data.normalizedAlias.value
          : this.normalizedAlias,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductAliase(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('alias: $alias, ')
          ..write('normalizedAlias: $normalizedAlias, ')
          ..write('storeId: $storeId, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, alias, normalizedAlias, storeId, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductAliase &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.alias == this.alias &&
          other.normalizedAlias == this.normalizedAlias &&
          other.storeId == this.storeId &&
          other.source == this.source);
}

class ProductAliasesCompanion extends UpdateCompanion<ProductAliase> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> alias;
  final Value<String> normalizedAlias;
  final Value<int?> storeId;
  final Value<String> source;
  const ProductAliasesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.alias = const Value.absent(),
    this.normalizedAlias = const Value.absent(),
    this.storeId = const Value.absent(),
    this.source = const Value.absent(),
  });
  ProductAliasesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String alias,
    required String normalizedAlias,
    this.storeId = const Value.absent(),
    this.source = const Value.absent(),
  }) : productId = Value(productId),
       alias = Value(alias),
       normalizedAlias = Value(normalizedAlias);
  static Insertable<ProductAliase> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? alias,
    Expression<String>? normalizedAlias,
    Expression<int>? storeId,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (alias != null) 'alias': alias,
      if (normalizedAlias != null) 'normalized_alias': normalizedAlias,
      if (storeId != null) 'store_id': storeId,
      if (source != null) 'source': source,
    });
  }

  ProductAliasesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? alias,
    Value<String>? normalizedAlias,
    Value<int?>? storeId,
    Value<String>? source,
  }) {
    return ProductAliasesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      alias: alias ?? this.alias,
      normalizedAlias: normalizedAlias ?? this.normalizedAlias,
      storeId: storeId ?? this.storeId,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (normalizedAlias.present) {
      map['normalized_alias'] = Variable<String>(normalizedAlias.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductAliasesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('alias: $alias, ')
          ..write('normalizedAlias: $normalizedAlias, ')
          ..write('storeId: $storeId, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $PriceObservationsTable extends PriceObservations
    with TableInfo<$PriceObservationsTable, PriceObservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceObservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_memory (id)',
    ),
  );
  static const VerificationMeta _purchaseEntryIdMeta = const VerificationMeta(
    'purchaseEntryId',
  );
  @override
  late final GeneratedColumn<int> purchaseEntryId = GeneratedColumn<int>(
    'purchase_entry_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_entries (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _storeIdMeta = const VerificationMeta(
    'storeId',
  );
  @override
  late final GeneratedColumn<int> storeId = GeneratedColumn<int>(
    'store_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stores (id)',
    ),
  );
  static const VerificationMeta _observedAtMeta = const VerificationMeta(
    'observedAt',
  );
  @override
  late final GeneratedColumn<DateTime> observedAt = GeneratedColumn<DateTime>(
    'observed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<String> quantity = GeneratedColumn<String>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCodeMeta = const VerificationMeta(
    'unitCode',
  );
  @override
  late final GeneratedColumn<String> unitCode = GeneratedColumn<String>(
    'unit_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedBaseQuantityMeta =
      const VerificationMeta('normalizedBaseQuantity');
  @override
  late final GeneratedColumn<String> normalizedBaseQuantity =
      GeneratedColumn<String>(
        'normalized_base_quantity',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<String> unitPrice = GeneratedColumn<String>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineTotalMinorUnitsMeta =
      const VerificationMeta('lineTotalMinorUnits');
  @override
  late final GeneratedColumn<int> lineTotalMinorUnits = GeneratedColumn<int>(
    'line_total_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMinorUnitsMeta =
      const VerificationMeta('discountMinorUnits');
  @override
  late final GeneratedColumn<int> discountMinorUnits = GeneratedColumn<int>(
    'discount_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    purchaseEntryId,
    storeId,
    observedAt,
    quantity,
    unitCode,
    normalizedBaseQuantity,
    unitPrice,
    lineTotalMinorUnits,
    discountMinorUnits,
    currencyCode,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_observations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PriceObservation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('purchase_entry_id')) {
      context.handle(
        _purchaseEntryIdMeta,
        purchaseEntryId.isAcceptableOrUnknown(
          data['purchase_entry_id']!,
          _purchaseEntryIdMeta,
        ),
      );
    }
    if (data.containsKey('store_id')) {
      context.handle(
        _storeIdMeta,
        storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta),
      );
    }
    if (data.containsKey('observed_at')) {
      context.handle(
        _observedAtMeta,
        observedAt.isAcceptableOrUnknown(data['observed_at']!, _observedAtMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_code')) {
      context.handle(
        _unitCodeMeta,
        unitCode.isAcceptableOrUnknown(data['unit_code']!, _unitCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCodeMeta);
    }
    if (data.containsKey('normalized_base_quantity')) {
      context.handle(
        _normalizedBaseQuantityMeta,
        normalizedBaseQuantity.isAcceptableOrUnknown(
          data['normalized_base_quantity']!,
          _normalizedBaseQuantityMeta,
        ),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('line_total_minor_units')) {
      context.handle(
        _lineTotalMinorUnitsMeta,
        lineTotalMinorUnits.isAcceptableOrUnknown(
          data['line_total_minor_units']!,
          _lineTotalMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMinorUnitsMeta);
    }
    if (data.containsKey('discount_minor_units')) {
      context.handle(
        _discountMinorUnitsMeta,
        discountMinorUnits.isAcceptableOrUnknown(
          data['discount_minor_units']!,
          _discountMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceObservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceObservation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      purchaseEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_entry_id'],
      ),
      storeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}store_id'],
      ),
      observedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}observed_at'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantity'],
      )!,
      unitCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_code'],
      )!,
      normalizedBaseQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_base_quantity'],
      ),
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_price'],
      )!,
      lineTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_total_minor_units'],
      )!,
      discountMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_minor_units'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $PriceObservationsTable createAlias(String alias) {
    return $PriceObservationsTable(attachedDatabase, alias);
  }
}

class PriceObservation extends DataClass
    implements Insertable<PriceObservation> {
  final int id;
  final int? productId;
  final int? purchaseEntryId;
  final int? storeId;
  final DateTime observedAt;
  final String quantity;
  final String unitCode;

  /// Ortak temel birime indirilmiş değer; güvenli değilse null (spec §7.2).
  final String? normalizedBaseQuantity;
  final String unitPrice;
  final int lineTotalMinorUnits;
  final int discountMinorUnits;
  final String currencyCode;

  /// manual | voice | shelfOcr | receiptOcr
  final String source;
  const PriceObservation({
    required this.id,
    this.productId,
    this.purchaseEntryId,
    this.storeId,
    required this.observedAt,
    required this.quantity,
    required this.unitCode,
    this.normalizedBaseQuantity,
    required this.unitPrice,
    required this.lineTotalMinorUnits,
    required this.discountMinorUnits,
    required this.currencyCode,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || purchaseEntryId != null) {
      map['purchase_entry_id'] = Variable<int>(purchaseEntryId);
    }
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<int>(storeId);
    }
    map['observed_at'] = Variable<DateTime>(observedAt);
    map['quantity'] = Variable<String>(quantity);
    map['unit_code'] = Variable<String>(unitCode);
    if (!nullToAbsent || normalizedBaseQuantity != null) {
      map['normalized_base_quantity'] = Variable<String>(
        normalizedBaseQuantity,
      );
    }
    map['unit_price'] = Variable<String>(unitPrice);
    map['line_total_minor_units'] = Variable<int>(lineTotalMinorUnits);
    map['discount_minor_units'] = Variable<int>(discountMinorUnits);
    map['currency_code'] = Variable<String>(currencyCode);
    map['source'] = Variable<String>(source);
    return map;
  }

  PriceObservationsCompanion toCompanion(bool nullToAbsent) {
    return PriceObservationsCompanion(
      id: Value(id),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      purchaseEntryId: purchaseEntryId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseEntryId),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      observedAt: Value(observedAt),
      quantity: Value(quantity),
      unitCode: Value(unitCode),
      normalizedBaseQuantity: normalizedBaseQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedBaseQuantity),
      unitPrice: Value(unitPrice),
      lineTotalMinorUnits: Value(lineTotalMinorUnits),
      discountMinorUnits: Value(discountMinorUnits),
      currencyCode: Value(currencyCode),
      source: Value(source),
    );
  }

  factory PriceObservation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceObservation(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int?>(json['productId']),
      purchaseEntryId: serializer.fromJson<int?>(json['purchaseEntryId']),
      storeId: serializer.fromJson<int?>(json['storeId']),
      observedAt: serializer.fromJson<DateTime>(json['observedAt']),
      quantity: serializer.fromJson<String>(json['quantity']),
      unitCode: serializer.fromJson<String>(json['unitCode']),
      normalizedBaseQuantity: serializer.fromJson<String?>(
        json['normalizedBaseQuantity'],
      ),
      unitPrice: serializer.fromJson<String>(json['unitPrice']),
      lineTotalMinorUnits: serializer.fromJson<int>(
        json['lineTotalMinorUnits'],
      ),
      discountMinorUnits: serializer.fromJson<int>(json['discountMinorUnits']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int?>(productId),
      'purchaseEntryId': serializer.toJson<int?>(purchaseEntryId),
      'storeId': serializer.toJson<int?>(storeId),
      'observedAt': serializer.toJson<DateTime>(observedAt),
      'quantity': serializer.toJson<String>(quantity),
      'unitCode': serializer.toJson<String>(unitCode),
      'normalizedBaseQuantity': serializer.toJson<String?>(
        normalizedBaseQuantity,
      ),
      'unitPrice': serializer.toJson<String>(unitPrice),
      'lineTotalMinorUnits': serializer.toJson<int>(lineTotalMinorUnits),
      'discountMinorUnits': serializer.toJson<int>(discountMinorUnits),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'source': serializer.toJson<String>(source),
    };
  }

  PriceObservation copyWith({
    int? id,
    Value<int?> productId = const Value.absent(),
    Value<int?> purchaseEntryId = const Value.absent(),
    Value<int?> storeId = const Value.absent(),
    DateTime? observedAt,
    String? quantity,
    String? unitCode,
    Value<String?> normalizedBaseQuantity = const Value.absent(),
    String? unitPrice,
    int? lineTotalMinorUnits,
    int? discountMinorUnits,
    String? currencyCode,
    String? source,
  }) => PriceObservation(
    id: id ?? this.id,
    productId: productId.present ? productId.value : this.productId,
    purchaseEntryId: purchaseEntryId.present
        ? purchaseEntryId.value
        : this.purchaseEntryId,
    storeId: storeId.present ? storeId.value : this.storeId,
    observedAt: observedAt ?? this.observedAt,
    quantity: quantity ?? this.quantity,
    unitCode: unitCode ?? this.unitCode,
    normalizedBaseQuantity: normalizedBaseQuantity.present
        ? normalizedBaseQuantity.value
        : this.normalizedBaseQuantity,
    unitPrice: unitPrice ?? this.unitPrice,
    lineTotalMinorUnits: lineTotalMinorUnits ?? this.lineTotalMinorUnits,
    discountMinorUnits: discountMinorUnits ?? this.discountMinorUnits,
    currencyCode: currencyCode ?? this.currencyCode,
    source: source ?? this.source,
  );
  PriceObservation copyWithCompanion(PriceObservationsCompanion data) {
    return PriceObservation(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      purchaseEntryId: data.purchaseEntryId.present
          ? data.purchaseEntryId.value
          : this.purchaseEntryId,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      observedAt: data.observedAt.present
          ? data.observedAt.value
          : this.observedAt,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitCode: data.unitCode.present ? data.unitCode.value : this.unitCode,
      normalizedBaseQuantity: data.normalizedBaseQuantity.present
          ? data.normalizedBaseQuantity.value
          : this.normalizedBaseQuantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      lineTotalMinorUnits: data.lineTotalMinorUnits.present
          ? data.lineTotalMinorUnits.value
          : this.lineTotalMinorUnits,
      discountMinorUnits: data.discountMinorUnits.present
          ? data.discountMinorUnits.value
          : this.discountMinorUnits,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceObservation(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('purchaseEntryId: $purchaseEntryId, ')
          ..write('storeId: $storeId, ')
          ..write('observedAt: $observedAt, ')
          ..write('quantity: $quantity, ')
          ..write('unitCode: $unitCode, ')
          ..write('normalizedBaseQuantity: $normalizedBaseQuantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('lineTotalMinorUnits: $lineTotalMinorUnits, ')
          ..write('discountMinorUnits: $discountMinorUnits, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    purchaseEntryId,
    storeId,
    observedAt,
    quantity,
    unitCode,
    normalizedBaseQuantity,
    unitPrice,
    lineTotalMinorUnits,
    discountMinorUnits,
    currencyCode,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceObservation &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.purchaseEntryId == this.purchaseEntryId &&
          other.storeId == this.storeId &&
          other.observedAt == this.observedAt &&
          other.quantity == this.quantity &&
          other.unitCode == this.unitCode &&
          other.normalizedBaseQuantity == this.normalizedBaseQuantity &&
          other.unitPrice == this.unitPrice &&
          other.lineTotalMinorUnits == this.lineTotalMinorUnits &&
          other.discountMinorUnits == this.discountMinorUnits &&
          other.currencyCode == this.currencyCode &&
          other.source == this.source);
}

class PriceObservationsCompanion extends UpdateCompanion<PriceObservation> {
  final Value<int> id;
  final Value<int?> productId;
  final Value<int?> purchaseEntryId;
  final Value<int?> storeId;
  final Value<DateTime> observedAt;
  final Value<String> quantity;
  final Value<String> unitCode;
  final Value<String?> normalizedBaseQuantity;
  final Value<String> unitPrice;
  final Value<int> lineTotalMinorUnits;
  final Value<int> discountMinorUnits;
  final Value<String> currencyCode;
  final Value<String> source;
  const PriceObservationsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.purchaseEntryId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCode = const Value.absent(),
    this.normalizedBaseQuantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.lineTotalMinorUnits = const Value.absent(),
    this.discountMinorUnits = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.source = const Value.absent(),
  });
  PriceObservationsCompanion.insert({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.purchaseEntryId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.observedAt = const Value.absent(),
    required String quantity,
    required String unitCode,
    this.normalizedBaseQuantity = const Value.absent(),
    required String unitPrice,
    required int lineTotalMinorUnits,
    this.discountMinorUnits = const Value.absent(),
    required String currencyCode,
    required String source,
  }) : quantity = Value(quantity),
       unitCode = Value(unitCode),
       unitPrice = Value(unitPrice),
       lineTotalMinorUnits = Value(lineTotalMinorUnits),
       currencyCode = Value(currencyCode),
       source = Value(source);
  static Insertable<PriceObservation> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? purchaseEntryId,
    Expression<int>? storeId,
    Expression<DateTime>? observedAt,
    Expression<String>? quantity,
    Expression<String>? unitCode,
    Expression<String>? normalizedBaseQuantity,
    Expression<String>? unitPrice,
    Expression<int>? lineTotalMinorUnits,
    Expression<int>? discountMinorUnits,
    Expression<String>? currencyCode,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (purchaseEntryId != null) 'purchase_entry_id': purchaseEntryId,
      if (storeId != null) 'store_id': storeId,
      if (observedAt != null) 'observed_at': observedAt,
      if (quantity != null) 'quantity': quantity,
      if (unitCode != null) 'unit_code': unitCode,
      if (normalizedBaseQuantity != null)
        'normalized_base_quantity': normalizedBaseQuantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (lineTotalMinorUnits != null)
        'line_total_minor_units': lineTotalMinorUnits,
      if (discountMinorUnits != null)
        'discount_minor_units': discountMinorUnits,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (source != null) 'source': source,
    });
  }

  PriceObservationsCompanion copyWith({
    Value<int>? id,
    Value<int?>? productId,
    Value<int?>? purchaseEntryId,
    Value<int?>? storeId,
    Value<DateTime>? observedAt,
    Value<String>? quantity,
    Value<String>? unitCode,
    Value<String?>? normalizedBaseQuantity,
    Value<String>? unitPrice,
    Value<int>? lineTotalMinorUnits,
    Value<int>? discountMinorUnits,
    Value<String>? currencyCode,
    Value<String>? source,
  }) {
    return PriceObservationsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      purchaseEntryId: purchaseEntryId ?? this.purchaseEntryId,
      storeId: storeId ?? this.storeId,
      observedAt: observedAt ?? this.observedAt,
      quantity: quantity ?? this.quantity,
      unitCode: unitCode ?? this.unitCode,
      normalizedBaseQuantity:
          normalizedBaseQuantity ?? this.normalizedBaseQuantity,
      unitPrice: unitPrice ?? this.unitPrice,
      lineTotalMinorUnits: lineTotalMinorUnits ?? this.lineTotalMinorUnits,
      discountMinorUnits: discountMinorUnits ?? this.discountMinorUnits,
      currencyCode: currencyCode ?? this.currencyCode,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (purchaseEntryId.present) {
      map['purchase_entry_id'] = Variable<int>(purchaseEntryId.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (observedAt.present) {
      map['observed_at'] = Variable<DateTime>(observedAt.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<String>(quantity.value);
    }
    if (unitCode.present) {
      map['unit_code'] = Variable<String>(unitCode.value);
    }
    if (normalizedBaseQuantity.present) {
      map['normalized_base_quantity'] = Variable<String>(
        normalizedBaseQuantity.value,
      );
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<String>(unitPrice.value);
    }
    if (lineTotalMinorUnits.present) {
      map['line_total_minor_units'] = Variable<int>(lineTotalMinorUnits.value);
    }
    if (discountMinorUnits.present) {
      map['discount_minor_units'] = Variable<int>(discountMinorUnits.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceObservationsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('purchaseEntryId: $purchaseEntryId, ')
          ..write('storeId: $storeId, ')
          ..write('observedAt: $observedAt, ')
          ..write('quantity: $quantity, ')
          ..write('unitCode: $unitCode, ')
          ..write('normalizedBaseQuantity: $normalizedBaseQuantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('lineTotalMinorUnits: $lineTotalMinorUnits, ')
          ..write('discountMinorUnits: $discountMinorUnits, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $ReceiptCandidateLinesTable extends ReceiptCandidateLines
    with TableInfo<$ReceiptCandidateLinesTable, ReceiptCandidateLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptCandidateLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _receiptIdMeta = const VerificationMeta(
    'receiptId',
  );
  @override
  late final GeneratedColumn<int> receiptId = GeneratedColumn<int>(
    'receipt_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES receipts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _rawTextMeta = const VerificationMeta(
    'rawText',
  );
  @override
  late final GeneratedColumn<String> rawText = GeneratedColumn<String>(
    'raw_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bboxMetadataMeta = const VerificationMeta(
    'bboxMetadata',
  );
  @override
  late final GeneratedColumn<String> bboxMetadata = GeneratedColumn<String>(
    'bbox_metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parsedNameMeta = const VerificationMeta(
    'parsedName',
  );
  @override
  late final GeneratedColumn<String> parsedName = GeneratedColumn<String>(
    'parsed_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parsedQuantityMeta = const VerificationMeta(
    'parsedQuantity',
  );
  @override
  late final GeneratedColumn<String> parsedQuantity = GeneratedColumn<String>(
    'parsed_quantity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parsedUnitCodeMeta = const VerificationMeta(
    'parsedUnitCode',
  );
  @override
  late final GeneratedColumn<String> parsedUnitCode = GeneratedColumn<String>(
    'parsed_unit_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parsedUnitPriceMeta = const VerificationMeta(
    'parsedUnitPrice',
  );
  @override
  late final GeneratedColumn<String> parsedUnitPrice = GeneratedColumn<String>(
    'parsed_unit_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parsedLineTotalMinorUnitsMeta =
      const VerificationMeta('parsedLineTotalMinorUnits');
  @override
  late final GeneratedColumn<int> parsedLineTotalMinorUnits =
      GeneratedColumn<int>(
        'parsed_line_total_minor_units',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<String> confidence = GeneratedColumn<String>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedPlannedItemIdMeta =
      const VerificationMeta('linkedPlannedItemId');
  @override
  late final GeneratedColumn<int> linkedPlannedItemId = GeneratedColumn<int>(
    'linked_planned_item_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES planned_items (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _reviewStatusMeta = const VerificationMeta(
    'reviewStatus',
  );
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
    'review_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    receiptId,
    rawText,
    bboxMetadata,
    parsedName,
    parsedQuantity,
    parsedUnitCode,
    parsedUnitPrice,
    parsedLineTotalMinorUnits,
    confidence,
    linkedPlannedItemId,
    reviewStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipt_candidate_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReceiptCandidateLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receipt_id')) {
      context.handle(
        _receiptIdMeta,
        receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta),
      );
    } else if (isInserting) {
      context.missing(_receiptIdMeta);
    }
    if (data.containsKey('raw_text')) {
      context.handle(
        _rawTextMeta,
        rawText.isAcceptableOrUnknown(data['raw_text']!, _rawTextMeta),
      );
    } else if (isInserting) {
      context.missing(_rawTextMeta);
    }
    if (data.containsKey('bbox_metadata')) {
      context.handle(
        _bboxMetadataMeta,
        bboxMetadata.isAcceptableOrUnknown(
          data['bbox_metadata']!,
          _bboxMetadataMeta,
        ),
      );
    }
    if (data.containsKey('parsed_name')) {
      context.handle(
        _parsedNameMeta,
        parsedName.isAcceptableOrUnknown(data['parsed_name']!, _parsedNameMeta),
      );
    }
    if (data.containsKey('parsed_quantity')) {
      context.handle(
        _parsedQuantityMeta,
        parsedQuantity.isAcceptableOrUnknown(
          data['parsed_quantity']!,
          _parsedQuantityMeta,
        ),
      );
    }
    if (data.containsKey('parsed_unit_code')) {
      context.handle(
        _parsedUnitCodeMeta,
        parsedUnitCode.isAcceptableOrUnknown(
          data['parsed_unit_code']!,
          _parsedUnitCodeMeta,
        ),
      );
    }
    if (data.containsKey('parsed_unit_price')) {
      context.handle(
        _parsedUnitPriceMeta,
        parsedUnitPrice.isAcceptableOrUnknown(
          data['parsed_unit_price']!,
          _parsedUnitPriceMeta,
        ),
      );
    }
    if (data.containsKey('parsed_line_total_minor_units')) {
      context.handle(
        _parsedLineTotalMinorUnitsMeta,
        parsedLineTotalMinorUnits.isAcceptableOrUnknown(
          data['parsed_line_total_minor_units']!,
          _parsedLineTotalMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('linked_planned_item_id')) {
      context.handle(
        _linkedPlannedItemIdMeta,
        linkedPlannedItemId.isAcceptableOrUnknown(
          data['linked_planned_item_id']!,
          _linkedPlannedItemIdMeta,
        ),
      );
    }
    if (data.containsKey('review_status')) {
      context.handle(
        _reviewStatusMeta,
        reviewStatus.isAcceptableOrUnknown(
          data['review_status']!,
          _reviewStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptCandidateLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptCandidateLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      receiptId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receipt_id'],
      )!,
      rawText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_text'],
      )!,
      bboxMetadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bbox_metadata'],
      ),
      parsedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parsed_name'],
      ),
      parsedQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parsed_quantity'],
      ),
      parsedUnitCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parsed_unit_code'],
      ),
      parsedUnitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parsed_unit_price'],
      ),
      parsedLineTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parsed_line_total_minor_units'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence'],
      ),
      linkedPlannedItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}linked_planned_item_id'],
      ),
      reviewStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_status'],
      )!,
    );
  }

  @override
  $ReceiptCandidateLinesTable createAlias(String alias) {
    return $ReceiptCandidateLinesTable(attachedDatabase, alias);
  }
}

class ReceiptCandidateLine extends DataClass
    implements Insertable<ReceiptCandidateLine> {
  final int id;
  final int receiptId;
  final String rawText;
  final String? bboxMetadata;
  final String? parsedName;
  final String? parsedQuantity;
  final String? parsedUnitCode;
  final String? parsedUnitPrice;
  final int? parsedLineTotalMinorUnits;

  /// high | medium | low
  final String? confidence;
  final int? linkedPlannedItemId;

  /// pending | accepted | ignored | edited
  final String reviewStatus;
  const ReceiptCandidateLine({
    required this.id,
    required this.receiptId,
    required this.rawText,
    this.bboxMetadata,
    this.parsedName,
    this.parsedQuantity,
    this.parsedUnitCode,
    this.parsedUnitPrice,
    this.parsedLineTotalMinorUnits,
    this.confidence,
    this.linkedPlannedItemId,
    required this.reviewStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['receipt_id'] = Variable<int>(receiptId);
    map['raw_text'] = Variable<String>(rawText);
    if (!nullToAbsent || bboxMetadata != null) {
      map['bbox_metadata'] = Variable<String>(bboxMetadata);
    }
    if (!nullToAbsent || parsedName != null) {
      map['parsed_name'] = Variable<String>(parsedName);
    }
    if (!nullToAbsent || parsedQuantity != null) {
      map['parsed_quantity'] = Variable<String>(parsedQuantity);
    }
    if (!nullToAbsent || parsedUnitCode != null) {
      map['parsed_unit_code'] = Variable<String>(parsedUnitCode);
    }
    if (!nullToAbsent || parsedUnitPrice != null) {
      map['parsed_unit_price'] = Variable<String>(parsedUnitPrice);
    }
    if (!nullToAbsent || parsedLineTotalMinorUnits != null) {
      map['parsed_line_total_minor_units'] = Variable<int>(
        parsedLineTotalMinorUnits,
      );
    }
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<String>(confidence);
    }
    if (!nullToAbsent || linkedPlannedItemId != null) {
      map['linked_planned_item_id'] = Variable<int>(linkedPlannedItemId);
    }
    map['review_status'] = Variable<String>(reviewStatus);
    return map;
  }

  ReceiptCandidateLinesCompanion toCompanion(bool nullToAbsent) {
    return ReceiptCandidateLinesCompanion(
      id: Value(id),
      receiptId: Value(receiptId),
      rawText: Value(rawText),
      bboxMetadata: bboxMetadata == null && nullToAbsent
          ? const Value.absent()
          : Value(bboxMetadata),
      parsedName: parsedName == null && nullToAbsent
          ? const Value.absent()
          : Value(parsedName),
      parsedQuantity: parsedQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(parsedQuantity),
      parsedUnitCode: parsedUnitCode == null && nullToAbsent
          ? const Value.absent()
          : Value(parsedUnitCode),
      parsedUnitPrice: parsedUnitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(parsedUnitPrice),
      parsedLineTotalMinorUnits:
          parsedLineTotalMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(parsedLineTotalMinorUnits),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      linkedPlannedItemId: linkedPlannedItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedPlannedItemId),
      reviewStatus: Value(reviewStatus),
    );
  }

  factory ReceiptCandidateLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptCandidateLine(
      id: serializer.fromJson<int>(json['id']),
      receiptId: serializer.fromJson<int>(json['receiptId']),
      rawText: serializer.fromJson<String>(json['rawText']),
      bboxMetadata: serializer.fromJson<String?>(json['bboxMetadata']),
      parsedName: serializer.fromJson<String?>(json['parsedName']),
      parsedQuantity: serializer.fromJson<String?>(json['parsedQuantity']),
      parsedUnitCode: serializer.fromJson<String?>(json['parsedUnitCode']),
      parsedUnitPrice: serializer.fromJson<String?>(json['parsedUnitPrice']),
      parsedLineTotalMinorUnits: serializer.fromJson<int?>(
        json['parsedLineTotalMinorUnits'],
      ),
      confidence: serializer.fromJson<String?>(json['confidence']),
      linkedPlannedItemId: serializer.fromJson<int?>(
        json['linkedPlannedItemId'],
      ),
      reviewStatus: serializer.fromJson<String>(json['reviewStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'receiptId': serializer.toJson<int>(receiptId),
      'rawText': serializer.toJson<String>(rawText),
      'bboxMetadata': serializer.toJson<String?>(bboxMetadata),
      'parsedName': serializer.toJson<String?>(parsedName),
      'parsedQuantity': serializer.toJson<String?>(parsedQuantity),
      'parsedUnitCode': serializer.toJson<String?>(parsedUnitCode),
      'parsedUnitPrice': serializer.toJson<String?>(parsedUnitPrice),
      'parsedLineTotalMinorUnits': serializer.toJson<int?>(
        parsedLineTotalMinorUnits,
      ),
      'confidence': serializer.toJson<String?>(confidence),
      'linkedPlannedItemId': serializer.toJson<int?>(linkedPlannedItemId),
      'reviewStatus': serializer.toJson<String>(reviewStatus),
    };
  }

  ReceiptCandidateLine copyWith({
    int? id,
    int? receiptId,
    String? rawText,
    Value<String?> bboxMetadata = const Value.absent(),
    Value<String?> parsedName = const Value.absent(),
    Value<String?> parsedQuantity = const Value.absent(),
    Value<String?> parsedUnitCode = const Value.absent(),
    Value<String?> parsedUnitPrice = const Value.absent(),
    Value<int?> parsedLineTotalMinorUnits = const Value.absent(),
    Value<String?> confidence = const Value.absent(),
    Value<int?> linkedPlannedItemId = const Value.absent(),
    String? reviewStatus,
  }) => ReceiptCandidateLine(
    id: id ?? this.id,
    receiptId: receiptId ?? this.receiptId,
    rawText: rawText ?? this.rawText,
    bboxMetadata: bboxMetadata.present ? bboxMetadata.value : this.bboxMetadata,
    parsedName: parsedName.present ? parsedName.value : this.parsedName,
    parsedQuantity: parsedQuantity.present
        ? parsedQuantity.value
        : this.parsedQuantity,
    parsedUnitCode: parsedUnitCode.present
        ? parsedUnitCode.value
        : this.parsedUnitCode,
    parsedUnitPrice: parsedUnitPrice.present
        ? parsedUnitPrice.value
        : this.parsedUnitPrice,
    parsedLineTotalMinorUnits: parsedLineTotalMinorUnits.present
        ? parsedLineTotalMinorUnits.value
        : this.parsedLineTotalMinorUnits,
    confidence: confidence.present ? confidence.value : this.confidence,
    linkedPlannedItemId: linkedPlannedItemId.present
        ? linkedPlannedItemId.value
        : this.linkedPlannedItemId,
    reviewStatus: reviewStatus ?? this.reviewStatus,
  );
  ReceiptCandidateLine copyWithCompanion(ReceiptCandidateLinesCompanion data) {
    return ReceiptCandidateLine(
      id: data.id.present ? data.id.value : this.id,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      rawText: data.rawText.present ? data.rawText.value : this.rawText,
      bboxMetadata: data.bboxMetadata.present
          ? data.bboxMetadata.value
          : this.bboxMetadata,
      parsedName: data.parsedName.present
          ? data.parsedName.value
          : this.parsedName,
      parsedQuantity: data.parsedQuantity.present
          ? data.parsedQuantity.value
          : this.parsedQuantity,
      parsedUnitCode: data.parsedUnitCode.present
          ? data.parsedUnitCode.value
          : this.parsedUnitCode,
      parsedUnitPrice: data.parsedUnitPrice.present
          ? data.parsedUnitPrice.value
          : this.parsedUnitPrice,
      parsedLineTotalMinorUnits: data.parsedLineTotalMinorUnits.present
          ? data.parsedLineTotalMinorUnits.value
          : this.parsedLineTotalMinorUnits,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      linkedPlannedItemId: data.linkedPlannedItemId.present
          ? data.linkedPlannedItemId.value
          : this.linkedPlannedItemId,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptCandidateLine(')
          ..write('id: $id, ')
          ..write('receiptId: $receiptId, ')
          ..write('rawText: $rawText, ')
          ..write('bboxMetadata: $bboxMetadata, ')
          ..write('parsedName: $parsedName, ')
          ..write('parsedQuantity: $parsedQuantity, ')
          ..write('parsedUnitCode: $parsedUnitCode, ')
          ..write('parsedUnitPrice: $parsedUnitPrice, ')
          ..write('parsedLineTotalMinorUnits: $parsedLineTotalMinorUnits, ')
          ..write('confidence: $confidence, ')
          ..write('linkedPlannedItemId: $linkedPlannedItemId, ')
          ..write('reviewStatus: $reviewStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    receiptId,
    rawText,
    bboxMetadata,
    parsedName,
    parsedQuantity,
    parsedUnitCode,
    parsedUnitPrice,
    parsedLineTotalMinorUnits,
    confidence,
    linkedPlannedItemId,
    reviewStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptCandidateLine &&
          other.id == this.id &&
          other.receiptId == this.receiptId &&
          other.rawText == this.rawText &&
          other.bboxMetadata == this.bboxMetadata &&
          other.parsedName == this.parsedName &&
          other.parsedQuantity == this.parsedQuantity &&
          other.parsedUnitCode == this.parsedUnitCode &&
          other.parsedUnitPrice == this.parsedUnitPrice &&
          other.parsedLineTotalMinorUnits == this.parsedLineTotalMinorUnits &&
          other.confidence == this.confidence &&
          other.linkedPlannedItemId == this.linkedPlannedItemId &&
          other.reviewStatus == this.reviewStatus);
}

class ReceiptCandidateLinesCompanion
    extends UpdateCompanion<ReceiptCandidateLine> {
  final Value<int> id;
  final Value<int> receiptId;
  final Value<String> rawText;
  final Value<String?> bboxMetadata;
  final Value<String?> parsedName;
  final Value<String?> parsedQuantity;
  final Value<String?> parsedUnitCode;
  final Value<String?> parsedUnitPrice;
  final Value<int?> parsedLineTotalMinorUnits;
  final Value<String?> confidence;
  final Value<int?> linkedPlannedItemId;
  final Value<String> reviewStatus;
  const ReceiptCandidateLinesCompanion({
    this.id = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.rawText = const Value.absent(),
    this.bboxMetadata = const Value.absent(),
    this.parsedName = const Value.absent(),
    this.parsedQuantity = const Value.absent(),
    this.parsedUnitCode = const Value.absent(),
    this.parsedUnitPrice = const Value.absent(),
    this.parsedLineTotalMinorUnits = const Value.absent(),
    this.confidence = const Value.absent(),
    this.linkedPlannedItemId = const Value.absent(),
    this.reviewStatus = const Value.absent(),
  });
  ReceiptCandidateLinesCompanion.insert({
    this.id = const Value.absent(),
    required int receiptId,
    required String rawText,
    this.bboxMetadata = const Value.absent(),
    this.parsedName = const Value.absent(),
    this.parsedQuantity = const Value.absent(),
    this.parsedUnitCode = const Value.absent(),
    this.parsedUnitPrice = const Value.absent(),
    this.parsedLineTotalMinorUnits = const Value.absent(),
    this.confidence = const Value.absent(),
    this.linkedPlannedItemId = const Value.absent(),
    this.reviewStatus = const Value.absent(),
  }) : receiptId = Value(receiptId),
       rawText = Value(rawText);
  static Insertable<ReceiptCandidateLine> custom({
    Expression<int>? id,
    Expression<int>? receiptId,
    Expression<String>? rawText,
    Expression<String>? bboxMetadata,
    Expression<String>? parsedName,
    Expression<String>? parsedQuantity,
    Expression<String>? parsedUnitCode,
    Expression<String>? parsedUnitPrice,
    Expression<int>? parsedLineTotalMinorUnits,
    Expression<String>? confidence,
    Expression<int>? linkedPlannedItemId,
    Expression<String>? reviewStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiptId != null) 'receipt_id': receiptId,
      if (rawText != null) 'raw_text': rawText,
      if (bboxMetadata != null) 'bbox_metadata': bboxMetadata,
      if (parsedName != null) 'parsed_name': parsedName,
      if (parsedQuantity != null) 'parsed_quantity': parsedQuantity,
      if (parsedUnitCode != null) 'parsed_unit_code': parsedUnitCode,
      if (parsedUnitPrice != null) 'parsed_unit_price': parsedUnitPrice,
      if (parsedLineTotalMinorUnits != null)
        'parsed_line_total_minor_units': parsedLineTotalMinorUnits,
      if (confidence != null) 'confidence': confidence,
      if (linkedPlannedItemId != null)
        'linked_planned_item_id': linkedPlannedItemId,
      if (reviewStatus != null) 'review_status': reviewStatus,
    });
  }

  ReceiptCandidateLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? receiptId,
    Value<String>? rawText,
    Value<String?>? bboxMetadata,
    Value<String?>? parsedName,
    Value<String?>? parsedQuantity,
    Value<String?>? parsedUnitCode,
    Value<String?>? parsedUnitPrice,
    Value<int?>? parsedLineTotalMinorUnits,
    Value<String?>? confidence,
    Value<int?>? linkedPlannedItemId,
    Value<String>? reviewStatus,
  }) {
    return ReceiptCandidateLinesCompanion(
      id: id ?? this.id,
      receiptId: receiptId ?? this.receiptId,
      rawText: rawText ?? this.rawText,
      bboxMetadata: bboxMetadata ?? this.bboxMetadata,
      parsedName: parsedName ?? this.parsedName,
      parsedQuantity: parsedQuantity ?? this.parsedQuantity,
      parsedUnitCode: parsedUnitCode ?? this.parsedUnitCode,
      parsedUnitPrice: parsedUnitPrice ?? this.parsedUnitPrice,
      parsedLineTotalMinorUnits:
          parsedLineTotalMinorUnits ?? this.parsedLineTotalMinorUnits,
      confidence: confidence ?? this.confidence,
      linkedPlannedItemId: linkedPlannedItemId ?? this.linkedPlannedItemId,
      reviewStatus: reviewStatus ?? this.reviewStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (receiptId.present) {
      map['receipt_id'] = Variable<int>(receiptId.value);
    }
    if (rawText.present) {
      map['raw_text'] = Variable<String>(rawText.value);
    }
    if (bboxMetadata.present) {
      map['bbox_metadata'] = Variable<String>(bboxMetadata.value);
    }
    if (parsedName.present) {
      map['parsed_name'] = Variable<String>(parsedName.value);
    }
    if (parsedQuantity.present) {
      map['parsed_quantity'] = Variable<String>(parsedQuantity.value);
    }
    if (parsedUnitCode.present) {
      map['parsed_unit_code'] = Variable<String>(parsedUnitCode.value);
    }
    if (parsedUnitPrice.present) {
      map['parsed_unit_price'] = Variable<String>(parsedUnitPrice.value);
    }
    if (parsedLineTotalMinorUnits.present) {
      map['parsed_line_total_minor_units'] = Variable<int>(
        parsedLineTotalMinorUnits.value,
      );
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (linkedPlannedItemId.present) {
      map['linked_planned_item_id'] = Variable<int>(linkedPlannedItemId.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptCandidateLinesCompanion(')
          ..write('id: $id, ')
          ..write('receiptId: $receiptId, ')
          ..write('rawText: $rawText, ')
          ..write('bboxMetadata: $bboxMetadata, ')
          ..write('parsedName: $parsedName, ')
          ..write('parsedQuantity: $parsedQuantity, ')
          ..write('parsedUnitCode: $parsedUnitCode, ')
          ..write('parsedUnitPrice: $parsedUnitPrice, ')
          ..write('parsedLineTotalMinorUnits: $parsedLineTotalMinorUnits, ')
          ..write('confidence: $confidence, ')
          ..write('linkedPlannedItemId: $linkedPlannedItemId, ')
          ..write('reviewStatus: $reviewStatus')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ownerTypeMeta = const VerificationMeta(
    'ownerType',
  );
  @override
  late final GeneratedColumn<String> ownerType = GeneratedColumn<String>(
    'owner_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerType,
    ownerId,
    filePath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_type')) {
      context.handle(
        _ownerTypeMeta,
        ownerType.isAcceptableOrUnknown(data['owner_type']!, _ownerTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerTypeMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_type'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_id'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class Attachment extends DataClass implements Insertable<Attachment> {
  final int id;

  /// plannedItem | purchaseEntry | list | receipt
  final String ownerType;
  final int ownerId;
  final String filePath;
  final DateTime createdAt;
  const Attachment({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    required this.filePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_type'] = Variable<String>(ownerType);
    map['owner_id'] = Variable<int>(ownerId);
    map['file_path'] = Variable<String>(filePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      filePath: Value(filePath),
      createdAt: Value(createdAt),
    );
  }

  factory Attachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      id: serializer.fromJson<int>(json['id']),
      ownerType: serializer.fromJson<String>(json['ownerType']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerType': serializer.toJson<String>(ownerType),
      'ownerId': serializer.toJson<int>(ownerId),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Attachment copyWith({
    int? id,
    String? ownerType,
    int? ownerId,
    String? filePath,
    DateTime? createdAt,
  }) => Attachment(
    id: id ?? this.id,
    ownerType: ownerType ?? this.ownerType,
    ownerId: ownerId ?? this.ownerId,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
  );
  Attachment copyWithCompanion(AttachmentsCompanion data) {
    return Attachment(
      id: data.id.present ? data.id.value : this.id,
      ownerType: data.ownerType.present ? data.ownerType.value : this.ownerType,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerType, ownerId, filePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.id == this.id &&
          other.ownerType == this.ownerType &&
          other.ownerId == this.ownerId &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<int> id;
  final Value<String> ownerType;
  final Value<int> ownerId;
  final Value<String> filePath;
  final Value<DateTime> createdAt;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.ownerType = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    this.id = const Value.absent(),
    required String ownerType,
    required int ownerId,
    required String filePath,
    this.createdAt = const Value.absent(),
  }) : ownerType = Value(ownerType),
       ownerId = Value(ownerId),
       filePath = Value(filePath);
  static Insertable<Attachment> custom({
    Expression<int>? id,
    Expression<String>? ownerType,
    Expression<int>? ownerId,
    Expression<String>? filePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerType != null) 'owner_type': ownerType,
      if (ownerId != null) 'owner_id': ownerId,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AttachmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? ownerType,
    Value<int>? ownerId,
    Value<String>? filePath,
    Value<DateTime>? createdAt,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerType.present) {
      map['owner_type'] = Variable<String>(ownerType.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _listIdMeta = const VerificationMeta('listId');
  @override
  late final GeneratedColumn<int> listId = GeneratedColumn<int>(
    'list_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shopping_lists (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listId,
    scheduledAt,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('list_id')) {
      context.handle(
        _listIdMeta,
        listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listIdMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      listId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}list_id'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final int listId;
  final DateTime scheduledAt;

  /// active | cancelled | done
  final String status;
  final DateTime createdAt;
  const Reminder({
    required this.id,
    required this.listId,
    required this.scheduledAt,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['list_id'] = Variable<int>(listId);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      listId: Value(listId),
      scheduledAt: Value(scheduledAt),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      listId: serializer.fromJson<int>(json['listId']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'listId': serializer.toJson<int>(listId),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reminder copyWith({
    int? id,
    int? listId,
    DateTime? scheduledAt,
    String? status,
    DateTime? createdAt,
  }) => Reminder(
    id: id ?? this.id,
    listId: listId ?? this.listId,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      listId: data.listId.present ? data.listId.value : this.listId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, listId, scheduledAt, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.listId == this.listId &&
          other.scheduledAt == this.scheduledAt &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<int> listId;
  final Value<DateTime> scheduledAt;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required int listId,
    required DateTime scheduledAt,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : listId = Value(listId),
       scheduledAt = Value(scheduledAt);
  static Insertable<Reminder> custom({
    Expression<int>? id,
    Expression<int>? listId,
    Expression<DateTime>? scheduledAt,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listId != null) 'list_id': listId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<int>? listId,
    Value<DateTime>? scheduledAt,
    Value<String>? status,
    Value<DateTime>? createdAt,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<int>(listId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String? value;
  final DateTime updatedAt;
  const AppSetting({required this.key, this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
    DateTime? updatedAt,
  }) => AppSetting(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String?> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StoresTable stores = $StoresTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $AislesTable aisles = $AislesTable(this);
  late final $ShoppingListsTable shoppingLists = $ShoppingListsTable(this);
  late final $ProductMemoryTable productMemory = $ProductMemoryTable(this);
  late final $PlannedItemsTable plannedItems = $PlannedItemsTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $PurchaseEntriesTable purchaseEntries = $PurchaseEntriesTable(
    this,
  );
  late final $ProductAliasesTable productAliases = $ProductAliasesTable(this);
  late final $PriceObservationsTable priceObservations =
      $PriceObservationsTable(this);
  late final $ReceiptCandidateLinesTable receiptCandidateLines =
      $ReceiptCandidateLinesTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stores,
    categories,
    aisles,
    shoppingLists,
    productMemory,
    plannedItems,
    receipts,
    purchaseEntries,
    productAliases,
    priceObservations,
    receiptCandidateLines,
    attachments,
    reminders,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'stores',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('aisles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shopping_lists',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('planned_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shopping_lists',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('receipts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shopping_lists',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'planned_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_entries', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'receipts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_entries', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'product_memory',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_aliases', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchase_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('price_observations', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'receipts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('receipt_candidate_lines', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'planned_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('receipt_candidate_lines', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shopping_lists',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$StoresTableCreateCompanionBuilder = StoresCompanion Function({
  Value<int> id,
  required String name,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
});
typedef $$StoresTableUpdateCompanionBuilder = StoresCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
});

final class $$StoresTableReferences
    extends BaseReferences<_$AppDatabase, $StoresTable, Store> {
  $$StoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AislesTable, List<Aisle>> _aislesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.aisles,
    aliasName: 'stores__id__aisles__store_id',
  );

  $$AislesTableProcessedTableManager get aislesRefs {
    final manager = $$AislesTableTableManager(
      $_db,
      $_db.aisles,
    ).filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_aislesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShoppingListsTable, List<ShoppingList>>
  _shoppingListsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shoppingLists,
    aliasName: 'stores__id__shopping_lists__store_id',
  );

  $$ShoppingListsTableProcessedTableManager get shoppingListsRefs {
    final manager = $$ShoppingListsTableTableManager(
      $_db,
      $_db.shoppingLists,
    ).filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_shoppingListsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductAliasesTable, List<ProductAliase>>
  _productAliasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productAliases,
    aliasName: 'stores__id__product_aliases__store_id',
  );

  $$ProductAliasesTableProcessedTableManager get productAliasesRefs {
    final manager = $$ProductAliasesTableTableManager(
      $_db,
      $_db.productAliases,
    ).filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productAliasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PriceObservationsTable, List<PriceObservation>>
  _priceObservationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.priceObservations,
        aliasName: 'stores__id__price_observations__store_id',
      );

  $$PriceObservationsTableProcessedTableManager get priceObservationsRefs {
    final manager = $$PriceObservationsTableTableManager(
      $_db,
      $_db.priceObservations,
    ).filter((f) => f.storeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _priceObservationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StoresTableFilterComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> aislesRefs(
    Expression<bool> Function($$AislesTableFilterComposer f) f,
  ) {
    final $$AislesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aisles,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AislesTableFilterComposer(
            $db: $db,
            $table: $db.aisles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shoppingListsRefs(
    Expression<bool> Function($$ShoppingListsTableFilterComposer f) f,
  ) {
    final $$ShoppingListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableFilterComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productAliasesRefs(
    Expression<bool> Function($$ProductAliasesTableFilterComposer f) f,
  ) {
    final $$ProductAliasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productAliases,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductAliasesTableFilterComposer(
            $db: $db,
            $table: $db.productAliases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> priceObservationsRefs(
    Expression<bool> Function($$PriceObservationsTableFilterComposer f) f,
  ) {
    final $$PriceObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.priceObservations,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PriceObservationsTableFilterComposer(
            $db: $db,
            $table: $db.priceObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoresTableOrderingComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> aislesRefs<T extends Object>(
    Expression<T> Function($$AislesTableAnnotationComposer a) f,
  ) {
    final $$AislesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aisles,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AislesTableAnnotationComposer(
            $db: $db,
            $table: $db.aisles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shoppingListsRefs<T extends Object>(
    Expression<T> Function($$ShoppingListsTableAnnotationComposer a) f,
  ) {
    final $$ShoppingListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productAliasesRefs<T extends Object>(
    Expression<T> Function($$ProductAliasesTableAnnotationComposer a) f,
  ) {
    final $$ProductAliasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productAliases,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductAliasesTableAnnotationComposer(
            $db: $db,
            $table: $db.productAliases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> priceObservationsRefs<T extends Object>(
    Expression<T> Function($$PriceObservationsTableAnnotationComposer a) f,
  ) {
    final $$PriceObservationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.priceObservations,
          getReferencedColumn: (t) => t.storeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PriceObservationsTableAnnotationComposer(
                $db: $db,
                $table: $db.priceObservations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$StoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoresTable,
          Store,
          $$StoresTableFilterComposer,
          $$StoresTableOrderingComposer,
          $$StoresTableAnnotationComposer,
          $$StoresTableCreateCompanionBuilder,
          $$StoresTableUpdateCompanionBuilder,
          (Store, $$StoresTableReferences),
          Store,
          PrefetchHooks Function({
            bool aislesRefs,
            bool shoppingListsRefs,
            bool productAliasesRefs,
            bool priceObservationsRefs,
          })
        > {
  $$StoresTableTableManager(_$AppDatabase db, $StoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StoresCompanion(
                id: id,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StoresCompanion.insert(
                id: id,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StoresTable, Store>(table),
                  $$StoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                aislesRefs = false,
                shoppingListsRefs = false,
                productAliasesRefs = false,
                priceObservationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aislesRefs) db.aisles,
                    if (shoppingListsRefs) db.shoppingLists,
                    if (productAliasesRefs) db.productAliases,
                    if (priceObservationsRefs) db.priceObservations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aislesRefs)
                        await $_getPrefetchedData<Store, $StoresTable, Aisle>(
                          currentTable: table,
                          referencedTable: $$StoresTableReferences
                              ._aislesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoresTableReferences(db, table, p0).aislesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.storeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shoppingListsRefs)
                        await $_getPrefetchedData<
                          Store,
                          $StoresTable,
                          ShoppingList
                        >(
                          currentTable: table,
                          referencedTable: $$StoresTableReferences
                              ._shoppingListsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoresTableReferences(
                                db,
                                table,
                                p0,
                              ).shoppingListsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.storeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productAliasesRefs)
                        await $_getPrefetchedData<
                          Store,
                          $StoresTable,
                          ProductAliase
                        >(
                          currentTable: table,
                          referencedTable: $$StoresTableReferences
                              ._productAliasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoresTableReferences(
                                db,
                                table,
                                p0,
                              ).productAliasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.storeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (priceObservationsRefs)
                        await $_getPrefetchedData<
                          Store,
                          $StoresTable,
                          PriceObservation
                        >(
                          currentTable: table,
                          referencedTable: $$StoresTableReferences
                              ._priceObservationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoresTableReferences(
                                db,
                                table,
                                p0,
                              ).priceObservationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.storeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoresTable,
      Store,
      $$StoresTableFilterComposer,
      $$StoresTableOrderingComposer,
      $$StoresTableAnnotationComposer,
      $$StoresTableCreateCompanionBuilder,
      $$StoresTableUpdateCompanionBuilder,
      (Store, $$StoresTableReferences),
      Store,
      PrefetchHooks Function({
        bool aislesRefs,
        bool shoppingListsRefs,
        bool productAliasesRefs,
        bool priceObservationsRefs,
      })
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required String name,
  Value<int> sortOrder,
  Value<String?> iconToken,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> sortOrder,
  Value<String?> iconToken,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductMemoryTable, List<ProductMemoryData>>
  _productMemoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productMemory,
    aliasName: 'categories__id__product_memory__default_category_id',
  );

  $$ProductMemoryTableProcessedTableManager get productMemoryRefs {
    final manager = $$ProductMemoryTableTableManager(
      $_db,
      $_db.productMemory,
    ).filter((f) => f.defaultCategoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productMemoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlannedItemsTable, List<PlannedItem>>
  _plannedItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.plannedItems,
    aliasName: 'categories__id__planned_items__category_id',
  );

  $$PlannedItemsTableProcessedTableManager get plannedItemsRefs {
    final manager = $$PlannedItemsTableTableManager(
      $_db,
      $_db.plannedItems,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_plannedItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconToken => $composableBuilder(
    column: $table.iconToken,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productMemoryRefs(
    Expression<bool> Function($$ProductMemoryTableFilterComposer f) f,
  ) {
    final $$ProductMemoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableFilterComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> plannedItemsRefs(
    Expression<bool> Function($$PlannedItemsTableFilterComposer f) f,
  ) {
    final $$PlannedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableFilterComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconToken => $composableBuilder(
    column: $table.iconToken,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get iconToken =>
      $composableBuilder(column: $table.iconToken, builder: (column) => column);

  Expression<T> productMemoryRefs<T extends Object>(
    Expression<T> Function($$ProductMemoryTableAnnotationComposer a) f,
  ) {
    final $$ProductMemoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableAnnotationComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> plannedItemsRefs<T extends Object>(
    Expression<T> Function($$PlannedItemsTableAnnotationComposer a) f,
  ) {
    final $$PlannedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({
            bool productMemoryRefs,
            bool plannedItemsRefs,
          })
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> iconToken = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                sortOrder: sortOrder,
                iconToken: iconToken,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<String?> iconToken = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                sortOrder: sortOrder,
                iconToken: iconToken,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({productMemoryRefs = false, plannedItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (productMemoryRefs) db.productMemory,
                    if (plannedItemsRefs) db.plannedItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (productMemoryRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          ProductMemoryData
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._productMemoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).productMemoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultCategoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (plannedItemsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          PlannedItem
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._plannedItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).plannedItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool productMemoryRefs, bool plannedItemsRefs})
    >;
typedef $$AislesTableCreateCompanionBuilder = AislesCompanion Function({
  Value<int> id,
  required String name,
  Value<int?> storeId,
  Value<int> sortOrder,
});
typedef $$AislesTableUpdateCompanionBuilder = AislesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int?> storeId,
  Value<int> sortOrder,
});

final class $$AislesTableReferences
    extends BaseReferences<_$AppDatabase, $AislesTable, Aisle> {
  $$AislesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('aisles__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager(
      $_db,
      $_db.stores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlannedItemsTable, List<PlannedItem>>
  _plannedItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.plannedItems,
    aliasName: 'aisles__id__planned_items__aisle_id',
  );

  $$PlannedItemsTableProcessedTableManager get plannedItemsRefs {
    final manager = $$PlannedItemsTableTableManager(
      $_db,
      $_db.plannedItems,
    ).filter((f) => f.aisleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_plannedItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AislesTableFilterComposer
    extends Composer<_$AppDatabase, $AislesTable> {
  $$AislesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableFilterComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> plannedItemsRefs(
    Expression<bool> Function($$PlannedItemsTableFilterComposer f) f,
  ) {
    final $$PlannedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.aisleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableFilterComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AislesTableOrderingComposer
    extends Composer<_$AppDatabase, $AislesTable> {
  $$AislesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableOrderingComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AislesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AislesTable> {
  $$AislesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableAnnotationComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> plannedItemsRefs<T extends Object>(
    Expression<T> Function($$PlannedItemsTableAnnotationComposer a) f,
  ) {
    final $$PlannedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.aisleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AislesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AislesTable,
          Aisle,
          $$AislesTableFilterComposer,
          $$AislesTableOrderingComposer,
          $$AislesTableAnnotationComposer,
          $$AislesTableCreateCompanionBuilder,
          $$AislesTableUpdateCompanionBuilder,
          (Aisle, $$AislesTableReferences),
          Aisle,
          PrefetchHooks Function({bool storeId, bool plannedItemsRefs})
        > {
  $$AislesTableTableManager(_$AppDatabase db, $AislesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AislesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AislesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AislesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> storeId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => AislesCompanion(
                id: id,
                name: name,
                storeId: storeId,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> storeId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => AislesCompanion.insert(
                id: id,
                name: name,
                storeId: storeId,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AislesTable, Aisle>(table),
                  $$AislesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({storeId = false, plannedItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (plannedItemsRefs) db.plannedItems],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (storeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.storeId,
                        referencedTable: $$AislesTableReferences._storeIdTable(
                          db,
                        ),
                        referencedColumn: $$AislesTableReferences
                            ._storeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (plannedItemsRefs)
                    await $_getPrefetchedData<Aisle, $AislesTable, PlannedItem>(
                      currentTable: table,
                      referencedTable: $$AislesTableReferences
                          ._plannedItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$AislesTableReferences(
                        db,
                        table,
                        p0,
                      ).plannedItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.aisleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AislesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AislesTable,
      Aisle,
      $$AislesTableFilterComposer,
      $$AislesTableOrderingComposer,
      $$AislesTableAnnotationComposer,
      $$AislesTableCreateCompanionBuilder,
      $$AislesTableUpdateCompanionBuilder,
      (Aisle, $$AislesTableReferences),
      Aisle,
      PrefetchHooks Function({bool storeId, bool plannedItemsRefs})
    >;
typedef $$ShoppingListsTableCreateCompanionBuilder =
    ShoppingListsCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> generatedTitle,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> plannedAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<int?> storeId,
      required String currencyCode,
      Value<int?> budgetMinorUnits,
      Value<String> status,
      Value<String?> note,
      Value<String?> colorToken,
      Value<String?> iconToken,
      Value<DateTime?> archivedAt,
    });
typedef $$ShoppingListsTableUpdateCompanionBuilder =
    ShoppingListsCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> generatedTitle,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> plannedAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<int?> storeId,
      Value<String> currencyCode,
      Value<int?> budgetMinorUnits,
      Value<String> status,
      Value<String?> note,
      Value<String?> colorToken,
      Value<String?> iconToken,
      Value<DateTime?> archivedAt,
    });

final class $$ShoppingListsTableReferences
    extends BaseReferences<_$AppDatabase, $ShoppingListsTable, ShoppingList> {
  $$ShoppingListsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('shopping_lists__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager(
      $_db,
      $_db.stores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlannedItemsTable, List<PlannedItem>>
  _plannedItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.plannedItems,
    aliasName: 'shopping_lists__id__planned_items__list_id',
  );

  $$PlannedItemsTableProcessedTableManager get plannedItemsRefs {
    final manager = $$PlannedItemsTableTableManager(
      $_db,
      $_db.plannedItems,
    ).filter((f) => f.listId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_plannedItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReceiptsTable, List<Receipt>> _receiptsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.receipts,
    aliasName: 'shopping_lists__id__receipts__list_id',
  );

  $$ReceiptsTableProcessedTableManager get receiptsRefs {
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.listId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseEntriesTable, List<PurchaseEntry>>
  _purchaseEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseEntries,
    aliasName: 'shopping_lists__id__purchase_entries__list_id',
  );

  $$PurchaseEntriesTableProcessedTableManager get purchaseEntriesRefs {
    final manager = $$PurchaseEntriesTableTableManager(
      $_db,
      $_db.purchaseEntries,
    ).filter((f) => f.listId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<Reminder>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'shopping_lists__id__reminders__list_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.listId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShoppingListsTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingListsTable> {
  $$ShoppingListsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get generatedTitle => $composableBuilder(
    column: $table.generatedTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plannedAt => $composableBuilder(
    column: $table.plannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get budgetMinorUnits => $composableBuilder(
    column: $table.budgetMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconToken => $composableBuilder(
    column: $table.iconToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableFilterComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> plannedItemsRefs(
    Expression<bool> Function($$PlannedItemsTableFilterComposer f) f,
  ) {
    final $$PlannedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableFilterComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> receiptsRefs(
    Expression<bool> Function($$ReceiptsTableFilterComposer f) f,
  ) {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseEntriesRefs(
    Expression<bool> Function($$PurchaseEntriesTableFilterComposer f) f,
  ) {
    final $$PurchaseEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShoppingListsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingListsTable> {
  $$ShoppingListsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get generatedTitle => $composableBuilder(
    column: $table.generatedTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plannedAt => $composableBuilder(
    column: $table.plannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get budgetMinorUnits => $composableBuilder(
    column: $table.budgetMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconToken => $composableBuilder(
    column: $table.iconToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableOrderingComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingListsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingListsTable> {
  $$ShoppingListsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get generatedTitle => $composableBuilder(
    column: $table.generatedTitle,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedAt =>
      $composableBuilder(column: $table.plannedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get budgetMinorUnits => $composableBuilder(
    column: $table.budgetMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconToken =>
      $composableBuilder(column: $table.iconToken, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableAnnotationComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> plannedItemsRefs<T extends Object>(
    Expression<T> Function($$PlannedItemsTableAnnotationComposer a) f,
  ) {
    final $$PlannedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> receiptsRefs<T extends Object>(
    Expression<T> Function($$ReceiptsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseEntriesRefs<T extends Object>(
    Expression<T> Function($$PurchaseEntriesTableAnnotationComposer a) f,
  ) {
    final $$PurchaseEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.listId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShoppingListsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingListsTable,
          ShoppingList,
          $$ShoppingListsTableFilterComposer,
          $$ShoppingListsTableOrderingComposer,
          $$ShoppingListsTableAnnotationComposer,
          $$ShoppingListsTableCreateCompanionBuilder,
          $$ShoppingListsTableUpdateCompanionBuilder,
          (ShoppingList, $$ShoppingListsTableReferences),
          ShoppingList,
          PrefetchHooks Function({
            bool storeId,
            bool plannedItemsRefs,
            bool receiptsRefs,
            bool purchaseEntriesRefs,
            bool remindersRefs,
          })
        > {
  $$ShoppingListsTableTableManager(_$AppDatabase db, $ShoppingListsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> generatedTitle = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> plannedAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> storeId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int?> budgetMinorUnits = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> colorToken = const Value.absent(),
                Value<String?> iconToken = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
              }) => ShoppingListsCompanion(
                id: id,
                title: title,
                generatedTitle: generatedTitle,
                createdAt: createdAt,
                updatedAt: updatedAt,
                plannedAt: plannedAt,
                startedAt: startedAt,
                completedAt: completedAt,
                storeId: storeId,
                currencyCode: currencyCode,
                budgetMinorUnits: budgetMinorUnits,
                status: status,
                note: note,
                colorToken: colorToken,
                iconToken: iconToken,
                archivedAt: archivedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> generatedTitle = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> plannedAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> storeId = const Value.absent(),
                required String currencyCode,
                Value<int?> budgetMinorUnits = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> colorToken = const Value.absent(),
                Value<String?> iconToken = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
              }) => ShoppingListsCompanion.insert(
                id: id,
                title: title,
                generatedTitle: generatedTitle,
                createdAt: createdAt,
                updatedAt: updatedAt,
                plannedAt: plannedAt,
                startedAt: startedAt,
                completedAt: completedAt,
                storeId: storeId,
                currencyCode: currencyCode,
                budgetMinorUnits: budgetMinorUnits,
                status: status,
                note: note,
                colorToken: colorToken,
                iconToken: iconToken,
                archivedAt: archivedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShoppingListsTable, ShoppingList>(table),
                  $$ShoppingListsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                storeId = false,
                plannedItemsRefs = false,
                receiptsRefs = false,
                purchaseEntriesRefs = false,
                remindersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (plannedItemsRefs) db.plannedItems,
                    if (receiptsRefs) db.receipts,
                    if (purchaseEntriesRefs) db.purchaseEntries,
                    if (remindersRefs) db.reminders,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (storeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.storeId,
                            referencedTable: $$ShoppingListsTableReferences
                                ._storeIdTable(db),
                            referencedColumn: $$ShoppingListsTableReferences
                                ._storeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (plannedItemsRefs)
                        await $_getPrefetchedData<
                          ShoppingList,
                          $ShoppingListsTable,
                          PlannedItem
                        >(
                          currentTable: table,
                          referencedTable: $$ShoppingListsTableReferences
                              ._plannedItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShoppingListsTableReferences(
                                db,
                                table,
                                p0,
                              ).plannedItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (receiptsRefs)
                        await $_getPrefetchedData<
                          ShoppingList,
                          $ShoppingListsTable,
                          Receipt
                        >(
                          currentTable: table,
                          referencedTable: $$ShoppingListsTableReferences
                              ._receiptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShoppingListsTableReferences(
                                db,
                                table,
                                p0,
                              ).receiptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseEntriesRefs)
                        await $_getPrefetchedData<
                          ShoppingList,
                          $ShoppingListsTable,
                          PurchaseEntry
                        >(
                          currentTable: table,
                          referencedTable: $$ShoppingListsTableReferences
                              ._purchaseEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShoppingListsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          ShoppingList,
                          $ShoppingListsTable,
                          Reminder
                        >(
                          currentTable: table,
                          referencedTable: $$ShoppingListsTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShoppingListsTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ShoppingListsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingListsTable,
      ShoppingList,
      $$ShoppingListsTableFilterComposer,
      $$ShoppingListsTableOrderingComposer,
      $$ShoppingListsTableAnnotationComposer,
      $$ShoppingListsTableCreateCompanionBuilder,
      $$ShoppingListsTableUpdateCompanionBuilder,
      (ShoppingList, $$ShoppingListsTableReferences),
      ShoppingList,
      PrefetchHooks Function({
        bool storeId,
        bool plannedItemsRefs,
        bool receiptsRefs,
        bool purchaseEntriesRefs,
        bool remindersRefs,
      })
    >;
typedef $$ProductMemoryTableCreateCompanionBuilder =
    ProductMemoryCompanion Function({
      Value<int> id,
      required String canonicalName,
      required String normalizedName,
      Value<int?> defaultCategoryId,
      Value<String?> defaultUnitCode,
      Value<bool> favorite,
      Value<int> useCount,
      Value<DateTime?> lastUsedAt,
    });
typedef $$ProductMemoryTableUpdateCompanionBuilder =
    ProductMemoryCompanion Function({
      Value<int> id,
      Value<String> canonicalName,
      Value<String> normalizedName,
      Value<int?> defaultCategoryId,
      Value<String?> defaultUnitCode,
      Value<bool> favorite,
      Value<int> useCount,
      Value<DateTime?> lastUsedAt,
    });

final class $$ProductMemoryTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProductMemoryTable, ProductMemoryData> {
  $$ProductMemoryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _defaultCategoryIdTable(_$AppDatabase db) => db
      .categories
      .createAlias('product_memory__default_category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get defaultCategoryId {
    final $_column = $_itemColumn<int>('default_category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlannedItemsTable, List<PlannedItem>>
  _plannedItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.plannedItems,
    aliasName: 'product_memory__id__planned_items__product_id',
  );

  $$PlannedItemsTableProcessedTableManager get plannedItemsRefs {
    final manager = $$PlannedItemsTableTableManager(
      $_db,
      $_db.plannedItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_plannedItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductAliasesTable, List<ProductAliase>>
  _productAliasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productAliases,
    aliasName: 'product_memory__id__product_aliases__product_id',
  );

  $$ProductAliasesTableProcessedTableManager get productAliasesRefs {
    final manager = $$ProductAliasesTableTableManager(
      $_db,
      $_db.productAliases,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productAliasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PriceObservationsTable, List<PriceObservation>>
  _priceObservationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.priceObservations,
        aliasName: 'product_memory__id__price_observations__product_id',
      );

  $$PriceObservationsTableProcessedTableManager get priceObservationsRefs {
    final manager = $$PriceObservationsTableTableManager(
      $_db,
      $_db.priceObservations,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _priceObservationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductMemoryTableFilterComposer
    extends Composer<_$AppDatabase, $ProductMemoryTable> {
  $$ProductMemoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUnitCode => $composableBuilder(
    column: $table.defaultUnitCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get useCount => $composableBuilder(
    column: $table.useCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get defaultCategoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> plannedItemsRefs(
    Expression<bool> Function($$PlannedItemsTableFilterComposer f) f,
  ) {
    final $$PlannedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableFilterComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productAliasesRefs(
    Expression<bool> Function($$ProductAliasesTableFilterComposer f) f,
  ) {
    final $$ProductAliasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productAliases,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductAliasesTableFilterComposer(
            $db: $db,
            $table: $db.productAliases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> priceObservationsRefs(
    Expression<bool> Function($$PriceObservationsTableFilterComposer f) f,
  ) {
    final $$PriceObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.priceObservations,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PriceObservationsTableFilterComposer(
            $db: $db,
            $table: $db.priceObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductMemoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductMemoryTable> {
  $$ProductMemoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUnitCode => $composableBuilder(
    column: $table.defaultUnitCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get useCount => $composableBuilder(
    column: $table.useCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get defaultCategoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductMemoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductMemoryTable> {
  $$ProductMemoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultUnitCode => $composableBuilder(
    column: $table.defaultUnitCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get favorite =>
      $composableBuilder(column: $table.favorite, builder: (column) => column);

  GeneratedColumn<int> get useCount =>
      $composableBuilder(column: $table.useCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get defaultCategoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> plannedItemsRefs<T extends Object>(
    Expression<T> Function($$PlannedItemsTableAnnotationComposer a) f,
  ) {
    final $$PlannedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productAliasesRefs<T extends Object>(
    Expression<T> Function($$ProductAliasesTableAnnotationComposer a) f,
  ) {
    final $$ProductAliasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productAliases,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductAliasesTableAnnotationComposer(
            $db: $db,
            $table: $db.productAliases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> priceObservationsRefs<T extends Object>(
    Expression<T> Function($$PriceObservationsTableAnnotationComposer a) f,
  ) {
    final $$PriceObservationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.priceObservations,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PriceObservationsTableAnnotationComposer(
                $db: $db,
                $table: $db.priceObservations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductMemoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductMemoryTable,
          ProductMemoryData,
          $$ProductMemoryTableFilterComposer,
          $$ProductMemoryTableOrderingComposer,
          $$ProductMemoryTableAnnotationComposer,
          $$ProductMemoryTableCreateCompanionBuilder,
          $$ProductMemoryTableUpdateCompanionBuilder,
          (ProductMemoryData, $$ProductMemoryTableReferences),
          ProductMemoryData,
          PrefetchHooks Function({
            bool defaultCategoryId,
            bool plannedItemsRefs,
            bool productAliasesRefs,
            bool priceObservationsRefs,
          })
        > {
  $$ProductMemoryTableTableManager(_$AppDatabase db, $ProductMemoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductMemoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductMemoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductMemoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> canonicalName = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<int?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultUnitCode = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<int> useCount = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
              }) => ProductMemoryCompanion(
                id: id,
                canonicalName: canonicalName,
                normalizedName: normalizedName,
                defaultCategoryId: defaultCategoryId,
                defaultUnitCode: defaultUnitCode,
                favorite: favorite,
                useCount: useCount,
                lastUsedAt: lastUsedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String canonicalName,
                required String normalizedName,
                Value<int?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultUnitCode = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<int> useCount = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
              }) => ProductMemoryCompanion.insert(
                id: id,
                canonicalName: canonicalName,
                normalizedName: normalizedName,
                defaultCategoryId: defaultCategoryId,
                defaultUnitCode: defaultUnitCode,
                favorite: favorite,
                useCount: useCount,
                lastUsedAt: lastUsedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductMemoryTable, ProductMemoryData>(table),
                  $$ProductMemoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                defaultCategoryId = false,
                plannedItemsRefs = false,
                productAliasesRefs = false,
                priceObservationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (plannedItemsRefs) db.plannedItems,
                    if (productAliasesRefs) db.productAliases,
                    if (priceObservationsRefs) db.priceObservations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (defaultCategoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.defaultCategoryId,
                            referencedTable: $$ProductMemoryTableReferences
                                ._defaultCategoryIdTable(db),
                            referencedColumn: $$ProductMemoryTableReferences
                                ._defaultCategoryIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (plannedItemsRefs)
                        await $_getPrefetchedData<
                          ProductMemoryData,
                          $ProductMemoryTable,
                          PlannedItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductMemoryTableReferences
                              ._plannedItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductMemoryTableReferences(
                                db,
                                table,
                                p0,
                              ).plannedItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productAliasesRefs)
                        await $_getPrefetchedData<
                          ProductMemoryData,
                          $ProductMemoryTable,
                          ProductAliase
                        >(
                          currentTable: table,
                          referencedTable: $$ProductMemoryTableReferences
                              ._productAliasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductMemoryTableReferences(
                                db,
                                table,
                                p0,
                              ).productAliasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (priceObservationsRefs)
                        await $_getPrefetchedData<
                          ProductMemoryData,
                          $ProductMemoryTable,
                          PriceObservation
                        >(
                          currentTable: table,
                          referencedTable: $$ProductMemoryTableReferences
                              ._priceObservationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductMemoryTableReferences(
                                db,
                                table,
                                p0,
                              ).priceObservationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductMemoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductMemoryTable,
      ProductMemoryData,
      $$ProductMemoryTableFilterComposer,
      $$ProductMemoryTableOrderingComposer,
      $$ProductMemoryTableAnnotationComposer,
      $$ProductMemoryTableCreateCompanionBuilder,
      $$ProductMemoryTableUpdateCompanionBuilder,
      (ProductMemoryData, $$ProductMemoryTableReferences),
      ProductMemoryData,
      PrefetchHooks Function({
        bool defaultCategoryId,
        bool plannedItemsRefs,
        bool productAliasesRefs,
        bool priceObservationsRefs,
      })
    >;
typedef $$PlannedItemsTableCreateCompanionBuilder =
    PlannedItemsCompanion Function({
      Value<int> id,
      required int listId,
      Value<int?> productId,
      required String name,
      required String normalizedName,
      Value<String?> brand,
      Value<int?> categoryId,
      Value<int?> aisleId,
      required String plannedQuantity,
      required String plannedUnitCode,
      required String pricingInputMode,
      Value<String?> plannedUnitPrice,
      Value<int?> plannedLineTotalMinorUnits,
      Value<String?> maxAcceptablePrice,
      Value<bool> requiredFlag,
      Value<String?> note,
      Value<int> sortOrder,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PlannedItemsTableUpdateCompanionBuilder =
    PlannedItemsCompanion Function({
      Value<int> id,
      Value<int> listId,
      Value<int?> productId,
      Value<String> name,
      Value<String> normalizedName,
      Value<String?> brand,
      Value<int?> categoryId,
      Value<int?> aisleId,
      Value<String> plannedQuantity,
      Value<String> plannedUnitCode,
      Value<String> pricingInputMode,
      Value<String?> plannedUnitPrice,
      Value<int?> plannedLineTotalMinorUnits,
      Value<String?> maxAcceptablePrice,
      Value<bool> requiredFlag,
      Value<String?> note,
      Value<int> sortOrder,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$PlannedItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PlannedItemsTable, PlannedItem> {
  $$PlannedItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShoppingListsTable _listIdTable(_$AppDatabase db) => db.shoppingLists
      .createAlias('planned_items__list_id__shopping_lists__id');

  $$ShoppingListsTableProcessedTableManager get listId {
    final $_column = $_itemColumn<int>('list_id')!;

    final manager = $$ShoppingListsTableTableManager(
      $_db,
      $_db.shoppingLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductMemoryTable _productIdTable(_$AppDatabase db) => db
      .productMemory
      .createAlias('planned_items__product_id__product_memory__id');

  $$ProductMemoryTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductMemoryTableTableManager(
      $_db,
      $_db.productMemory,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('planned_items__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AislesTable _aisleIdTable(_$AppDatabase db) =>
      db.aisles.createAlias('planned_items__aisle_id__aisles__id');

  $$AislesTableProcessedTableManager? get aisleId {
    final $_column = $_itemColumn<int>('aisle_id');
    if ($_column == null) return null;
    final manager = $$AislesTableTableManager(
      $_db,
      $_db.aisles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_aisleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseEntriesTable, List<PurchaseEntry>>
  _purchaseEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseEntries,
    aliasName: 'planned_items__id__purchase_entries__planned_item_id',
  );

  $$PurchaseEntriesTableProcessedTableManager get purchaseEntriesRefs {
    final manager = $$PurchaseEntriesTableTableManager(
      $_db,
      $_db.purchaseEntries,
    ).filter((f) => f.plannedItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ReceiptCandidateLinesTable,
    List<ReceiptCandidateLine>
  >
  _receiptCandidateLinesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.receiptCandidateLines,
    aliasName:
        'planned_items__id__receipt_candidate_lines__linked_planned_item_id',
  );

  $$ReceiptCandidateLinesTableProcessedTableManager
  get receiptCandidateLinesRefs {
    final manager =
        $$ReceiptCandidateLinesTableTableManager(
          $_db,
          $_db.receiptCandidateLines,
        ).filter(
          (f) => f.linkedPlannedItemId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _receiptCandidateLinesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlannedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PlannedItemsTable> {
  $$PlannedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plannedQuantity => $composableBuilder(
    column: $table.plannedQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plannedUnitCode => $composableBuilder(
    column: $table.plannedUnitCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pricingInputMode => $composableBuilder(
    column: $table.pricingInputMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plannedUnitPrice => $composableBuilder(
    column: $table.plannedUnitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedLineTotalMinorUnits => $composableBuilder(
    column: $table.plannedLineTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maxAcceptablePrice => $composableBuilder(
    column: $table.maxAcceptablePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiredFlag => $composableBuilder(
    column: $table.requiredFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShoppingListsTableFilterComposer get listId {
    final $$ShoppingListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableFilterComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductMemoryTableFilterComposer get productId {
    final $$ProductMemoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableFilterComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AislesTableFilterComposer get aisleId {
    final $$AislesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aisleId,
      referencedTable: $db.aisles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AislesTableFilterComposer(
            $db: $db,
            $table: $db.aisles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseEntriesRefs(
    Expression<bool> Function($$PurchaseEntriesTableFilterComposer f) f,
  ) {
    final $$PurchaseEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.plannedItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> receiptCandidateLinesRefs(
    Expression<bool> Function($$ReceiptCandidateLinesTableFilterComposer f) f,
  ) {
    final $$ReceiptCandidateLinesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.receiptCandidateLines,
          getReferencedColumn: (t) => t.linkedPlannedItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReceiptCandidateLinesTableFilterComposer(
                $db: $db,
                $table: $db.receiptCandidateLines,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PlannedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlannedItemsTable> {
  $$PlannedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plannedQuantity => $composableBuilder(
    column: $table.plannedQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plannedUnitCode => $composableBuilder(
    column: $table.plannedUnitCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pricingInputMode => $composableBuilder(
    column: $table.pricingInputMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plannedUnitPrice => $composableBuilder(
    column: $table.plannedUnitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedLineTotalMinorUnits => $composableBuilder(
    column: $table.plannedLineTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maxAcceptablePrice => $composableBuilder(
    column: $table.maxAcceptablePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiredFlag => $composableBuilder(
    column: $table.requiredFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShoppingListsTableOrderingComposer get listId {
    final $$ShoppingListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableOrderingComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductMemoryTableOrderingComposer get productId {
    final $$ProductMemoryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableOrderingComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AislesTableOrderingComposer get aisleId {
    final $$AislesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aisleId,
      referencedTable: $db.aisles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AislesTableOrderingComposer(
            $db: $db,
            $table: $db.aisles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlannedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlannedItemsTable> {
  $$PlannedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get plannedQuantity => $composableBuilder(
    column: $table.plannedQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plannedUnitCode => $composableBuilder(
    column: $table.plannedUnitCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pricingInputMode => $composableBuilder(
    column: $table.pricingInputMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plannedUnitPrice => $composableBuilder(
    column: $table.plannedUnitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedLineTotalMinorUnits => $composableBuilder(
    column: $table.plannedLineTotalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get maxAcceptablePrice => $composableBuilder(
    column: $table.maxAcceptablePrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiredFlag => $composableBuilder(
    column: $table.requiredFlag,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ShoppingListsTableAnnotationComposer get listId {
    final $$ShoppingListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductMemoryTableAnnotationComposer get productId {
    final $$ProductMemoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableAnnotationComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AislesTableAnnotationComposer get aisleId {
    final $$AislesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aisleId,
      referencedTable: $db.aisles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AislesTableAnnotationComposer(
            $db: $db,
            $table: $db.aisles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseEntriesRefs<T extends Object>(
    Expression<T> Function($$PurchaseEntriesTableAnnotationComposer a) f,
  ) {
    final $$PurchaseEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.plannedItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> receiptCandidateLinesRefs<T extends Object>(
    Expression<T> Function($$ReceiptCandidateLinesTableAnnotationComposer a) f,
  ) {
    final $$ReceiptCandidateLinesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.receiptCandidateLines,
          getReferencedColumn: (t) => t.linkedPlannedItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReceiptCandidateLinesTableAnnotationComposer(
                $db: $db,
                $table: $db.receiptCandidateLines,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PlannedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlannedItemsTable,
          PlannedItem,
          $$PlannedItemsTableFilterComposer,
          $$PlannedItemsTableOrderingComposer,
          $$PlannedItemsTableAnnotationComposer,
          $$PlannedItemsTableCreateCompanionBuilder,
          $$PlannedItemsTableUpdateCompanionBuilder,
          (PlannedItem, $$PlannedItemsTableReferences),
          PlannedItem,
          PrefetchHooks Function({
            bool listId,
            bool productId,
            bool categoryId,
            bool aisleId,
            bool purchaseEntriesRefs,
            bool receiptCandidateLinesRefs,
          })
        > {
  $$PlannedItemsTableTableManager(_$AppDatabase db, $PlannedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlannedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlannedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlannedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> listId = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> aisleId = const Value.absent(),
                Value<String> plannedQuantity = const Value.absent(),
                Value<String> plannedUnitCode = const Value.absent(),
                Value<String> pricingInputMode = const Value.absent(),
                Value<String?> plannedUnitPrice = const Value.absent(),
                Value<int?> plannedLineTotalMinorUnits = const Value.absent(),
                Value<String?> maxAcceptablePrice = const Value.absent(),
                Value<bool> requiredFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PlannedItemsCompanion(
                id: id,
                listId: listId,
                productId: productId,
                name: name,
                normalizedName: normalizedName,
                brand: brand,
                categoryId: categoryId,
                aisleId: aisleId,
                plannedQuantity: plannedQuantity,
                plannedUnitCode: plannedUnitCode,
                pricingInputMode: pricingInputMode,
                plannedUnitPrice: plannedUnitPrice,
                plannedLineTotalMinorUnits: plannedLineTotalMinorUnits,
                maxAcceptablePrice: maxAcceptablePrice,
                requiredFlag: requiredFlag,
                note: note,
                sortOrder: sortOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int listId,
                Value<int?> productId = const Value.absent(),
                required String name,
                required String normalizedName,
                Value<String?> brand = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> aisleId = const Value.absent(),
                required String plannedQuantity,
                required String plannedUnitCode,
                required String pricingInputMode,
                Value<String?> plannedUnitPrice = const Value.absent(),
                Value<int?> plannedLineTotalMinorUnits = const Value.absent(),
                Value<String?> maxAcceptablePrice = const Value.absent(),
                Value<bool> requiredFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PlannedItemsCompanion.insert(
                id: id,
                listId: listId,
                productId: productId,
                name: name,
                normalizedName: normalizedName,
                brand: brand,
                categoryId: categoryId,
                aisleId: aisleId,
                plannedQuantity: plannedQuantity,
                plannedUnitCode: plannedUnitCode,
                pricingInputMode: pricingInputMode,
                plannedUnitPrice: plannedUnitPrice,
                plannedLineTotalMinorUnits: plannedLineTotalMinorUnits,
                maxAcceptablePrice: maxAcceptablePrice,
                requiredFlag: requiredFlag,
                note: note,
                sortOrder: sortOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlannedItemsTable, PlannedItem>(table),
                  $$PlannedItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                listId = false,
                productId = false,
                categoryId = false,
                aisleId = false,
                purchaseEntriesRefs = false,
                receiptCandidateLinesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseEntriesRefs) db.purchaseEntries,
                    if (receiptCandidateLinesRefs) db.receiptCandidateLines,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (listId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.listId,
                            referencedTable: $$PlannedItemsTableReferences
                                ._listIdTable(db),
                            referencedColumn: $$PlannedItemsTableReferences
                                ._listIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (productId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.productId,
                            referencedTable: $$PlannedItemsTableReferences
                                ._productIdTable(db),
                            referencedColumn: $$PlannedItemsTableReferences
                                ._productIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$PlannedItemsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$PlannedItemsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (aisleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.aisleId,
                            referencedTable: $$PlannedItemsTableReferences
                                ._aisleIdTable(db),
                            referencedColumn: $$PlannedItemsTableReferences
                                ._aisleIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseEntriesRefs)
                        await $_getPrefetchedData<
                          PlannedItem,
                          $PlannedItemsTable,
                          PurchaseEntry
                        >(
                          currentTable: table,
                          referencedTable: $$PlannedItemsTableReferences
                              ._purchaseEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlannedItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.plannedItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (receiptCandidateLinesRefs)
                        await $_getPrefetchedData<
                          PlannedItem,
                          $PlannedItemsTable,
                          ReceiptCandidateLine
                        >(
                          currentTable: table,
                          referencedTable: $$PlannedItemsTableReferences
                              ._receiptCandidateLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlannedItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).receiptCandidateLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.linkedPlannedItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlannedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlannedItemsTable,
      PlannedItem,
      $$PlannedItemsTableFilterComposer,
      $$PlannedItemsTableOrderingComposer,
      $$PlannedItemsTableAnnotationComposer,
      $$PlannedItemsTableCreateCompanionBuilder,
      $$PlannedItemsTableUpdateCompanionBuilder,
      (PlannedItem, $$PlannedItemsTableReferences),
      PlannedItem,
      PrefetchHooks Function({
        bool listId,
        bool productId,
        bool categoryId,
        bool aisleId,
        bool purchaseEntriesRefs,
        bool receiptCandidateLinesRefs,
      })
    >;
typedef $$ReceiptsTableCreateCompanionBuilder = ReceiptsCompanion Function({
  Value<int> id,
  Value<int?> listId,
  Value<List<String>> imagePaths,
  Value<String?> rawOcrText,
  Value<String?> detectedStore,
  Value<String?> confirmedStore,
  Value<DateTime?> detectedAt,
  Value<DateTime?> confirmedAt,
  Value<String?> detectedCurrency,
  Value<String?> confirmedCurrency,
  Value<int?> detectedTotalMinorUnits,
  Value<int?> confirmedTotalMinorUnits,
  Value<String?> parserVersion,
  Value<String> processingStatus,
  Value<DateTime> createdAt,
});
typedef $$ReceiptsTableUpdateCompanionBuilder = ReceiptsCompanion Function({
  Value<int> id,
  Value<int?> listId,
  Value<List<String>> imagePaths,
  Value<String?> rawOcrText,
  Value<String?> detectedStore,
  Value<String?> confirmedStore,
  Value<DateTime?> detectedAt,
  Value<DateTime?> confirmedAt,
  Value<String?> detectedCurrency,
  Value<String?> confirmedCurrency,
  Value<int?> detectedTotalMinorUnits,
  Value<int?> confirmedTotalMinorUnits,
  Value<String?> parserVersion,
  Value<String> processingStatus,
  Value<DateTime> createdAt,
});

final class $$ReceiptsTableReferences
    extends BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt> {
  $$ReceiptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShoppingListsTable _listIdTable(_$AppDatabase db) =>
      db.shoppingLists.createAlias('receipts__list_id__shopping_lists__id');

  $$ShoppingListsTableProcessedTableManager? get listId {
    final $_column = $_itemColumn<int>('list_id');
    if ($_column == null) return null;
    final manager = $$ShoppingListsTableTableManager(
      $_db,
      $_db.shoppingLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseEntriesTable, List<PurchaseEntry>>
  _purchaseEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseEntries,
    aliasName: 'receipts__id__purchase_entries__receipt_id',
  );

  $$PurchaseEntriesTableProcessedTableManager get purchaseEntriesRefs {
    final manager = $$PurchaseEntriesTableTableManager(
      $_db,
      $_db.purchaseEntries,
    ).filter((f) => f.receiptId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ReceiptCandidateLinesTable,
    List<ReceiptCandidateLine>
  >
  _receiptCandidateLinesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.receiptCandidateLines,
        aliasName: 'receipts__id__receipt_candidate_lines__receipt_id',
      );

  $$ReceiptCandidateLinesTableProcessedTableManager
  get receiptCandidateLinesRefs {
    final manager = $$ReceiptCandidateLinesTableTableManager(
      $_db,
      $_db.receiptCandidateLines,
    ).filter((f) => f.receiptId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _receiptCandidateLinesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get imagePaths => $composableBuilder(
    column: $table.imagePaths,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get rawOcrText => $composableBuilder(
    column: $table.rawOcrText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detectedStore => $composableBuilder(
    column: $table.detectedStore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confirmedStore => $composableBuilder(
    column: $table.confirmedStore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detectedCurrency => $composableBuilder(
    column: $table.detectedCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confirmedCurrency => $composableBuilder(
    column: $table.confirmedCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get detectedTotalMinorUnits => $composableBuilder(
    column: $table.detectedTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confirmedTotalMinorUnits => $composableBuilder(
    column: $table.confirmedTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShoppingListsTableFilterComposer get listId {
    final $$ShoppingListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableFilterComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseEntriesRefs(
    Expression<bool> Function($$PurchaseEntriesTableFilterComposer f) f,
  ) {
    final $$PurchaseEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.receiptId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> receiptCandidateLinesRefs(
    Expression<bool> Function($$ReceiptCandidateLinesTableFilterComposer f) f,
  ) {
    final $$ReceiptCandidateLinesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.receiptCandidateLines,
          getReferencedColumn: (t) => t.receiptId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReceiptCandidateLinesTableFilterComposer(
                $db: $db,
                $table: $db.receiptCandidateLines,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePaths => $composableBuilder(
    column: $table.imagePaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawOcrText => $composableBuilder(
    column: $table.rawOcrText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detectedStore => $composableBuilder(
    column: $table.detectedStore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confirmedStore => $composableBuilder(
    column: $table.confirmedStore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detectedCurrency => $composableBuilder(
    column: $table.detectedCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confirmedCurrency => $composableBuilder(
    column: $table.confirmedCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get detectedTotalMinorUnits => $composableBuilder(
    column: $table.detectedTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confirmedTotalMinorUnits => $composableBuilder(
    column: $table.confirmedTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShoppingListsTableOrderingComposer get listId {
    final $$ShoppingListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableOrderingComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get imagePaths =>
      $composableBuilder(
        column: $table.imagePaths,
        builder: (column) => column,
      );

  GeneratedColumn<String> get rawOcrText => $composableBuilder(
    column: $table.rawOcrText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get detectedStore => $composableBuilder(
    column: $table.detectedStore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confirmedStore => $composableBuilder(
    column: $table.confirmedStore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get detectedCurrency => $composableBuilder(
    column: $table.detectedCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confirmedCurrency => $composableBuilder(
    column: $table.confirmedCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<int> get detectedTotalMinorUnits => $composableBuilder(
    column: $table.detectedTotalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confirmedTotalMinorUnits => $composableBuilder(
    column: $table.confirmedTotalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ShoppingListsTableAnnotationComposer get listId {
    final $$ShoppingListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseEntriesRefs<T extends Object>(
    Expression<T> Function($$PurchaseEntriesTableAnnotationComposer a) f,
  ) {
    final $$PurchaseEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.receiptId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> receiptCandidateLinesRefs<T extends Object>(
    Expression<T> Function($$ReceiptCandidateLinesTableAnnotationComposer a) f,
  ) {
    final $$ReceiptCandidateLinesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.receiptCandidateLines,
          getReferencedColumn: (t) => t.receiptId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReceiptCandidateLinesTableAnnotationComposer(
                $db: $db,
                $table: $db.receiptCandidateLines,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          Receipt,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (Receipt, $$ReceiptsTableReferences),
          Receipt,
          PrefetchHooks Function({
            bool listId,
            bool purchaseEntriesRefs,
            bool receiptCandidateLinesRefs,
          })
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> listId = const Value.absent(),
                Value<List<String>> imagePaths = const Value.absent(),
                Value<String?> rawOcrText = const Value.absent(),
                Value<String?> detectedStore = const Value.absent(),
                Value<String?> confirmedStore = const Value.absent(),
                Value<DateTime?> detectedAt = const Value.absent(),
                Value<DateTime?> confirmedAt = const Value.absent(),
                Value<String?> detectedCurrency = const Value.absent(),
                Value<String?> confirmedCurrency = const Value.absent(),
                Value<int?> detectedTotalMinorUnits = const Value.absent(),
                Value<int?> confirmedTotalMinorUnits = const Value.absent(),
                Value<String?> parserVersion = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                listId: listId,
                imagePaths: imagePaths,
                rawOcrText: rawOcrText,
                detectedStore: detectedStore,
                confirmedStore: confirmedStore,
                detectedAt: detectedAt,
                confirmedAt: confirmedAt,
                detectedCurrency: detectedCurrency,
                confirmedCurrency: confirmedCurrency,
                detectedTotalMinorUnits: detectedTotalMinorUnits,
                confirmedTotalMinorUnits: confirmedTotalMinorUnits,
                parserVersion: parserVersion,
                processingStatus: processingStatus,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> listId = const Value.absent(),
                Value<List<String>> imagePaths = const Value.absent(),
                Value<String?> rawOcrText = const Value.absent(),
                Value<String?> detectedStore = const Value.absent(),
                Value<String?> confirmedStore = const Value.absent(),
                Value<DateTime?> detectedAt = const Value.absent(),
                Value<DateTime?> confirmedAt = const Value.absent(),
                Value<String?> detectedCurrency = const Value.absent(),
                Value<String?> confirmedCurrency = const Value.absent(),
                Value<int?> detectedTotalMinorUnits = const Value.absent(),
                Value<int?> confirmedTotalMinorUnits = const Value.absent(),
                Value<String?> parserVersion = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                listId: listId,
                imagePaths: imagePaths,
                rawOcrText: rawOcrText,
                detectedStore: detectedStore,
                confirmedStore: confirmedStore,
                detectedAt: detectedAt,
                confirmedAt: confirmedAt,
                detectedCurrency: detectedCurrency,
                confirmedCurrency: confirmedCurrency,
                detectedTotalMinorUnits: detectedTotalMinorUnits,
                confirmedTotalMinorUnits: confirmedTotalMinorUnits,
                parserVersion: parserVersion,
                processingStatus: processingStatus,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReceiptsTable, Receipt>(table),
                  $$ReceiptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                listId = false,
                purchaseEntriesRefs = false,
                receiptCandidateLinesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseEntriesRefs) db.purchaseEntries,
                    if (receiptCandidateLinesRefs) db.receiptCandidateLines,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (listId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.listId,
                            referencedTable: $$ReceiptsTableReferences
                                ._listIdTable(db),
                            referencedColumn: $$ReceiptsTableReferences
                                ._listIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseEntriesRefs)
                        await $_getPrefetchedData<
                          Receipt,
                          $ReceiptsTable,
                          PurchaseEntry
                        >(
                          currentTable: table,
                          referencedTable: $$ReceiptsTableReferences
                              ._purchaseEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReceiptsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.receiptId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (receiptCandidateLinesRefs)
                        await $_getPrefetchedData<
                          Receipt,
                          $ReceiptsTable,
                          ReceiptCandidateLine
                        >(
                          currentTable: table,
                          referencedTable: $$ReceiptsTableReferences
                              ._receiptCandidateLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReceiptsTableReferences(
                                db,
                                table,
                                p0,
                              ).receiptCandidateLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.receiptId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      Receipt,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (Receipt, $$ReceiptsTableReferences),
      Receipt,
      PrefetchHooks Function({
        bool listId,
        bool purchaseEntriesRefs,
        bool receiptCandidateLinesRefs,
      })
    >;
typedef $$PurchaseEntriesTableCreateCompanionBuilder =
    PurchaseEntriesCompanion Function({
      Value<int> id,
      required int listId,
      Value<int?> plannedItemId,
      Value<int?> receiptId,
      required String name,
      required String normalizedName,
      required String actualQuantity,
      required String actualUnitCode,
      Value<String?> actualUnitPrice,
      Value<int?> grossTotalMinorUnits,
      Value<int> discountMinorUnits,
      required int actualLineTotalMinorUnits,
      Value<String> source,
      Value<String?> confidence,
      Value<bool> userConfirmed,
      Value<bool> alternativeFlag,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PurchaseEntriesTableUpdateCompanionBuilder =
    PurchaseEntriesCompanion Function({
      Value<int> id,
      Value<int> listId,
      Value<int?> plannedItemId,
      Value<int?> receiptId,
      Value<String> name,
      Value<String> normalizedName,
      Value<String> actualQuantity,
      Value<String> actualUnitCode,
      Value<String?> actualUnitPrice,
      Value<int?> grossTotalMinorUnits,
      Value<int> discountMinorUnits,
      Value<int> actualLineTotalMinorUnits,
      Value<String> source,
      Value<String?> confidence,
      Value<bool> userConfirmed,
      Value<bool> alternativeFlag,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$PurchaseEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PurchaseEntriesTable, PurchaseEntry> {
  $$PurchaseEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShoppingListsTable _listIdTable(_$AppDatabase db) => db.shoppingLists
      .createAlias('purchase_entries__list_id__shopping_lists__id');

  $$ShoppingListsTableProcessedTableManager get listId {
    final $_column = $_itemColumn<int>('list_id')!;

    final manager = $$ShoppingListsTableTableManager(
      $_db,
      $_db.shoppingLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlannedItemsTable _plannedItemIdTable(_$AppDatabase db) => db
      .plannedItems
      .createAlias('purchase_entries__planned_item_id__planned_items__id');

  $$PlannedItemsTableProcessedTableManager? get plannedItemId {
    final $_column = $_itemColumn<int>('planned_item_id');
    if ($_column == null) return null;
    final manager = $$PlannedItemsTableTableManager(
      $_db,
      $_db.plannedItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plannedItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReceiptsTable _receiptIdTable(_$AppDatabase db) =>
      db.receipts.createAlias('purchase_entries__receipt_id__receipts__id');

  $$ReceiptsTableProcessedTableManager? get receiptId {
    final $_column = $_itemColumn<int>('receipt_id');
    if ($_column == null) return null;
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_receiptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PriceObservationsTable, List<PriceObservation>>
  _priceObservationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.priceObservations,
        aliasName:
            'purchase_entries__id__price_observations__purchase_entry_id',
      );

  $$PriceObservationsTableProcessedTableManager get priceObservationsRefs {
    final manager = $$PriceObservationsTableTableManager(
      $_db,
      $_db.priceObservations,
    ).filter((f) => f.purchaseEntryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _priceObservationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseEntriesTable> {
  $$PurchaseEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualUnitCode => $composableBuilder(
    column: $table.actualUnitCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualUnitPrice => $composableBuilder(
    column: $table.actualUnitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grossTotalMinorUnits => $composableBuilder(
    column: $table.grossTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountMinorUnits => $composableBuilder(
    column: $table.discountMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualLineTotalMinorUnits => $composableBuilder(
    column: $table.actualLineTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get userConfirmed => $composableBuilder(
    column: $table.userConfirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get alternativeFlag => $composableBuilder(
    column: $table.alternativeFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShoppingListsTableFilterComposer get listId {
    final $$ShoppingListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableFilterComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlannedItemsTableFilterComposer get plannedItemId {
    final $$PlannedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plannedItemId,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableFilterComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReceiptsTableFilterComposer get receiptId {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> priceObservationsRefs(
    Expression<bool> Function($$PriceObservationsTableFilterComposer f) f,
  ) {
    final $$PriceObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.priceObservations,
      getReferencedColumn: (t) => t.purchaseEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PriceObservationsTableFilterComposer(
            $db: $db,
            $table: $db.priceObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseEntriesTable> {
  $$PurchaseEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualUnitCode => $composableBuilder(
    column: $table.actualUnitCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualUnitPrice => $composableBuilder(
    column: $table.actualUnitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grossTotalMinorUnits => $composableBuilder(
    column: $table.grossTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountMinorUnits => $composableBuilder(
    column: $table.discountMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualLineTotalMinorUnits => $composableBuilder(
    column: $table.actualLineTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get userConfirmed => $composableBuilder(
    column: $table.userConfirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get alternativeFlag => $composableBuilder(
    column: $table.alternativeFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShoppingListsTableOrderingComposer get listId {
    final $$ShoppingListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableOrderingComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlannedItemsTableOrderingComposer get plannedItemId {
    final $$PlannedItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plannedItemId,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableOrderingComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReceiptsTableOrderingComposer get receiptId {
    final $$ReceiptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableOrderingComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseEntriesTable> {
  $$PurchaseEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actualUnitCode => $composableBuilder(
    column: $table.actualUnitCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actualUnitPrice => $composableBuilder(
    column: $table.actualUnitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get grossTotalMinorUnits => $composableBuilder(
    column: $table.grossTotalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountMinorUnits => $composableBuilder(
    column: $table.discountMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualLineTotalMinorUnits => $composableBuilder(
    column: $table.actualLineTotalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get userConfirmed => $composableBuilder(
    column: $table.userConfirmed,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get alternativeFlag => $composableBuilder(
    column: $table.alternativeFlag,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ShoppingListsTableAnnotationComposer get listId {
    final $$ShoppingListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlannedItemsTableAnnotationComposer get plannedItemId {
    final $$PlannedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plannedItemId,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReceiptsTableAnnotationComposer get receiptId {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> priceObservationsRefs<T extends Object>(
    Expression<T> Function($$PriceObservationsTableAnnotationComposer a) f,
  ) {
    final $$PriceObservationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.priceObservations,
          getReferencedColumn: (t) => t.purchaseEntryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PriceObservationsTableAnnotationComposer(
                $db: $db,
                $table: $db.priceObservations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PurchaseEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseEntriesTable,
          PurchaseEntry,
          $$PurchaseEntriesTableFilterComposer,
          $$PurchaseEntriesTableOrderingComposer,
          $$PurchaseEntriesTableAnnotationComposer,
          $$PurchaseEntriesTableCreateCompanionBuilder,
          $$PurchaseEntriesTableUpdateCompanionBuilder,
          (PurchaseEntry, $$PurchaseEntriesTableReferences),
          PurchaseEntry,
          PrefetchHooks Function({
            bool listId,
            bool plannedItemId,
            bool receiptId,
            bool priceObservationsRefs,
          })
        > {
  $$PurchaseEntriesTableTableManager(
    _$AppDatabase db,
    $PurchaseEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> listId = const Value.absent(),
                Value<int?> plannedItemId = const Value.absent(),
                Value<int?> receiptId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String> actualQuantity = const Value.absent(),
                Value<String> actualUnitCode = const Value.absent(),
                Value<String?> actualUnitPrice = const Value.absent(),
                Value<int?> grossTotalMinorUnits = const Value.absent(),
                Value<int> discountMinorUnits = const Value.absent(),
                Value<int> actualLineTotalMinorUnits = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> confidence = const Value.absent(),
                Value<bool> userConfirmed = const Value.absent(),
                Value<bool> alternativeFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PurchaseEntriesCompanion(
                id: id,
                listId: listId,
                plannedItemId: plannedItemId,
                receiptId: receiptId,
                name: name,
                normalizedName: normalizedName,
                actualQuantity: actualQuantity,
                actualUnitCode: actualUnitCode,
                actualUnitPrice: actualUnitPrice,
                grossTotalMinorUnits: grossTotalMinorUnits,
                discountMinorUnits: discountMinorUnits,
                actualLineTotalMinorUnits: actualLineTotalMinorUnits,
                source: source,
                confidence: confidence,
                userConfirmed: userConfirmed,
                alternativeFlag: alternativeFlag,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int listId,
                Value<int?> plannedItemId = const Value.absent(),
                Value<int?> receiptId = const Value.absent(),
                required String name,
                required String normalizedName,
                required String actualQuantity,
                required String actualUnitCode,
                Value<String?> actualUnitPrice = const Value.absent(),
                Value<int?> grossTotalMinorUnits = const Value.absent(),
                Value<int> discountMinorUnits = const Value.absent(),
                required int actualLineTotalMinorUnits,
                Value<String> source = const Value.absent(),
                Value<String?> confidence = const Value.absent(),
                Value<bool> userConfirmed = const Value.absent(),
                Value<bool> alternativeFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PurchaseEntriesCompanion.insert(
                id: id,
                listId: listId,
                plannedItemId: plannedItemId,
                receiptId: receiptId,
                name: name,
                normalizedName: normalizedName,
                actualQuantity: actualQuantity,
                actualUnitCode: actualUnitCode,
                actualUnitPrice: actualUnitPrice,
                grossTotalMinorUnits: grossTotalMinorUnits,
                discountMinorUnits: discountMinorUnits,
                actualLineTotalMinorUnits: actualLineTotalMinorUnits,
                source: source,
                confidence: confidence,
                userConfirmed: userConfirmed,
                alternativeFlag: alternativeFlag,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PurchaseEntriesTable, PurchaseEntry>(table),
                  $$PurchaseEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                listId = false,
                plannedItemId = false,
                receiptId = false,
                priceObservationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (priceObservationsRefs) db.priceObservations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (listId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.listId,
                            referencedTable: $$PurchaseEntriesTableReferences
                                ._listIdTable(db),
                            referencedColumn: $$PurchaseEntriesTableReferences
                                ._listIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (plannedItemId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.plannedItemId,
                            referencedTable: $$PurchaseEntriesTableReferences
                                ._plannedItemIdTable(db),
                            referencedColumn: $$PurchaseEntriesTableReferences
                                ._plannedItemIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (receiptId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.receiptId,
                            referencedTable: $$PurchaseEntriesTableReferences
                                ._receiptIdTable(db),
                            referencedColumn: $$PurchaseEntriesTableReferences
                                ._receiptIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (priceObservationsRefs)
                        await $_getPrefetchedData<
                          PurchaseEntry,
                          $PurchaseEntriesTable,
                          PriceObservation
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseEntriesTableReferences
                              ._priceObservationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).priceObservationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseEntryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PurchaseEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseEntriesTable,
      PurchaseEntry,
      $$PurchaseEntriesTableFilterComposer,
      $$PurchaseEntriesTableOrderingComposer,
      $$PurchaseEntriesTableAnnotationComposer,
      $$PurchaseEntriesTableCreateCompanionBuilder,
      $$PurchaseEntriesTableUpdateCompanionBuilder,
      (PurchaseEntry, $$PurchaseEntriesTableReferences),
      PurchaseEntry,
      PrefetchHooks Function({
        bool listId,
        bool plannedItemId,
        bool receiptId,
        bool priceObservationsRefs,
      })
    >;
typedef $$ProductAliasesTableCreateCompanionBuilder =
    ProductAliasesCompanion Function({
      Value<int> id,
      required int productId,
      required String alias,
      required String normalizedAlias,
      Value<int?> storeId,
      Value<String> source,
    });
typedef $$ProductAliasesTableUpdateCompanionBuilder =
    ProductAliasesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> alias,
      Value<String> normalizedAlias,
      Value<int?> storeId,
      Value<String> source,
    });

final class $$ProductAliasesTableReferences
    extends BaseReferences<_$AppDatabase, $ProductAliasesTable, ProductAliase> {
  $$ProductAliasesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductMemoryTable _productIdTable(_$AppDatabase db) => db
      .productMemory
      .createAlias('product_aliases__product_id__product_memory__id');

  $$ProductMemoryTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductMemoryTableTableManager(
      $_db,
      $_db.productMemory,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('product_aliases__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager(
      $_db,
      $_db.stores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductAliasesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductAliasesTable> {
  $$ProductAliasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedAlias => $composableBuilder(
    column: $table.normalizedAlias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductMemoryTableFilterComposer get productId {
    final $$ProductMemoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableFilterComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableFilterComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductAliasesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductAliasesTable> {
  $$ProductAliasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedAlias => $composableBuilder(
    column: $table.normalizedAlias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductMemoryTableOrderingComposer get productId {
    final $$ProductMemoryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableOrderingComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableOrderingComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductAliasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductAliasesTable> {
  $$ProductAliasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get normalizedAlias => $composableBuilder(
    column: $table.normalizedAlias,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$ProductMemoryTableAnnotationComposer get productId {
    final $$ProductMemoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableAnnotationComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableAnnotationComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductAliasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductAliasesTable,
          ProductAliase,
          $$ProductAliasesTableFilterComposer,
          $$ProductAliasesTableOrderingComposer,
          $$ProductAliasesTableAnnotationComposer,
          $$ProductAliasesTableCreateCompanionBuilder,
          $$ProductAliasesTableUpdateCompanionBuilder,
          (ProductAliase, $$ProductAliasesTableReferences),
          ProductAliase,
          PrefetchHooks Function({bool productId, bool storeId})
        > {
  $$ProductAliasesTableTableManager(
    _$AppDatabase db,
    $ProductAliasesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductAliasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductAliasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductAliasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> alias = const Value.absent(),
                Value<String> normalizedAlias = const Value.absent(),
                Value<int?> storeId = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => ProductAliasesCompanion(
                id: id,
                productId: productId,
                alias: alias,
                normalizedAlias: normalizedAlias,
                storeId: storeId,
                source: source,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String alias,
                required String normalizedAlias,
                Value<int?> storeId = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => ProductAliasesCompanion.insert(
                id: id,
                productId: productId,
                alias: alias,
                normalizedAlias: normalizedAlias,
                storeId: storeId,
                source: source,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductAliasesTable, ProductAliase>(table),
                  $$ProductAliasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, storeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$ProductAliasesTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$ProductAliasesTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (storeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.storeId,
                        referencedTable: $$ProductAliasesTableReferences
                            ._storeIdTable(db),
                        referencedColumn: $$ProductAliasesTableReferences
                            ._storeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductAliasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductAliasesTable,
      ProductAliase,
      $$ProductAliasesTableFilterComposer,
      $$ProductAliasesTableOrderingComposer,
      $$ProductAliasesTableAnnotationComposer,
      $$ProductAliasesTableCreateCompanionBuilder,
      $$ProductAliasesTableUpdateCompanionBuilder,
      (ProductAliase, $$ProductAliasesTableReferences),
      ProductAliase,
      PrefetchHooks Function({bool productId, bool storeId})
    >;
typedef $$PriceObservationsTableCreateCompanionBuilder =
    PriceObservationsCompanion Function({
      Value<int> id,
      Value<int?> productId,
      Value<int?> purchaseEntryId,
      Value<int?> storeId,
      Value<DateTime> observedAt,
      required String quantity,
      required String unitCode,
      Value<String?> normalizedBaseQuantity,
      required String unitPrice,
      required int lineTotalMinorUnits,
      Value<int> discountMinorUnits,
      required String currencyCode,
      required String source,
    });
typedef $$PriceObservationsTableUpdateCompanionBuilder =
    PriceObservationsCompanion Function({
      Value<int> id,
      Value<int?> productId,
      Value<int?> purchaseEntryId,
      Value<int?> storeId,
      Value<DateTime> observedAt,
      Value<String> quantity,
      Value<String> unitCode,
      Value<String?> normalizedBaseQuantity,
      Value<String> unitPrice,
      Value<int> lineTotalMinorUnits,
      Value<int> discountMinorUnits,
      Value<String> currencyCode,
      Value<String> source,
    });

final class $$PriceObservationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PriceObservationsTable,
          PriceObservation
        > {
  $$PriceObservationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductMemoryTable _productIdTable(_$AppDatabase db) => db
      .productMemory
      .createAlias('price_observations__product_id__product_memory__id');

  $$ProductMemoryTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductMemoryTableTableManager(
      $_db,
      $_db.productMemory,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PurchaseEntriesTable _purchaseEntryIdTable(_$AppDatabase db) =>
      db.purchaseEntries.createAlias(
        'price_observations__purchase_entry_id__purchase_entries__id',
      );

  $$PurchaseEntriesTableProcessedTableManager? get purchaseEntryId {
    final $_column = $_itemColumn<int>('purchase_entry_id');
    if ($_column == null) return null;
    final manager = $$PurchaseEntriesTableTableManager(
      $_db,
      $_db.purchaseEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StoresTable _storeIdTable(_$AppDatabase db) =>
      db.stores.createAlias('price_observations__store_id__stores__id');

  $$StoresTableProcessedTableManager? get storeId {
    final $_column = $_itemColumn<int>('store_id');
    if ($_column == null) return null;
    final manager = $$StoresTableTableManager(
      $_db,
      $_db.stores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PriceObservationsTableFilterComposer
    extends Composer<_$AppDatabase, $PriceObservationsTable> {
  $$PriceObservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitCode => $composableBuilder(
    column: $table.unitCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedBaseQuantity => $composableBuilder(
    column: $table.normalizedBaseQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineTotalMinorUnits => $composableBuilder(
    column: $table.lineTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountMinorUnits => $composableBuilder(
    column: $table.discountMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductMemoryTableFilterComposer get productId {
    final $$ProductMemoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableFilterComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PurchaseEntriesTableFilterComposer get purchaseEntryId {
    final $$PurchaseEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseEntryId,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableFilterComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PriceObservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceObservationsTable> {
  $$PriceObservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitCode => $composableBuilder(
    column: $table.unitCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedBaseQuantity => $composableBuilder(
    column: $table.normalizedBaseQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineTotalMinorUnits => $composableBuilder(
    column: $table.lineTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountMinorUnits => $composableBuilder(
    column: $table.discountMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductMemoryTableOrderingComposer get productId {
    final $$ProductMemoryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableOrderingComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PurchaseEntriesTableOrderingComposer get purchaseEntryId {
    final $$PurchaseEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseEntryId,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableOrderingComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PriceObservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceObservationsTable> {
  $$PriceObservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unitCode =>
      $composableBuilder(column: $table.unitCode, builder: (column) => column);

  GeneratedColumn<String> get normalizedBaseQuantity => $composableBuilder(
    column: $table.normalizedBaseQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get lineTotalMinorUnits => $composableBuilder(
    column: $table.lineTotalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountMinorUnits => $composableBuilder(
    column: $table.discountMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$ProductMemoryTableAnnotationComposer get productId {
    final $$ProductMemoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productMemory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductMemoryTableAnnotationComposer(
            $db: $db,
            $table: $db.productMemory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PurchaseEntriesTableAnnotationComposer get purchaseEntryId {
    final $$PurchaseEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseEntryId,
      referencedTable: $db.purchaseEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableAnnotationComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PriceObservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PriceObservationsTable,
          PriceObservation,
          $$PriceObservationsTableFilterComposer,
          $$PriceObservationsTableOrderingComposer,
          $$PriceObservationsTableAnnotationComposer,
          $$PriceObservationsTableCreateCompanionBuilder,
          $$PriceObservationsTableUpdateCompanionBuilder,
          (PriceObservation, $$PriceObservationsTableReferences),
          PriceObservation,
          PrefetchHooks Function({
            bool productId,
            bool purchaseEntryId,
            bool storeId,
          })
        > {
  $$PriceObservationsTableTableManager(
    _$AppDatabase db,
    $PriceObservationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceObservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceObservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceObservationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<int?> purchaseEntryId = const Value.absent(),
                Value<int?> storeId = const Value.absent(),
                Value<DateTime> observedAt = const Value.absent(),
                Value<String> quantity = const Value.absent(),
                Value<String> unitCode = const Value.absent(),
                Value<String?> normalizedBaseQuantity = const Value.absent(),
                Value<String> unitPrice = const Value.absent(),
                Value<int> lineTotalMinorUnits = const Value.absent(),
                Value<int> discountMinorUnits = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => PriceObservationsCompanion(
                id: id,
                productId: productId,
                purchaseEntryId: purchaseEntryId,
                storeId: storeId,
                observedAt: observedAt,
                quantity: quantity,
                unitCode: unitCode,
                normalizedBaseQuantity: normalizedBaseQuantity,
                unitPrice: unitPrice,
                lineTotalMinorUnits: lineTotalMinorUnits,
                discountMinorUnits: discountMinorUnits,
                currencyCode: currencyCode,
                source: source,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<int?> purchaseEntryId = const Value.absent(),
                Value<int?> storeId = const Value.absent(),
                Value<DateTime> observedAt = const Value.absent(),
                required String quantity,
                required String unitCode,
                Value<String?> normalizedBaseQuantity = const Value.absent(),
                required String unitPrice,
                required int lineTotalMinorUnits,
                Value<int> discountMinorUnits = const Value.absent(),
                required String currencyCode,
                required String source,
              }) => PriceObservationsCompanion.insert(
                id: id,
                productId: productId,
                purchaseEntryId: purchaseEntryId,
                storeId: storeId,
                observedAt: observedAt,
                quantity: quantity,
                unitCode: unitCode,
                normalizedBaseQuantity: normalizedBaseQuantity,
                unitPrice: unitPrice,
                lineTotalMinorUnits: lineTotalMinorUnits,
                discountMinorUnits: discountMinorUnits,
                currencyCode: currencyCode,
                source: source,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PriceObservationsTable, PriceObservation>(table),
                  $$PriceObservationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({productId = false, purchaseEntryId = false, storeId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (productId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.productId,
                            referencedTable: $$PriceObservationsTableReferences
                                ._productIdTable(db),
                            referencedColumn: $$PriceObservationsTableReferences
                                ._productIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (purchaseEntryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.purchaseEntryId,
                            referencedTable: $$PriceObservationsTableReferences
                                ._purchaseEntryIdTable(db),
                            referencedColumn: $$PriceObservationsTableReferences
                                ._purchaseEntryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (storeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.storeId,
                            referencedTable: $$PriceObservationsTableReferences
                                ._storeIdTable(db),
                            referencedColumn: $$PriceObservationsTableReferences
                                ._storeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PriceObservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PriceObservationsTable,
      PriceObservation,
      $$PriceObservationsTableFilterComposer,
      $$PriceObservationsTableOrderingComposer,
      $$PriceObservationsTableAnnotationComposer,
      $$PriceObservationsTableCreateCompanionBuilder,
      $$PriceObservationsTableUpdateCompanionBuilder,
      (PriceObservation, $$PriceObservationsTableReferences),
      PriceObservation,
      PrefetchHooks Function({
        bool productId,
        bool purchaseEntryId,
        bool storeId,
      })
    >;
typedef $$ReceiptCandidateLinesTableCreateCompanionBuilder =
    ReceiptCandidateLinesCompanion Function({
      Value<int> id,
      required int receiptId,
      required String rawText,
      Value<String?> bboxMetadata,
      Value<String?> parsedName,
      Value<String?> parsedQuantity,
      Value<String?> parsedUnitCode,
      Value<String?> parsedUnitPrice,
      Value<int?> parsedLineTotalMinorUnits,
      Value<String?> confidence,
      Value<int?> linkedPlannedItemId,
      Value<String> reviewStatus,
    });
typedef $$ReceiptCandidateLinesTableUpdateCompanionBuilder =
    ReceiptCandidateLinesCompanion Function({
      Value<int> id,
      Value<int> receiptId,
      Value<String> rawText,
      Value<String?> bboxMetadata,
      Value<String?> parsedName,
      Value<String?> parsedQuantity,
      Value<String?> parsedUnitCode,
      Value<String?> parsedUnitPrice,
      Value<int?> parsedLineTotalMinorUnits,
      Value<String?> confidence,
      Value<int?> linkedPlannedItemId,
      Value<String> reviewStatus,
    });

final class $$ReceiptCandidateLinesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReceiptCandidateLinesTable,
          ReceiptCandidateLine
        > {
  $$ReceiptCandidateLinesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ReceiptsTable _receiptIdTable(_$AppDatabase db) => db.receipts
      .createAlias('receipt_candidate_lines__receipt_id__receipts__id');

  $$ReceiptsTableProcessedTableManager get receiptId {
    final $_column = $_itemColumn<int>('receipt_id')!;

    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_receiptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlannedItemsTable _linkedPlannedItemIdTable(_$AppDatabase db) =>
      db.plannedItems.createAlias(
        'receipt_candidate_lines__linked_planned_item_id__planned_items__id',
      );

  $$PlannedItemsTableProcessedTableManager? get linkedPlannedItemId {
    final $_column = $_itemColumn<int>('linked_planned_item_id');
    if ($_column == null) return null;
    final manager = $$PlannedItemsTableTableManager(
      $_db,
      $_db.plannedItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedPlannedItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReceiptCandidateLinesTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptCandidateLinesTable> {
  $$ReceiptCandidateLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bboxMetadata => $composableBuilder(
    column: $table.bboxMetadata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parsedName => $composableBuilder(
    column: $table.parsedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parsedQuantity => $composableBuilder(
    column: $table.parsedQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parsedUnitCode => $composableBuilder(
    column: $table.parsedUnitCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parsedUnitPrice => $composableBuilder(
    column: $table.parsedUnitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parsedLineTotalMinorUnits => $composableBuilder(
    column: $table.parsedLineTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$ReceiptsTableFilterComposer get receiptId {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlannedItemsTableFilterComposer get linkedPlannedItemId {
    final $$PlannedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedPlannedItemId,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableFilterComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptCandidateLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptCandidateLinesTable> {
  $$ReceiptCandidateLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bboxMetadata => $composableBuilder(
    column: $table.bboxMetadata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parsedName => $composableBuilder(
    column: $table.parsedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parsedQuantity => $composableBuilder(
    column: $table.parsedQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parsedUnitCode => $composableBuilder(
    column: $table.parsedUnitCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parsedUnitPrice => $composableBuilder(
    column: $table.parsedUnitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parsedLineTotalMinorUnits => $composableBuilder(
    column: $table.parsedLineTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReceiptsTableOrderingComposer get receiptId {
    final $$ReceiptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableOrderingComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlannedItemsTableOrderingComposer get linkedPlannedItemId {
    final $$PlannedItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedPlannedItemId,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableOrderingComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptCandidateLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptCandidateLinesTable> {
  $$ReceiptCandidateLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumn<String> get bboxMetadata => $composableBuilder(
    column: $table.bboxMetadata,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parsedName => $composableBuilder(
    column: $table.parsedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parsedQuantity => $composableBuilder(
    column: $table.parsedQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parsedUnitCode => $composableBuilder(
    column: $table.parsedUnitCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parsedUnitPrice => $composableBuilder(
    column: $table.parsedUnitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get parsedLineTotalMinorUnits => $composableBuilder(
    column: $table.parsedLineTotalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => column,
  );

  $$ReceiptsTableAnnotationComposer get receiptId {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlannedItemsTableAnnotationComposer get linkedPlannedItemId {
    final $$PlannedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedPlannedItemId,
      referencedTable: $db.plannedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.plannedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptCandidateLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptCandidateLinesTable,
          ReceiptCandidateLine,
          $$ReceiptCandidateLinesTableFilterComposer,
          $$ReceiptCandidateLinesTableOrderingComposer,
          $$ReceiptCandidateLinesTableAnnotationComposer,
          $$ReceiptCandidateLinesTableCreateCompanionBuilder,
          $$ReceiptCandidateLinesTableUpdateCompanionBuilder,
          (ReceiptCandidateLine, $$ReceiptCandidateLinesTableReferences),
          ReceiptCandidateLine,
          PrefetchHooks Function({bool receiptId, bool linkedPlannedItemId})
        > {
  $$ReceiptCandidateLinesTableTableManager(
    _$AppDatabase db,
    $ReceiptCandidateLinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptCandidateLinesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ReceiptCandidateLinesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReceiptCandidateLinesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> receiptId = const Value.absent(),
                Value<String> rawText = const Value.absent(),
                Value<String?> bboxMetadata = const Value.absent(),
                Value<String?> parsedName = const Value.absent(),
                Value<String?> parsedQuantity = const Value.absent(),
                Value<String?> parsedUnitCode = const Value.absent(),
                Value<String?> parsedUnitPrice = const Value.absent(),
                Value<int?> parsedLineTotalMinorUnits = const Value.absent(),
                Value<String?> confidence = const Value.absent(),
                Value<int?> linkedPlannedItemId = const Value.absent(),
                Value<String> reviewStatus = const Value.absent(),
              }) => ReceiptCandidateLinesCompanion(
                id: id,
                receiptId: receiptId,
                rawText: rawText,
                bboxMetadata: bboxMetadata,
                parsedName: parsedName,
                parsedQuantity: parsedQuantity,
                parsedUnitCode: parsedUnitCode,
                parsedUnitPrice: parsedUnitPrice,
                parsedLineTotalMinorUnits: parsedLineTotalMinorUnits,
                confidence: confidence,
                linkedPlannedItemId: linkedPlannedItemId,
                reviewStatus: reviewStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int receiptId,
                required String rawText,
                Value<String?> bboxMetadata = const Value.absent(),
                Value<String?> parsedName = const Value.absent(),
                Value<String?> parsedQuantity = const Value.absent(),
                Value<String?> parsedUnitCode = const Value.absent(),
                Value<String?> parsedUnitPrice = const Value.absent(),
                Value<int?> parsedLineTotalMinorUnits = const Value.absent(),
                Value<String?> confidence = const Value.absent(),
                Value<int?> linkedPlannedItemId = const Value.absent(),
                Value<String> reviewStatus = const Value.absent(),
              }) => ReceiptCandidateLinesCompanion.insert(
                id: id,
                receiptId: receiptId,
                rawText: rawText,
                bboxMetadata: bboxMetadata,
                parsedName: parsedName,
                parsedQuantity: parsedQuantity,
                parsedUnitCode: parsedUnitCode,
                parsedUnitPrice: parsedUnitPrice,
                parsedLineTotalMinorUnits: parsedLineTotalMinorUnits,
                confidence: confidence,
                linkedPlannedItemId: linkedPlannedItemId,
                reviewStatus: reviewStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ReceiptCandidateLinesTable,
                    ReceiptCandidateLine
                  >(table),
                  $$ReceiptCandidateLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({receiptId = false, linkedPlannedItemId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (receiptId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.receiptId,
                            referencedTable:
                                $$ReceiptCandidateLinesTableReferences
                                    ._receiptIdTable(db),
                            referencedColumn:
                                $$ReceiptCandidateLinesTableReferences
                                    ._receiptIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (linkedPlannedItemId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.linkedPlannedItemId,
                            referencedTable:
                                $$ReceiptCandidateLinesTableReferences
                                    ._linkedPlannedItemIdTable(db),
                            referencedColumn:
                                $$ReceiptCandidateLinesTableReferences
                                    ._linkedPlannedItemIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ReceiptCandidateLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptCandidateLinesTable,
      ReceiptCandidateLine,
      $$ReceiptCandidateLinesTableFilterComposer,
      $$ReceiptCandidateLinesTableOrderingComposer,
      $$ReceiptCandidateLinesTableAnnotationComposer,
      $$ReceiptCandidateLinesTableCreateCompanionBuilder,
      $$ReceiptCandidateLinesTableUpdateCompanionBuilder,
      (ReceiptCandidateLine, $$ReceiptCandidateLinesTableReferences),
      ReceiptCandidateLine,
      PrefetchHooks Function({bool receiptId, bool linkedPlannedItemId})
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      required String ownerType,
      required int ownerId,
      required String filePath,
      Value<DateTime> createdAt,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      Value<String> ownerType,
      Value<int> ownerId,
      Value<String> filePath,
      Value<DateTime> createdAt,
    });

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerType =>
      $composableBuilder(column: $table.ownerType, builder: (column) => column);

  GeneratedColumn<int> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          Attachment,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (
            Attachment,
            BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment>,
          ),
          Attachment,
          PrefetchHooks Function()
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ownerType = const Value.absent(),
                Value<int> ownerId = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                filePath: filePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ownerType,
                required int ownerId,
                required String filePath,
                Value<DateTime> createdAt = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                filePath: filePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttachmentsTable, Attachment>(table),
                  BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      Attachment,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (
        Attachment,
        BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment>,
      ),
      Attachment,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  Value<int> id,
  required int listId,
  required DateTime scheduledAt,
  Value<String> status,
  Value<DateTime> createdAt,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<int> id,
  Value<int> listId,
  Value<DateTime> scheduledAt,
  Value<String> status,
  Value<DateTime> createdAt,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, Reminder> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShoppingListsTable _listIdTable(_$AppDatabase db) =>
      db.shoppingLists.createAlias('reminders__list_id__shopping_lists__id');

  $$ShoppingListsTableProcessedTableManager get listId {
    final $_column = $_itemColumn<int>('list_id')!;

    final manager = $$ShoppingListsTableTableManager(
      $_db,
      $_db.shoppingLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShoppingListsTableFilterComposer get listId {
    final $$ShoppingListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableFilterComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShoppingListsTableOrderingComposer get listId {
    final $$ShoppingListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableOrderingComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ShoppingListsTableAnnotationComposer get listId {
    final $$ShoppingListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listId,
      referencedTable: $db.shoppingLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListsTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, $$RemindersTableReferences),
          Reminder,
          PrefetchHooks Function({bool listId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> listId = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                listId: listId,
                scheduledAt: scheduledAt,
                status: status,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int listId,
                required DateTime scheduledAt,
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                listId: listId,
                scheduledAt: scheduledAt,
                status: status,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, Reminder>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({listId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (listId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.listId,
                        referencedTable: $$RemindersTableReferences
                            ._listIdTable(db),
                        referencedColumn: $$RemindersTableReferences
                            ._listIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, $$RemindersTableReferences),
      Reminder,
      PrefetchHooks Function({bool listId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      Value<String?> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StoresTableTableManager get stores =>
      $$StoresTableTableManager(_db, _db.stores);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$AislesTableTableManager get aisles =>
      $$AislesTableTableManager(_db, _db.aisles);
  $$ShoppingListsTableTableManager get shoppingLists =>
      $$ShoppingListsTableTableManager(_db, _db.shoppingLists);
  $$ProductMemoryTableTableManager get productMemory =>
      $$ProductMemoryTableTableManager(_db, _db.productMemory);
  $$PlannedItemsTableTableManager get plannedItems =>
      $$PlannedItemsTableTableManager(_db, _db.plannedItems);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$PurchaseEntriesTableTableManager get purchaseEntries =>
      $$PurchaseEntriesTableTableManager(_db, _db.purchaseEntries);
  $$ProductAliasesTableTableManager get productAliases =>
      $$ProductAliasesTableTableManager(_db, _db.productAliases);
  $$PriceObservationsTableTableManager get priceObservations =>
      $$PriceObservationsTableTableManager(_db, _db.priceObservations);
  $$ReceiptCandidateLinesTableTableManager get receiptCandidateLines =>
      $$ReceiptCandidateLinesTableTableManager(_db, _db.receiptCandidateLines);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
