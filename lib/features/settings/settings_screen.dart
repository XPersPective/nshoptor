import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/quantity/unit_code.dart';
import '../../app/language_controller.dart';
import 'settings_repository.dart';

/// Ayarlar ekranı (spec §6.15): dil, tema, varsayılanlar, yedekleme,
/// silme, gizlilik ve hakkında bölümleri. "Double onay" silme akışı
/// (spec §12: ikinci onay + kapsam açıklaması).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.repository,
    required this.languageController,
  });

  final SettingsRepository repository;
  final LanguageController languageController;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsRepository get _repo => widget.repository;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
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
              onChanged: (v) => setState(() {
                if (v != null) _repo.setThemeMode(v);
              }),
            ),

            _SectionTitle(
                icon: Icons.currency_exchange, label: l10n.unitsSection),
            ListTile(
              leading: const Icon(Icons.category_outlined),
              title: Text(l10n.defaultUnitLabel),
              subtitle: Text(_repo.defaultUnit),
              trailing: DropdownButton<String>(
                value: _repo.defaultUnit,
                items: UnitCode.standard()
                    .map((u) => DropdownMenuItem(
                          value: u.name,
                          child: Text(u.name),
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
                icon: Icons.backup_outlined, label: l10n.backupSection),
            ListTile(
              key: const Key('export_backup_button'),
              leading: const Icon(Icons.upload_file),
              title: Text(l10n.exportBackupLabel),
              onTap: () => _exportBackup(context),
            ),
            ListTile(
              key: const Key('import_backup_button'),
              leading: const Icon(Icons.download_outlined),
              title: Text(l10n.importBackupLabel),
              onTap: () => _importBackup(context),
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

            _SectionTitle(
                icon: Icons.privacy_tip_outlined, label: l10n.privacyInfoLabel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.privacyInfoBody,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),

            _SectionTitle(icon: Icons.info_outline, label: l10n.aboutSection),
            ListTile(
              title: Text(l10n.aboutVersion),
              subtitle: Text(l10n.aboutPublisher),
            ),
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
