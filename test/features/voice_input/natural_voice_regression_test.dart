import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/features/voice_input/ai_list_parser.dart';

void main() {
  test('local draft groups spoken price continuation before splitting products',
      () async {
    final draft = await AiListParser(localeCode: 'tr').parse(
      'Bir kilo elma 20 lira, iki ekmek, bir tanesi 20 TL '
      'toplamda 40 TL diyelim, bu kadar, listeye dönüştür',
    );
    expect(draft.fromAi, false);
    expect(draft.modelCalls, 0);
    expect(draft.items.map((item) => item.name), ['elma', 'ekmek']);
    final apple = draft.items[0];
    expect(apple.quantity!.toDbString(), '1');
    expect(apple.unitCode, UnitCode.kilogram);
    expect(apple.unitPrice!.toDbString(), '20');
    expect(apple.isUnitPrice, false);
    final bread = draft.items[1];
    expect(bread.quantity!.toDbString(), '2');
    expect(bread.unitCode, UnitCode.adet);
    expect(bread.unitPrice!.toDbString(), '20');
    expect(bread.isUnitPrice, true);
    expect((bread.quantity! * bread.unitPrice!).toDbString(), '40');
    expect(bread.requiresPriceConfirmation, false);
  });

  test('local draft produces no products from spoken controls or currency',
      () async {
    final draft = await AiListParser(localeCode: 'tr')
        .parse('TL, bu kadar, listeye dönüştür');
    expect(draft.items, isEmpty);
  });
}
