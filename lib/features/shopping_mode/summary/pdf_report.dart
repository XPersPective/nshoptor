import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money_parser.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../data/db/app_database.dart';
import 'result_repository.dart';

const pdfPrintChannel = MethodChannel('nshoptor/print');

/// A snapshot of the same recorded amounts used by the on-screen result.
Future<String> buildPdfReport(AppDatabase db, int listId, AppLocalizations l10n,
    String locale, {bool rtl = false}) => db.transaction(() async {
  final list = await (db.select(db.shoppingLists)..where((t) => t.id.equals(listId))).getSingle();
  final items = await (db.select(db.plannedItems)..where((t) => t.listId.equals(listId))).get();
  final entries = await (db.select(db.purchaseEntries)..where((t) => t.listId.equals(listId))).get();
  final result = await ResultRepository(db).compute(listId);
  const escape = HtmlEscape();
  String e(String value) => escape.convert(value);
  String money(int? minor) => minor == null ? '—' : formatMoney(Money.fromMinorUnits(minor,
    Currency.fromCode(list.currencyCode)), locale: locale);
  String qty(String quantity, String unit) => '${quantity.replaceAll('.', MoneySeparators.forLocaleCode(locale).decimal)} ${unitDisplayNameFromDb(unit, l10n)}';
  String row(List<String> cells) => '<tr>${cells.map((s) => '<td><bdi>${e(s)}</bdi></td>').join()}</tr>';
  final rows = <String>[];
  for (var i = 0; i < items.length; i++) {
    final item = items[i];
    final r = result.rows[i];
    final mine = entries.where((entry) => entry.plannedItemId == item.id);
    rows.add(row([item.name, qty(item.plannedQuantity, item.plannedUnitCode),
      mine.isEmpty ? (r.notTaken ? l10n.compareNotBought : '—') : mine.map((entry) =>
        qty(entry.actualQuantity, entry.actualUnitCode)).join(' + '),
      money(r.plannedKnown ? r.plannedLineTotalMinor : null),
      money(!r.notTaken && r.actualKnown ? r.actualLineTotalMinor : null),
      money(!r.notTaken && r.actualKnown && r.plannedKnown ? r.lineVarianceMinor : null)]));
  }
  for (final entry in entries.where((entry) => entry.plannedItemId == null)) {
    final known = entry.grossTotalMinorUnits != null || entry.actualLineTotalMinorUnits != 0 || entry.source == 'receiptOcr';
    rows.add(row([entry.name, l10n.compareUnplanned, qty(entry.actualQuantity, entry.actualUnitCode),
      '—', money(known ? entry.actualLineTotalMinorUnits : null), '—']));
  }
  final title = list.title ?? list.generatedTitle ?? l10n.listsTitle;
  final headers = [l10n.compareItem, l10n.plannedQtyLabel, l10n.actualQtyLabel,
    l10n.compareEstimated, l10n.compareActual, l10n.compareDiff];
  return '''<!doctype html><html lang="${e(l10n.localeName)}" dir="${rtl ? 'rtl' : 'ltr'}">
<meta charset="utf-8"><meta http-equiv="Content-Security-Policy" content="default-src 'none'; style-src 'unsafe-inline'">
<title>${e(title)}</title><style>
body{font:12px sans-serif;color:#111}h1{font-size:20px;overflow-wrap:anywhere}
table{border-collapse:collapse;width:100%;table-layout:fixed}th,td{border:1px solid #bbb;padding:7px;text-align:start;overflow-wrap:anywhere}
th:first-child{width:24%}thead{display:table-header-group}tr{break-inside:avoid}bdi{unicode-bidi:isolate}
</style><body><h1>${e(title)}</h1><p>${e(list.createdAt.toLocal().toIso8601String().split('T').first)} · ${e(list.currencyCode)}</p>
<p>${e(l10n.reportNotInvoice)}</p><table><thead><tr>${headers.map((s) => '<th>${e(s)}</th>').join()}</tr></thead>
<tbody>${rows.join()}</tbody></table>
<p>${e(l10n.compareEstimated)}: ${e(money(result.hasKnownPlan ? result.plannedTotalMinor : null))}<br>
${e(l10n.compareActual)}: ${e(result.hasKnownActual ? '${money(result.actualTotalMinor)}${result.hasUnknownActual ? ' + —' : ''}' : '—')}<br>
${e(l10n.compareDiff)}: ${e(money(result.hasComparison ? result.varianceMinor : null))}<br>
${e(l10n.totalDiscountLabel)}: ${e(money(result.totalDiscountMinor))}</p></body></html>''';
});

/// Opens Android's print dialog; this makes no claim that a file was saved.
Future<void> showPdfReport(BuildContext context, AppDatabase db, int listId) async {
  final l10n = AppLocalizations.of(context);
  final locale = formatLocaleCode(context);
  final rtl = Directionality.of(context) == TextDirection.rtl;
  try {
    final html = await buildPdfReport(db, listId, l10n, locale, rtl: rtl);
    if (!context.mounted) return;
    await pdfPrintChannel.invokeMethod<void>('print', {'html': html, 'title': 'NShoptor-$listId'});
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
        SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true, duration: const Duration(days: 1)));
    }
  }
}

class PdfReportButton extends StatefulWidget {
  const PdfReportButton({super.key, required this.db, required this.listId});
  final AppDatabase db;
  final int listId;
  @override
  State<PdfReportButton> createState() => _PdfReportButtonState();
}
class _PdfReportButtonState extends State<PdfReportButton> {
  bool _busy = false;
  @override
  Widget build(BuildContext context) => IconButton(key: const Key('report_pdf_button'),
    tooltip: AppLocalizations.of(context).reportPdfAction,
    icon: _busy ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()) : const Icon(Icons.picture_as_pdf_outlined),
    onPressed: _busy ? null : () async {
      setState(() => _busy = true);
      await showPdfReport(context, widget.db, widget.listId);
      if (mounted) setState(() => _busy = false);
    });
}
