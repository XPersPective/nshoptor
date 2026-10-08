import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';

import '../../../core/money/decimal_fixed.dart';
import '../../../data/db/app_database.dart';
import '../parser/receipt_parse_result.dart';
import '../parser/receipt_parser.dart' show ReceiptMatcher;
import '../../ai/ai_client.dart';
import 'ai_receipt_matcher.dart';

/// Bir aday satırın inceleme durumu.
enum ReviewStatus { pending, accepted, ignored }

/// İncelenmekte olan aday satır (spec §6.9 inceleme ekranı modeli).
class ReviewLine {
  ReviewLine({
    required this.rawText,
    required this.name,
    required this.normalizedName,
    this.quantity,
    this.unitPriceMinor,
    required this.lineTotalMinor,
    this.status = ReviewStatus.pending,
    this.linkedPlannedItemId,
    this.isUnplanned = false,
  });

  final String rawText;
  String name;
  final String normalizedName;
  DecimalFixed? quantity;
  final int? unitPriceMinor;
  int lineTotalMinor;
  ReviewStatus status;
  int? linkedPlannedItemId;

  /// Bağlantısız kabul edilen satır plansız ürün olarak eklenir (spec §6.9).
  bool isUnplanned;

  /// AI orta güvenle bağladı: kullanıcı kontrol etmeli (PB-051).
  bool needsCheck = false;

  /// Fişte indirim/kampanya satırı olarak işaretlendi (PB-051).
  bool isDiscount = false;
}

/// Fiş inceleme denetleyicisi (spec §6.9).
///
/// KRİTİK KURAL: [commit] çağrılana dek veritabanına HİÇBİR yazım yapılmaz;
/// kullanıcı onayı olmadan liste değişmez. Satırlar birleştirilebilir
/// ([mergeLines]) ve ayrılabilir ([splitLine]).
class ReceiptReviewController extends ChangeNotifier {
  ReceiptReviewController({
    required this._db,
    required this.listId,
    required ReceiptParseResult parseResult,
    this.imagePath,
    this.ai,
    this.localeCode = 'tr',
  }) {
    lines = [
      for (final line in parseResult.lines)
        ReviewLine(
          rawText: line.rawText,
          name: line.name,
          normalizedName: line.normalizedName,
          quantity: line.quantity,
          unitPriceMinor: line.unitPriceMinor,
          lineTotalMinor: line.lineTotalMinor,
        ),
    ];
    reportedTotalMinor = parseResult.totalMinor;
    detectedStore = parseResult.storeCandidates.firstOrNull;
    detectedDate = parseResult.dateCandidate;
    detectedCurrency = parseResult.currencyCandidate;
  }

  final AppDatabase _db;
  final int listId;

  /// AI eşleştirme (PB-051); null ya da başarısızsa kural tabanlı eşleştirici.
  final AiClient? ai;
  final String localeCode;

  /// Son öneri turunda eşleşmeleri AI mı yaptı (ekranda bilgi bandı).
  bool aiMatched = false;

  /// AI denenip kullanılamadıysa sebep (kota/çevrimdışı/hata).
  AiResult? aiProblem;

  late final List<ReviewLine> lines;

  /// Uzun fişler için çok fotoğraf; her görsel yolu gösterim sırasıyla tutulur
  /// (spec §6.9: birden fazla fotoğraf). Satır incelemesinden bağımsız.
  final String? imagePath;

  // Düzenlenebilir başlık alanları (spec §6.9: mağaza/tarih/para/toplam).
  String? detectedStore;
  DateTime? detectedDate;
  String? detectedCurrency;
  int? reportedTotalMinor;

  /// Kullanıcının düzenlediği doğrulanmış değerler; commit bu değerleri
  /// yazar, OCR adayları yazılmaz.
  String? confirmedStore;
  DateTime? confirmedDate;
  String? confirmedCurrency;
  int? confirmedTotalMinor;

  /// Kabul edilen satırların toplamı.
  int get acceptedTotalMinor => lines
      .where((l) => l.status == ReviewStatus.accepted)
      .fold<int>(0, (s, l) => s + l.lineTotalMinor);

  /// Kullanıcının toplamı düzgünleştirmesi (spec §6.9: toplam düzenlenebilir).
  void setReportedTotal(int minor) {
    reportedTotalMinor = minor;
    notifyListeners();
  }

  /// Bildirilen toplam ile kabul edilenlerin farkı; null = toplam okunamadı.
  int? get reconciliationDifference => reportedTotalMinor == null
      ? null
      : acceptedTotalMinor - reportedTotalMinor!;

  /// Kabul et.
  void accept(int index) {
    lines[index].status = ReviewStatus.accepted;
    notifyListeners();
  }

  /// Yok say: satır kaydedilmez.
  void ignore(int index) {
    lines[index].status = ReviewStatus.ignored;
    notifyListeners();
  }

  /// Planlanan ürüne bağla (spec §6.9).
  /// Öneri öncesi bağlama (PB-040): ReceiptMatcher'ın YÜKSEK güvenli
  /// eşleşmelerini satırlara işler — kullanıcı önizlemede bağlı görür, tek
  /// dokunuşla değiştirir/kaldırır. Orta güven yalnız öneridir, bağlamaz.
  /// Onay akışı değişmez (C-003): DB'ye yalnız accept yazımı yazar.
  Future<void> prefillSuggestions() async {
    if (await _prefillWithAi()) return;
    await _prefillWithRules();
  }

