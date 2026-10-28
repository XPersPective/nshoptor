import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/text/store_name.dart';

void main() {
  test('legal-form suffixes are removed, names are kept', () {
    expect(cleanStoreName('ŞOK MARKETLER TİC.A.Ş'), 'ŞOK MARKETLER');
    expect(cleanStoreName('ŞOK MARKETLER TİC. A.Ş.'), 'ŞOK MARKETLER');
    expect(cleanStoreName('MİGROS TİCARET A.Ş.'), 'MİGROS');
    expect(cleanStoreName('YILMAZ GIDA SAN. VE TİC. LTD. ŞTİ.'), 'YILMAZ GIDA');
    expect(cleanStoreName('ALDI GmbH & Co. KG'), 'ALDI');
    expect(cleanStoreName('Tesco Stores Ltd'), 'Tesco Stores');
    expect(cleanStoreName('A101'), 'A101');
    expect(cleanStoreName('セブン-イレブン 渋谷道玄坂店'), 'セブン-イレブン 渋谷道玄坂店');
    expect(cleanStoreName('أسواق العثيم'), 'أسواق العثيم');
    expect(cleanStoreName('BAGAS'), 'BAGAS');
  });
}
