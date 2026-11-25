import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:flutter/material.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/money/locale_conventions.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/core/util/normalize_name.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';

const _samplesJson = String.fromEnvironment('STORE_SAMPLES_JSON');

const _genericEstimates = <String>[
  '2.49',
  '2.19',
  '1.15',
  '2.99',
  '8.99',
  '1.89',
];

const _turkishEstimates = <String>[
  '42.90',
  '12.00',
  '34.50',
  '78.00',
  '389.90',
  '64.00',
];

const _genericPriceOffsetsMinor = <List<int>>[
  [-18, -5, -8, -20, -40, 10],
  [-10, 0, -5, -10, -20, 5],
  [0, 8, 0, 0, 0, -10],
  [8, -5, 10, 8, 25, 0],
  [3, 5, 5, 15, 10, -15],
  [20, 10, 15, 25, 45, 10],
];

const _turkishPriceOffsetsMinor = <List<int>>[
  [-250, -50, -150, -200, -1500, 100],
  [-100, 0, -50, -100, -500, 50],
  [0, 50, 0, 0, 0, -100],
  [100, -50, 100, 100, 750, 0],
  [50, 50, 50, 150, 500, -150],
  [200, 100, 200, 300, 1000, 150],
];

/// The nine hand-authored samples in test/store_capture_test.dart complement
/// the other localized names from test/store_samples.json.
const _builtInSamples = <String, _StoreSample>{
  'tr': _StoreSample('Haftalık market', [
    'Domates',
    'Ekmek',
    'Süt 1 L',
    'Yumurta (10)',
    'Zeytinyağı',
    'Pirinç 1 kg',
  ]),
  'en': _StoreSample('Weekly groceries', [
    'Tomatoes',
    'Bread',
    'Milk 1 gal',
    'Eggs (12)',
    'Olive oil',
    'Rice 2 lb',
  ]),
  'de': _StoreSample('Wocheneinkauf', [
    'Tomaten',
    'Brot',
    'Milch 1 L',
    'Eier (10)',
    'Olivenöl',
    'Reis 1 kg',
  ]),
  'fr': _StoreSample('Courses de la semaine', [
    'Tomates',
    'Baguette',
    'Lait 1 L',
    'Œufs (12)',
    "Huile d'olive",
    'Riz 1 kg',
  ]),
  'es': _StoreSample('Compra semanal', [
    'Tomates',
    'Pan',
    'Leche 1 L',
    'Huevos (12)',
    'Aceite de oliva',
    'Arroz 1 kg',
  ]),
  'it': _StoreSample('Spesa settimanale', [
    'Pomodori',
    'Pane',
    'Latte 1 L',
    'Uova (10)',
    "Olio d'oliva",
    'Riso 1 kg',
  ]),
  'pt': _StoreSample('Compras da semana', [
    'Tomate',
    'Pão',
    'Leite 1 L',
    'Ovos (12)',
    'Azeite',
    'Arroz 1 kg',
  ]),
  'ru': _StoreSample('Покупки на неделю', [
    'Помидоры',
    'Хлеб',
    'Молоко 1 л',
    'Яйца (10)',
    'Оливковое масло',
    'Рис 1 кг',
  ]),
  'ar': _StoreSample('تسوّق الأسبوع', [
    'طماطم',
    'خبز',
    'حليب 1 لتر',
    'بيض (12)',
    'زيت زيتون',
    'أرز 1 كغ',
  ]),
};

class _StoreSample {
  const _StoreSample(this.listName, this.items);

  final String listName;
  final List<String> items;

  static _StoreSample fromJson(Object? value, String localeCode) {
    if (value is! Map) {
      throw FormatException('Sample for $localeCode must be an object.');
    }
    final listName = value['list'];
    if (listName is! String || listName.trim().isEmpty) {
      throw FormatException('Sample for $localeCode needs a list name.');
    }
    final items = <String>[];
    for (var i = 0; i < 6; i++) {
      final item = value['i$i'];
      if (item is! String || item.trim().isEmpty) {
        throw FormatException('Sample for $localeCode needs i$i.');
      }
      items.add(item);
    }
    return _StoreSample(listName, List<String>.unmodifiable(items));
  }
}

Map<String, _StoreSample> _loadSamples() {
  final supported = NShoptorApp.supportedLocales
      .map((locale) => locale.languageCode)
      .toSet();
  if (supported.length != NShoptorApp.supportedLocales.length) {
    throw const FormatException('Supported UI locale codes are not unique.');
  }
  if (_samplesJson.isEmpty) {
    throw const FormatException('STORE_SAMPLES_JSON was not provided.');
  }
  final decoded = jsonDecode(_samplesJson);
  if (decoded is! Map) {
    throw const FormatException('STORE_SAMPLES_JSON must be an object.');
  }

  final samples = <String, _StoreSample>{..._builtInSamples};
  for (final entry in decoded.entries) {
    final code = entry.key;
    if (code is! String || !supported.contains(code)) {
      throw const FormatException(
        'Sample JSON contains an unsupported locale code.',
      );
    }
    samples[code] = _StoreSample.fromJson(entry.value, code);
  }

  final missing = supported.where((code) => !samples.containsKey(code)).toList()
    ..sort();
  if (missing.isNotEmpty || samples.length != supported.length) {
    throw FormatException(
      'Localized sample data must cover every supported UI locale. '
      'Missing: ${missing.join(', ')}',
    );
  }
  return Map<String, _StoreSample>.unmodifiable(samples);
}

