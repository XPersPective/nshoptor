import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money.dart';
import '../../data/db/app_database.dart';
import '../lists/item_form_sheet.dart';
import '../lists/list_repository.dart';
import '../lists/list_status.dart';
import '../lists/lists_screen.dart';
import '../lists/starter_categories.dart';
import '../shopping_mode/shopping_mode_screen.dart';
import '../shopping_mode/shopping_repository.dart';
import '../shopping_mode/summary/summary_screen.dart';
import '../shopping_mode/summary/result_repository.dart';

/// Liste detayı (spec §9 "Planlama liste detayı"): ürünler, ürün ekleme,
/// alışverişi başlat/bitir ve sonuç.
class ListDetailScreen extends StatefulWidget {
  const ListDetailScreen({
    super.key,
    required this.db,
    required this.listRepository,
    required this.listId,
  });

  final AppDatabase db;
  final ListRepository listRepository;
  final int listId;

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  late final ShoppingRepository _shoppingRepo = ShoppingRepository(widget.db);
  late Future<ShoppingList> _listFuture;

  @override
  void initState() {
    super.initState();
    _listFuture = widget.listRepository.getById(widget.listId);
  }

  void _refresh() {
    setState(() {
      _listFuture = widget.listRepository.getById(widget.listId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.listsTitle)),
      body: FutureBuilder<ShoppingList>(
        future: _listFuture,
        builder: (context, snapshot) {
          final list = snapshot.data;
          if (list == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final currency = Currency.fromCode(list.currencyCode);
          return Column(
            children: [
              ListTile(
                title: Text(list.title ?? list.generatedTitle ?? l10n.listsTitle),
                subtitle: Text(statusLabel(
                    l10n, ListStatus.tryFromDb(list.status) ?? ListStatus.draft)),
              ),
              Expanded(
                child: StreamBuilder<List<PlannedItem>>(
                  stream: _shoppingRepo.watchItems(widget.listId),
                  builder: (context, snapshot) {
                    final items = snapshot.data ?? const <PlannedItem>[];
                    if (items.isEmpty) {
                      return Center(child: Text(l10n.listsEmpty));
                    }
                    return ListView(
                      children: [
                        for (final item in items)
                          ListTile(
                            key: Key('detail_item_${item.id}'),
                            title: Text(item.name),
                            subtitle: Text(
                                '${item.plannedQuantity} ${item.plannedUnitCode}'),
                            trailing: item.plannedLineTotalMinorUnits == null
                                ? null
                                : Text(formatMoney(
                                    Money.fromMinorUnits(
                                        item.plannedLineTotalMinorUnits!,
                                        currency),
                                    locale: Localizations.localeOf(context)
                                        .languageCode)),
                          ),
                      ],
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          key: const Key('detail_start_shopping'),
                          onPressed: list.status == 'shopping'
                              ? () => _openShopping(context)
                              : () => _startShopping(context),
                          icon: const Icon(Icons.shopping_cart),
                          label: Text(list.status == 'shopping'
                              ? l10n.continueShoppingLabel
                              : l10n.startShoppingLabel),
                        ),
                      ),
                      if (list.status == 'shopping') ...[
                        const SizedBox(width: 8),
                        FilledButton.tonal(
                          key: const Key('detail_finish_button'),
                          onPressed: () => _finishAndShowResult(context),
                          child: Text(l10n.finishAndSeeResult),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('detail_add_item_button'),
        heroTag: 'detailAddItem',
        onPressed: () => _openItemForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _startShopping(BuildContext context) async {
    await _shoppingRepo.startShopping(widget.listId);
    _refresh();
    if (!context.mounted) return;
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => ShoppingModeScreen(
        repository: ShoppingRepository(widget.db),
        listId: widget.listId,
      ),
    ));
    _refresh();
  }

  Future<void> _openShopping(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => ShoppingModeScreen(
        repository: ShoppingRepository(widget.db),
        listId: widget.listId,
      ),
    ));
    _refresh();
  }

  Future<void> _openItemForm(BuildContext context) async {
    await StarterCategories().seedIfEmpty(widget.db);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ItemFormSheet(
        db: widget.db,
        starterCategories: StarterCategories(),
        listId: widget.listId,
      ),
    );
    _refresh();
  }

  /// Alışverişi tamamlar ve sonuç ekranını açar (spec §6.11).
  Future<void> _finishAndShowResult(BuildContext context) async {
    await widget.listRepository.changeStatus(
        widget.listId, ListStatus.completed);
    if (!context.mounted) return;
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => SummaryScreen(
        repository: ResultRepository(widget.db),
        listId: widget.listId,
      ),
    ));
    _refresh();
  }
}
