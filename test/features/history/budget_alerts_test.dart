import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/history/insights/budget_alerts.dart';
import 'package:nshoptor/features/history/insights/budget_check.dart';

BudgetStatus _status({required int week, required int month}) => BudgetStatus(
  currencyCode: 'TRY',
  listSpentMinor: 0,
  weekSpentMinor: week,
  monthSpentMinor: month,
  weekLimitMinor: 100000,
  monthLimitMinor: 400000,
);

void main() {
  test('80% and 100% of a limit are announced once per period', () async {
    AppDefaults.attach(SettingsStore());
    final l10n = await AppLocalizations.delegate.load(const Locale('tr'));
    final sent = <String>[];
    Future<void> notify(int id, String title, String body) async =>
        sent.add('$title|$body');
    final now = DateTime(2026, 10, 14);

    // Under 80%: nothing.
    await BudgetAlerts.check(
      _status(week: 70000, month: 70000),
      l10n,
      locale: 'tr',
      reference: now,
      notify: notify,
    );
    expect(sent, isEmpty);

    // Weekly 85%: one "near" alert; repeating does not re-send.
    await BudgetAlerts.check(
      _status(week: 85000, month: 85000),
      l10n,
      locale: 'tr',
      reference: now,
      notify: notify,
    );
    await BudgetAlerts.check(
      _status(week: 90000, month: 90000),
      l10n,
      locale: 'tr',
      reference: now,
      notify: notify,
    );
    expect(sent, hasLength(1));
    expect(sent.single, startsWith(l10n.weeklyLimitTitle));
    expect(sent.single, contains('85'));

    // Over 100% weekly and 80% monthly: two more, then quiet.
    await BudgetAlerts.check(
      _status(week: 120000, month: 330000),
      l10n,
      locale: 'tr',
      reference: now,
      notify: notify,
    );
    expect(sent, hasLength(3));
    await BudgetAlerts.check(
      _status(week: 130000, month: 340000),
      l10n,
      locale: 'tr',
      reference: now,
      notify: notify,
    );
    expect(sent, hasLength(3));

    // A new week starts again.
    await BudgetAlerts.check(
      _status(week: 90000, month: 340000),
      l10n,
      locale: 'tr',
      reference: now.add(const Duration(days: 7)),
      notify: notify,
    );
    expect(sent, hasLength(4));
  });
}
