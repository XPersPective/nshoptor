import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../app/app_defaults.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_format.dart';
import '../../../data/db/app_database.dart';
import '../../lists/starter_categories.dart';
import '../../shopping_mode/summary/pdf_report.dart' show pdfPrintChannel;
import '../../shopping_mode/summary/result_repository.dart';
import 'insights_repository.dart';

/// Aylık harcama raporu (alışveriş raporuyla aynı yazdırma yolu): ayın
/// tamamlanan alışverişleri, tahmin/gerçek/fark, toplamlar, limit durumu ve
/// kategori dağılımı. Gerçek tutarlar Harcamalar ekranındaki toplamla aynıdır.
Future<String> buildMonthlyReport(
  AppDatabase db,
  DateTime month,
  String currencyCode,
  AppLocalizations l10n,
  String locale, {
  required String monthLabel,
  bool rtl = false,
  int? limitMinor,
}) => buildPeriodReport(
  db, DateTime(month.year, month.month), DateTime(month.year, month.month + 1),
  currencyCode, l10n, locale, periodLabel: monthLabel,
  reportName: l10n.monthlyReportAction, rtl: rtl, limitMinor: limitMinor,
);

/// A consistent snapshot for a day, week, month or other [from, to) period.
/// Callers pass local calendar boundaries; currencies are never mixed.
Future<String> buildPeriodReport(
  AppDatabase db,
  DateTime from,
  DateTime to,
  String currencyCode,
  AppLocalizations l10n,
  String locale, {
  required String periodLabel,
  String? reportName,
  bool rtl = false,
  int? limitMinor,
}) => db.transaction(() async {
  if (!to.isAfter(from)) throw ArgumentError('empty_report_period');
  final insights = InsightsRepository(db);
  final points = (await insights.completedSpend(currencyCode))
      .where((p) => !p.at.toLocal().isBefore(from) && p.at.toLocal().isBefore(to))
      .toList();
  final lists = points.isEmpty
      ? <ShoppingList>[]
      : await (db.select(db.shoppingLists)..where((t) => t.id.isIn(points.map((p) => p.listId)))).get();
  final byId = {for (final l in lists) l.id: l};
  final results = ResultRepository(db);
  const escape = HtmlEscape();
  String e(String value) => escape.convert(value);
  String money(int? minor) => minor == null
      ? '—'
      : formatMoney(Money.fromMinorUnits(minor, Currency.fromCode(currencyCode)), locale: locale);
  String row(List<String> cells) => '<tr>${cells.map((s) => '<td><bdi>${e(s)}</bdi></td>').join()}</tr>';

  final rows = <String>[];
  var planned = 0, actual = 0, diff = 0;
  var hasPlan = false, hasComparison = false, hasActual = false, unknownActual = false;
  for (final p in points) {
    final list = byId[p.listId];
    if (list == null) continue;
    final r = await results.compute(list.id);
    actual += p.actualMinor;
    hasPlan = hasPlan || r.hasKnownPlan;
    hasComparison = hasComparison || r.hasComparison;
    hasActual = hasActual || p.hasKnownActual;
    unknownActual = unknownActual || p.hasUnknownActual;
    if (r.hasKnownPlan) planned += r.plannedTotalMinor;
    if (r.hasComparison) diff += r.varianceMinor;
    rows.add(row([
      p.at.toLocal().toIso8601String().split('T').first,
      list.title ?? list.generatedTitle ?? l10n.listsTitle,
      money(r.hasKnownPlan ? r.plannedTotalMinor : null),
      p.hasKnownActual ? '${money(p.actualMinor)}${p.hasUnknownActual ? ' + —' : ''}' : '—',
      money(r.hasComparison ? r.varianceMinor : null),
    ]));
  }

  final categories = await insights.purchaseStats(currencyCode, byCategory: true, from: from.toUtc(), to: to.toUtc());
  categories.sort((a, b) => b.actualMinor.compareTo(a.actualMinor));
  final categoryRows = [
    for (final c in categories.where((c) => c.actualMinor != 0))
      row([StarterCategories().labelOf(l10n, c.name), money(c.actualMinor)]),
  ];

  final limit = limitMinor;
  final limitLine = limit == null || !hasActual || unknownActual
      ? ''
      : '<p>${e(l10n.monthlyLimitTitle)}: ${e(money(limit))} · ${e(actual > limit ? l10n.monthlyLimitOver(money(actual - limit)) : l10n.monthlyLimitLeft(money(limit - actual)))}</p>';
  final headers = [l10n.reportDateColumn, l10n.reportShoppingColumn, l10n.compareEstimated, l10n.compareActual, l10n.compareDiff];
  final title = '${reportName ?? l10n.reportPdfAction} · $periodLabel';
  return '''<!doctype html><html lang="${e(l10n.localeName)}" dir="${rtl ? 'rtl' : 'ltr'}">
<meta charset="utf-8"><meta http-equiv="Content-Security-Policy" content="default-src 'none'; style-src 'unsafe-inline'">
<title>${e(title)}</title><style>
body{font:12px sans-serif;color:#111}h1{font-size:20px;overflow-wrap:anywhere}h2{font-size:15px;margin-top:18px}
.brand{font-weight:800;font-size:16px;letter-spacing:-0.3px;margin:0 0 6px}.brand span{color:#0B8457}
.totals{display:flex;gap:16px;flex-wrap:wrap}.totals div{border:1px solid #bbb;border-radius:8px;padding:8px 12px}
table{border-collapse:collapse;width:100%;table-layout:fixed}th,td{border:1px solid #bbb;padding:7px;text-align:start;overflow-wrap:anywhere}
thead{display:table-header-group}tr{break-inside:avoid}bdi{unicode-bidi:isolate}
</style><body><p class="brand"><span>N</span>Shoptor</p><h1>${e(title)}</h1><p>${e(currencyCode)} · ${e(l10n.reportNotInvoice)}</p>
<div class="totals"><div>${e(l10n.compareEstimated)}: <b>${e(money(hasPlan ? planned : null))}</b></div>
<div>${e(l10n.compareActual)}: <b>${e(hasActual ? '${money(actual)}${unknownActual ? ' + —' : ''}' : '—')}</b></div>
<div>${e(l10n.compareDiff)}: <b>${e(money(hasComparison ? diff : null))}</b></div></div>$limitLine
<table><thead><tr>${headers.map((s) => '<th>${e(s)}</th>').join()}</tr></thead>
<tbody>${rows.isEmpty ? '<tr><td colspan="5">${e(l10n.noPurchasesNote)}</td></tr>' : rows.join()}</tbody></table>
${categoryRows.isEmpty ? '' : '<h2>${e(l10n.categoryLabel)}</h2><table><tbody>${categoryRows.join()}</tbody></table>'}
</body></html>''';
});

