import '../../../app/app_defaults.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_format.dart';
import '../../lists/reminders/local_notifications_scheduler.dart';
import 'budget_check.dart';

/// Sends a free local notification the first time weekly or monthly spending
/// reaches 80% and again when it passes 100% of the limit (F33). Each level
/// is announced once per period and currency.
abstract final class BudgetAlerts {
  static const nearRatio = 0.8;

  /// [notify] is injectable for tests; production uses local notifications.
  static Future<List<String>> check(
    BudgetStatus status,
    AppLocalizations l10n, {
    required String locale,
    required DateTime reference,
    int? listId,
    Future<void> Function(int id, String title, String body)? notify,
  }) async {
    final currency = Currency.fromCode(status.currencyCode);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
    final send =
        notify ??
        (int id, String title, String body) => LocalNotificationsScheduler()
            .showReceiptResult(id: id, title: title, body: body, listId: listId);
    final sent = <String>[];
    Future<void> one({
      required String kind,
      required String period,
      required int spent,
      required int? limit,
      required String title,
    }) async {
      if (limit == null || limit <= 0) return;
      final level = spent > limit
          ? 100
          : spent >= limit * nearRatio
          ? 80
          : 0;
      if (level == 0) return;
      final key = '$kind.${status.currencyCode}.$period';
      if (AppDefaults.budgetAlertLevel(key) >= level) return;
      AppDefaults.setBudgetAlertLevel(key, level);
      final body = level == 100
          ? l10n.monthlyLimitOver(money(spent - limit))
          : l10n.budgetAlertNear((spent * 100 ~/ limit).toString());
      sent.add('$key:$level');
      try {
        await send(
          800000000 + key.hashCode.abs() % 99999999,
          title,
          '$body · ${money(spent)} / ${money(limit)}',
        );
      } catch (_) {
        // Without notification permission the in-app warning still shows.
      }
    }

    await one(
      kind: 'week',
      period: AppDefaults.weekPeriodKey(reference),
      spent: status.weekSpentMinor,
      limit: status.weekLimitMinor,
      title: l10n.weeklyLimitTitle,
    );
    await one(
      kind: 'month',
      period: AppDefaults.monthPeriodKey(reference),
      spent: status.monthSpentMinor,
      limit: status.monthLimitMinor,
      title: l10n.monthlyLimitTitle,
    );
    return sent;
  }
}
