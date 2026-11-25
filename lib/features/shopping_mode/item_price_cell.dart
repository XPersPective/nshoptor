import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/format_locale.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
import '../../core/theme/semantic_colors.dart';
import '../../data/db/app_database.dart';
import 'item_status.dart';

/// Bir ürünün tahmini ve gerçek tutarı (PB-062): ayrıntı ekranına gitmeden
/// her satırda "20 → 30, +10" görünür.
class ItemPrices {
  const ItemPrices({
    this.plannedMinor,
    this.actualMinor,
    this.grossActualMinor,
    this.discountMinor = 0,
    this.discountLabel,
  });

  final int? plannedMinor;
  final int? actualMinor;
  final int? grossActualMinor;
  final int discountMinor;
  final String? discountLabel;

  bool get hasActual => actualMinor != null;

  /// gerçek − tahmini; ikisi de varsa.
  int? get diffMinor =>
      plannedMinor != null && actualMinor != null ? actualMinor! - plannedMinor! : null;

  factory ItemPrices.of(PlannedItem item, Iterable<PurchaseEntry> entries) {
    final mine = entries.where((e) => e.plannedItemId == item.id).toList();
    final complete = mine.isNotEmpty && mine.every(hasMarketPrice);
    final actual = !complete
        ? null
        : mine.fold<int>(0, (a, e) => a + e.actualLineTotalMinorUnits);
    final discount = !complete
        ? 0
        : mine.fold<int>(0, (a, e) => a + e.discountMinorUnits);
    final labels = !complete
        ? const <String>[]
        : mine
              .map((e) => e.note?.trim())
              .whereType<String>()
              .where((s) => s.isNotEmpty)
              .toSet()
              .toList();
    return ItemPrices(
      plannedMinor: item.plannedLineTotalMinorUnits,
      actualMinor: actual,
      grossActualMinor: actual != null && discount > 0 ? actual + discount : null,
      discountMinor: discount,
      discountLabel: labels.isEmpty ? null : labels.join(', '),
    );
  }
}

/// Satırın sağ tarafı: üstte tahmini, altta gerçek (+ fark). Gerçek fiyat yoksa
/// "gerçek fiyatı gir" ve (varsa) kamerayla okut düğmeleri hemen yanında durur.
class ItemPriceCell extends StatelessWidget {
  const ItemPriceCell({
    super.key,
    required this.prices,
    required this.currencyCode,
    this.onEnter,
    this.onScan,
  });

  final ItemPrices prices;
  final String currencyCode;

  /// Gerçek fiyatı elle gir (sayfa/satır dokunuşuyla aynı).
  final VoidCallback? onEnter;

  /// Etiketi kamerayla okut; null ise düğme görünmez.
  final VoidCallback? onScan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currency = Currency.fromCode(currencyCode);
    final locale = formatLocaleCode(context);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);

    final diff = prices.diffMinor;

    // Amounts wrap naturally; tooltips and semantics retain the price roles.
    Widget line(List<Widget> children) => Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: children);

    final planned = line([
        Text(
          prices.plannedMinor == null ? '—' : money(prices.plannedMinor!),
          key: const Key('price_planned'),
          semanticsLabel: '${l10n.compareEstimated} ${prices.plannedMinor == null ? '—' : money(prices.plannedMinor!)}',
          style: theme.textTheme.bodyMedium,
        ),
    ]);

    final actual = line([
        Icon(Icons.arrow_forward, size: 14, semanticLabel: l10n.compareActual),
        const SizedBox(width: 6),
        Text(
          prices.hasActual ? money(prices.actualMinor!) : '—',
          key: prices.hasActual ? const Key('price_actual') : const Key('price_actual_empty'),
          style: theme.textTheme.titleSmall,
        ),
        if (diff != null && diff != 0) ...[
          const SizedBox(width: 6),
          _Diff(diff: diff, text: money(diff.abs())),
        ],
    ]);

    // Gerçek fiyat girilmemişse düzenle/kamera düğmeleri yanında durur.
    final buttons = <Widget>[
      if (onEnter != null)
        IconButton(
          key: const Key('price_enter'),
          tooltip: l10n.actualPriceLabel,
          icon: const Icon(Icons.edit_outlined, size: 22),
          onPressed: onEnter,
        ),
      if (onScan != null)
        IconButton(
          key: const Key('price_scan'),
          tooltip: l10n.tipShelfCamera,
          icon: const Icon(Icons.photo_camera_outlined, size: 22),
          onPressed: onScan,
        ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Tooltip(message: l10n.compareEstimated, child: planned),
        if (prices.hasActual) Tooltip(message: l10n.compareActual, child: actual),
        if (prices.discountMinor > 0)
          line([
            Icon(
              Icons.local_offer_outlined,
              size: 13,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Text(
              key: const Key('price_discount'),
              [
                if (prices.grossActualMinor != null)
                  money(prices.grossActualMinor!),
                '−${money(prices.discountMinor)}',
                if (prices.discountLabel?.isNotEmpty == true)
                  prices.discountLabel!,
              ].join(' · '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]),
        ...buttons,
      ],
    );
  }
}

class _Diff extends StatelessWidget {
  const _Diff({required this.diff, required this.text});

  final int diff;
  final String text;

  @override
  Widget build(BuildContext context) {
    final delta = SemanticDelta.resolve(
      direction: diff > 0 ? SpendingDirection.overPlan : SpendingDirection.underPlan,
      brightness: Theme.of(context).brightness,
    );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(delta.icon, size: 14, color: delta.color, semanticLabel: delta.marker),
        Text(
          '${diff > 0 ? '+' : '−'}$text',
          style: TextStyle(color: delta.color, fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ],
    );
  }
}