/// Uses the same native print/save flow as individual shopping reports.
Future<void> showPeriodReport(
  BuildContext context, AppDatabase db, DateTime from, DateTime to,
  String currencyCode, {required String periodLabel}
) async {
  final l10n = AppLocalizations.of(context);
  final locale = formatLocaleCode(context);
  final rtl = Directionality.of(context) == TextDirection.rtl;
  try {
    final html = await buildPeriodReport(db, from, to, currencyCode, l10n, locale,
      periodLabel: periodLabel, rtl: rtl);
    if (!context.mounted) return;
    await pdfPrintChannel.invokeMethod<void>('print', {
      'html': html,
      'title': 'NShoptor-${from.toIso8601String().split('T').first}',
    });
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true));
    }
  }
}

/// Android yazdırma iletişim kutusunu açar (alışveriş raporuyla aynı kanal).
Future<void> showMonthlyReport(BuildContext context, AppDatabase db, DateTime month, String currencyCode) async {
  final l10n = AppLocalizations.of(context);
  final locale = formatLocaleCode(context);
  final rtl = Directionality.of(context) == TextDirection.rtl;
  final monthLabel = MaterialLocalizations.of(context).formatMonthYear(month);
  try {
    final html = await buildMonthlyReport(db, month, currencyCode, l10n, locale,
        monthLabel: monthLabel, rtl: rtl, limitMinor: AppDefaults.monthlyLimitMinor(currencyCode: currencyCode));
    if (!context.mounted) return;
    await pdfPrintChannel.invokeMethod<void>(
        'print', {'html': html, 'title': 'NShoptor-${month.year}-${month.month.toString().padLeft(2, '0')}'});
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true, duration: const Duration(days: 1)));
    }
  }
}
