// Native PDF audit fixture: flutter run -t tool/pdf_probe.dart -d emulator-5554.
// Use the PDF button, cancel once, then print again and save/open in Android.
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/features/shopping_mode/summary/summary_screen.dart';
import 'package:nshoptor/features/shopping_mode/summary/result_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase(NativeDatabase.memory());
  final id = await ListRepository(db).createList(title: 'Çığ Şölen — Haftalık alışveriş', currencyCode: 'TRY');
  for (var i = 0; i < 85; i++) {
    final item = await ItemRepository(db).addItem(listId: id,
      name: 'Ürün ${i + 1}: Yoğurt, çilek, şeftali ve uzun ürün adı — طماطم',
      quantity: DecimalFixed.fromInt(2), unitCode: 'kilogram', priceIsUnitPrice: true, price: DecimalFixed.fromInt(40));
    if (i % 3 != 0) { await ShoppingRepository(db).recordPurchase(listId: id, plannedItemId: item,
      name: 'Ürün ${i + 1}', normalizedName: 'ürün ${i + 1}', quantity: DecimalFixed.parse('1.5'),
      unitCode: 'kilogram', unitPrice: DecimalFixed.parse('45.50')); }
  }
  runApp(MaterialApp(locale: const Locale('tr'), supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
    home: SummaryScreen(repository: ResultRepository(db), listId: id)));
}
