import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/format_locale.dart';
import 'report_document.dart';
import 'report_export_service.dart';
import 'report_repository.dart';

class ReportPreviewScreen extends StatefulWidget {
  const ReportPreviewScreen({
    super.key,
    required this.document,
    this.exportService = const ReportExportService(),
  });
  final ReportDocument document;
  final ReportExportService exportService;
  @override
  State<ReportPreviewScreen> createState() => _ReportPreviewScreenState();
}

class _ReportPreviewScreenState extends State<ReportPreviewScreen> {
  bool _busy = false;
  double _zoom = 1;

  Future<void> _export(ReportFileFormat format, {bool share = false}) async {
    if (_busy) return;
    final l = AppLocalizations.of(context);
    final text = ReportText(
      l,
      formatLocaleCode(context),
      widget.document.currencyCode,
    );
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? const Rect.fromLTWH(0, 0, 1, 1)
        : box.localToGlobal(Offset.zero) & box.size;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    setState(() => _busy = true);
    try {
      final data = await widget.exportService.bytes(
        widget.document,
        text,
        format,
        rtl: rtl,
      );
      if (!mounted) return;
      if (share) {
        await widget.exportService.share(data, format, origin);
      } else if (await widget.exportService.save(
        data,
        format,
        format == ReportFileFormat.pdf ? l.reportPdfAction : l.csvExportAction,
      )) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.reportSaved), showCloseIcon: true),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.saveFailed), showCloseIcon: true),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = ReportText(
      l,
      formatLocaleCode(context),
      widget.document.currencyCode,
    );
    return PopScope(
      canPop: !_busy,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.reportPreview),
          actions: [
            IconButton(
              key: const Key('report_zoom'),
              tooltip: '${l.reportZoom} ${(_zoom * 100).round()}%',
              onPressed: () => setState(() {
                _zoom = _zoom >= 2 ? 1 : _zoom + .25;
              }),
              icon: const Icon(Icons.zoom_in),
            ),
          ],
        ),
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.textScalerOf(context).scale(1) * _zoom,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                widget.document.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(l.reportNotInvoice),
              for (final (index, report) in widget.document.shopping.indexed)
                _ShoppingSection(report: report, index: index, text: text),
              const Divider(height: 32),
              Text(
                '${l.reportTotalSpent}: ${widget.document.spent.display(text.money)}',
                key: const Key('report_grand_total'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              if (_busy) const Center(child: CircularProgressIndicator()),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: _busy
                        ? null
                        : () => _export(ReportFileFormat.pdf),
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    label: Text(l.reportPdfAction),
                  ),
                  OutlinedButton.icon(
                    onPressed: _busy
                        ? null
                        : () => _export(ReportFileFormat.csv),
                    icon: const Icon(Icons.table_view_outlined),
                    label: Text(l.csvExportAction),
                  ),
                  PopupMenuButton<ReportFileFormat>(
                    enabled: !_busy,
                    tooltip: l.reportShareAction,
                    onSelected: (format) => _export(format, share: true),
                    itemBuilder: (_) => [
                      for (final format in ReportFileFormat.values)
                        PopupMenuItem(
                          value: format,
                          child: Text(format.name.toUpperCase()),
                        ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.share_outlined),
                          const SizedBox(width: 8),
                          Text(l.reportShareAction),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShoppingSection extends StatelessWidget {
  const _ShoppingSection({
    required this.report,
    required this.index,
    required this.text,
  });
  final ShoppingReport report;
  final int index;
  final ReportText text;
  @override
  Widget build(BuildContext context) {
    final l = text.l10n;
    Widget price(String label, String value) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 32),
        Text(
          report.list.title ?? report.list.generatedTitle ?? l.listsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text('${l.reportAddedAt}: ${text.date(report.list.createdAt)}'),
        Text(
          '${l.shoppingDateLabel}: ${text.date(report.list.completedAt ?? report.list.plannedAt)}',
        ),
        if (report.storeName != null)
          Text('${l.storeLabel}: ${report.storeName}'),
        for (final receipt in report.receipts) Text(text.receipt(receipt)),
        for (final (row, p) in report.products.indexed)
          Card(
            key: Key('report_product_${index}_$row'),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MergeSemantics(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          checked: p.purchased,
                          readOnly: true,
                          child: ExcludeSemantics(
                            child: Icon(
                              p.purchased
                                  ? Icons.check_circle_outline
                                  : Icons.radio_button_unchecked,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            p.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${l.plannedQtyLabel}: ${text.quantity(p.plannedQuantity, p.plannedUnitCode)}',
                  ),
                  Text('${l.actualQtyLabel}: ${text.actualQuantity(p)}'),
                  const SizedBox(height: 8),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final values = [
                        price(l.compareEstimated, text.amount(p.plannedMinor)),
                        price(l.compareActual, p.actual.display(text.money)),
                      ];
                      return constraints.maxWidth < 380 ||
                              MediaQuery.textScalerOf(context).scale(1) > 1.4
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                values[0],
                                const SizedBox(height: 8),
                                values[1],
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: values[0]),
                                Expanded(child: values[1]),
                              ],
                            );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text('${l.compareDiff}: ${text.amount(p.difference)}'),
                ],
              ),
            ),
          ),
        Text(
          '${l.reportTotalSpent}: ${report.spent.display(text.money)}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (report.list.budgetMinorUnits != null &&
            report.spent.known &&
            !report.spent.unknown &&
            report.spent.minor > report.list.budgetMinorUnits!)
          Text(
            '${l.budgetLabel}: ${l.monthlyLimitOver(text.money(report.spent.minor - report.list.budgetMinorUnits!))}',
            key: Key('report_over_limit_$index'),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }
}
