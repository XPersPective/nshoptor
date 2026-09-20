/// Ölçü birimleri — kanonik kodlar (spec §6.2, §7.2).
///
/// Görünen adlar l10n katmanından gelir; burada hiçbir çeviri tutulmaz.
/// Kodlar veritabanına bu haliyle saklanır.
enum UnitCode {
  adet('piece'),
  kilogram('kilogram'),
  gram('gram'),
  litre('litre'),
  mililitre('millilitre'),
  paket('package'),
  kutu('box'),
  sise('bottle'),
  kavanoz('jar'),
  demet('bunch'),
  duzine('dozen'),
  metre('meter'),
  custom('custom');

  const UnitCode(this.dbCode);

  /// Veritabanı/JSON'da saklanan kararlı kod.
  final String dbCode;

  static UnitCode fromDbCode(String code) => UnitCode.values
      .firstWhere((u) => u.dbCode == code,
          orElse: () => throw ArgumentError('bilinmeyen birim kodu: $code'));

  /// `custom` dışındaki tüm birimler; Ayarlar'daki varsayılan liste için.
  static List<UnitCode> standard() =>
      UnitCode.values.where((u) => u != UnitCode.custom).toList();
}

/// Birim boyut ailesi: güvenli dönüşüm yalnız aynı aile içinde mümkündür.
enum UnitDimension { count, mass, volume, length, unknown }

extension UnitCodeX on UnitCode {
  UnitDimension get dimension => switch (this) {
        UnitCode.adet || UnitCode.duzine => UnitDimension.count,
        UnitCode.kilogram || UnitCode.gram => UnitDimension.mass,
        UnitCode.litre || UnitCode.mililitre => UnitDimension.volume,
        UnitCode.metre => UnitDimension.length,
        _ => UnitDimension.unknown,
      };
}
