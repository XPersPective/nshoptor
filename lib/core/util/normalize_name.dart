/// Ürün adı normalize etme: küçük harf + Türkçe karakter katlama + boşluk
/// temizliği. Ürün hafızası, alias eşleştirme ve yinelenen kontrolü bu
/// tek kuralı kullanır (spec §6.2, §6.9, §8).
String normalizeName(String name) => name
    .toLowerCase()
    .replaceAll('ç', 'c')
    .replaceAll('ğ', 'g')
    .replaceAll('ı', 'i')
    .replaceAll('ö', 'o')
    .replaceAll('ş', 's')
    .replaceAll('ü', 'u')
    .replaceAll(RegExp(r'[^a-z0-9 ]'), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();
