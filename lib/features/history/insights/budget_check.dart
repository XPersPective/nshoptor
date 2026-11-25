import 'package:drift/drift.dart';

import '../../../app/app_defaults.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_format.dart';
import '../../../data/db/app_database.dart';
import 'insights_repository.dart';

/// Independent list, weekly, and monthly budget status for a single currency.
final class BudgetStatus {
  const BudgetStatus({
    required this.currencyCode,
    required this.listSpentMinor,
    required this.weekSpentMinor,
    required this.monthSpentMinor,
    this.listLimitMinor,
    this.weekLimitMinor,
    this.monthLimitMinor,
  });

  final String currencyCode;
  final int listSpentMinor;
  final int weekSpentMinor;
  final int monthSpentMinor;
  final int? listLimitMinor;
  final int? weekLimitMinor;
  final int? monthLimitMinor;

  bool get listOver =>
      listLimitMinor != null && listSpentMinor > listLimitMinor!;
  int get listOverMinor => listOver ? listSpentMinor - listLimitMinor! : 0;

  bool get weekOver =>
      weekLimitMinor != null && weekSpentMinor > weekLimitMinor!;
  int get weekOverMinor => weekOver ? weekSpentMinor - weekLimitMinor! : 0;

  bool get monthOver =>
      monthLimitMinor != null && monthSpentMinor > monthLimitMinor!;
  int get monthOverMinor => monthOver ? monthSpentMinor - monthLimitMinor! : 0;

  bool get anyOver => listOver || weekOver || monthOver;

  List<String> warningLines(AppLocalizations l10n, String locale) {
    final currency = Currency.fromCode(currencyCode);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
    return [
      if (listOver)
        '${l10n.budgetLabel}: ${l10n.monthlyLimitOver(money(listOverMinor))}',
      if (weekOver)
        '${l10n.spanWeek}: ${l10n.monthlyLimitOver(money(weekOverMinor))}',
      if (monthOver)
        '${l10n.monthlyLimitTitle}: ${l10n.monthlyLimitOver(money(monthOverMinor))}',
    ];
  }
}

/// Evaluates list budget, weekly limit, and monthly limit independently in the
/// shopping list's currency without mixing other currencies.
Future<BudgetStatus> evaluateBudgetStatus(
  AppDatabase db, {
  required int listId,
  DateTime? now,
}) async {
  final list = await (db.select(
    db.shoppingLists,
  )..where((t) => t.id.equals(listId))).getSingle();
  final entries =
      await (db.select(db.purchaseEntries)..where(
            (t) => t.listId.equals(listId) & t.userConfirmed.equals(true),
          ))
          .get();
  final listSpent = entries.fold<int>(
    0,
    (sum, e) => sum + e.actualLineTotalMinorUnits,
  );
  final reference =
      (list.completedAt ?? list.plannedAt ?? now ?? DateTime.now()).toLocal();
  final completedPoints = await InsightsRepository(
    db,
  ).completedSpend(list.currencyCode);
  final otherPoints = completedPoints
      .where((p) => p.listId != listId)
      .toList(growable: false);
  final weekRange = SpendSpan.week.range(reference);
  final monthRange = SpendSpan.month.range(reference);
  final weekOther = SpendMath.total(otherPoints, weekRange.from, weekRange.to);
  final monthOther = SpendMath.total(
    otherPoints,
    monthRange.from,
    monthRange.to,
  );
  final weekSpent = weekOther + listSpent;
  final monthSpent = monthOther + listSpent;
  return BudgetStatus(
    currencyCode: list.currencyCode,
    listSpentMinor: listSpent,
    weekSpentMinor: weekSpent,
    monthSpentMinor: monthSpent,
    listLimitMinor: list.budgetMinorUnits != null && list.budgetMinorUnits! > 0
        ? list.budgetMinorUnits
        : null,
    weekLimitMinor: AppDefaults.weeklyLimitMinor(
      currencyCode: list.currencyCode,
      week: reference,
    ),
    monthLimitMinor: AppDefaults.monthlyLimitMinor(
      currencyCode: list.currencyCode,
      month: reference,
    ),
  );
}
