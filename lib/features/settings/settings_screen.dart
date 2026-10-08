import 'package:flutter/material.dart';

import '../ai/ai_client.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import '../../../../core/app_version.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/format_locale.dart';
import '../../../../core/quantity/unit_code.dart';
import '../../../../core/quantity/unit_display.dart';
import '../../app/language_controller.dart';
import '../../app/theme_mode_controller.dart';
import 'settings_repository.dart';

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
    this.appIdentity,
    this.giftFlow,
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

  /// Paywall başlığı/marka için kimlik (napp_core).
  final AppIdentity? appIdentity;

  /// Verilirse üst çubukta ödüllü reklam hediye düğmesi (standart §5.2).
  final Widget? giftFlow;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsRepository get _repo => widget.repository;

  @override
  void initState() {
    super.initState();
    // Pro durumu değişince (satın alma/ödüllü 24s) kilitler anında kalkar.
    widget.proController?.addListener(_onProChanged);
  }

  @override
  void dispose() {
    widget.proController?.removeListener(_onProChanged);
    super.dispose();
  }

  void _onProChanged() {
    if (mounted) setState(() {});
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
          if (widget.giftFlow != null) widget.giftFlow!,
        ],
      ),
      body: AnimatedBuilder(
        animation: widget.languageController,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionTitle(icon: Icons.language, label: l10n.languageLabel),
            DropdownButtonFormField<String>(
              key: const Key('settings_language_dropdown'),
              initialValue: _repo.currentLanguage,
              decoration: InputDecoration(
                  labelText: l10n.languageLabel,
                  prefixIcon: const Icon(Icons.language)),
              items: [
                DropdownMenuItem(value: 'system', child: Text(l10n.languageSystem)),
                DropdownMenuItem(value: 'tr', child: Text(l10n.languageTr)),
                DropdownMenuItem(value: 'en', child: Text(l10n.languageEn)),
              ],
              onChanged: (v) => _setLanguage(v),
            ),

            // Biçim yereli DİLDEN BAĞIMSIZ seçilir (C-001, PB-042).
            _SectionTitle(
                icon: Icons.numbers, label: l10n.formatLocaleLabel),
            DropdownButtonFormField<String>(
              key: const Key('settings_format_locale_dropdown'),
              initialValue: _repo.formatLocale,
              decoration: InputDecoration(
                labelText: l10n.formatLocaleLabel,
                prefixIcon: const Icon(Icons.numbers),
              ),
              items: [
                DropdownMenuItem(
                    value: 'system', child: Text(l10n.formatLocaleSystem)),
                DropdownMenuItem(
                    value: 'tr', child: Text(l10n.formatLocaleTr)),
                DropdownMenuItem(
                    value: 'en', child: Text(l10n.formatLocaleEn)),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() => _repo.setFormatLocale(v));
                AppFormatLocale.attach(v == 'tr' || v == 'en' ? v : null);
              },
            ),

            _SectionTitle(
                icon: Icons.dark_mode_outlined, label: l10n.themeLabel),
            DropdownButtonFormField<String>(
              key: const Key('settings_theme_dropdown'),
              initialValue: _repo.themeMode,
              decoration: InputDecoration(
                labelText: l10n.themeLabel,
                prefixIcon: const Icon(Icons.dark_mode_outlined),
              ),
              items: [
                DropdownMenuItem(value: 'system', child: Text(l10n.themeSystem)),
                DropdownMenuItem(value: 'light', child: Text(l10n.themeLight)),
                DropdownMenuItem(value: 'dark', child: Text(l10n.themeDark)),
              ],
              onChanged: _setThemeMode,
            ),

            _SectionTitle(
                icon: Icons.currency_exchange, label: l10n.unitsSection),
            ListTile(
              leading: const Icon(Icons.category_outlined),
              title: Text(l10n.defaultUnitLabel),
              subtitle:
                  Text(unitDisplayNameFromName(_repo.defaultUnit, l10n)),
              trailing: DropdownButton<String>(
                value: _repo.defaultUnit,
                items: UnitCode.standard()
                    .map((u) => DropdownMenuItem(
                          value: u.name,
                          child: Text(unitDisplayName(u, l10n)),
                        ))
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
                    .map((c) => DropdownMenuItem(
                          value: c.code,
                          child: Text(c.code),
                        ))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _repo.setDefaultCurrency(v!)),
              ),
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.screen_lock_portrait),
              title: Text(l10n.keepAwakeLabel),
              value: _repo.keepScreenAwake,
              onChanged: (v) =>
                  setState(() => _repo.setKeepScreenAwake(v ?? false)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.roundingNote,
                  style: Theme.of(context).textTheme.bodySmall),
            ),

            _SectionTitle(
                icon: Icons.workspace_premium_outlined,
                label: 'NShoptor Pro'),
            ListTile(
              key: const Key('settings_pro_row'),
              leading: const Icon(Icons.workspace_premium_outlined),
              title: Text(_proUnlocked
                  ? l10n.proActiveLabel
                  : l10n.proBuyLabel),
              subtitle: !_proUnlocked ? Text(l10n.proBenefitsLine) : null,
              trailing: _proUnlocked
                  ? const Icon(Icons.check_circle_outline)
                  : const Icon(Icons.chevron_right),
              onTap: () => _proUnlocked ? null : _openPaywall(context),
            ),

            _SectionTitle(
                icon: Icons.backup_outlined, label: l10n.backupSection),
            // Yedekleme Pro'ya özeldir (standart §3.8): Pro değilken
            // kilit simgesi + dokunuş paywall açar.
            ListTile(
              key: const Key('export_backup_button'),
              leading: const Icon(Icons.upload_file),
              title: Text(l10n.exportBackupLabel),
              trailing: _proUnlocked
                  ? null
                  : const Icon(Icons.lock_outline),
              onTap: () => _proUnlocked
                  ? _exportBackup(context)
                  : _openPaywall(context),
            ),
            ListTile(
              key: const Key('import_backup_button'),
              leading: const Icon(Icons.download_outlined),
              title: Text(l10n.importBackupLabel),
              trailing: _proUnlocked
                  ? null
                  : const Icon(Icons.lock_outline),
              onTap: () => _proUnlocked
                  ? _importBackup(context)
                  : _openPaywall(context),
            ),

            _SectionTitle(
                icon: Icons.delete_outline, label: l10n.deleteAllSection),
            SwitchListTile(
              key: const Key('delete_all_button'),
              secondary: const Icon(Icons.delete_forever),
              title: Text(l10n.deleteAllLabel),
              value: false,
              onChanged: (_) => _confirmDeleteAll(context),
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
                icon: Icons.privacy_tip_outlined, label: l10n.privacyInfoLabel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.privacyInfoBody,
                  style: Theme.of(context).textTheme.bodyMedium),
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
                onTap: () => ShareService().shareApp(
                  widget.appIdentity!,
                  message: l10n.shareAction,
                  isIos: false, // Android öncelikli (C-033); iOS ertelendi
                ),
              ),
              ListTile(
                key: const Key('settings_rate_row'),
                leading: const Icon(Icons.star_outline),
                title: Text(l10n.rateAction),
                onTap: () => ReviewService()
                    .openRatePage(widget.appIdentity!, isIos: false),
              ),
            ] else
              ListTile(title: Text(l10n.aboutLicenses)),

            _SectionTitle(
                icon: Icons.mic_none, label: l10n.voiceSettingsLabel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.permissionsBody,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }

  void _setLanguage(String? value) {
    if (value == null) return;
    setState(() => _repo.setLanguage(value));
    widget.languageController.set(
      AppLocaleSetting.values.firstWhere((e) => e.name == value),
    );
  }

  bool get _proUnlocked => widget.proController?.isPro ?? true;

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
          benefits: [
            l10n.proBenefitNoAds,
            l10n.proBenefitBackup,
          ],
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _exportBackup(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    final file = await _repo.exportBackupToFile();
    if (!context.mounted) return;
    messenger.showSnackBar(
      SnackBar(content: Text('${l10n.backupExported} ${file.path}')),
    );
  }

  Future<void> _importBackup(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    // Dosya seçici açılış noktası minimal tutulur: T30.2 içe aktarma ekranı
    // tamamlanmadan önceki davranış: yalnız bildirim.
    messenger.showSnackBar(SnackBar(content: Text(l10n.cancelButton)));
  }

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final first = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const Key('delete_all_dialog_1'),
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
    await _repo.deleteAllData();
    if (!context.mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(l10n.dataDeleted)));
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
          Text(label, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
