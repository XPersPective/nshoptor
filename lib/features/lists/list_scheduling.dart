import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../data/db/app_database.dart';

enum ListSortMode {
  date,
  title,
  manual;

  static ListSortMode fromCode(String? value) =>
      values.where((mode) => mode.name == value).firstOrNull ?? date;
}

String shoppingListTitle(ShoppingList list, {String fallback = ''}) {
  for (final value in [list.title, list.generatedTitle]) {
    if (value != null && value.trim().isNotEmpty) return value.trim();
  }
  return fallback;
}

String _foldTitle(String value, String localeCode) =>
    (localeCode.startsWith('tr') || localeCode.startsWith('az')
            ? value.replaceAll('I', 'ı').replaceAll('İ', 'i')
            : value.replaceAll('İ', 'i'))
        .toLowerCase();

int _compareTitles(String a, String b, String localeCode) {
  a = _foldTitle(a, localeCode);
  b = _foldTitle(b, localeCode);
  if (!localeCode.startsWith('tr') && !localeCode.startsWith('az')) {
    return a.compareTo(b);
  }
  // Turkish tailoring keeps ı before i and ç/ğ/ö/ş/ü beside their letters.
  const alphabet = 'abcçdefgğhıijklmnoöpqrsştuüvwxyz';
  final ar = a.runes.toList(), br = b.runes.toList();
  for (var i = 0; i < ar.length && i < br.length; i++) {
    int rank(int rune) {
      final index = alphabet.indexOf(String.fromCharCode(rune));
      return index < 0 ? alphabet.length + rune : index;
    }

    final difference = rank(ar[i]).compareTo(rank(br[i]));
    if (difference != 0) return difference;
  }
  return ar.length.compareTo(br.length);
}

List<ShoppingList> sortShoppingLists(
  Iterable<ShoppingList> lists, {
  ListSortMode mode = ListSortMode.date,
  String localeCode = 'tr',
  String fallbackTitle = '',
}) {
  return lists.toList()..sort((a, b) {
    var difference = 0;
    switch (mode) {
      case ListSortMode.date:
        if (a.plannedAt == null && b.plannedAt != null) return 1;
        if (a.plannedAt != null && b.plannedAt == null) return -1;
        difference = a.plannedAt?.compareTo(b.plannedAt!) ?? 0;
      case ListSortMode.title:
        difference = _compareTitles(
          shoppingListTitle(a, fallback: fallbackTitle),
          shoppingListTitle(b, fallback: fallbackTitle),
          localeCode,
        );
      case ListSortMode.manual:
        difference = a.sortOrder.compareTo(b.sortOrder);
    }
    if (difference != 0) return difference;
    final created = a.createdAt.compareTo(b.createdAt);
    return created == 0 ? a.id.compareTo(b.id) : created;
  });
}

String shoppingDateText(BuildContext context, DateTime value) {
  final local = value.toLocal();
  final material = MaterialLocalizations.of(context);
  return '${material.formatMediumDate(local)} · ${material.formatTimeOfDay(TimeOfDay.fromDateTime(local), alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context))}';
}

/// Commit only after both pickers finish. Cancelling either preserves the old
/// value; past dates remain editable and visible instead of being discarded.
Future<DateTime?> pickShoppingDateTime(
  BuildContext context,
  DateTime? value,
) async {
  final initial = value?.toLocal() ?? DateTime.now();
  final now = DateTime.now();
  final l10n = AppLocalizations.of(context);
  final firstYear = initial.year < now.year - 100
      ? initial.year
      : now.year - 100;
  final lastYear = initial.year > now.year + 100
      ? initial.year
      : now.year + 100;
  final date = await showDatePicker(
    context: context,
    helpText: l10n.shoppingDateLabel,
    firstDate: DateTime(firstYear),
    lastDate: DateTime(lastYear, 12, 31),
    initialDate: initial,
  );
  if (date == null || !context.mounted) return null;
  final time = await showTimePicker(
    context: context,
    helpText: l10n.reminderPickTime,
    initialTime: TimeOfDay.fromDateTime(initial),
  );
  if (time == null || !context.mounted) return null;
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  ).toUtc();
}

class ShoppingDateField extends StatefulWidget {
  const ShoppingDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final bool enabled;

  @override
  State<ShoppingDateField> createState() => _ShoppingDateFieldState();
}

class _ShoppingDateFieldState extends State<ShoppingDateField> {
  bool _picking = false;

  Future<void> _pick() async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final value = await pickShoppingDateTime(context, widget.value);
      if (mounted && value != null) widget.onChanged(value);
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            key: const Key('shopping_date_pick'),
            onPressed: widget.enabled && !_picking ? _pick : null,
            icon: const Icon(Icons.event_outlined),
            label: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.shoppingDateLabel),
                Text(
                  widget.value == null
                      ? l10n.shoppingDateNone
                      : shoppingDateText(context, widget.value!),
                ),
              ],
            ),
          ),
        ),
        if (widget.value != null)
          IconButton(
            key: const Key('shopping_date_clear'),
            tooltip: l10n.clearShoppingDateAction,
            onPressed: widget.enabled && !_picking
                ? () => widget.onChanged(null)
                : null,
            icon: const Icon(Icons.event_busy_outlined),
          ),
      ],
    );
  }
}
