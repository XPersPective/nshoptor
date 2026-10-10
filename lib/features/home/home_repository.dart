import 'package:drift/drift.dart';

import '../../data/db/app_database.dart';
import '../history/insights/insights_repository.dart';

/// Ana ekran verisi: aktif listeler, son tamamlananlar ve bu ay toplamları
/// (spec §6.4). Bu ay kartı yalnız ay içinde tamamlanmış alışveriş varsa
/// anlamlıdır; yoksa UI boş durum gösterir (demo veri yok).
class HomeRepository {
  HomeRepository(this._db);

  final AppDatabase _db;

  Stream<List<ShoppingList>> watchActiveLists() =>
      (_db.select(_db.shoppingLists)
            ..where((t) => t.status.isIn(const ['draft', 'planned', 'shopping']))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Stream<List<ShoppingList>> watchRecentCompleted({int limit = 3}) =>
      (_db.select(_db.shoppingLists)
            ..where((t) => t.status.equals('completed'))
            ..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
          .watch();

  /// Bu ay tamamlanan listelerin PARA BİRİMİ BAŞINA planlanan ve gerçek
  /// toplamları (spec §7.1: farklı para birimleri asla toplanmaz).
  /// Ay içinde tamamlanan alışveriş yoksa boş liste yayar.
  Stream<List<MonthlyBucket>> watchMonthlyTotals() {
    final now = DateTime.now();
    final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    return InsightsRepository(_db).watchMonthlyTotals()
        .map((buckets) => buckets.where((b) => b.month == month).toList());
  }
}