  Future<bool> _prefillWithAi() async {
    final client = ai;
    if (client == null || !client.enabled) return false;
    final planned = await (_db.select(_db.plannedItems)
          ..where((t) => t.listId.equals(listId)))
        .get();
    final outcome = await AiReceiptMatcher(client, localeCode: localeCode).match(
      [
        for (var i = 0; i < lines.length; i++)
          (
            index: i,
            text: lines[i].rawText,
            total: DecimalFixed.fromMinorUnits(lines[i].lineTotalMinor, 2).toDbString(),
          ),
      ],
      [for (final p in planned) (id: p.id, name: p.name)],
    );
    if (outcome == null) return false;
    if (outcome.result is! AiOk) {
      aiProblem = outcome.result;
      return false;
    }
    for (final m in outcome.matches) {
      final line = lines[m.lineIndex];
      line.isDiscount = m.isDiscount;
      if (m.plannedId == null || m.confidence == 'low') continue;
      if (line.linkedPlannedItemId != null) continue;
      line.linkedPlannedItemId = m.plannedId;
      line.needsCheck = m.confidence == 'medium';
    }
    aiMatched = true;
    notifyListeners();
    return true;
  }

  Future<void> _prefillWithRules() async {
    final candidates = [
      for (final line in lines)
        ReceiptLineCandidate(
          rawText: line.rawText,
          name: line.name,
          normalizedName: line.normalizedName,
          quantity: line.quantity,
          unitPriceMinor: line.unitPriceMinor,
          lineTotalMinor: line.lineTotalMinor,
          confidence: 'medium',
        ),
    ];
    final matches = await ReceiptMatcher(_db)
        .match(candidates, listId: listId);
    var changed = false;
    for (final (line, item, confidence) in matches) {
      if (confidence != 'high' || item == null) continue;
      final index = lines.indexWhere((l) => l.rawText == line.rawText);
      if (index == -1 || lines[index].linkedPlannedItemId != null) continue;
      lines[index].linkedPlannedItemId = item.id;
      changed = true;
    }
    if (changed) notifyListeners();
  }

  void linkLine(int index, int plannedItemId) {    lines[index]
      ..status = ReviewStatus.accepted
      ..linkedPlannedItemId = plannedItemId
      ..isUnplanned = false;
    notifyListeners();
  }

  void unlinkLine(int index) {
    lines[index]
      ..linkedPlannedItemId = null
      ..isUnplanned = true;
    notifyListeners();
  }

  /// İki adayı birleştirir: adlar boşlukla bitişir, miktarlar toplanır,
  /// satır tutarları toplanır (spec §6.9: yanlış bölünmüş satırlar
  /// birleştirilebilir).
  void mergeLines(int a, int b) {
    if (a == b) return;
    final first = lines[a];
    final second = lines[b];
    first
      ..name = '${first.name} ${second.name}'.trim()
      ..lineTotalMinor = first.lineTotalMinor + second.lineTotalMinor
      ..quantity = _sumQty(first.quantity, second.quantity)
      ..status = ReviewStatus.pending;
    lines.removeAt(b);
    notifyListeners();
  }

  /// Satırı ikiye ayırır: tutarı [firstMinor] + kalan olarak bölünür
  /// (birleşmiş satırlar ayrılabilir).
  void splitLine(int index, {required int firstMinor}) {
    final original = lines[index];
    final remaining = original.lineTotalMinor - firstMinor;
    final copy = ReviewLine(
      rawText: original.rawText,
      name: original.name,
      normalizedName: original.normalizedName,
      quantity: original.quantity,
      unitPriceMinor: original.unitPriceMinor,
      lineTotalMinor: remaining,
      status: ReviewStatus.pending,
      linkedPlannedItemId: original.linkedPlannedItemId,
    );
    original.lineTotalMinor = firstMinor;
    lines.insert(index + 1, copy);
    notifyListeners();
  }

  /// Kullanıcı onayı: yalnız kabul edilen satırlar kayda geçer.
  /// Bağlılar planlanan ürüne, bağlantısızlar plansız ürün olarak yazılır
  /// (spec §6.9: onaydan önce veritabanı değişmez).
  Future<void> commit() async {
    final accepted = lines.where((l) => l.status == ReviewStatus.accepted);
    for (final line in accepted) {
      await _db.into(_db.purchaseEntries).insert(
            PurchaseEntriesCompanion.insert(
              listId: listId,
              plannedItemId: Value(line.linkedPlannedItemId),
              name: line.name,
              normalizedName: line.normalizedName,
              actualQuantity: line.quantity?.toDbString() ?? '1',
              actualUnitCode: 'adet',
              actualLineTotalMinorUnits: line.lineTotalMinor,
              source: const Value('receiptOcr'),
              userConfirmed: const Value(true),
            ),
          );
    }
  }

  DecimalFixed? _sumQty(DecimalFixed? a, DecimalFixed? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a + b;
  }
}
