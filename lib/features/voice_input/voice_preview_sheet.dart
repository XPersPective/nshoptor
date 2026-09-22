import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import 'parser/parsed_item_candidate.dart';
import 'parser/voice_command_parser.dart';
import 'voice_input_service.dart';

/// Sesle ürün ekleme sayfası: dinleme, düzenlenebilir transcript, parser
/// önizlemesi, onay (spec §6.7). Onaylanan aday forma döner; kaydetme yine
/// formdadır. Servis yoksa kullanıcı transcript'i elle yazabilir.
class VoicePreviewSheet extends StatefulWidget {
  const VoicePreviewSheet({super.key, required this.service});

  final SpeechService service;

  @override
  State<VoicePreviewSheet> createState() => _VoicePreviewSheetState();
}

class _VoicePreviewSheetState extends State<VoicePreviewSheet> {
  late final VoiceInputController _controller = VoiceInputController(
    service: widget.service,
  );
  final TextEditingController _text = TextEditingController();
  ParsedItemCandidate? _parsed;

  String get _lang => Localizations.localeOf(context).languageCode;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    _controller.dispose();
    _text.dispose();
    super.dispose();
  }

  void _onChange() {
    if (_controller.transcript.isNotEmpty) {
      _text.text = _controller.transcript;
    }
    setState(() {});
  }

  Future<void> _listen() async {
    if (!await _controller.initialize()) return;
    await _controller.start(locale: _lang == 'tr' ? 'tr_TR' : 'en_US');
  }

  void _parse() {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    setState(() => _parsed = VoiceCommandParser(localeCode: _lang).parse(text));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final parsed = _parsed;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.voiceInputTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  key: const Key('voice_mic_button'),
                  icon: Icon(
                    _controller.state == VoiceInputState.listening
                        ? Icons.mic
                        : Icons.mic_none,
                  ),
                  tooltip: l10n.voiceStartListening,
                  onPressed: _listen,
                ),
              ],
            ),
            if (_controller.state == VoiceInputState.error)
              Text(
                l10n.voiceUnavailable,
                key: const Key('voice_unavailable'),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            TextField(
              key: const Key('voice_transcript_field'),
              controller: _text,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(labelText: l10n.voiceTranscriptLabel),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                OutlinedButton(
                  key: const Key('voice_parse_button'),
                  onPressed: _text.text.trim().isEmpty ? null : _parse,
                  child: Text(l10n.parseAction),
                ),
                const Spacer(),
                FilledButton(
                  key: const Key('voice_confirm_button'),
                  onPressed: parsed == null
                      ? null
                      : () => Navigator.of(context).pop(parsed),
                  child: Text(l10n.saveButton),
                ),
              ],
            ),
            if (parsed != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${l10n.itemNameLabel}: ${parsed.name}'),
                    Text(
                      '${l10n.quantityLabel}: '
                      '${parsed.quantity?.toDbString() ?? '-'}',
                    ),
                    Text(
                      '${l10n.unitLabel}: ${parsed.unitCode?.dbCode ?? '-'}',
                    ),
                    Text(
                      '${l10n.plannedPriceLabel}: '
                      '${parsed.unitPrice?.toDbString() ?? '-'}',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
