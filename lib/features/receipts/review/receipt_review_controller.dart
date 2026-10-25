import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' show Value, BooleanExpressionOperators;

import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';
import '../../../core/quantity/unit_conversion.dart';
import '../../../core/money/currency.dart';
import '../../../core/util/normalize_name.dart';
import '../../shopping_mode/shopping_repository.dart';
import '../../shopping_mode/item_status.dart' show hasMarketPrice;
import '../../lists/item_repository.dart';
import '../../lists/list_repository.dart';
import '../../../data/db/app_database.dart';
import '../parser/receipt_parse_result.dart';
import '../parser/receipt_parser.dart' show ReceiptMatcher;
import '../receipt_document.dart';
import '../../ai/ai_client.dart';
import 'ai_receipt_matcher.dart';

/// Bir aday satırın inceleme durumu.
enum ReviewStatus { pending, accepted, ignored }

final class ReceiptAlreadyImported implements Exception {
  const ReceiptAlreadyImported(this.listId);
  final int? listId;
}

final class ReceiptIncomplete implements Exception {
  const ReceiptIncomplete();
}

final class ReceiptUnresolvedLines implements Exception {
  const ReceiptUnresolvedLines();
}

final class ReceiptPartialNeedsConfirmation implements Exception {
  const ReceiptPartialNeedsConfirmation();
}

enum ReceiptSelection { wholeReceipt, confirmedSubset }

typedef _MatchInput = ({
  ReviewLine line,
  String name,
  String? quantity,
  UnitCode? unit,
  int total,
});

