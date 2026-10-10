import '../../core/money/format_locale.dart';
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
import '../history/insights/spending_screen.dart';
import '../subscription/subscription_service.dart';
import '../assistant/assistant_bubble.dart';
import '../voice_input/list_draft_sheet.dart';
import '../voice_input/ai_list_parser.dart';
import '../voice_input/stt_speech_service.dart';
import '../lists/item_repository.dart';

import '../../app/app_defaults.dart';
import '../settings/settings_repository.dart';
import '../settings/settings_screen.dart';
import '../lists/templates/template_repository.dart';
import '../lists/list_detail_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../receipts/ocr_text_source.dart';
import '../receipts/parser/receipt_parser.dart';
import '../receipts/shelf_label/mlkit_text_source.dart';
import '../receipts/review/receipt_review_controller.dart';
import '../receipts/review/receipt_review_screen.dart';
import 'package:napp_ads/napp_ads.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import 'home_repository.dart';
import '../../app/language_controller.dart';
import '../../app/theme_mode_controller.dart';
import '../lists/reminders/reminder_scheduler.dart';

/// Alt navigasyonlu uygulama kabuğu (spec §9): Ana Sayfa, Listeler,
/// Geçmiş, Ayarlar.
class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.db,
    required this.listRepository,
    this.settingsRepository,
    this.languageController,
    this.themeModeController,
    this.appIdentity,
    this.proController,
    this.purchaseRepository,
    this.subscriptions,
    this.bannerController,
    this.giftFlow,
    this.reminderScheduler,
    this.pickImage,
    this.ocrSource,
  });

  final AppDatabase db;
  final ListRepository listRepository;

  /// Ayarlar sekmesi: verilmezse yer tutucu gösterilir.
  final SettingsRepository? settingsRepository;

  /// Dil denetleyicisi; Ayarlar ekranına devredilir.
  final LanguageController? languageController;

  /// Tema denetleyicisi; Ayarlar ekranına devredilir.
  final AppThemeModeController? themeModeController;

  /// napp kimliği; Ayarlar/paywall'a devredilir.
  final AppIdentity? appIdentity;

  /// Pro durumu; null = Pro (test dikişi).
  final ProController? proController;
  final PurchaseRepository? purchaseRepository;
  final SubscriptionService? subscriptions;

  /// Bottom bar'IN altındaki banner (standart §5.2); null = banner yok.
  final BannerAdController? bannerController;

  /// Ödüllü reklam hediye düğmesi (Ayarlar üst çubuğu).
  final Widget? giftFlow;

  /// Test dikişi: hatırlatma zamanlayıcısı (ListDetailScreen'e geçer).
  final ReminderScheduler? reminderScheduler;
  final Future<String?> Function()? pickImage;
  final OcrTextSource? ocrSource;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;
  bool _inputBusy = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tabs = [
      HomeScreen(
        db: widget.db,
        listRepository: widget.listRepository,
        onOpenList: (list) => _openShopping(context, list.id),
        onNewList: () => showListEditor(context, widget.listRepository,
            reminderScheduler: widget.reminderScheduler),
      ),
      ListsScreen(
        repository: widget.listRepository,
        reminderScheduler: widget.reminderScheduler,
      ),
      HistoryPlaceholder(db: widget.db),
      // Keşfet (standart §3.6): diğer Crazy Penguin uygulamaları;
      // kimlik yoksa yer tutucu (testler).
      widget.appIdentity?.otherAppsUrl == null
          ? const _DiscoverPlaceholder()
          : OtherAppsPage(
              identity: widget.appIdentity!,
              repository: OtherAppsRepository(
                appsUrl: widget.appIdentity!.otherAppsUrl!,
              ),
            ),
      widget.settingsRepository == null || widget.languageController == null
          ? const SettingsPlaceholder()
          : SettingsScreen(
              repository: widget.settingsRepository!,
              languageController: widget.languageController!,
              themeModeController: widget.themeModeController,
              appIdentity: widget.appIdentity,
              proController: widget.proController,
              purchaseRepository: widget.purchaseRepository,
              subscriptions: widget.subscriptions,
              giftFlow: widget.giftFlow,
            ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _tab, children: tabs),
          // Asistan (PB-057): sağ altta, sekme FAB'larının üstünde.
          ValueListenableBuilder<bool>(
            valueListenable: AssistantPrefs.visible,
            builder: (context, visible, _) => !visible || _tab > 2
                ? const SizedBox.shrink()
                : Positioned(
                    right: 20,
                    bottom: 88,
                    child: AssistantBubble(
                      busy: _inputBusy,
                      onChoice: (c) => _onAssistant(context, c),
                    ),
                  ),
          ),
        ],
      ),
      // Banner bottom bar'ın altındadır (kullanıcı talebi 2026-10-02);
      // AdPolicy Pro'da hiç yüklemez, kalkınca boşluk kalmaz.
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationBar(
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
            icon: const Icon(Icons.explore_outlined),
            selectedIcon: const Icon(Icons.explore),
            label: l10n.navDiscover,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
            ],
          ),
          if (widget.bannerController != null)
            BannerAdWidget(controller: widget.bannerController!),
        ],
      ),
    );
  }

  Future<void> _onAssistant(BuildContext context, AssistantChoice choice) async {
    if (_inputBusy) return;
    setState(() => _inputBusy = true);
    final l10n = AppLocalizations.of(context);
    try {
    switch (choice.action) {
      case AssistantAction.newList:
        await showListEditor(context, widget.listRepository,
            reminderScheduler: widget.reminderScheduler);
      case AssistantAction.scanReceipt:
        await _scanReceipt(context);
      case AssistantAction.spending:
        await Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => SpendingScreen(db: widget.db)),
        );
      case AssistantAction.voiceList || AssistantAction.textList:
        int? createdId;
        final picked = await showModalBottomSheet<ListDraft>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => ListDraftSheet(
            speechService: SttSpeechService(),
            initialText: choice.text,
            autoListen: choice.action == AssistantAction.voiceList,
            onApprove: (draft) async {
              createdId = await widget.db.transaction(() async {
                final id = await widget.listRepository.createList(title: draft.title,
                  currencyCode: AppDefaults.defaultCurrency(), generatedTitle: l10n.quickListTitle);
                await ItemRepository(widget.db).addCandidates(id, draft.items);
                return id;
              });
            },
          ),
        );
        if (picked == null || createdId == null || !context.mounted) return;
        final listId = createdId!;
        // Önce liste açılır: fiyatları düzenle, sonra "Alışverişe başla" (plan → alışveriş).
        if (context.mounted) {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ListDetailScreen(
                db: widget.db,
                listRepository: widget.listRepository,
                listId: listId,
                reminderScheduler: widget.reminderScheduler,
              ),
            ),
          );
        }
    }
      } catch (_) {
        if (context.mounted) { ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
          SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true, duration: const Duration(days: 1))); }
      } finally { if (mounted) setState(() => _inputBusy = false); }
  }

  Future<void> _scanReceipt(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      final path = await (widget.pickImage?.call() ?? ImagePicker().pickImage(source: ImageSource.camera).then((x) => x?.path));
      if (path == null || !mounted) return;
      final source = widget.ocrSource ?? MlKitTextSource();
      final OcrScanResult scan;
      try { scan = await source.scan(path); }
      finally { if (widget.ocrSource == null) (source as MlKitTextSource).dispose(); }
      if (!context.mounted) return;
      final currency = AppDefaults.defaultCurrency();
      final parsed = ReceiptParser(currency: currency).parse(scan);
      if (parsed.lines.isEmpty) {
        ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(SnackBar(content: Text(l10n.ocrNoText), showCloseIcon: true, duration: const Duration(days: 1)));
        return;
      }
      final controller = ReceiptReviewController(db: widget.db, currencyCode: currency,
        title: l10n.receiptReviewTitle, parseResult: parsed);
      try {
        await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ReceiptReviewScreen(
          controller: controller, currency: currency, plannedItems: Future.value(const []))));
        if (controller.listId != null && context.mounted) await _openShopping(context, controller.listId!);
      } finally { controller.dispose(); }
    } catch (_) {
      if (context.mounted) { ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
        SnackBar(content: Text(l10n.ocrNoText), showCloseIcon: true, duration: const Duration(days: 1))); }
    }
  }

  Future<void> _openShopping(BuildContext context, int listId) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ListDetailScreen(
          db: widget.db,
          listRepository: widget.listRepository,
          listId: listId,
          reminderScheduler: widget.reminderScheduler,
        ),
      ),
    );
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
                final colors = Theme.of(context).colorScheme;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors.secondaryContainer,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Icon(
                            Icons.shopping_basket_outlined,
                            size: 28,
                            color: colors.onSecondaryContainer,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.homeEmptyTitle,
                          style:
                              Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.homeEmptyBody,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.slogan,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: colors.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: onNewList,
                          icon: const Icon(Icons.add),
                          label: Text(l10n.newListButton),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeActiveSection,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  for (final list in active)
                    Card(
                      child: ListTile(
                        key: Key('home_list_tile_${list.id}'),
                        title: Text(
                          list.title ?? list.generatedTitle ?? l10n.listsTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          statusLabel(
                            l10n,
                            ListStatus.tryFromDb(list.status) ??
                                ListStatus.draft,
                          ),
                        ),
                        trailing: list.status == 'shopping'
                            ? TextButton.icon(
                                key: Key('home_continue_${list.id}'),
                                onPressed: () => onOpenList(list),
                                icon: const Icon(Icons.play_arrow),
                                label: Text(l10n.continueShoppingLabel),
                              )
                            : null,
                        onTap: () => onOpenList(list),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder<List<MonthlyBucket>>(
            stream: repo.watchMonthlyTotals(),
            builder: (context, snapshot) {
              final totalsList = snapshot.data ?? const <MonthlyBucket>[];
              if (totalsList.isEmpty) return const SizedBox.shrink();
              return Column(
                children: [
                  for (final totals in totalsList) StatefulBuilder(builder: (context, refresh) =>
                    _MonthlyCard(totals: totals, onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (_) => SpendingScreen(db: db, currencyCode: totals.currencyCode)));
                      if (context.mounted) refresh(() {});
                    })),
                ],
              );
            },
          ),
          _TemplatesSection(db: db, listRepository: listRepository),
          const SizedBox(height: 12),
          StreamBuilder<List<ShoppingList>>(
            stream: repo.watchRecentCompleted(),
            builder: (context, snapshot) {
              final completed = snapshot.data ?? const <ShoppingList>[];
              if (completed.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeCompletedSection,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  for (final list in completed)
                    ListTile(
                      key: Key('home_completed_${list.id}'),
                      onTap: () => onOpenList(list),
                      leading: const Icon(Icons.check_circle_outline),
                      title: Text(
                        list.title ?? list.generatedTitle ?? l10n.listsTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        key: Key('home_plan_from_${list.id}'),
                        icon: const Icon(Icons.content_copy),
                        tooltip: l10n.templateHint,
                        onPressed: () =>
                            planFromTemplate(context, db, listRepository, list),
                      ),
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

/// Şablon olarak işaretli listeler; dokununca önceki gerçek alımlardan yeni
/// taslak plan üretilir ve açılır (spec §6.1). Şablon yoksa görünmez.
class _TemplatesSection extends StatelessWidget {
  const _TemplatesSection({required this.db, required this.listRepository});

  final AppDatabase db;
  final ListRepository listRepository;

  Future<List<ShoppingList>> _load() async {
    final ids = await TemplateRepository(db).templateIds();
    return (db.select(db.shoppingLists)..where((t) => t.id.isIn(ids))).get();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FutureBuilder<List<ShoppingList>>(
      future: _load(),
      builder: (context, snapshot) {
        final lists = snapshot.data ?? const <ShoppingList>[];
        if (lists.isEmpty) return const SizedBox.shrink();
        return Card(
          key: const Key('home_templates_card'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(l10n.templatesSection),
                subtitle: Text(l10n.templateHint),
              ),
              for (final list in lists)
                ListTile(
                  key: Key('home_template_${list.id}'),
                  leading: const Icon(Icons.content_copy),
                  title: Text(
                    list.title ?? list.generatedTitle ?? l10n.listsTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () =>
                      planFromTemplate(context, db, listRepository, list),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Kaynak listeyi şablon olarak işaretler, gerçek alımlarından yeni plan
/// üretir ve açar.
Future<void> planFromTemplate(
  BuildContext context,
  AppDatabase db,
  ListRepository listRepository,
  ShoppingList source,
) async {
  final templates = TemplateRepository(db);
  await templates.markTemplate(source.id);
  final newId = await templates.createPlanFromActuals(
    source.id,
    title: source.title,
  );
  if (!context.mounted) return;
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => ListDetailScreen(
        db: db,
        listRepository: listRepository,
        listId: newId,
      ),
    ),
  );
}

/// Tek para birimi için aylık plan-gerçek kartı; farklı para birimleri
/// asla tek toplamda birleştirilmez (spec §7.1).
class _MonthlyCard extends StatelessWidget {
  const _MonthlyCard({required this.totals, required this.onTap});

  final MonthlyBucket totals;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(totals.currencyCode);
    String money(int minor) => formatMoney(
      Money.fromMinorUnits(minor, currency),
      locale: formatLocaleCode(context),
    );
    final variance = totals.varianceMinor;
    final direction = (variance ?? 0) < 0
        ? SpendingDirection.underPlan
        : (variance ?? 0) > 0
        ? SpendingDirection.overPlan
        : SpendingDirection.nearPlan;
    final delta = SemanticDelta.resolve(
      direction: direction,
      brightness: Theme.of(context).brightness,
    );
    return Card(
      key: Key('home_monthly_card_${totals.currencyCode}'),
      child: InkWell(onTap: onTap, child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.homeMonthlySection,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.monthPlannedLabel}: ${money(totals.plannedMinor)}',
                  ),
                ),
                Expanded(
                  child: Text(
                    '${l10n.monthActualLabel}: ${money(totals.actualMinor)}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (variance != null) Icon(
                  delta.icon,
                  size: 16,
                  color: delta.color,
                  semanticLabel: delta.marker,
                ),
                const SizedBox(width: 4),
                Text(
                  '${l10n.monthVarianceLabel}: ${variance == null ? '—' : money(variance.abs())}',
                  style: TextStyle(color: variance == null ? Theme.of(context).colorScheme.onSurface : delta.color),
                ),
              ],
            ),
            if (AppDefaults.monthlyLimitMinor(currencyCode: totals.currencyCode) != null) ...[
              const SizedBox(height: 10),
              LinearProgressIndicator(
                key: const Key('home_limit_progress'),
                value: (totals.actualMinor / AppDefaults.monthlyLimitMinor(currencyCode: totals.currencyCode)!)
                    .clamp(0, 1)
                    .toDouble(),
                color: totals.actualMinor > AppDefaults.monthlyLimitMinor(currencyCode: totals.currencyCode)!
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
              const SizedBox(height: 4),
              Text(
                totals.actualMinor > AppDefaults.monthlyLimitMinor(currencyCode: totals.currencyCode)!
                    ? l10n.monthlyLimitOver(money(totals.actualMinor - AppDefaults.monthlyLimitMinor(currencyCode: totals.currencyCode)!))
                    : l10n.monthlyLimitLeft(money(AppDefaults.monthlyLimitMinor(currencyCode: totals.currencyCode)! - totals.actualMinor)),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      )),
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
      appBar: AppBar(
        title: Text(l10n.navHistory),
        actions: [
          IconButton(
            key: const Key('history_spending'),
            icon: const Icon(Icons.insights_outlined),
            tooltip: l10n.spendingAction,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => SpendingScreen(db: db)),
            ),
          ),
        ],
      ),
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
              Card(
                key: const Key('history_spending_card'),
                child: ListTile(
                  leading: const Icon(Icons.insights_outlined),
                  title: Text(l10n.spendingTitle),
                  subtitle: Text('${l10n.spendingWeekly} · ${l10n.monthlyLimitTitle}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => SpendingScreen(db: db)),
                  ),
                ),
              ),
              for (final list in completed)
                ListTile(
                  key: Key('history_list_${list.id}'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) =>
                    ListDetailScreen(db: db, listRepository: ListRepository(db), listId: list.id))),
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    list.title ?? list.generatedTitle ?? l10n.listsTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    list.completedAt == null
                        ? ''
                        : MaterialLocalizations.of(context)
                              .formatMediumDate(list.completedAt!),
                  ),
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
          Text(
            l10n.aboutTabTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(l10n.aboutBody),
        ],
      ),
    );
  }
}

/// Keşfet yer tutucusu (yalnız test ortamı: kimlik verilmediğinde).
class _DiscoverPlaceholder extends StatelessWidget {
  const _DiscoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.explore_outlined));
  }
}
