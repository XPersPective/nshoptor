import 'package:drift/drift.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../data/db/app_database.dart';

/// İlk açılışta eklenen başlangıç kategorileri (spec §6.3).
///
/// `Categories.name` kanonik token'ı saklar (ör. `dairy`); görünen ad
/// l10n'dan `categoryToken` eşlemesiyle üretilir. Kullanıcının kendi
/// eklediği kategorilerde `name` doğrudan girilen addır ve token eşleşmezse
/// ham ad gösterilir.
class StarterCategories {
  StarterCategories._();

  factory StarterCategories() => StarterCategories._();

  /// Kanonik kategori kodları; sıralama bu listedeki sıradır.
  static const List<String> tokens = [
    'produce',
    'dairy',
    'meat',
    'bakery',
    'drinks',
    'cleaning',
    'personalCare',
    'home',
    'other',
  ];

  /// Token → l10n görünen ad (kanonik değerler kod olarak saklanır, spec §3).
  String labelOf(AppLocalizations l10n, String storedName) {
    final known = <String, String>{
      'produce': l10n.categoryProduce,
      'dairy': l10n.categoryDairy,
      'meat': l10n.categoryMeat,
      'bakery': l10n.categoryBakery,
      'drinks': l10n.categoryDrinks,
      'cleaning': l10n.categoryCleaning,
      'personalCare': l10n.categoryPersonalCare,
      'home': l10n.categoryHome,
      'other': l10n.categoryOther,
    };
    return known[storedName] ?? storedName;
  }

  /// Yalnız kategori tablosu boşsa ekler (seed).
  Future<void> seedIfEmpty(AppDatabase db) async {
    final count = await db.categories.select().get().then((r) => r.length);
    if (count > 0) return;
    for (var i = 0; i < tokens.length; i++) {
      await db.into(db.categories).insert(
            CategoriesCompanion.insert(name: tokens[i], sortOrder: Value(i)),
          );
    }
  }
}
