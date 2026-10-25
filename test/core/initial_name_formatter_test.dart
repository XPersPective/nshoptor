import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/text/initial_name_formatter.dart';

void main() {
  TextEditingValue value(String text) => TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: text.length),
  );

  test(
    'initial paste uses locale initials and preserves the rest of the name',
    () {
      for (final entry in [
        ('tr', '  izmir eLMa', '  İzmir eLMa'),
        ('tr', 'ıspanak', 'Ispanak'),
        ('en', 'izmir eLMa', 'Izmir eLMa'),
        ('az', 'isti çay', 'İsti çay'),
        ('de', 'öl eXtra', 'Öl eXtra'),
      ]) {
        final formatter = InitialNameFormatter(localeCode: entry.$1);
        final result = formatter.formatEditUpdate(
          TextEditingValue.empty,
          value(entry.$2),
        );
        expect(result.text, entry.$3);
        expect(result.selection.baseOffset, entry.$3.length);
        expect(result.selection.extentOffset, entry.$3.length);
      }
    },
  );

  test(
    'initial IME composition waits for commit; explicit later lowercase wins',
    () {
      final formatter = InitialNameFormatter();
      final composing = value('incir')
          .copyWith(composing: const TextRange(start: 0, end: 5));
      expect(
        formatter.formatEditUpdate(TextEditingValue.empty, composing),
        composing,
      );
      final committed = formatter.formatEditUpdate(composing, value('incir'));
      expect(committed.text, 'İncir');
      expect(
        formatter.formatEditUpdate(committed, value('incir')).text,
        'incir',
      );
      expect(
        formatter.formatEditUpdate(value('incir'), TextEditingValue.empty).text,
        '',
      );
      expect(
        formatter.formatEditUpdate(TextEditingValue.empty, value('incir')).text,
        'incir',
      );
    },
  );

  test('whitespace does not consume the initial entry; existing values stay unchanged', () {
    final formatter = InitialNameFormatter();
    expect(
      formatter.formatEditUpdate(TextEditingValue.empty, value('  ')).text,
      '  ',
    );
    expect(
      formatter.formatEditUpdate(value('  '), value('  ıhlamur')).text,
      '  Ihlamur',
    );
    final editing = InitialNameFormatter(alreadyEntered: true);
    expect(
      editing.formatEditUpdate(TextEditingValue.empty, value('incir')).text,
      'incir',
    );
  });
}
