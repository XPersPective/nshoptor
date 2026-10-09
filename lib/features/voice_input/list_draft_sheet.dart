import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/quantity/unit_display.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_parser.dart';
import '../../core/money/format_locale.dart';
import '../lists/starter_categories.dart';
import '../ai/ai_client.dart';
import 'ai_list_parser.dart';
import '../subscription/subscription_paywall.dart';
import '../subscription/subscription_service.dart';
import 'parser/parsed_item_candidate.dart';
import 'voice_input_service.dart';

/// Cümleden/sesten çok ürünlü taslak (PB-050). Kullanıcı söyler ya da yazar,
/// "Listeye dönüştür" ile adaylar çıkar; yalnız işaretlenenler eklenir
/// (C-003: onaysız kayıt yok). Sonuç: seçilen adaylar.
class ListDraftSheet extends StatefulWidget {
  const ListDraftSheet({
    super.key,
    this.speechService,
    this.parser,
    this.initialText,
    this.autoListen = false,
    this.onApprove,
  });

  /// Asistandan gelen cümle: verilirse hemen dönüştürülür (PB-057).
  final String? initialText;

  /// Asistanın "Sesle liste" eylemi: açılır açılmaz dinlemeye başlar.
  final bool autoListen;

  final Future<void> Function(ListDraft)? onApprove;

  final SpeechService? speechService;

  /// Testlerde enjekte edilir; yoksa AiService.client ile kurulur.
  final AiListParser? parser;

  @override
  State<ListDraftSheet> createState() => _ListDraftSheetState();
}

class _ListDraftSheetState extends State<ListDraftSheet> {
  final _text = TextEditingController();
  final _title = TextEditingController();
  String? _error;
  VoiceInputController? _voice;
  ListDraft? _draft;
  final _selected = <int>{};
  bool _busy = false;
  bool _micBusy = false;

  String get _lang => Localizations.localeOf(context).languageCode;

