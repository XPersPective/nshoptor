import '../l10n/generated/app_localizations.dart';
import 'unit_code.dart';
import '../money/decimal_fixed.dart';
import '../money/money_parser.dart';

/// Exact human-readable quantity; integer zeroes and all significant decimal
/// digits survive. No floating-point conversion or thousands ambiguity.
String formatQuantityNumber(
  DecimalFixed value, {
  String decimalSeparator = '.',
  String? locale,
}) {
  var text = value.toDbString();
  if (value.scale > 0) {
    text = text
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
  return locale == null
      ? text.replaceAll('.', decimalSeparator)
      : MoneySeparators.forLocaleCode(locale).formatInput(text);
}

/// Birimin kullanıcıya görünen adı (hedef kuralı: kanonik kod DB'de,
/// görünen ad l10n'dan gelir). Tek kaynak burasıdır.
String unitDisplayName(UnitCode unit, AppLocalizations l10n) => switch (unit) {
  UnitCode.adet => l10n.unitAdet,
  UnitCode.kilogram => l10n.unitKilogram,
  UnitCode.gram => l10n.unitGram,
  UnitCode.litre => l10n.unitLitre,
  UnitCode.mililitre => l10n.unitMililitre,
  UnitCode.paket => l10n.unitPaket,
  UnitCode.kutu => l10n.unitKutu,
  UnitCode.sise => l10n.unitSise,
  UnitCode.kavanoz => l10n.unitKavanoz,
  UnitCode.demet => l10n.unitDemet,
  UnitCode.duzine => l10n.unitDuzine,
  UnitCode.metre => l10n.unitMetre,
  UnitCode.custom => l10n.unitCustom,
};

/// DB'deki kanonik koddan görünen ad; bilinmeyen kod olduğu gibi döner.
String unitDisplayNameFromDb(String dbCode, AppLocalizations l10n) {
  for (final unit in UnitCode.values) {
    if (unit != UnitCode.custom && unit.dbCode == dbCode) {
      return unitDisplayName(unit, l10n);
    }
  }
  return dbCode;
}

/// Ayarlarda saklanan enum adından görünen ad; bilinmeyen ad olduğu gibi döner.
String unitDisplayNameFromName(String name, AppLocalizations l10n) {
  for (final unit in UnitCode.values) {
    if (unit.name == name) return unitDisplayName(unit, l10n);
  }
  return name;
}