String _currencyCodeFor(String localeCode) {
  if (localeCode == 'tr') return 'TRY';
  if (usesCommaDecimal(localeCode) && usesLatinDigits(localeCode)) {
    return 'EUR';
  }
  return 'USD';
}

int _toMinorUnits(String decimal, Currency currency) =>
    DecimalFixed.parse(decimal).toMinorUnits(currency.minorUnitDigits);

String _minorUnitsToDecimal(int minorUnits, Currency currency) =>
    DecimalFixed.fromMinorUnits(
      minorUnits,
      currency.minorUnitDigits,
    ).toDbString();

String _dateSuffix(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

Future<void> _seedMemoryDatabase(
  AppDatabase db,
  _StoreSample sample,
  String localeCode,
) async {
  final currencyCode = _currencyCodeFor(localeCode);
  final currency = Currency.fromCode(currencyCode);
  final estimates = localeCode == 'tr' ? _turkishEstimates : _genericEstimates;
  final estimateMinor = [
    for (final estimate in estimates) _toMinorUnits(estimate, currency),
  ];
  final offsets = localeCode == 'tr'
      ? _turkishPriceOffsetsMinor
      : _genericPriceOffsetsMinor;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final itemNames = sample.items;
  final normalizedNames = [for (final name in itemNames) normalizeName(name)];
  final unitCode = UnitCode.adet.dbCode;

  await db.transaction(() async {
    final productIds = <int>[];
    for (var itemIndex = 0; itemIndex < itemNames.length; itemIndex++) {
      productIds.add(
        await db
            .into(db.productMemory)
            .insert(
              ProductMemoryCompanion.insert(
                canonicalName: itemNames[itemIndex],
                normalizedName: normalizedNames[itemIndex],
                defaultUnitCode: Value(unitCode),
                useCount: const Value(6),
                lastUsedAt: Value(today.subtract(const Duration(days: 3))),
              ),
            ),
      );
    }

    final activeListId = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            title: Value(sample.listName),
            currencyCode: currencyCode,
            budgetMinorUnits: Value(
              _toMinorUnits(
                currencyCode == 'TRY'
                    ? '1000'
                    : currencyCode == 'EUR'
                    ? '30'
                    : '40',
                currency,
              ),
            ),
            plannedAt: Value(today.add(const Duration(days: 1))),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    for (var itemIndex = 0; itemIndex < itemNames.length; itemIndex++) {
      final estimate = estimateMinor[itemIndex];
      await db
          .into(db.plannedItems)
          .insert(
            PlannedItemsCompanion.insert(
              listId: activeListId,
              productId: Value(productIds[itemIndex]),
              name: itemNames[itemIndex],
              normalizedName: normalizedNames[itemIndex],
              plannedQuantity: '1',
              plannedUnitCode: unitCode,
              pricingInputMode: 'lineTotal',
              plannedUnitPrice: Value(_minorUnitsToDecimal(estimate, currency)),
              plannedLineTotalMinorUnits: Value(estimate),
              sortOrder: Value(itemIndex),
            ),
          );
    }

    // Each completed week contains purchases for the same six localized
    // products, linked to price observations in fixed-point minor units.
    for (var week = 0; week < 6; week++) {
      final completedAt = today.subtract(Duration(days: 3 + week * 7));
      final startedAt = completedAt.subtract(const Duration(hours: 2));
      final listId = await db
          .into(db.shoppingLists)
          .insert(
            ShoppingListsCompanion.insert(
              title: Value('${sample.listName} · ${_dateSuffix(completedAt)}'),
              currencyCode: currencyCode,
              status: const Value('completed'),
              plannedAt: Value(startedAt),
              startedAt: Value(startedAt),
              completedAt: Value(completedAt),
              createdAt: Value(startedAt),
              updatedAt: Value(completedAt),
            ),
          );

      for (var itemIndex = 0; itemIndex < itemNames.length; itemIndex++) {
        final lineTotal = estimateMinor[itemIndex] + offsets[week][itemIndex];
        final unitPrice = _minorUnitsToDecimal(lineTotal, currency);
        final purchaseId = await db
            .into(db.purchaseEntries)
            .insert(
              PurchaseEntriesCompanion.insert(
                listId: listId,
                name: itemNames[itemIndex],
                normalizedName: normalizedNames[itemIndex],
                actualQuantity: '1',
                actualUnitCode: unitCode,
                actualUnitPrice: Value(unitPrice),
                pricingInputMode: const Value('lineTotal'),
                grossTotalMinorUnits: Value(lineTotal),
                actualLineTotalMinorUnits: lineTotal,
                userConfirmed: const Value(true),
              ),
            );
        await db
            .into(db.priceObservations)
            .insert(
              PriceObservationsCompanion.insert(
                productId: Value(productIds[itemIndex]),
                purchaseEntryId: Value(purchaseId),
                observedAt: Value(completedAt),
                quantity: '1',
                unitCode: unitCode,
                normalizedBaseQuantity: const Value('1'),
                unitPrice: unitPrice,
                lineTotalMinorUnits: lineTotal,
                currencyCode: currencyCode,
                source: 'manual',
              ),
            );
      }
    }

    final archivedAt = today.subtract(const Duration(days: 50));
    await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            title: Value('${sample.listName} · ${_dateSuffix(archivedAt)}'),
            currencyCode: currencyCode,
            status: const Value('archived'),
            archivedAt: Value(archivedAt),
            createdAt: Value(archivedAt.subtract(const Duration(days: 1))),
            updatedAt: Value(archivedAt),
          ),
        );
  });
}