  @override
  void initState() {
    super.initState();
    final service = widget.speechService;
    if (service != null) {
      _voice = VoiceInputController(service: service)..addListener(_onVoice);
    }
    final initial = widget.initialText;
    if (initial != null && initial.trim().isNotEmpty) {
      _text.text = initial;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _convert();
      });
    } else if (widget.autoListen && _voice != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _listen();
      });
    }
  }

  @override
  void dispose() {
    _voice?.removeListener(_onVoice);
    _voice?.dispose();
    _text.dispose();
    _title.dispose();
    super.dispose();
  }

  void _onVoice() {
    final t = _voice!.transcript;
    if (t.isNotEmpty && t != _text.text) { _text.text = t; _draft = null; _selected.clear(); }
    setState(() {});
  }

  Future<void> _listen() async {
    final voice = _voice;
    if (voice == null || _micBusy || _busy) return;
    setState(() => _micBusy = true);
    voice.transcript = _text.text;
    try {
      if (voice.state == VoiceInputState.listening) { await voice.stop(); }
      else if (await voice.initialize() && mounted) {
        await voice.start(locale: Localizations.localeOf(context).toLanguageTag());
      }
    } finally { if (mounted) setState(() => _micBusy = false); }
  }

  Future<void> _convert() async {
    if (_busy || _micBusy || _voice?.state == VoiceInputState.listening) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    setState(() { _busy = true; _error = null; });
    final parser = widget.parser ?? AiListParser(ai: AiService.client, localeCode: _lang);
    try {
    final draft = await parser.parse(_text.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _draft = draft;
      _title.text = draft.title ?? "";
      _selected
        ..clear()
        ..addAll(List.generate(draft.items.length, (i) => i));
    });
    final why = draft.aiResult;
    final note = switch (why) {
      AiQuota(:final used, :final limit) => l10n.aiQuotaReached(used, limit),
      AiOffline() => l10n.aiOffline,
      AiFailed(:final reason) when reason != 'disabled' => l10n.aiFailed,
      _ => null,
    };
    if (note != null && !draft.fromAi) {
      final nav = Navigator.of(context);
      messenger?.clearSnackBars();
      messenger?.showSnackBar(SnackBar(showCloseIcon: true,
        content: Text(note),
        action: why is AiQuota && SubscriptionService.instance != null
            ? SnackBarAction(label: l10n.plansTitle, onPressed: () => openPlans(nav.context))
            : null,
      ));
    }
    } catch (_) { if (mounted) setState(() => _error = l10n.aiFailed); }
    finally { if (mounted) setState(() => _busy = false); }
  }

  Future<void> _approve() async {
    if (_busy || _draft == null || _selected.isEmpty) return;
    final l10n = AppLocalizations.of(context);
    final draft = ListDraft([for (final i in _selected.toList()..sort()) _draft!.items[i]],
      fromAi: _draft!.fromAi, aiResult: _draft!.aiResult,
      title: _title.text.trim().isEmpty ? null : _title.text.trim());
    setState(() { _busy = true; _error = null; });
    try { await widget.onApprove?.call(draft); if (mounted) Navigator.of(context).pop(draft); }
    catch (_) { if (mounted) setState(() => _error = l10n.saveFailed); }
    finally { if (mounted) setState(() => _busy = false); }
  }

  Future<void> _edit(int index) async {
    final c = _draft!.items[index];
    final l10n = AppLocalizations.of(context);
    final separators = MoneySeparators.forLocaleCode(formatLocaleCode(context));
    final form = GlobalKey<FormState>();
    var name = c.name, brand = c.brand ?? '', category = c.category ?? '';
    var quantity = (c.quantity ?? DecimalFixed.fromInt(1)).toDbString().replaceAll('.', separators.decimal);
    var price = c.unitPrice?.toDbString().replaceAll('.', separators.decimal) ?? '';
    var unit = c.unitCode ?? UnitCode.adet;
    var isUnit = c.isUnitPrice ?? false;
    DecimalFixed? decimal(String text) => text.trim().isEmpty ? null : MoneyParser.parseDecimal(text, separators: separators);
    String? validDecimal(String? value, {bool positive = false}) {
      try { final d = decimal(value ?? ''); return d == null ? (positive ? l10n.invalidQuantityError : null) :
        d.isNegative || positive && !d.isPositive ? l10n.invalidAmountError : null; }
      catch (_) { return l10n.invalidAmountError; }
    }
    final edited = await showDialog<ParsedItemCandidate>(context: context, builder: (ctx) => AlertDialog(
      title: Text(l10n.editAction),
      content: SingleChildScrollView(child: Form(key: form, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextFormField(key: const Key('draft_edit_name'), initialValue: name, maxLength: 60,
          decoration: InputDecoration(labelText: l10n.itemNameLabel), onChanged: (v) => name = v,
          validator: (v) => v == null || v.trim().isEmpty ? l10n.invalidNameError : null),
        TextFormField(key: const Key('draft_edit_brand'), initialValue: brand, maxLength: 60,
          decoration: InputDecoration(labelText: l10n.brandLabel), onChanged: (v) => brand = v),
        TextFormField(key: const Key('draft_edit_category'), initialValue: StarterCategories().labelOf(l10n, category), maxLength: 60,
          decoration: InputDecoration(labelText: l10n.categoryLabel), onChanged: (v) => category = v),
        TextFormField(key: const Key('draft_edit_quantity'), initialValue: quantity,
          decoration: InputDecoration(labelText: l10n.quantityLabel), onChanged: (v) => quantity = v,
          validator: (v) => validDecimal(v, positive: true), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
        DropdownButtonFormField<UnitCode>(initialValue: unit, isExpanded: true,
          decoration: InputDecoration(labelText: l10n.unitLabel),
          items: [for (final u in UnitCode.values) DropdownMenuItem(value: u, child: Text(unitDisplayName(u, l10n)))],
          onChanged: (v) => unit = v!),
        TextFormField(key: const Key('draft_edit_price'), initialValue: price,
          decoration: InputDecoration(labelText: l10n.plannedPriceLabel), onChanged: (v) => price = v,
          validator: validDecimal, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
        DropdownButtonFormField<bool>(initialValue: isUnit, isExpanded: true,
          decoration: InputDecoration(labelText: l10n.pricingModeLabel),
          items: [DropdownMenuItem(value: true, child: Text(l10n.pricingModeUnitPrice)),
            DropdownMenuItem(value: false, child: Text(l10n.pricingModeLineTotal))], onChanged: (v) => isUnit = v!),
      ]))),
      actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(l10n.cancelButton)),
        FilledButton(key: const Key('draft_edit_save'), onPressed: () {
          if (!form.currentState!.validate()) return;
          Navigator.of(ctx).pop(ParsedItemCandidate(name: name.trim(), rawText: c.rawText,
            brand: brand.trim().isEmpty ? null : brand.trim(), category: category.trim().isEmpty ? null : category.trim(),
            quantity: decimal(quantity), unitCode: unit, unitPrice: decimal(price), isUnitPrice: isUnit, currencyCode: c.currencyCode));
        }, child: Text(l10n.saveButton))],
    ));
    if (edited != null && mounted) setState(() { _draft!.items[index] = edited; });
  }

  String _line(ParsedItemCandidate c, AppLocalizations l10n) {
    final parts = <String>[
      if (c.brand != null) c.brand!,
      if (c.category != null) StarterCategories().labelOf(l10n, c.category!),
      if (c.quantity != null)
        '${c.quantity!.toDbString()} ${c.unitCode == null ? '' : unitDisplayName(c.unitCode!, l10n)}'.trim(),
      if (c.unitPrice != null)
        c.isUnitPrice == true
            ? '${c.unitPrice!.toDbString()} / ${c.unitCode == null ? '' : unitDisplayName(c.unitCode!, l10n)}'
            : c.unitPrice!.toDbString(),
    ];
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = _draft;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16, right: 16, top: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SingleChildScrollView(child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(l10n.quickListTitle, style: Theme.of(context).textTheme.titleMedium)),
                if (_voice != null)
                  IconButton.filledTonal(
                    key: const Key('draft_mic_button'),
                    tooltip: _voice!.state == VoiceInputState.listening ? l10n.voiceStopListening : l10n.voiceStartListening,
                    icon: _micBusy ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Icon(_voice!.state == VoiceInputState.listening ? Icons.stop : Icons.mic_none),
                    onPressed: _micBusy || _busy ? null : _listen,
                  ),
              ],
            ),
            if (_voice?.state == VoiceInputState.error) Text(
              _voice?.errorMessage == 'unsupportedLanguage' ? l10n.voiceUnsupportedLanguage : l10n.voiceUnavailable,
              key: const Key('draft_voice_unavailable'), style: TextStyle(color: Theme.of(context).colorScheme.error)),
            const SizedBox(height: 8),
            TextField(
              key: const Key('draft_text_field'),
              controller: _text,
              enabled: !_busy && !_micBusy && _voice?.state != VoiceInputState.listening,
              minLines: 2,
              maxLines: 5,
              onChanged: (text) { _voice?.transcript = text; setState(() { _draft = null; _selected.clear(); _error = null; }); },
              decoration: InputDecoration(hintText: l10n.quickListHint),
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              key: const Key('draft_convert_button'),
              onPressed: _busy || _text.text.trim().isEmpty ? null : _convert,
              icon: _busy
                  ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.auto_awesome_outlined),
              label: Text(l10n.quickListConvert),
            ),
            if (_error != null) Text(_error!, key: const Key('draft_error'), style: TextStyle(color: Theme.of(context).colorScheme.error)),
            if (draft != null) ...[
              TextField(key: const Key('draft_title_field'), controller: _title, maxLength: 80, enabled: !_busy,
                decoration: InputDecoration(labelText: l10n.listTitleHint)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Chip(
                    key: const Key('draft_source_chip'),
                    avatar: Icon(draft.fromAi ? Icons.auto_awesome : Icons.phone_android, size: 16),
                    label: Text(draft.fromAi ? l10n.aiSourceLabel : l10n.deviceSourceLabel),
                  ),
                ],
              ),
              if (draft.items.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(l10n.quickListEmpty, textAlign: TextAlign.center),
                )
              else
                Column(children: [for (var i = 0; i < draft.items.length; i++) CheckboxListTile(
                  key: Key('draft_item_$i'), value: _selected.contains(i),
                  onChanged: _busy ? null : (v) => setState(() => v == true ? _selected.add(i) : _selected.remove(i)),
                  title: Text(draft.items[i].name), subtitle: Text(_line(draft.items[i], l10n)),
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: IconButton(key: Key('draft_edit_$i'), tooltip: l10n.editAction,
                    onPressed: _busy ? null : () => _edit(i), icon: const Icon(Icons.edit_outlined)),
                )]),
              const SizedBox(height: 8),
              FilledButton(
                key: const Key('draft_add_button'),
                onPressed: _busy || _selected.isEmpty || _micBusy || _voice?.state == VoiceInputState.listening
                    ? null
                    : _approve,
                child: Text(l10n.quickListAdd(_selected.length)),
              ),
            ],
          ],
        )),
      ),
    );
  }
}
