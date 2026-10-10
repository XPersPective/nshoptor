import '../../../core/money/currency.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';
import '../../shopping_mode/summary/result_repository.dart';

/// Alışveriş sonucunu CSV'ye çevirir (spec §6.14). Ayraç güvenliği: hücreler
/// tırnaklanır. Ondalık ayracı kanonik `.`'dır; görüntüleme formatlaması
/// kullanıcı aracına bırakılır.
String listResultToCsv(ListResult result, {List<String>? headers}) {
  assert(headers == null || headers.length == 8);
  final buffer = StringBuffer()
    ..writeln((headers ?? const ['Urun', 'PlanlananMiktar', 'PlanlananBirimFiyat',
      'GercekMiktar', 'GercekBirimFiyat', 'SatirToplami', 'SatirFarki', 'Gruplar']).map(_escape).join(','));
  for (final row in result.rows) {
    final groups = row.groups.map((g) => g.name).join('|');
    buffer.writeln([
      _escape(row.name),
      row.plannedQuantity?.toDbString() ?? '',
      row.plannedUnitPrice?.toDbString() ?? '',
      row.actualQuantity?.toDbString() ?? '',
      row.actualUnitPrice?.toDbString() ?? '',
      row.actualKnown && !row.notTaken ? _toMajor(row.actualLineTotalMinor, result.currencyCode) : '',
      row.actualKnown && row.plannedKnown && !row.notTaken && !row.isUnplanned
          ? _toMajor(row.lineVarianceMinor, result.currencyCode) : '',
      _escape(groups),
    ].join(','));
  }
  return buffer.toString();
}

/// Paylaşılabilir özet metni (spec §6.14): düz metin, sonuç ekranı özeti.
String summaryToShareText(ListResult result) {
  final currency = Currency.fromCode(result.currencyCode);
  String money(int minor) =>
      formatMoney(Money.fromMinorUnits(minor, currency), locale: 'en');
  final percent = !result.hasComparison || result.variancePercent == null
      ? ''
      : ' (${_trimZeros(result.variancePercent!.toDbString())}%)';
  final buffer = StringBuffer()
    ..writeln('NShoptor sonucu')
    ..writeln('Planlanan: ${result.hasKnownPlan ? money(result.plannedTotalMinor) : '—'}')
    ..writeln('Gercek: ${result.hasKnownActual ? money(result.actualTotalMinor) : '—'}'
        '${result.hasKnownActual && result.hasUnknownActual ? ' + —' : ''}')
    ..writeln('Fark: ${result.hasComparison ? money(result.varianceMinor.abs()) : '—'}'
        '${!result.hasComparison ? '' : result.varianceMinor < 0 ? ' altinda' : result.varianceMinor > 0 ? ' ustunde' : ''}$percent');
  if (result.unplannedTotalMinor > 0) {
    buffer.writeln('Plansiz: ${money(result.unplannedTotalMinor)}');
  }
  if (result.unpurchasedPlannedMinor > 0) {
    buffer.writeln('Alinmayan plan: ${money(result.unpurchasedPlannedMinor)}');
  }
  return buffer.toString();
}

String _toMajor(int minor, String currencyCode) =>
    Money.fromMinorUnits(minor, Currency.fromCode(currencyCode)).toDecimal().toDbString();

String _escape(String cell) {
  final start = cell.trimLeft();
  // ponytail: quoted tabs protect Excel viewing; raw text retains them. Use JSON for lossless strings, typed XLSX for other readers.
  final text = start.isNotEmpty && '=+-@＝＋－＠'.contains(start[0]) ? '\t$cell' : cell;
  return '"${text.replaceAll('"', '""')}"';
}

String _trimZeros(String s) {
  var value = s;
  while (value.endsWith('0')) {
    value = value.substring(0, value.length - 1);
  }
  return value.endsWith('.') ? value.substring(0, value.length - 1) : value;
}
