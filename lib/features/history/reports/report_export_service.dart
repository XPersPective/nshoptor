import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'report_document.dart';

enum ReportFileFormat { pdf, csv }

class ReportExportService {
  const ReportExportService();
  static const _channel = MethodChannel('nshoptor/print');

  Future<Uint8List> bytes(
    ReportDocument document,
    ReportText text,
    ReportFileFormat format, {
    bool rtl = false,
  }) async {
    if (format == ReportFileFormat.csv) {
      return Uint8List.fromList(
        utf8.encode('\uFEFF${buildShoppingReportCsv(document, text)}'),
      );
    }
    final fragments = buildShoppingReportHtmlFragments(
      document,
      text,
      rtl: rtl,
    );
    final arguments = <String, Object>{
      'title': document.title.length > 200
          ? document.title.substring(0, 200)
          : document.title,
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

  Future<void> share(
    Uint8List data,
    ReportFileFormat format,
    Rect origin,
  ) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(data, mimeType: mime(format), name: fileName(format)),
        ],
        fileNameOverrides: [fileName(format)],
        sharePositionOrigin: origin,
      ),
    );
  }
}