/// İncelenmekte olan aday satır (spec §6.9 inceleme ekranı modeli).
class ReviewLine {
  ReviewLine({
    required this.rawText,
    required this.name,
    required this.normalizedName,
    this.quantity,
    this.unitCode,
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
  UnitCode? unitCode;
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
/// KRİTİK KURAL: [commit] çağrılana dek liste/satın alım değişmez;
/// ayrı kalıcı tarama taslakları onaylanmış alışveriş değildir. Satırlar birleştirilebilir
/// ([mergeLines]) ve ayrılabilir ([splitLine]).
class ReceiptReviewController extends ChangeNotifier {
  ReceiptReviewController({
    required this._db,
    this.listId,
    this.currencyCode = 'TRY',
    this.title,
    required ReceiptParseResult parseResult,
    this.imagePath,
    this.document,
    this.draftId,
    this.ai,
    this.localeCode = 'tr',
  }) {
    // The approved document is the source of its candidates and currency.
    // A stale caller parser result cannot bind another basket to this identity.
    parseResult = document?.toParseResult() ?? parseResult;
    lines = [
      for (final line in parseResult.lines)
        ReviewLine(
          rawText: line.rawText,
          name: line.name,
          normalizedName: line.normalizedName,
          quantity: line.quantity,
          unitCode: line.unitCode,
          unitPriceMinor: line.unitPriceMinor,
          lineTotalMinor: line.lineTotalMinor,
        ),
    ];
    if ((parseResult.discountMinor ?? 0) > 0) {
      lines.add(
        ReviewLine(
          rawText: '',
          name: '−',
          normalizedName: 'discount',
          quantity: DecimalFixed.zero(),
          lineTotalMinor: -parseResult.discountMinor!,
        )..isDiscount = true,
      );
    }
    reportedTotalMinor = parseResult.totalMinor;
    detectedStore = parseResult.storeCandidates.firstOrNull;
    detectedDate = parseResult.dateCandidate;
    detectedCurrency = parseResult.currencyCandidate;
    currencyNeedsConfirmation = parseResult.currencyNeedsConfirmation;
  }

  final AppDatabase _db;
  int? listId;
  final String currencyCode;
  final String? title;
  bool _disposed = false;
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

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
  final ReceiptDocument? document;
  final int? draftId;

  bool get documentReady =>
      document == null ||
      document!.state == ReceiptDocumentState.complete &&
          document!.toParseResult().withinReconciliationTolerance;

  bool get reviewResolved =>
      document == null ||
      lines.every((line) => line.status != ReviewStatus.pending);

  bool get isPartialSelection =>
      document != null && acceptedTotalMinor != document!.metadata.totalMinor;

  void acceptAll() {
    for (final line in lines) {
      line.status = ReviewStatus.accepted;
    }
    notifyListeners();
  }

  // Düzenlenebilir başlık alanları (spec §6.9: mağaza/tarih/para/toplam).
  String? detectedStore;
  DateTime? detectedDate;
  String? detectedCurrency;
  bool currencyNeedsConfirmation = false;
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
    if (listId == null || _disposed) return;
    if (await _prefillWithAi() || _disposed) return;
    await _prefillWithRules();
  }

  Future<void> prefillRules() async {
    if (listId == null || _disposed) return;
    await _prefillWithRules();
  }

  Future<bool> _prefillWithAi() async {
    final client = ai;
    if (client == null || !client.enabled) return false;
    final list = await ShoppingRepository(_db).getList(listId!);
    final digits = Currency.fromCode(list.currencyCode).minorUnitDigits;
    final planned = await (_db.select(
      _db.plannedItems,
    )..where((t) => t.listId.equals(listId!))).get();
    final inputs = _matchInputs();
    final outcome = await AiReceiptMatcher(client, localeCode: localeCode)
        .match(
          [
            for (var i = 0; i < inputs.length; i++)
              (
                index: i,
                text: inputs[i].line.rawText,
                total: DecimalFixed.fromMinorUnits(
                  inputs[i].total,
                  digits,
                ).toDbString(),
              ),
          ],
          [for (final p in planned) (id: p.id, name: p.name)],
        );
    if (outcome == null || _disposed) return false;
    // Review edits invalidate the request's indices. Never partially apply an
    // old response to a merged/split/renamed basket or fall back on stale text.
    if (!listEquals(inputs, _matchInputs())) return true;
    if (outcome.result is! AiOk) {
      aiProblem = outcome.result;
      return false;
    }
    for (final m in outcome.matches) {
      final line = inputs[m.lineIndex].line;
      if (line.status != ReviewStatus.pending || line.isUnplanned) continue;
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
    final inputs = _matchInputs();
    final candidates = [
      for (final line in lines)
        ReceiptLineCandidate(
          rawText: line.rawText,
          name: line.name,
          normalizedName: line.normalizedName,
          quantity: line.quantity,
          unitCode: line.unitCode,
          unitPriceMinor: line.unitPriceMinor,
          lineTotalMinor: line.lineTotalMinor,
          confidence: 'medium',
        ),
    ];
    final matches = await ReceiptMatcher(_db)
        .match(candidates, listId: listId!);
    if (_disposed || !listEquals(inputs, _matchInputs())) return;
    var changed = false;
    for (final (line, item, confidence) in matches) {
      if (confidence != 'high' || item == null) continue;
      final index = lines.indexWhere((l) => l.rawText == line.rawText);
      if (index == -1 || lines[index].linkedPlannedItemId != null) continue;
      if (lines[index].status != ReviewStatus.pending ||
          lines[index].isUnplanned) {
        continue;
      }
      lines[index].linkedPlannedItemId = item.id;
      changed = true;
    }
    if (changed) notifyListeners();
  }

  List<_MatchInput> _matchInputs() => [
    for (final line in lines)
      (
        line: line,
        name: line.name,
        quantity: line.quantity?.toDbString(),
        unit: line.unitCode,
        total: line.lineTotalMinor,
      ),
  ];

  void linkLine(int index, int plannedItemId) {
    lines[index]
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
    DecimalFixed? secondQuantity = second.quantity;
    if (first.unitCode != second.unitCode) {
      if (first.unitCode == null ||
          second.unitCode == null ||
          secondQuantity == null) {
        throw ArgumentError(
          'Receipt units require confirmation before merging',
        );
      }
      secondQuantity = UnitConversion.convert(
        secondQuantity,
        second.unitCode!,
        first.unitCode!,
      );
    }
    first
      ..name = '${first.name} ${second.name}'.trim()
      ..lineTotalMinor = first.lineTotalMinor + second.lineTotalMinor
      ..quantity = _sumQty(first.quantity, secondQuantity)
      ..status = ReviewStatus.pending;
    lines.removeAt(b);
    notifyListeners();
  }

  /// Satırı ikiye ayırır: tutarı [firstMinor] + kalan olarak bölünür
  /// (birleşmiş satırlar ayrılabilir).
  void splitLine(int index, {required int firstMinor}) {
    final original = lines[index];
    final remaining = original.lineTotalMinor - firstMinor;
    if (original.lineTotalMinor == 0 ||
        firstMinor == 0 ||
        remaining == 0 ||
        firstMinor.isNegative != original.lineTotalMinor.isNegative ||
        remaining.isNegative != original.lineTotalMinor.isNegative) {
      throw ArgumentError('Split must preserve the line total sign');
    }
    final firstQuantity = original.quantity == null
        ? null
        : (original.quantity! * DecimalFixed.fromInt(firstMinor)).divide(
            DecimalFixed.fromInt(original.lineTotalMinor),
            scale: DecimalFixed.maxFractionDigits,
          );
    final copy = ReviewLine(
      rawText: original.rawText,
      name: original.name,
      normalizedName: original.normalizedName,
      unitCode: original.unitCode,
      quantity: firstQuantity == null
          ? null
          : original.quantity! - firstQuantity,
      unitPriceMinor: original.unitPriceMinor,
      lineTotalMinor: remaining,
      status: ReviewStatus.pending,
      linkedPlannedItemId: original.linkedPlannedItemId,
    )..isDiscount = original.isDiscount;
    original.lineTotalMinor = firstMinor;
    original.quantity = firstQuantity;
    lines.insert(index + 1, copy);
    notifyListeners();
  }

  /// Kullanıcı onayı: yalnız kabul edilen satırlar kayda geçer.
  /// Bağlılar planlanan ürüne, bağlantısızlar plansız ürün olarak yazılır
  /// (spec §6.9: onaydan önce veritabanı değişmez).
  Future<void>? _commitFuture;
  Future<List<PurchaseEntry>> replacementEntries() =>
      listId == null || document != null
      ? Future.value([])
      : (_db.select(_db.purchaseEntries)..where(
              (t) => t.plannedItemId.isIn(
                lines
                    .where((l) => l.status == ReviewStatus.accepted)
                    .map((l) => l.linkedPlannedItemId)
                    .whereType<int>(),
              ),
            ))
            .get();

  Future<void> commit({
    ReceiptSelection selection = ReceiptSelection.wholeReceipt,
  }) => _commitFuture ??= _commitOnce(selection).onError((error, stack) {
    _commitFuture = null;
    Error.throwWithStackTrace(error!, stack);
  });

  Future<void> _commitOnce(ReceiptSelection selection) async {
    if (!documentReady) throw const ReceiptIncomplete();
    if (!reviewResolved) throw const ReceiptUnresolvedLines();
    if (isPartialSelection && selection != ReceiptSelection.confirmedSubset) {
      throw const ReceiptPartialNeedsConfirmation();
    }
    final reviewed = [
      for (final line in lines)
        ReviewLine(
          rawText: line.rawText,
          name: line.name,
          normalizedName: line.normalizedName,
          quantity: line.quantity,
          unitCode: line.unitCode,
          unitPriceMinor: line.unitPriceMinor,
          lineTotalMinor: line.lineTotalMinor,
          status: line.status,
          linkedPlannedItemId: line.linkedPlannedItemId,
          isUnplanned: line.isUnplanned,
        )..isDiscount = line.isDiscount,
    ];
    try {
      final committedId = await _db.transaction(() async {
        final identity = document?.identity;
        if (document != null) {
          if (identity == null) throw const ReceiptIncomplete();
          final previous =
              await (_db.select(_db.receipts)..where(
                    (t) =>
                        t.identityKey.isNotNull() &
                        (t.identityKey.equals(identity) |
                            t.documentNumber.equals(
                              document!.metadata.documentNumber!,
                            )),
                  ))
                  .get();
          for (final receipt in previous) {
            // Version1 keys used exact seconds. Recompute from retained OCR
            // (or its stored metadata) to protect already-approved documents.
            final previousIdentity = receipt.captureDataJson == null
                ? ReceiptMetadata(
                    store: receipt.detectedStore,
                    documentNumber: receipt.documentNumber,
                    dateTime: receipt.detectedAt,
                    currencyCode: receipt.detectedCurrency,
                  ).identity
                : ReceiptDocument.decode(receipt.captureDataJson!).identity;
            if (receipt.identityKey == identity ||
                previousIdentity == identity) {
              throw ReceiptAlreadyImported(receipt.listId);
            }
          }
        }
        final accepted = reviewed
            .where((l) => l.status == ReviewStatus.accepted)
            .toList();
        if (accepted.isEmpty) {
          throw ArgumentError('Receipt has no accepted lines');
        }
        final repo = ShoppingRepository(_db);
        final committedListId =
            listId ??
            await ListRepository(_db).createList(
              title: title,
              currencyCode: currencyCode,
              plannedAt: document?.metadata.dateTime,
            );
        final list = await repo.getList(committedListId);
        if (list.status == 'completed' || list.status == 'archived') {
          throw StateError('Receipt requires an active shopping list');
        }
        if (currencyNeedsConfirmation ||
            document != null &&
                document!.metadata.currencyCode != list.currencyCode ||
            detectedCurrency != null && detectedCurrency != list.currencyCode ||
            confirmedCurrency != null &&
                confirmedCurrency != list.currencyCode) {
          throw ArgumentError('Receipt currency must match the list');
        }
        int? receiptId;
        if (document != null) {
          final doc = document!;
          final values = ReceiptsCompanion(
            listId: Value(committedListId),
            identityKey: Value(identity),
            documentNumber: Value(doc.metadata.documentNumber),
            captureDataJson: Value(doc.encode()),
            rawOcrText: Value(
              doc.fragments
                  .map((f) => f.lines.map((l) => l.text).join('\n'))
                  .join('\n\n'),
            ),
            detectedStore: Value(doc.metadata.store),
            detectedAt: Value(doc.metadata.dateTime),
            detectedCurrency: Value(doc.metadata.currencyCode),
            detectedTotalMinorUnits: Value(doc.metadata.totalMinor),
            confirmedStore: Value(confirmedStore ?? doc.metadata.store),
            confirmedAt: Value(confirmedDate ?? doc.metadata.dateTime),
            confirmedCurrency: Value(
              confirmedCurrency ?? doc.metadata.currencyCode,
            ),
            confirmedTotalMinorUnits: Value(
              confirmedTotalMinor ?? reportedTotalMinor,
            ),
            processingStatus: const Value('reviewed'),
            parserVersion: Value('${ReceiptParseResult.parserVersion}'),
          );
          if (draftId != null) {
            final draft = await (_db.select(
              _db.receipts,
            )..where((t) => t.id.equals(draftId!))).getSingleOrNull();
            if (draft == null ||
                draft.processingStatus != 'pending' ||
                draft.listId != listId ||
                draft.captureDataJson != doc.encode()) {
              throw StateError('Receipt draft changed before approval');
            }
            await (_db.update(
              _db.receipts,
            )..where((t) => t.id.equals(draftId!))).write(values);
            receiptId = draftId;
          } else {
            receiptId = await _db.into(_db.receipts).insert(values);
          }
          for (final line in reviewed) {
            await _db
                .into(_db.receiptCandidateLines)
                .insert(
                  ReceiptCandidateLinesCompanion.insert(
                    receiptId: receiptId!,
                    rawText: line.rawText,
                    parsedName: Value(line.name),
                    parsedQuantity: Value(line.quantity?.toDbString()),
                    parsedUnitCode: Value(line.unitCode?.dbCode),
                    parsedUnitPrice: Value(
                      line.unitPriceMinor == null
                          ? null
                          : DecimalFixed.fromMinorUnits(
                              line.unitPriceMinor!,
                              Currency.fromCode(list.currencyCode)
                                  .minorUnitDigits,
                            ).toDbString(),
                    ),
                    parsedLineTotalMinorUnits: Value(line.lineTotalMinor),
                    linkedPlannedItemId: Value(line.linkedPlannedItemId),
                    reviewStatus: Value(line.status.name),
                  ),
                );
          }
        }
        final linked = <int, PlannedItem>{};
        final alreadyPriced = <int>{};
        for (final id
            in (document == null ? accepted : reviewed)
                .map((l) => l.linkedPlannedItemId)
                .whereType<int>()
                .toSet()) {
          final item = await (_db.select(
            _db.plannedItems,
          )..where((t) => t.id.equals(id))).getSingleOrNull();
          if (item == null || item.listId != committedListId) {
            throw ArgumentError('Receipt item must belong to its list');
          }
          linked[id] = item;
          if (document == null) {
            await repo.removePurchases(id);
          } else {
            final entries = await (_db.select(
              _db.purchaseEntries,
            )..where((t) => t.plannedItemId.equals(id))).get();
            if (entries.any(hasMarketPrice)) {
              alreadyPriced.add(id);
            }
          }
        }
        for (final line in accepted) {
          var quantity = line.quantity ?? DecimalFixed.fromInt(1);
          if (line.isDiscount && line.lineTotalMinor < 0) {
            quantity = DecimalFixed.zero();
          }
          if (line.lineTotalMinor < 0 && quantity.isPositive) {
            quantity = quantity.negated();
          }
          var purchaseUnit = line.unitCode ?? UnitCode.adet;
          final reuseTarget =
              document == null ||
              !alreadyPriced.contains(line.linkedPlannedItemId);
          final target = reuseTarget ? linked[line.linkedPlannedItemId] : null;
          if (target != null) {
            final targetUnit = UnitCode.values.firstWhere(
              (u) =>
                  u.dbCode == target.plannedUnitCode ||
                  u.name == target.plannedUnitCode,
            );
            if (line.unitCode != null && purchaseUnit != targetUnit) {
              quantity = UnitConversion.convert(
                quantity,
                purchaseUnit,
                targetUnit,
              );
            }
            purchaseUnit = targetUnit;
          }
          var plannedItemId = reuseTarget ? line.linkedPlannedItemId : null;
          if (document != null && plannedItemId != null) {
            alreadyPriced.add(plannedItemId);
          }
          // Positive receipt lines absent from the plan still belong in the list:
          // create the smallest valid planned row, then link its purchase so the
          // completed receipt is visible in the same shopping history.
          if (plannedItemId == null &&
              !line.isDiscount &&
              quantity.isPositive) {
            plannedItemId = await ItemRepository(_db).addItem(
              listId: committedListId,
              name: line.name,
              quantity: quantity,
              unitCode: purchaseUnit.dbCode,
              priceIsUnitPrice: false,
            );
          }
          await repo.recordPurchase(
            listId: committedListId,
            receiptId: receiptId,
            plannedItemId: plannedItemId,
            name: line.name,
            normalizedName: line.isDiscount && quantity.isZero
                ? 'discount'
                : normalizeName(line.name),
            quantity: quantity,
            unitCode: purchaseUnit.dbCode,
            lineTotalMinor: line.lineTotalMinor,
            source: 'receiptOcr',
            replaceExisting: false,
          );
        }
        if (listId == null) await repo.startShopping(committedListId);
        return committedListId;
      });
      listId = committedId;
    } catch (error) {
      // Another connection may win the unique constraint after our read.
      // Resolve that outcome only after this transaction has rolled back.
      final identity = document?.identity;
      if (identity != null && error is! ReceiptAlreadyImported) {
        final previous = await (_db.select(
          _db.receipts,
        )..where((t) => t.identityKey.equals(identity))).getSingleOrNull();
        if (previous != null) throw ReceiptAlreadyImported(previous.listId);
      }
      rethrow;
    }
  }

  DecimalFixed? _sumQty(DecimalFixed? a, DecimalFixed? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a + b;
  }
}
