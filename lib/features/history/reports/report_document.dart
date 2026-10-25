import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money_parser.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../data/db/app_database.dart';
import '../../receipts/receipt_document.dart';
import '../insights/insights_repository.dart' show SpendAmount;
import 'report_repository.dart';

final class ReportDocument {
  ReportDocument({
    required this.title,
    required this.currencyCode,
    required List<ShoppingReport> shopping,
  }) : shopping = List.unmodifiable(shopping) {
    if (shopping.any((report) => report.list.currencyCode != currencyCode)) {
      throw ArgumentError('Report currencies must not be combined');
    }
  }
  final String title;
  final String currencyCode;
  final List<ShoppingReport> shopping;
  SpendAmount get spent => SpendAmount(
    shopping.fold(0, (sum, s) => sum + s.spent.minor),
    known: shopping.any((s) => s.spent.known),
    unknown: shopping.any((s) => s.spent.unknown),
  );
}

class ReportText {
  ReportText(this.l10n, this.locale, this.currencyCode);
  final AppLocalizations l10n;
  final String locale;
  final String currencyCode;
  String money(int minor) => formatMoney(
    Money.fromMinorUnits(minor, Currency.fromCode(currencyCode)),
    locale: locale,
  );
  String amount(int? minor) => minor == null ? '—' : money(minor);
  String date(DateTime? date) => date == null
      ? '—'
      : DateFormat.yMd(locale).add_Hm().format(date.toLocal());
  String quantity(DecimalFixed? quantity, String? unit) => quantity == null
      ? '—'
      : '${formatQuantityNumber(quantity, decimalSeparator: MoneySeparators.forLocaleCode(locale).decimal)} ${unitDisplayNameFromDb(unit ?? '', l10n)}';
  String actualQuantity(ReportProduct product) => product.isDiscount
      ? '—'
      : product.actualQuantities
            .map((q) => quantity(q.quantity, q.unitCode))
            .join(' · ');

  String receipt(Receipt receipt) {
    DateTime? printedAt = receipt.confirmedAt ?? receipt.detectedAt;
    if (receipt.captureDataJson != null) {
      try {
        // Printed receipt time is local wall time, not a captured timezone.
        printedAt =
            ReceiptDocument.decode(receipt.captureDataJson!)
                .metadata
                .dateTime ??
            printedAt;
      } on FormatException {
        /* Stored metadata remains available. */
      }
    }
    return [
      receipt.confirmedStore ?? receipt.detectedStore,
      if (printedAt != null) date(printedAt),
      if (receipt.documentNumber != null)
        '${l10n.reportReceiptNumber}: ${receipt.documentNumber}',
      if ((receipt.confirmedTotalMinorUnits ??
              receipt.detectedTotalMinorUnits) !=
          null)
        '${l10n.receiptTotal}: ${formatMoney(Money.fromMinorUnits((receipt.confirmedTotalMinorUnits ?? receipt.detectedTotalMinorUnits)!, Currency.fromCode(receipt.confirmedCurrency ?? receipt.detectedCurrency ?? currencyCode)), locale: locale)}',
    ].whereType<String>().where((s) => s.isNotEmpty).join(' · ');
  }
}

String buildShoppingReportHtml(
  ReportDocument document,
  ReportText text, {
  bool rtl = false,
}) {
  const escape = HtmlEscape();
  String e(String value) => escape.convert(value);
  final l10n = text.l10n;
  String cells(List<String> cells, {bool header = false}) =>
      '<tr>${cells.map((s) => '<${header ? 'th' : 'td'}>${e(s)}</${header ? 'th' : 'td'}>').join()}</tr>';
  final sections = <String>[];
  for (final report in document.shopping) {
    final rows = <String>[
      for (final product in report.products)
        cells([
          product.purchased ? '✓' : '○',
          product.name,
          text.quantity(product.plannedQuantity, product.plannedUnitCode),
          text.amount(product.plannedMinor),
          text.actualQuantity(product),
          product.actual.display(text.money),
          text.amount(product.difference),
        ]),
    ];
    sections.add(
      '''<section><h2>${e(report.list.title ?? report.list.generatedTitle ?? l10n.listsTitle)}</h2>
<p>${e(l10n.reportAddedAt)}: ${e(text.date(report.list.createdAt))}<br>
${e(l10n.shoppingDateLabel)}: ${e(text.date(report.list.completedAt ?? report.list.plannedAt))}
${report.storeName == null ? '' : '<br>${e(l10n.storeLabel)}: ${e(report.storeName!)}'}</p>
${report.receipts.map((r) => '<p>${e(text.receipt(r))}</p>').join()}
<table><thead>${cells(['', l10n.compareItem, l10n.plannedQtyLabel, l10n.compareEstimated, l10n.actualQtyLabel, l10n.compareActual, l10n.compareDiff], header: true)}</thead>
<tbody>${rows.join()}</tbody></table>
<p class="spent">${e(l10n.reportTotalSpent)}: ${e(report.spent.display(text.money))}</p></section>''',
    );
  }
  return '''<!doctype html><html lang="${e(l10n.localeName)}" dir="${rtl ? 'rtl' : 'ltr'}">
<meta charset="utf-8"><meta http-equiv="Content-Security-Policy" content="default-src 'none'; style-src 'unsafe-inline'">
<title>${e(document.title)}</title><style>
@page{size:A4;margin:12mm}body{font:12px sans-serif;color:#202824}h1{font-size:20px}h2{font-size:16px}
table{width:100%;table-layout:fixed;border-collapse:collapse}th,td{padding:7px;border:1px solid #bbb;text-align:start;overflow-wrap:anywhere}
th{font-size:12px;background:#f0f3f2}th:first-child,td:first-child{width:18px}thead{display:table-header-group}
tr{break-inside:avoid}.spent{font-size:16px;font-weight:700}h1,h2,p{overflow-wrap:anywhere}.brand{color:#0b8457;font-weight:800}
</style><body><p class="brand">NShoptor</p><h1>${e(document.title)}</h1>
<p>${e(l10n.reportNotInvoice)}</p>${sections.join()}
<p class="spent">${e(l10n.reportTotalSpent)}: ${e(document.spent.display(text.money))}</p></body></html>''';
}

