import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/format_locale.dart';
import 'report_document.dart';
import 'report_export_service.dart';

/// What the single report Share action can do (F28).
enum ReportShareAction { pdf, csv, print }

/// The small share menu: Share as PDF, Share as CSV, Print.
Future<ReportShareAction?> showReportShareMenu(BuildContext context) {
  final l = AppLocalizations.of(context);
  return showModalBottomSheet<ReportShareAction>(
    context: context,
    showDragHandle: true,
    // Large text at 320dp must scroll, never overflow.
    isScrollControlled: true,
    builder: (context) => SafeArea(
      child: SingleChildScrollView(
        child: Column(
          key: const Key('report_share_menu'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 8),
              child: Semantics(
                header: true,
                child: Text(
                  l.reportShareAction,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            for (final (action, icon, label) in [
              (
                ReportShareAction.pdf,
                Icons.picture_as_pdf_outlined,
                l.reportSharePdf,
              ),
              (
                ReportShareAction.csv,
                Icons.table_view_outlined,
                l.reportShareCsv,
              ),
              (
                ReportShareAction.print,
                Icons.print_outlined,
                l.reportPrintAction,
              ),
            ])
              ListTile(
                key: Key('report_share_${action.name}'),
                minTileHeight: 56,
                contentPadding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 24,
                ),
                leading: Icon(icon),
                title: Text(label),
                onTap: () => Navigator.of(context).pop(action),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}

/// One Share action for a report: opens [showReportShareMenu], then shares a
/// PDF or CSV file through the system share sheet, or prints.
class ReportShareButton extends StatefulWidget {
  const ReportShareButton({
    super.key,
    required this.document,
    this.service = const ReportExportService(),
    this.label,
    this.iconOnly = false,
    this.onBusy,
  });

  /// Loaded when an action is chosen, so the report is always current.
  final Future<ReportDocument> Function() document;
  final ReportExportService service;

  /// Button text; defaults to the localized "Share".
  final String? label;
  final bool iconOnly;

  /// Lets a host screen block navigation while an export runs.
  final ValueChanged<bool>? onBusy;

  @override
  State<ReportShareButton> createState() => _ReportShareButtonState();
}

class _ReportShareButtonState extends State<ReportShareButton> {
  bool _busy = false;

  void _setBusy(bool value) {
    setState(() => _busy = value);
    widget.onBusy?.call(value);
  }

  Future<void> _open() async {
    if (_busy) return;
    final action = await showReportShareMenu(context);
    if (action == null || !mounted) return;
    final l = AppLocalizations.of(context);
    final locale = formatLocaleCode(context);
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final messenger = ScaffoldMessenger.of(context);
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null || !box.hasSize
        ? const Rect.fromLTWH(0, 0, 1, 1)
        : box.localToGlobal(Offset.zero) & box.size;
    _setBusy(true);
    try {
      final document = await widget.document();
      final text = ReportText(l, locale, document.currencyCode);
      final service = widget.service;
      switch (action) {
        case ReportShareAction.pdf || ReportShareAction.csv:
          final format = action == ReportShareAction.pdf
              ? ReportFileFormat.pdf
              : ReportFileFormat.csv;
          final data = await service.bytes(document, text, format, rtl: rtl);
          if (!mounted) return;
          await service.share(data, format, origin);
        case ReportShareAction.print:
          await service.printReport(document, text, rtl: rtl);
      }
    } catch (_) {
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text(l.saveFailed), showCloseIcon: true),
        );
    } finally {
      if (mounted) _setBusy(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label =
        widget.label ?? AppLocalizations.of(context).reportShareAction;
    final icon = _busy
        ? const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.share_outlined);
    if (widget.iconOnly) {
      return IconButton(
        tooltip: label,
        icon: icon,
        onPressed: _busy ? null : _open,
      );
    }
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(minimumSize: const Size(48, 48)),
      onPressed: _busy ? null : _open,
      icon: icon,
      label: Text(label),
    );
  }
}
