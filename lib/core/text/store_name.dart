/// Display name of a store as printed on a receipt, without legal-form
/// suffixes ("ŞOK MARKETLER TİC. A.Ş." → "ŞOK MARKETLER"), so one store is
/// shown under one name in lists and reports (F29).
String cleanStoreName(String raw) {
  var name = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  final suffix = RegExp(
    r'[\s,.-]+(?:'
    r'(?:san(?:ayi)?\.?\s*(?:ve|&)\s*)?t[iİı]c(?:aret)?\.?\s*(?:ltd\.?\s*ş?t[iİı]\.?|a\.?\s*[şs]\.?)'
    r'|ltd\.?\s*[şs]t[iİı]\.?'
    r'|a\.?\s*[şs]\.?'
    r'|gmbh(?:\s*&\s*co\.?\s*kg)?'
    r'|s\.?\s*a\.?\s*s?'
    r'|s\.?\s*r\.?\s*l\.?'
    r'|s\.?\s*l\.?'
    r'|ltd\.?|limited|inc\.?|llc|plc|corp\.?|co\.?\s*ltd\.?'
    r'|b\.?\s*v\.?|n\.?\s*v\.?|ag|kg|oy|ab'
    r')\s*$',
    caseSensitive: false,
    unicode: true,
  );
  for (var i = 0; i < 3; i++) {
    final next = name.replaceFirst(suffix, '').trim();
    if (next == name || next.isEmpty) break;
    name = next;
  }
  return name.replaceFirst(RegExp(r'[\s,.-]+$'), '');
}
