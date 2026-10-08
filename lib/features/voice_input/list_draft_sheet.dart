import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/quantity/unit_display.dart';
import '../ai/ai_client.dart';
import 'ai_list_parser.dart';
import 'parser/parsed_item_candidate.dart';
import 'voice_input_service.dart';

/// Cümleden/sesten çok ürünlü taslak (PB-050). Kullanıcı söyler ya da yazar,
/// "Listeye dönüştür" ile adaylar çıkar; yalnız işaretlenenler eklenir
/// (C-003: onaysız kayıt yok). Sonuç: seçilen adaylar.
class ListDraftSheet extends StatefulWidget {
  const ListDraftSheet({super.key, this.speechService, this.parser});

  final SpeechService? speechService;

  /// Testlerde enjekte edilir; yoksa AiService.client ile kurulur.
  final AiListParser? parser;

  @override
  State<ListDraftSheet> createState() => _ListDraftSheetState();
}

class _ListDraftSheetState extends State<ListDraftSheet> {
  final _text = TextEditingController();
  VoiceInputController? _voice;
  ListDraft? _draft;
  final _selected = <int>{};
  bool _busy = false;

  String get _lang => Localizations.localeOf(context).languageCode;

  @override
  void initState() {
    super.initState();
    final service = widget.speechService;
    if (service != null) {
      _voice = VoiceInputController(service: service)..addListener(_onVoice);
    }
  }

  @override
  void dispose() {
    _voice?.removeListener(_onVoice);
    _voice?.dispose();
    _text.dispose();
    super.dispose();
  }

  void _onVoice() {
    final t = _voice!.transcript;
    if (t.isNotEmpty) _text.text = t;
    setState(() {});
  }

  Future<void> _listen() async {
    final voice = _voice;
    if (voice == null || !await voice.initialize()) return;
    await voice.start(locale: _lang == 'tr' ? 'tr_TR' : 'en_US');
  }

  Future<void> _convert() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    setState(() => _busy = true);
    final parser = widget.parser ?? AiListParser(ai: AiService.client, localeCode: _lang);
    final draft = await parser.parse(_text.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _draft = draft;
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
      messenger?.showSnackBar(SnackBar(content: Text(note)));
    }
  }

  String _line(ParsedItemCandidate c, AppLocalizations l10n) {
    final parts = <String>[
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(l10n.quickListTitle, style: Theme.of(context).textTheme.titleMedium)),
                if (_voice != null)
                  IconButton.filledTonal(
                    key: const Key('draft_mic_button'),
                    tooltip: l10n.voiceStartListening,
                    icon: Icon(_voice!.state == VoiceInputState.listening ? Icons.mic : Icons.mic_none),
                    onPressed: _listen,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('draft_text_field'),
              controller: _text,
              minLines: 2,
              maxLines: 5,
              onChanged: (_) => setState(() {}),
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
            if (draft != null) ...[
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
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 280),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (var i = 0; i < draft.items.length; i++)
                        CheckboxListTile(
                          key: Key('draft_item_$i'),
                          value: _selected.contains(i),
                          onChanged: (v) => setState(() => v == true ? _selected.add(i) : _selected.remove(i)),
                          title: Text(draft.items[i].name),
                          subtitle: _line(draft.items[i], l10n).isEmpty ? null : Text(_line(draft.items[i], l10n)),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              FilledButton(
                key: const Key('draft_add_button'),
                onPressed: _selected.isEmpty
                    ? null
                    : () => Navigator.of(context).pop([
                          for (final i in _selected.toList()..sort()) draft.items[i],
                        ]),
                child: Text(l10n.quickListAdd(_selected.length)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