class StoreMediaLauncher extends StatefulWidget {
  const StoreMediaLauncher({super.key});

  @override
  State<StoreMediaLauncher> createState() => _StoreMediaLauncherState();
}

class _StoreMediaLauncherState extends State<StoreMediaLauncher> {
  final _localeController = TextEditingController(text: 'en');
  Map<String, _StoreSample> _samples = const {};
  AppDatabase? _database;
  String? _startedLocale;
  String? _fixtureError;
  String? _startError;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    try {
      _samples = _loadSamples();
    } on FormatException catch (error) {
      _fixtureError = error.message;
    }
  }

  @override
  void dispose() {
    _localeController.dispose();
    final db = _database;
    if (db != null) unawaited(db.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text('Store media launcher requires a debug build.'),
          ),
        ),
      );
    }

    final db = _database;
    final localeCode = _startedLocale;
    if (db != null && localeCode != null) {
      return NShoptorApp(
        db: db,
        fixedLocale: Locale(localeCode),
        splash: Duration.zero,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Store media sample')),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Choose a supported UI language to load an in-memory sample.',
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      key: const Key('media_locale'),
                      controller: _localeController,
                      enabled: !_busy,
                      autocorrect: false,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        labelText: 'Locale code',
                        hintText: 'en',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      key: const Key('media_start'),
                      onPressed: _busy || _fixtureError != null
                          ? null
                          : _startSample,
                      child: _busy
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Start'),
                    ),
                    if (_fixtureError != null || _startError != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _startError ??
                            'Localized sample data is unavailable. '
                                'Check STORE_SAMPLES_JSON.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startSample() async {
    if (_busy || _database != null) return;
    final localeCode = _localeController.text.trim().toLowerCase();
    final supportedCodes = NShoptorApp.supportedLocales
        .map((locale) => locale.languageCode)
        .toSet();
    if (!supportedCodes.contains(localeCode)) {
      setState(() => _startError = 'Unsupported UI locale code.');
      return;
    }
    final sample = _samples[localeCode];
    if (sample == null) {
      setState(
        () => _startError = 'No localized sample exists for this locale.',
      );
      return;
    }

    setState(() {
      _busy = true;
      _startError = null;
    });
    AppDatabase? db;
    try {
      db = AppDatabase(NativeDatabase.memory());
      await _seedMemoryDatabase(db, sample, localeCode);

      final currencyCode = _currencyCodeFor(localeCode);
      final formatLocale = AppFormatLocale.forLanguage(localeCode);
      final settings = SettingsStore()
        ..setString(SettingsRepository.localeKey, localeCode)
        ..setString(SettingsRepository.currencyKey, currencyCode)
        ..setString(SettingsRepository.formatLocaleKey, formatLocale);
      AppDefaults.attach(settings);
      AppDefaults.markGuideSeen();
      AppFormatLocale.attach(formatLocale);

      if (!mounted) {
        await db.close();
        return;
      }
      setState(() {
        _database = db;
        _startedLocale = localeCode;
        _busy = false;
      });
    } on Object catch (error, stackTrace) {
      debugPrint('Store media sample startup failed: $error\n$stackTrace');
      if (db != null) {
        try {
          await db.close();
        } on Object {
          // The chooser remains usable even when cleanup itself fails.
        }
      }
      if (!mounted) return;
      setState(() {
        _busy = false;
        _startError =
            'The sample could not be prepared. Check the locale data.';
      });
    }
  }
}

void main() {
  if (!kDebugMode) {
    throw StateError('Store media launcher requires a debug build.');
  }
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsApp.debugAllowBannerOverride = false;
  runApp(const StoreMediaLauncher());
}
