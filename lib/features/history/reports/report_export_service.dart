import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'report_document.dart';

enum ReportFileFormat { pdf, csv }

typedef ReportShareFn = Future<void> Function(ShareParams params);
typedef ReportPrintFn = Future<void> Function(String html, String title);

class ReportExportService {
  /// Side effects are injectable for tests: [shareFiles] replaces the system
  /// share sheet, [printer] the native print dialog and [tempDirectory] the
  /// app's temporary directory.
  const ReportExportService({
    this.shareFiles,
    this.printer,
    this.tempDirectory,
  });

  static const _channel = MethodChannel('nshoptor/print');
  final ReportShareFn? shareFiles;
  final ReportPrintFn? printer;
  final Future<Directory> Function()? tempDirectory;

  String _title(ReportDocument document) => document.title.trim().isEmpty
      ? 'NShoptor'
      : document.title.length > 200
      ? document.title.substring(0, 200)
      : document.title;

  Future<Uint8List> bytes(
    ReportDocument document,
    ReportText text,
    ReportFileFormat format, {
    bool rtl = false,
  }) async {
    if (format == ReportFileFormat.csv) {
      return Uint8List.fromList(
        utf8.encode('﻿${buildShoppingReportCsv(document, text)}'),
      );
    }
    final fragments = buildShoppingReportHtmlFragments(
      document,
      text,
      rtl: rtl,
    );
    final arguments = <String, Object>{
      'title': _title(document),
      'html': fragments.html,
      'text': buildShoppingReportText(document, text),
      if (defaultTargetPlatform == TargetPlatform.iOS)
        'pagination': fragments.toMap(),
    };
    final data = await _channel
        .invokeMethod<Uint8List>('renderPdf', arguments)
        .timeout(const Duration(seconds: 35));
    if (data == null ||
        data.length < 5 ||
        data.length > 20 * 1024 * 1024 ||
        ascii.decode(data.sublist(0, 5), allowInvalid: true) != '%PDF-') {
      throw const FormatException('Invalid PDF output');
    }
    return data;
  }

  String fileName(ReportFileFormat format) => 'NShoptor-report.${format.name}';
  String mime(ReportFileFormat format) =>
      format == ReportFileFormat.pdf ? 'application/pdf' : 'text/csv';

  Future<bool> save(
    Uint8List data,
    ReportFileFormat format,
    String title,
  ) async =>
      await FilePicker.saveFile(
        dialogTitle: title,
        fileName: fileName(format),
        bytes: data,
        mimeType: mime(format),
      ) !=
      null;

  /// Writes [data] to a temporary report file (replacing an older one).
  Future<File> writeTemporary(Uint8List data, ReportFileFormat format) async {
    final root = await (tempDirectory ?? getTemporaryDirectory)();
    final dir = Directory('${root.path}${Platform.pathSeparator}reports');
    // Small files: synchronous IO keeps the hand-off deterministic.
    dir.createSync(recursive: true);
    final file = File(
      '${dir.path}${Platform.pathSeparator}${fileName(format)}',
    );
    file.writeAsBytesSync(data, flush: true);
    return file;
  }

  /// Shares a real temporary file through the system share sheet, so apps
  /// such as WhatsApp receive a named PDF/CSV attachment.
  Future<void> share(
    Uint8List data,
    ReportFileFormat format,
    Rect origin,
  ) async {
    final file = await writeTemporary(data, format);
    final params = ShareParams(
      files: [XFile(file.path, mimeType: mime(format), name: fileName(format))],
      fileNameOverrides: [fileName(format)],
      sharePositionOrigin: origin,
    );
    final shareFiles = this.shareFiles;
    if (shareFiles != null) {
      await shareFiles(params);
    } else {
      await SharePlus.instance.share(params);
    }
  }

  /// Opens the system print dialog with the same report HTML.
  Future<void> printReport(
    ReportDocument document,
    ReportText text, {
    bool rtl = false,
  }) async {
    final html = buildShoppingReportHtml(document, text, rtl: rtl);
    final printer = this.printer;
    if (printer != null) return printer(html, _title(document));
    await _channel.invokeMethod<void>('print', {
      'html': html,
      'title': _title(document),
    });
  }
}
