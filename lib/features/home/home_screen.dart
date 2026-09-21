import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money.dart';
import '../../core/theme/semantic_colors.dart';
import '../../data/db/app_database.dart';
import '../lists/list_status.dart';
import '../lists/list_repository.dart';
import '../lists/lists_screen.dart';
import '../history/insights/insights_repository.dart';
import '../shopping_mode/shopping_mode_screen.dart';
import '../shopping_mode/shopping_repository.dart';
import 'home_repository.dart';

/// Alt navigasyonlu uygulama kabuğu (spec §9): Ana Sayfa, Listeler,
/// Geçmiş, Ayarlar.
class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.db,
    required this.listRepository,
  });

  final AppDatabase db;
  final ListRepository listRepository;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tabs = [
      HomeScreen(
        db: widget.db,
        listRepository: widget.listRepository,
        onOpenList: (list) => _openShopping(context, list.id),
        onNewList: () => setState(() => _tab = 1),
      ),
      ListsScreen(repository: widget.listRepository),
      HistoryPlaceholder(db: widget.db),
      const SettingsPlaceholder(),
    ];
    return Scaffold(
      body: IndexedStack(index: _tab, children: tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.list_outlined),
            selectedIcon: const Icon(Icons.list),
            label: l10n.navLists,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: l10n.navHistory,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }

  Future<void> _openShopping(BuildContext context, int listId) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => ShoppingModeScreen(
        repository: ShoppingRepository(widget.db),
        listId: listId,
      ),
    ));
  }
}

/// Ana ekran (spec §6.4). Yeterli veri yoksa kart gösterilmez; anlamlı
/// boş durumlar gerçek davranıştır, demo veri yoktur.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.db,
    required this.listRepository,
    required this.onOpenList,
    required this.onNewList,
  });

  final AppDatabase db;
  final ListRepository listRepository;
  final void Function(ShoppingList list) onOpenList;

  /// "Yeni liste" ana eylemi: Listeler sekmesine geçirir (oradaki FAB ile
  /// oluşturulur; işlevsiz buton yoktur).
  final VoidCallback onNewList;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repo = HomeRepository(db);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHome)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          StreamBuilder<List<ShoppingList>>(
            stream: repo.watchActiveLists(),
            builder: (context, snapshot) {
              final active = snapshot.data ?? const <ShoppingList>[];
              if (active.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.homeEmptyTitle,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(l10n.homeEmptyBody),
                        const SizedBox(height: 8),
                        Text(l10n.slogan,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant)),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.homeActiveSection,
                      style: Theme.of(context).textTheme.titleMedium),
                  for (final list in active)
                    Card(
                      child: ListTile(
                        key: Key('home_list_tile_${list.id}'),
                        title: Text(list.title ??
                            list.generatedTitle ??
                            l10n.listsTitle,
                            overflow: TextOverflow.ellipsis),
                        subtitle: Text(
                            statusLabel(l10n,
                                ListStatus.tryFromDb(list.status) ??
                                    ListStatus.draft)),
                        trailing: list.status == 'shopping'
                            ? TextButton.icon(
                                key: Key('home_continue_${list.id}'),
                                onPressed: () => onOpenList(list),
                                icon: const Icon(Icons.play_arrow),
                                label: Text(l10n.continueShoppingLabel),
                              )
                            : null,
                        onTap: list.status == 'shopping'
                            ? () => onOpenList(list)
                            : null,
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder<List<MonthlyTotals>>(
            stream: repo.watchMonthlyTotals(),
            builder: (context, snapshot) {
              final totalsList = snapshot.data ?? const <MonthlyTotals>[];
              if (totalsList.isEmpty) return const SizedBox.shrink();
              return Column(
                children: [
                  for (final totals in totalsList)
                    _MonthlyCard(totals: totals),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder<List<ShoppingList>>(
            stream: repo.watchRecentCompleted(),
            builder: (context, snapshot) {
              final completed = snapshot.data ?? const <ShoppingList>[];
              if (completed.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.homeCompletedSection,
                      style: Theme.of(context).textTheme.titleMedium),
                  for (final list in completed)
                    ListTile(
                      leading: const Icon(Icons.check_circle_outline),
                      title: Text(list.title ??
                          list.generatedTitle ??
                          l10n.listsTitle,
                          overflow: TextOverflow.ellipsis),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('home_new_list_button'),
        heroTag: 'homeFab',
        onPressed: onNewList,
        icon: const Icon(Icons.add),
        label: Text(l10n.newListButton),
      ),
    );
  }
}

/// Tek para birimi için aylık plan-gerçek kartı; farklı para birimleri
/// asla tek toplamda birleştirilmez (spec §7.1).
class _MonthlyCard extends StatelessWidget {
  const _MonthlyCard({required this.totals});

  final MonthlyTotals totals;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(totals.currencyCode);
    String money(int minor) => formatMoney(
        Money.fromMinorUnits(minor, currency),
        locale: Localizations.localeOf(context).languageCode);
    final direction = totals.varianceMinor < 0
        ? SpendingDirection.underPlan
        : totals.varianceMinor > 0
            ? SpendingDirection.overPlan
            : SpendingDirection.nearPlan;
    final delta = SemanticDelta.resolve(
        direction: direction, brightness: Theme.of(context).brightness);
    return Card(
      key: Key('home_monthly_card_${totals.currencyCode}'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.homeMonthlySection,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: Text(
                        '${l10n.monthPlannedLabel}: ${money(totals.plannedMinor)}')),
                Expanded(
                    child: Text(
                        '${l10n.monthActualLabel}: ${money(totals.actualMinor)}')),
              ],
            ),
            const SizedBox(height: 4),
            Row(children: [
              Icon(delta.icon,
                  size: 16,
                  color: delta.color,
                  semanticLabel: delta.marker),
              const SizedBox(width: 4),
              Text(
                '${l10n.monthVarianceLabel}: ${money(totals.varianceMinor.abs())}',
                style: TextStyle(color: delta.color),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

/// Geçmiş sekmesi: tamamlanan alışverişler + aylık toplamlar (T18).
class HistoryPlaceholder extends StatelessWidget {
  const HistoryPlaceholder({super.key, required this.db});

  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repo = InsightsRepository(db);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHistory)),
      body: StreamBuilder<List<ShoppingList>>(
        stream: repo.watchCompleted(),
        builder: (context, snapshot) {
          final completed = snapshot.data ?? const <ShoppingList>[];
          if (completed.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.historyEmpty, textAlign: TextAlign.center),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              for (final list in completed)
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                      list.title ?? list.generatedTitle ?? l10n.listsTitle,
                      overflow: TextOverflow.ellipsis),
                  subtitle: Text(list.completedAt == null
                      ? ''
                      : MaterialLocalizations.of(context)
                          .formatMediumDate(list.completedAt!)),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Ayarlar sekmesi: T30 tam ekran gelene kadar hakkında bilgisi (gerçek içerik).
class SettingsPlaceholder extends StatelessWidget {
  const SettingsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.aboutTabTitle,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.aboutBody),
        ],
      ),
    );
  }
}
