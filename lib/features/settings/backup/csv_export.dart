import '../../../core/money/currency.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';
import '../../shopping_mode/summary/result_repository.dart';

/// Alışveriş sonucunu CSV'ye çevirir (spec §6.14). Ayraç güvenliği: hücreler
/// tırnaklanır. Ondalık ayracı kanonik `.`'dır; görüntüleme formatlaması
/// kullanıcı aracına bırakılır.
String listResultToCsv(ListResult result) {
  final buffer = StringBuffer()
    ..writeln('Urun,PlanlananMiktar,PlanlananBirimFiyat,GercekMiktar,'
        'GercekBirimFiyat,SatirToplami,SatirFarki,Gruplar');
  for (final row in result.rows) {
    final groups = row.groups.map((g) => g.name).join('|');
    buffer.writeln([
      _escape(row.name),
      row.plannedQuantity?.toDbString() ?? '',
      row.plannedUnitPrice?.toDbString() ?? '',
      row.actualQuantity?.toDbString() ?? '',
      row.actualUnitPrice?.toDbString() ?? '',
      _toMajor(row.actualLineTotalMinor, result.currencyCode),
      _toMajor(row.lineVarianceMinor, result.currencyCode),
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
  final percent = result.variancePercent == null
      ? ''
      : ' (${_trimZeros(result.variancePercent!.toDbString())}%)';
  final buffer = StringBuffer()
    ..writeln('NShoptor sonucu')
    ..writeln('Planlanan: ${money(result.plannedTotalMinor)}')
    ..writeln('Gercek: ${money(result.actualTotalMinor)}')
    ..writeln('Fark: ${money(result.varianceMinor.abs())}'
        '${result.varianceMinor < 0 ? ' altinda' : result.varianceMinor > 0 ? ' ustunde' : ''}$percent');
  if (result.unplannedTotalMinor > 0) {
    buffer.writeln('Plansiz: ${money(result.unplannedTotalMinor)}');
  }
  if (result.unpurchasedPlannedMinor > 0) {
    buffer.writeln('Alinmayan plan: ${money(result.unpurchasedPlannedMinor)}');
  }
  return buffer.toString();
}

String _toMajor(int minor, String currencyCode) {
  final digits = Currency.fromCode(currencyCode).minorUnitDigits;
  if (digits == 0) return '$minor';
  var divisor = 1;
  for (var i = 0; i < digits; i++) {
    divisor *= 10;
  }
  final major = minor ~/ divisor;
  final frac = minor % divisor;
  return digits == 0
      ? '$major'
      : '$major.${frac.toString().padLeft(digits, '0')}';
}

String _escape(String cell) =>
    cell.contains(',') || cell.contains('"') || cell.contains('\n')
        ? '"${cell.replaceAll('"', '""')}"'
        : cell;

String _trimZeros(String s) {
  var value = s;
  while (value.endsWith('0')) {
    value = value.substring(0, value.length - 1);
  }
  return value.endsWith('.') ? value.substring(0, value.length - 1) : value;
}
