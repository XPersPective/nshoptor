import '../../core/l10n/language_names.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

import '../ai/ai_client.dart';
import '../engagement/review_moments.dart';
import '../onboarding/first_run_guide.dart';
import '../assistant/assistant_bubble.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/brand_wordmark.dart';
import '../subscription/plan_badge.dart';
import 'demo_data.dart';
import '../../app/app_defaults.dart';
import '../subscription/subscription_paywall.dart';
import '../subscription/subscription_service.dart';

import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import '../../../../core/app_version.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/format_locale.dart';
import '../../../../core/money/money.dart';
import '../../../../core/money/money_format.dart';
import '../history/insights/limit_editor.dart';
import '../../../../core/quantity/unit_code.dart';
import '../../../../core/quantity/unit_display.dart';
import '../../app/language_controller.dart';
import '../../app/theme_mode_controller.dart';
import 'settings_repository.dart';
import 'backup/backup_repository.dart';
import '../../data/db/app_database.dart' show Reminder;

/// Ayarlar ekranı (spec §6.15): dil, tema, varsayılanlar, yedekleme,
/// silme, gizlilik ve hakkında bölümleri. "Double onay" silme akışı
/// (spec §12: ikinci onay + kapsam açıklaması).
///
/// Yedekleme dışa/içe aktarma Pro'ya özeldir (standart §3.8):
/// [proController] verilmezse Pro sayılır (test dikişi).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.repository,
    required this.languageController,
    this.themeModeController,
    this.proController,
    this.purchaseRepository,
    this.subscriptions,
    this.appIdentity,
    this.giftFlow,
    this.shareApp,
    this.openRatePage,
  });

  final SettingsRepository repository;
  final LanguageController languageController;

  /// Tema tercihi değişince MaterialApp'e canlı uygulanır.
  final AppThemeModeController? themeModeController;

  /// Pro durumu; null = Pro (testler). Pro değilken yedek satırları
  /// kilitlidir ve paywall açılır.
  final ProController? proController;

  /// Paywall için satın alma deposu; null ise yalnız durum gösterilir.
  final PurchaseRepository? purchaseRepository;

  /// Pro/Max abonelikleri (PB-055); null ise yalnız durum gösterilir.
  final SubscriptionService? subscriptions;

  /// Paywall başlığı/marka için kimlik (napp_core).
  final AppIdentity? appIdentity;

  /// Verilirse üst çubukta ödüllü reklam hediye düğmesi (standart §5.2).
  final Widget? giftFlow;
  final Future<void> Function(ShareParams)? shareApp;
  final Future<void> Function()? openRatePage;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Stand-in listenable when no subscription service is wired (tests, placeholders).
  static final Listenable _neverChanges = ChangeNotifier();
  SettingsRepository get _repo => widget.repository;
  bool _backupBusy = false;
  bool _engagementBusy = false;
  late Future<List<Reminder>> _restoredReminders;

  Future<void> _engage({required bool share}) async {
    if (_engagementBusy) return;
    setState(() => _engagementBusy = true);
    try {
      final identity = widget.appIdentity!;
      final isIos = defaultTargetPlatform == TargetPlatform.iOS;
      if (share) {
        final hasStore = !isIos || (identity.appStoreId?.isNotEmpty ?? false);
        final url = hasStore
            ? StoreLinks.forIdentity(identity, isIos: isIos)
            : 'https://xperspective.github.io/nshoptor/';
        final box = context.findRenderObject() as RenderBox?;
        final params = ShareParams(
          text:
              '${identity.appName} — ${AppLocalizations.of(context).slogan}\n$url',
          sharePositionOrigin: box == null
              ? null
              : box.localToGlobal(Offset.zero) & box.size,
        );
        await (widget.shareApp ??
            (params) async {
              await SharePlus.instance.share(params);
            })(params);
      } else {
        await (widget.openRatePage ??
            () => ReviewService().openRatePage(identity, isIos: isIos))();
        ReviewMoments.instance?.manualRequest();
      }
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
      if (mounted) setState(() => _engagementBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _restoredReminders = _repo.pendingRestoredReminders();
    // Pro durumu değişince (satın alma/ödüllü 24s) kilitler anında kalkar.
    widget.proController?.addListener(_onProChanged);
    widget.subscriptions?.addListener(_onProChanged);
  }

  @override
  void dispose() {
    widget.proController?.removeListener(_onProChanged);
    widget.subscriptions?.removeListener(_onProChanged);
    super.dispose();
  }

  void _onProChanged() {
    if (mounted) setState(() {});
  }

  String _paletteName(AppLocalizations l10n, AppPalette p) => switch (p) {
    AppPalette.forest => l10n.paletteForest,
    AppPalette.ocean => l10n.paletteOcean,
    AppPalette.sunset => l10n.paletteSunset,
    AppPalette.lavender => l10n.paletteLavender,
  };

  Future<void> _demo({required bool load}) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final demo = DemoData(widget.repository.db);
    try {
      if (load) {
        await demo.insert(l10n, currencyCode: AppDefaults.defaultCurrency());
      } else {
        await demo.remove();
      }
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(load ? l10n.demoDataAdded : l10n.demoDataRemoved),
            showCloseIcon: true,
          ),
        );
    } catch (_) {
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true),
        );
    }
  }

  void _setThemeMode(String? v) {
    if (v == null) return;
    setState(() {
      _repo.setThemeMode(v);
      widget.themeModeController?.set(v);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSettings),
        actions: [
          // Current plan at a glance; tap opens the plans. Large text keeps
          // only the icon (label in the tooltip) so the app bar never overflows.
          ListenableBuilder(
            listenable: widget.subscriptions ?? _neverChanges,
            builder: (context, _) => PlanBadge(
              badgeKey: const Key('settings_plan_badge'),
              label: _planLabel(l10n),
              trial:
                  _tier == Tier.pro && widget.subscriptions?.inTrial() == true,
              remaining: trialRemainingLabel(l10n, widget.subscriptions),
              active: _proUnlocked,
              onPressed: () => widget.subscriptions != null
                  ? _openPlans(context)
                  : _openPaywall(context),
            ),
          ),
          if (widget.giftFlow != null) widget.giftFlow!,
        ],
      ),
      body: AnimatedBuilder(
        animation: widget.languageController,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.workspace_premium_outlined, size: 18),
                  SizedBox(width: 8),
                  BrandWordmark(size: 15, suffix: 'Pro'),
                ],
              ),
            ),
            ListTile(
              key: const Key('settings_pro_row'),
              leading: const Icon(Icons.workspace_premium_outlined),
              title: widget.subscriptions == null
                  ? Text(_proUnlocked ? l10n.proActiveLabel : l10n.proBuyLabel)
                  : switch (_tier) {
                      Tier.max => const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: BrandWordmark(size: 16, suffix: 'Max'),
                      ),
                      Tier.pro => const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: BrandWordmark(size: 16, suffix: 'Pro'),
                      ),
                      Tier.free => Text(l10n.plansAction),
                    },
              subtitle: trialRemainingLabel(l10n, widget.subscriptions) != null
                  ? Text(trialRemainingLabel(l10n, widget.subscriptions)!)
                  : _tier == Tier.free
                  ? Text(l10n.proBenefitsLine)
                  : null,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => widget.subscriptions == null
                  ? (_proUnlocked ? null : _openPaywall(context))
                  : _openPlans(context),
            ),

            _SectionTitle(icon: Icons.language, label: l10n.languageLabel),
            DropdownButtonFormField<String>(
              isExpanded: true,
              key: const Key('settings_language_dropdown'),
              initialValue: _repo.currentLanguage,
              decoration: InputDecoration(
                labelText: l10n.languageLabel,
                prefixIcon: const Icon(Icons.language),
              ),
              items: [
                DropdownMenuItem(
                  value: 'system',
                  child: Text(l10n.languageSystem),
                ),
                // Diller kendi adlarıyla (kullanıcı kendi dilini tanır).
                for (final e in appLanguages.entries)
                  DropdownMenuItem(value: e.key, child: Text(e.value)),
              ],
              onChanged: (v) => _setLanguage(v),
            ),

            // Biçim yereli DİLDEN BAĞIMSIZ seçilir (C-001, PB-042).
            _SectionTitle(icon: Icons.numbers, label: l10n.formatLocaleLabel),
            DropdownButtonFormField<String>(
              isExpanded: true,
              key: const Key('settings_format_locale_dropdown'),
              itemHeight: null,
              initialValue: _repo.formatLocale,
              decoration: InputDecoration(
                labelText: l10n.formatLocaleLabel,
                prefixIcon: const Icon(Icons.numbers),
              ),
              items: [
                DropdownMenuItem(
                  value: 'system',
                  child: Text(l10n.formatLocaleSystem),
                ),
                DropdownMenuItem(value: 'tr', child: Text(l10n.formatLocaleTr)),
                DropdownMenuItem(value: 'en', child: Text(l10n.formatLocaleEn)),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() => _repo.setFormatLocale(v));
                AppFormatLocale.attach(v == 'tr' || v == 'en' ? v : null);
              },
            ),

            _SectionTitle(
              icon: Icons.dark_mode_outlined,
              label: l10n.themeLabel,
            ),
            DropdownButtonFormField<String>(
              isExpanded: true,
              key: const Key('settings_theme_dropdown'),
              initialValue: _repo.themeMode,
              decoration: InputDecoration(
                labelText: l10n.themeLabel,
                prefixIcon: const Icon(Icons.dark_mode_outlined),
              ),
              items: [
                DropdownMenuItem(
                  value: 'system',
                  child: Text(l10n.themeSystem),
                ),
                DropdownMenuItem(value: 'light', child: Text(l10n.themeLight)),
                DropdownMenuItem(value: 'dark', child: Text(l10n.themeDark)),
              ],
              onChanged: _setThemeMode,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.paletteLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final p in AppPalette.values)
                  ChoiceChip(
                    key: Key('settings_palette_${p.name}'),
                    avatar: CircleAvatar(backgroundColor: p.seed, radius: 8),
                    label: Text(_paletteName(l10n, p)),
                    selected:
                        (widget.themeModeController?.palette ??
                            AppPalette.forest) ==
                        p,
                    onSelected: (_) => setState(
                      () => widget.themeModeController?.setPalette(p),
                    ),
                  ),
              ],
            ),
            SwitchListTile(
              key: const Key('settings_dark_black'),
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.contrast),
              title: Text(l10n.darkBlackLabel),
              value: widget.themeModeController?.black ?? false,
              onChanged: (v) =>
                  setState(() => widget.themeModeController?.setBlack(v)),
            ),

            _SectionTitle(
              icon: Icons.currency_exchange,
              label: l10n.unitsSection,
            ),
            ListTile(
              leading: const Icon(Icons.category_outlined),
              title: Text(l10n.defaultUnitLabel),
              subtitle: Text(unitDisplayNameFromName(_repo.defaultUnit, l10n)),
              trailing: DropdownButton<String>(
                value: _repo.defaultUnit,
                items: UnitCode.standard()
                    .map(
                      (u) => DropdownMenuItem(
                        value: u.name,
                        child: Text(unitDisplayName(u, l10n)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _repo.setDefaultUnit(v!)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: Text(l10n.defaultCurrencyLabel),
              subtitle: Text(_repo.defaultCurrency),
              trailing: DropdownButton<String>(
                value: _repo.defaultCurrency,
                items: Currency.all
                    .map(
                      (c) =>
                          DropdownMenuItem(value: c.code, child: Text(c.code)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _repo.setDefaultCurrency(v!)),
              ),
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.light_mode_outlined),
              title: Text(l10n.keepAwakeLabel),
              value: _repo.keepScreenAwake,
              onChanged: (v) =>
                  setState(() => _repo.setKeepScreenAwake(v ?? false)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                l10n.roundingNote,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),

            _SectionTitle(
              icon: Icons.savings_outlined,
              label: l10n.spendingTitle,
            ),
            SpendingLimitTiles(
              // Rebuilt with the default currency so limits follow it.
              key: ValueKey('limits_${_repo.defaultCurrency}'),
              formatMoney: (minor, code) => formatMoney(
                Money.fromMinorUnits(minor, Currency.fromCode(code)),
                locale: formatLocaleCode(context),
              ),
            ),

            _SectionTitle(
              icon: Icons.backup_outlined,
              label: l10n.backupSection,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.backupSizeWarning),
            ),
            // Yedekleme Pro'ya özeldir (standart §3.8): Pro değilken
            // kilit simgesi + dokunuş paywall açar.
            ListTile(
              key: const Key('export_backup_button'),
              leading: const Icon(Icons.upload_file),
              title: Text(l10n.exportBackupLabel),
              trailing: _proUnlocked ? null : const Icon(Icons.lock_outline),
              onTap: _backupBusy
                  ? null
                  : () => _proUnlocked
                        ? _exportBackup(context)
                        : (widget.subscriptions != null
                              ? _openPlans(context)
                              : _openPaywall(context)),
            ),
            ListTile(
              key: const Key('import_backup_button'),
              leading: const Icon(Icons.download_outlined),
              title: Text(l10n.importBackupLabel),
              trailing: _proUnlocked ? null : const Icon(Icons.lock_outline),
              onTap: _backupBusy
                  ? null
                  : () => _proUnlocked
                        ? _importBackup(context)
                        : (widget.subscriptions != null
                              ? _openPlans(context)
                              : _openPaywall(context)),
            ),
            FutureBuilder<List<Reminder>>(
              future: _restoredReminders,
              builder: (context, snapshot) => Column(
                children: [
                  for (final reminder in snapshot.data ?? const <Reminder>[])
                    ListTile(
                      key: Key('restore_reminder_${reminder.id}'),
                      leading: const Icon(Icons.notifications_paused_outlined),
                      title: Text(l10n.setReminderAction),
                      subtitle: FutureBuilder(
                        future:
                            (_repo.db.select(_repo.db.shoppingLists)
                                  ..where((t) => t.id.equals(reminder.listId)))
                                .getSingleOrNull(),
                        builder: (context, list) => Text(
                          [
                            list.data?.title ??
                                list.data?.generatedTitle ??
                                l10n.listsTitle,
                            DateFormat.yMd(formatLocaleCode(context))
                                .add_Hm()
                                .format(reminder.scheduledAt.toLocal()),
                          ].join(' · '),
                        ),
                      ),
                      onTap: _backupBusy
                          ? null
                          : () => _activateReminder(reminder),
                    ),
                ],
              ),
            ),

            _SectionTitle(icon: Icons.help_outline, label: l10n.helpSection),
            ListTile(
              key: const Key('settings_guide_row'),
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(l10n.howToUseLabel),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showFirstRunGuide(context),
            ),
            if (widget.appIdentity?.contactEmail.isNotEmpty == true)
              ListTile(
                key: const Key('settings_support_email'),
                leading: const Icon(Icons.mail_outline),
                title: Text(l10n.supportEmailLabel),
                subtitle: SelectableText(widget.appIdentity!.contactEmail),
                trailing: IconButton(
                  tooltip: MaterialLocalizations.of(context).copyButtonLabel,
                  icon: const Icon(Icons.copy_outlined),
                  onPressed: () => Clipboard.setData(
                    ClipboardData(text: widget.appIdentity!.contactEmail),
                  ),
                ),
              ),
            if (AiService.client != null)
              ListTile(
                key: const Key('settings_support_id'),
                leading: const Icon(Icons.badge_outlined),
                title: Text(l10n.supportIdLabel),
                subtitle: SelectableText(AiService.client!.installId),
                trailing: IconButton(
                  tooltip: MaterialLocalizations.of(context).copyButtonLabel,
                  icon: const Icon(Icons.copy_outlined),
                  onPressed: () => Clipboard.setData(
                    ClipboardData(text: AiService.client!.installId),
                  ),
                ),
              ),

            ValueListenableBuilder<bool>(
              valueListenable: AssistantPrefs.visible,
              builder: (context, visible, _) => SwitchListTile(
                key: const Key('assistant_toggle'),
                secondary: const Icon(Icons.support_agent_outlined),
                title: Text(l10n.assistantToggleTitle),
                subtitle: Text(l10n.assistantToggleSubtitle),
                value: visible,
                onChanged: AssistantPrefs.set,
              ),
            ),
            if (AiService.client != null)
              SwitchListTile(
                key: const Key('ai_toggle'),
                secondary: const Icon(Icons.auto_awesome_outlined),
                title: Text(l10n.aiToggleTitle),
                subtitle: Text(l10n.aiToggleSubtitle),
                value: AiService.client!.enabled,
                onChanged: (v) => setState(() => AiService.client!.enabled = v),
              ),
            _SectionTitle(
              icon: Icons.privacy_tip_outlined,
              label: l10n.privacyInfoLabel,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                l10n.privacyInfoBody,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            _SectionTitle(
              icon: Icons.science_outlined,
              label: l10n.demoDataTitle,
            ),
            ListTile(
              key: const Key('settings_demo_load'),
              leading: const Icon(Icons.auto_graph),
              title: Text(l10n.demoDataLoad),
              subtitle: Text(l10n.demoDataLoadHelp),
              onTap: () => _demo(load: true),
            ),
            ListTile(
              key: const Key('settings_demo_remove'),
              leading: const Icon(Icons.delete_sweep_outlined),
              title: Text(l10n.demoDataRemove),
              onTap: () => _demo(load: false),
            ),

            _SectionTitle(icon: Icons.info_outline, label: l10n.aboutSection),
            // Sürüm dizesi jargonsuz (C-035): "Sürüm 1.0.0".
            ListTile(
              title: Text(l10n.aboutVersion(appVersion)),
              subtitle: Text(l10n.aboutPublisher),
            ),
            if (widget.appIdentity != null) ...[
              ListTile(
                key: const Key('settings_about_row'),
                leading: const Icon(Icons.code_outlined),
                title: Text(l10n.aboutOpenRow),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => AboutPage(
                      identity: widget.appIdentity!,
                      version: appVersion,
                    ),
                  ),
                ),
              ),
              ListTile(
                key: const Key('settings_licenses_row'),
                leading: const Icon(Icons.description_outlined),
                title: Text(l10n.aboutLicenses),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => LicensesPage(identity: widget.appIdentity!),
                  ),
                ),
              ),
              ListTile(
                key: const Key('settings_share_row'),
                leading: const Icon(Icons.share_outlined),
                title: Text(l10n.shareAction),
                onTap: _engagementBusy ? null : () => _engage(share: true),
              ),
              if (defaultTargetPlatform != TargetPlatform.iOS ||
                  (widget.appIdentity!.appStoreId?.isNotEmpty ?? false))
                ListTile(
                  key: const Key('settings_rate_row'),
                  leading: const Icon(Icons.star_outline),
                  title: Text(l10n.rateAction),
                  onTap: _engagementBusy ? null : () => _engage(share: false),
                ),
            ] else
              ListTile(title: Text(l10n.aboutLicenses)),

            _SectionTitle(icon: Icons.mic_none, label: l10n.voiceSettingsLabel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                l10n.permissionsBody,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),

            // Destructive actions stay separate from optional assistance.
            _SectionTitle(
              icon: Icons.delete_outline,
              label: l10n.deleteAllLabel,
            ),
            ListTile(
              key: const Key('delete_all_button'),
              leading: const Icon(Icons.delete_outline),
              title: Text(l10n.deleteAllLabel),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _confirmDeleteAll(context),
            ),
          ],
        ),
      ),
    );
  }

  void _setLanguage(String? value) {
    if (value == null) return;
    setState(() => _repo.setLanguage(value));
    widget.languageController.set(value);
  }

  bool get _proUnlocked =>
      (widget.proController?.isPro ?? true) ||
      (widget.subscriptions?.tier ?? Tier.free) != Tier.free;

  Tier get _tier => widget.subscriptions?.tier ?? Tier.free;

  String _planLabel(AppLocalizations l10n) => switch (_tier) {
    Tier.max => 'Max',
    Tier.pro => 'Pro',
    Tier.free => _proUnlocked ? 'Pro' : l10n.planFree,
  };

  Future<void> _openPlans(BuildContext context) async {
    final subs = widget.subscriptions!;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => SubscriptionPaywall(service: subs),
      ),
    );
    if (mounted) setState(() {});
  }

  /// Paywall: Pro değilken kilitli özelliklerden buraya gelinir (standart
  /// §5.1: dürüst faydalar, geri yükleme düğmesi).
  Future<void> _openPaywall(BuildContext context) async {
    final controller = widget.proController;
    final repository = widget.purchaseRepository;
    final identity = widget.appIdentity;
    if (controller == null || repository == null || identity == null) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PaywallPage(
          identity: identity,
          controller: controller,
          repository: repository,
          benefits: [l10n.proBenefitNoAds, l10n.proBenefitBackup],
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _exportBackup(BuildContext context) async {
    if (_backupBusy || !_proUnlocked) return;
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    File? file;
    setState(() => _backupBusy = true);
    try {
      file = await _repo.exportBackupToFile();
      if (!mounted || !_proUnlocked) return;
      final bytes = await file.readAsBytes();
      if (!mounted || !_proUnlocked) return;
      final saved = await FilePicker.saveFile(
        fileName: 'NShoptor-backup.json',
        dialogTitle: l10n.exportBackupLabel,
        mimeType: 'application/json',
        bytes: bytes,
      );
      if (!mounted || saved == null) return;
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text(l10n.backupExported), showCloseIcon: true),
        );
    } catch (_) {
      if (mounted) {
        messenger
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.saveFailed),
              showCloseIcon: true,
              duration: const Duration(days: 1),
            ),
          );
      }
    } finally {
      // Only our temporary snapshot is removed; the selected destination belongs to the user.
      try {
        await file?.delete();
      } on FileSystemException {
        /* OS cache cleanup can retry. */
      }
      if (mounted) setState(() => _backupBusy = false);
    }
  }

  Future<void> _importBackup(BuildContext context) async {
    if (_backupBusy || !_proUnlocked) return;
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    setState(() => _backupBusy = true);
    try {
      final file = await FilePicker.pickFile(
        dialogTitle: l10n.importBackupLabel,
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (!mounted || !_proUnlocked || file == null) return;
      // ponytail: 16 MiB bounds decode memory; larger backups need streaming JSON import.
      const limit = 16 * 1024 * 1024;
      final knownSize = file.lengthSync();
      if (knownSize != null && (knownSize < 0 || knownSize > limit)) {
        throw const FormatException('backup size');
      }
      final bytes = BytesBuilder(copy: false);
      await for (final chunk in file.readAsByteStream()) {
        if (!mounted || !_proUnlocked) return;
        if (bytes.length + chunk.length > limit) {
          throw const FormatException('backup size');
        }
        bytes.add(chunk);
      }
      final json = utf8.decode(bytes.takeBytes());
      final preview = _repo.validateBackup(json);
      if (!context.mounted || !_proUnlocked) return;
      final mode = await showDialog<ImportMode>(
        context: context,
        builder: (ctx) => AlertDialog(
          key: const Key('backup_import_dialog'),
          title: Text(l10n.importBackupLabel),
          content: SingleChildScrollView(
            child: Text(
              '${l10n.backupPreviewCounts(preview.listCount, preview.itemCount, preview.entryCount)}\n\n${l10n.backupSizeWarning}',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancelAction),
            ),
            TextButton(
              key: const Key('backup_merge'),
              onPressed: () => Navigator.pop(ctx, ImportMode.merge),
              child: Text(l10n.mergeImportLabel),
            ),
            FilledButton(
              key: const Key('backup_separate'),
              onPressed: () => Navigator.pop(ctx, ImportMode.separate),
              child: Text(l10n.separateImportLabel),
            ),
          ],
        ),
      );
      if (!mounted || !_proUnlocked || mode == null) return;
      await _repo.importBackupJson(json, mode: mode);
      if (!mounted) return;
      final pending = await _repo.pendingRestoredReminders();
      if (!mounted) return;
      setState(() {
        _restoredReminders = Future.value(pending);
      });
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              [
                l10n.backupImported,
                if (pending.isNotEmpty) l10n.setReminderAction,
              ].join('\n'),
            ),
            showCloseIcon: true,
          ),
        );
    } catch (_) {
      if (mounted) {
        messenger
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.backupImportFailed),
              showCloseIcon: true,
              duration: const Duration(days: 1),
            ),
          );
      }
    } finally {
      if (mounted) setState(() => _backupBusy = false);
    }
  }

  Future<void> _activateReminder(Reminder reminder) async {
    if (_backupBusy) return;
    final l = AppLocalizations.of(context);
    setState(() => _backupBusy = true);
    try {
      final list = await (_repo.db.select(
        _repo.db.shoppingLists,
      )..where((t) => t.id.equals(reminder.listId))).getSingle();
      final activated = await _repo.activateRestoredReminder(
        reminderId: reminder.id,
        title: l.reminderTitle,
        body: l.reminderBody(list.title ?? list.generatedTitle ?? l.listsTitle),
      );
      if (!mounted) return;
      setState(() {
        _restoredReminders = _repo.pendingRestoredReminders();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            activated ? l.reminderScheduled : l.reminderPermissionDenied,
          ),
          showCloseIcon: true,
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.saveFailed), showCloseIcon: true),
        );
      }
    } finally {
      if (mounted) setState(() => _backupBusy = false);
    }
  }

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final first = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const Key('delete_all_dialog_1'),
        scrollable: true,
        title: Text(l10n.deleteAllLabel),
        content: Text(l10n.deleteAllConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelAction),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.confirmDelete),
          ),
        ],
      ),
    );
    if (first != true || !context.mounted) return;

    final second = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const Key('delete_all_dialog_2'),
        scrollable: true,
        title: Text(l10n.deleteAllLabel),
        content: Text(l10n.deleteAllConfirm2),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelAction),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.confirmDelete),
          ),
        ],
      ),
    );
    if (second != true || !context.mounted) return;

    // Gerçek silme (ikinci onay sonrası). spec §12: context'i görüntüleme için.
    _repo.confirmDeleteAll();
    try {
      await _repo.deleteAllData();
    } catch (_) {
      if (context.mounted) {
        messenger
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.saveFailed),
              showCloseIcon: true,
              duration: const Duration(days: 1),
            ),
          );
      }
      return;
    }
    if (!context.mounted) return;
    setState(() {
      _restoredReminders = Future.value(const <Reminder>[]);
    });
    messenger
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(l10n.dataDeleted), showCloseIcon: true),
      );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}
