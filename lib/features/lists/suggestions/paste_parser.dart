import 'paste_candidate.dart';

/// Çok satırlı yapıştırma: her boş olmayan satır bir ürün adayıdır
/// (spec §6.2). Deterministiktir; miktar/fiyat çıkarımı yapılmaz, adayı
/// kullanıcı önizlemede düzenler.
List<PasteCandidate> parsePastedLines(String text) {
  final candidates = <PasteCandidate>[];
  for (final raw in text.split(RegExp(r'\r?\n'))) {
    final line = raw.trim();
    if (line.isEmpty) continue;
    candidates.add(PasteCandidate(rawLine: line, name: line));
  }
  return candidates;
}
