import 'dart:async';
import 'dart:convert';
import 'package:drift/native.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/summary/result_repository.dart';
import 'package:nshoptor/features/shopping_mode/summary/summary_screen.dart';

class _SavePicker extends FilePickerPlatform {
  _SavePicker(this.save);
  final Future<Uri?> Function(Uint8List) save;
  @override
  Future<Uri?> saveFile({required String fileName, required Uint8List bytes,
    required String mimeType, String? dialogTitle, String? initialDirectory,
    Function(FilePickerStatus)? onFileSaving, WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(), WebOptions webOptions = const WebOptions()}) {
    expect(fileName, 'NShoptor-TRY.csv');
    expect(mimeType, 'text/csv');
    return save(bytes);
  }
}

void main() {
  for (final locale in ['en', 'ar']) {
    testWidgets('CSV native save boundary, cancel/retry/busy and 320dp2x ($locale)', (tester) async {
      tester.view.physicalSize = const Size(320, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        final closing = db.close(); await tester.pump(const Duration(milliseconds: 1)); await closing;
      });
      final id = await ListRepository(db).createList(title: 'Owned QA', currencyCode: 'TRY');
      await ItemRepository(db).addItem(listId: id, name: '=1+2', quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece', priceIsUnitPrice: true, price: DecimalFixed.parse('1.23'));
      final previous = FilePickerPlatform.instance;
      final pending = Completer<Uri?>();
      var calls = 0;
      String? savedCsv;
      Uint8List? savedBytes;
      FilePickerPlatform.instance = _SavePicker((bytes) {
        calls++;
        savedBytes = bytes;
        savedCsv = utf8.decode(bytes);
        if (calls == 1) return pending.future;
        return Future.error(PlatformException(code: 'save_failed'));
      });
      addTearDown(() => FilePickerPlatform.instance = previous);
      await tester.pumpWidget(MaterialApp(locale: Locale(locale), supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(2)), child: child!),
        home: SummaryScreen(repository: ResultRepository(db), listId: id)));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.byKey(const Key('summary_details')), 200, scrollable: find.byType(Scrollable).first);
      final header = find.descendant(of: find.byKey(const Key('summary_details')), matching: find.byType(ListTile)).first;
      await Scrollable.ensureVisible(tester.element(header), alignment: 0.5);
      await tester.pumpAndSettle();
      await tester.tap(header);
      await tester.pumpAndSettle();
      final button = find.byKey(const Key('summary_csv_export'));
      await Scrollable.ensureVisible(tester.element(button), alignment: 0.5);
      await tester.pumpAndSettle();
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(calls, 1);
      expect(savedBytes!.take(3), [0xef, 0xbb, 0xbf]);
      expect(savedCsv, contains('"\t=1+2"'));
      expect(savedCsv, contains('1.23'));
      expect(tester.widget<TextButton>(button).onPressed, isNull);
      await tester.tap(button);
      expect(calls, 1);
      pending.complete(null);
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsNothing);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(calls, 2);
      expect(tester.widget<SnackBar>(find.byType(SnackBar)).showCloseIcon, isTrue);
      expect(tester.takeException(), isNull);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    });
  }
}