String buildShoppingReportCsv(ReportDocument document, ReportText text) {
  final l10n = text.l10n;
  String cell(String value, {bool number = false}) {
    final leading = value.trimLeft();
    final safe =
        !number &&
            leading.isNotEmpty &&
            RegExp(r'^[=+\-@＝＋－＠\t\r\n]').hasMatch(leading)
        ? "'$value"
        : value;
    return '"${safe.replaceAll('"', '""')}"';
  }

  String major(int? minor) => minor == null
      ? ''
      : DecimalFixed.fromMinorUnits(
          minor,
          Currency.fromCode(document.currencyCode).minorUnitDigits,
        ).toDbString();
  final buffer = StringBuffer()
    ..writeln(
      [
        l10n.reportDateColumn,
        l10n.reportShoppingColumn,
        l10n.currencyLabel,
        l10n.compareItem,
        l10n.plannedQtyLabel,
        l10n.compareEstimated,
        l10n.actualQtyLabel,
        l10n.compareActual,
        l10n.compareDiff,
        l10n.storeLabel,
        l10n.reportReceiptNumber,
      ].map(cell).join(','),
    );
  for (final report in document.shopping) {
    for (final product in report.products) {
      buffer.writeln(
        [
          cell(
            (report.list.completedAt ?? report.list.createdAt)
                .toLocal()
                .toIso8601String(),
          ),
          cell(
            report.list.title ?? report.list.generatedTitle ?? l10n.listsTitle,
          ),
          cell(document.currencyCode),
          cell(product.name),
          cell(text.quantity(product.plannedQuantity, product.plannedUnitCode)),
          cell(major(product.plannedMinor), number: true),
          cell(text.actualQuantity(product)),
          cell(
            major(
              product.actual.known && !product.actual.unknown
                  ? product.actual.minor
                  : null,
            ),
            number: true,
          ),
          cell(major(product.difference), number: true),
          cell(
            report.storeName ??
                report.receipts
                    .map((r) => r.confirmedStore ?? r.detectedStore)
                    .whereType<String>()
                    .toSet()
                    .join(' · '),
          ),
          cell(
            report.receipts
                .map((r) => r.documentNumber)
                .whereType<String>()
                .join(' · '),
          ),
        ].join(','),
      );
    }
  }
  return buffer.toString();
}

/// Public Android PDF APIs render this same snapshot as readable paragraphs.
String buildShoppingReportText(ReportDocument document, ReportText text) {
  final l = text.l10n;
  final lines = <String>['NShoptor', document.title, l.reportNotInvoice];
  for (final report in document.shopping) {
    lines.addAll([
      '',
      report.list.title ?? report.list.generatedTitle ?? l.listsTitle,
      '${l.reportAddedAt}: ${text.date(report.list.createdAt)}',
      '${l.shoppingDateLabel}: ${text.date(report.list.completedAt ?? report.list.plannedAt)}',
      if (report.storeName != null) '${l.storeLabel}: ${report.storeName}',
      ...report.receipts.map(text.receipt),
    ]);
    for (final p in report.products) {
      lines.addAll([
        '',
        '${p.purchased ? '✓' : '○'} ${p.name}',
        '${l.plannedQtyLabel}: ${text.quantity(p.plannedQuantity, p.plannedUnitCode)}',
        '${l.compareEstimated}: ${text.amount(p.plannedMinor)}',
        '${l.actualQtyLabel}: ${text.actualQuantity(p)}',
        '${l.compareActual}: ${p.actual.display(text.money)}',
        '${l.compareDiff}: ${text.amount(p.difference)}',
      ]);
    }
    lines.add('${l.reportTotalSpent}: ${report.spent.display(text.money)}');
  }
  lines.add('\n${l.reportTotalSpent}: ${document.spent.display(text.money)}');
  return lines.join('\n');
}
