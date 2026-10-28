import 'dart:async';

import '../../core/money/format_locale.dart';

import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money.dart';
import '../../core/theme/semantic_colors.dart';
import '../../data/db/app_database.dart';
import '../lists/list_repository.dart';
import '../lists/lists_screen.dart';
import '../history/insights/insights_repository.dart';
import '../history/insights/spending_screen.dart';
import '../history/history_screen.dart';
import '../discover/discover_screen.dart';
import '../onboarding/first_run_guide.dart';
import '../subscription/plan_badge.dart';
import '../subscription/subscription_paywall.dart';
import '../subscription/subscription_service.dart';

import '../../app/app_defaults.dart';
import '../settings/settings_repository.dart';
import '../settings/settings_screen.dart';
import '../lists/templates/template_repository.dart';
import '../lists/list_detail_screen.dart';

import '../receipts/receipt_capture_flow.dart';
import '../receipts/receipt_image_store.dart';
import '../receipts/ocr_text_source.dart';

import 'package:napp_ads/napp_ads.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import 'home_repository.dart';
import '../../app/language_controller.dart';
import '../../app/theme_mode_controller.dart';
import '../lists/reminders/reminder_scheduler.dart';
import '../lists/reminders/local_notifications_scheduler.dart';

/// Listeler, Geçmiş ve Ayarlar sekmeleri; Keşfet üst araç çubuğundan açılır.
class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.db,
    required this.listRepository,
    this.settingsRepository,
    this.languageController,
    this.themeModeController,
    this.appIdentity,
    this.appsCacheStore,
    this.proController,
    this.purchaseRepository,
    this.subscriptions,
    this.bannerController,
    this.giftFlow,
    this.reminderScheduler,
    this.pickImage,
    this.receiptImageStore,
    this.ocrSource,
    this.firstRunGuide = false,
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

  /// NAppKit Keşfet listesinin kalıcı ağ önbelleği.
  final SettingsStore? appsCacheStore;

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
  final ReceiptImageStore? receiptImageStore;
  final OcrTextSource? ocrSource;

  /// Uygulama açılışında ilk kullanım rehberini bir kez gösterir (app.dart).
  final bool firstRunGuide;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;
  final _nativeReminders = LocalNotificationsScheduler();
  StreamSubscription<int>? _notificationSubscription;
  final _openedReminders = <int>{};
  Future<void> _reminderNavigation = Future<void>.value();
  bool _trialNoticeShowing = false;

  @override
  void initState() {
    super.initState();
    widget.subscriptions?.addListener(_trialChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted && widget.firstRunGuide && !AppDefaults.guideSeen()) {
        await showFirstRunGuide(context);
      }
      if (mounted) await _maybeTrialNotice();
      if (!mounted || widget.reminderScheduler != null) return;
      _notificationSubscription = LocalNotificationsScheduler.selectedReminders
          .listen((id) => unawaited(_openReminder(id)));
      try {
        final id = await _nativeReminders.initialReminderId();
        if (id != null && mounted) await _openReminder(id);
      } catch (_) {
        // Unsupported native notification services leave manual lists usable.
      }
    });
  }

  @override
  void dispose() {
    widget.subscriptions?.removeListener(_trialChanged);
    unawaited(_notificationSubscription?.cancel());
    super.dispose();
  }

  void _trialChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_maybeTrialNotice());
    });
  }

  Future<void> _maybeTrialNotice() async {
    final service = widget.subscriptions;
    if (!mounted ||
        _trialNoticeShowing ||
        service == null ||
        !service.needsTrialExpiryNotice ||
        ModalRoute.of(context)?.isCurrent != true) {
      return;
    }
    _trialNoticeShowing = true;
    final l10n = AppLocalizations.of(context);
    final annual = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.planTrialEndedTitle),
        content: SingleChildScrollView(child: Text(l10n.planTrialEndedBody)),
        actions: [
          TextButton(
            key: const Key('trial_continue_free'),
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.planContinueFree),
          ),
          FilledButton(
            key: const Key('trial_annual_pro'),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.plansAction),
          ),
        ],
      ),
    );
    service.acknowledgeTrialExpiry();
    _trialNoticeShowing = false;
    if (mounted && annual == true) await _openPlanPage(context);
  }

  Future<void> _openReminder(int id) {
    if (!mounted || !_openedReminders.add(id)) return Future<void>.value();
    // Resolve taps in arrival order, but do not wait for a route to close:
    // a distinct notification must be reachable while another list is open.
    return _reminderNavigation = _reminderNavigation.then(
      (_) => _navigateReminder(id),
    );
  }

  Future<void> _navigateReminder(int id) async {
    Future<void>? routeClosed;
    try {
      if (!mounted) return;
      final reminder = await (widget.db.select(
        widget.db.reminders,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      if (!mounted) return;
      if (reminder == null || reminder.status != 'active') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).reminderCancelled),
            showCloseIcon: true,
          ),
        );
        return;
      }
      await widget.listRepository.getById(reminder.listId);
      if (!mounted) return;
      routeClosed = Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => ListDetailScreen(
            db: widget.db,
            listRepository: widget.listRepository,
            listId: reminder.listId,
            reminderScheduler: _nativeReminders,
          ),
        ),
      );
      unawaited(
        routeClosed.whenComplete(() {
          _openedReminders.remove(id);
        }),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).saveFailed),
            showCloseIcon: true,
          ),
        );
      }
    } finally {
      if (routeClosed == null) _openedReminders.remove(id);
    }
  }

  bool _inputBusy = false;
  // Settings is rebuilt on each visit: ad availability (daily gift) and the
  // plan badge change outside its own state.
  int _settingsVisit = 0;

  /// Plan simgesi, abonelik değişince kendini günceller (satın alma, iptal).
  Widget _planBadgeLive(BuildContext context) {
    final subs = widget.subscriptions;
    if (subs == null) return _planBadge(context);
    return ListenableBuilder(
      listenable: subs,
      builder: (context, _) => _planBadge(context),
    );
  }

  /// Plan simgesi: ana sayfanın üstünde. Dokununca plan/abonelik sayfası açılır.
  Widget _planBadge(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subs = widget.subscriptions;
    final tier = subs?.tier ?? Tier.free;
    final proUnlocked =
        (widget.proController?.isPro ?? false) || tier != Tier.free;
    return PlanBadge(
      badgeKey: const Key('home_plan_badge'),
      label: planLabel(l10n, tier: tier, proUnlocked: proUnlocked),
      trial: tier == Tier.pro && subs != null && subs.inTrial(),
      remaining: trialRemainingLabel(l10n, subs),
      active: proUnlocked,
      onPressed: () => _openPlanPage(context),
    );
  }

  Future<void> _openPlanPage(BuildContext context) async {
    final subs = widget.subscriptions;
    if (subs != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (ctx) => SubscriptionPaywall(service: subs),
        ),
      );
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tabs = [
      ListsScreen(
        repository: widget.listRepository,
        reminderScheduler: widget.reminderScheduler,
        bannerController: widget.bannerController,
        planBadge: _planBadgeLive(context),
        onScanReceipt: () => _createFromReceipt(context),
        receiptBusy: _inputBusy,
        onDiscover: () => _openDiscover(context),
      ),
      HistoryPlaceholder(
        db: widget.db,
        bannerController: widget.bannerController,
      ),
      widget.settingsRepository == null || widget.languageController == null
          ? const SettingsPlaceholder()
          : SettingsScreen(
              key: ValueKey('settings_$_settingsVisit'),
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
      body: IndexedStack(index: _tab, children: tabs),
      // Banner bottom bar'ın altındadır (kullanıcı talebi 2026-10-02);
      // AdPolicy Pro'da hiç yüklemez, kalkınca boşluk kalmaz.
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationBar(
            selectedIndex: _tab,
            onDestinationSelected: (i) => setState(() {
              if (i == 2 && _tab != 2) _settingsVisit++;
              _tab = i;
            }),
            destinations: [
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
        ],
      ),
    );
  }

  Future<void> _openDiscover(BuildContext context) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => widget.appIdentity?.otherAppsUrl == null
              ? const _DiscoverPlaceholder()
              : DiscoverScreen(
                  identity: widget.appIdentity!,
                  repository: OtherAppsRepository(
                    appsUrl: widget.appIdentity!.otherAppsUrl!,
                    cacheStore: widget.appsCacheStore,
                  ),
                ),
        ),
      );

  Future<void> _createFromReceipt(BuildContext context) async {
    if (_inputBusy) return;
    setState(() => _inputBusy = true);
    try {
      await _scanReceipt(context);
    } finally {
      if (mounted) setState(() => _inputBusy = false);
    }
  }

  Future<void> _scanReceipt(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      final committedList = await openReceiptCaptureFlow(
        context,
        db: widget.db,
        currencyCode: AppDefaults.defaultCurrency(),
        pickImage: widget.pickImage,
        ocrSource: widget.ocrSource,
        imageStore: widget.receiptImageStore,
      );
      if (committedList != null && context.mounted) {
        await _openShopping(context, committedList);
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true),
          );
      }
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
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.homeEmptyBody,
                          style: Theme.of(context).textTheme.bodyMedium
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
                  for (final totals in totalsList)
                    StatefulBuilder(
                      builder: (context, refresh) => _MonthlyCard(
                        totals: totals,
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => SpendingScreen(
                                db: db,
                                currencyCode: totals.currencyCode,
                              ),
                            ),
                          );
                          if (context.mounted) refresh(() {});
                        },
                      ),
                    ),
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
      child: InkWell(
        onTap: onTap,
        child: Padding(
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
                  if (variance != null)
                    Icon(
                      delta.icon,
                      size: 16,
                      color: delta.color,
                      semanticLabel: delta.marker,
                    ),
                  const SizedBox(width: 4),
                  Text(
                    '${l10n.monthVarianceLabel}: ${variance == null ? '—' : money(variance.abs())}',
                    style: TextStyle(
                      color: variance == null
                          ? Theme.of(context).colorScheme.onSurface
                          : delta.color,
                    ),
                  ),
                ],
              ),
              if (AppDefaults.monthlyLimitMinor(
                    currencyCode: totals.currencyCode,
                  ) !=
                  null) ...[
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  key: const Key('home_limit_progress'),
                  value:
                      (totals.actualMinor /
                              AppDefaults.monthlyLimitMinor(
                                currencyCode: totals.currencyCode,
                              )!)
                          .clamp(0, 1)
                          .toDouble(),
                  color:
                      totals.actualMinor >
                          AppDefaults.monthlyLimitMinor(
                            currencyCode: totals.currencyCode,
                          )!
                      ? Theme.of(context).colorScheme.error
                      : null,
                ),
                const SizedBox(height: 4),
                Text(
                  totals.actualMinor >
                          AppDefaults.monthlyLimitMinor(
                            currencyCode: totals.currencyCode,
                          )!
                      ? l10n.monthlyLimitOver(
                          money(
                            totals.actualMinor -
                                AppDefaults.monthlyLimitMinor(
                                  currencyCode: totals.currencyCode,
                                )!,
                          ),
                        )
                      : l10n.monthlyLimitLeft(
                          money(
                            AppDefaults.monthlyLimitMinor(
                                  currencyCode: totals.currencyCode,
                                )! -
                                totals.actualMinor,
                          ),
                        ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Geçmiş sekmesi: dönem sekmeleri, takvim, alınan ürünler (SA-010).
class HistoryPlaceholder extends StatelessWidget {
  const HistoryPlaceholder({
    super.key,
    required this.db,
    this.bannerController,
  });

  final AppDatabase db;
  final BannerAdController? bannerController;

  @override
  Widget build(BuildContext context) =>
      HistoryScreen(db: db, bannerController: bannerController);
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
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).navDiscover)),
      body: const Center(child: Icon(Icons.explore_outlined)),
    );
  }
}
