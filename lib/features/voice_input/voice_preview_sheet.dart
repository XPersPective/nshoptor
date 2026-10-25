import 'package:flutter/material.dart';

import '../../core/widgets/price_mode_selector.dart';
import '../../core/text/list_title.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/quantity/unit_display.dart';
import 'parser/parsed_item_candidate.dart';
import 'parser/voice_command_parser.dart';
import 'dictation_mic_button.dart';
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
  bool _micBusy = false;

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
    if (_controller.transcript.isNotEmpty &&
        _controller.transcript != _text.text) {
      _text.text = _controller.transcript;
      _parsed = null;
    }
    setState(() {});
  }

  Future<void> _listen() async {
    if (_micBusy) return;
    setState(() => _micBusy = true);
    _controller.transcript = _text.text;
    try {
      if (_controller.state == VoiceInputState.listening) {
        await _controller.stop();
      } else if (await _controller.initialize() && mounted) {
        await _controller.start(
          locale: Localizations.localeOf(context).toLanguageTag(),
        );
      }
    } finally {
      if (mounted) setState(() => _micBusy = false);
    }
  }

  void _parse() {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    final parsed = VoiceCommandParser(localeCode: _lang).parse(text);
    setState(
      () => _parsed = parsed.withName(
        capitalizeListTitle(parsed.name, localeCode: _lang),
      ),
    );
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
        child: SingleChildScrollView(
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
                ],
              ),
              if (_controller.state == VoiceInputState.error)
                Text(
                  voiceErrorText(l10n, _controller.errorMessage),
                  key: const Key('voice_unavailable'),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              TextField(
                key: const Key('voice_transcript_field'),
                controller: _text,
                readOnly: _controller.state == VoiceInputState.listening,
                onChanged: (text) {
                  _controller.transcript = text;
                  setState(() => _parsed = null);
                },
                decoration: InputDecoration(
                  labelText: l10n.voiceTranscriptLabel,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: IconButton.filledTonal(
                  key: const Key('voice_mic_button'),
                  icon: _micBusy
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          _controller.state == VoiceInputState.listening
                              ? Icons.stop
                              : Icons.mic_none,
                        ),
                  tooltip: _controller.state == VoiceInputState.listening
                      ? l10n.voiceStopListening
                      : l10n.voiceStartListening,
                  onPressed: _micBusy ? null : _listen,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton(
                    key: const Key('voice_parse_button'),
                    onPressed: _text.text.trim().isEmpty ? null : _parse,
                    child: Text(l10n.parseAction),
                  ),
                  FilledButton(
                    key: const Key('voice_confirm_button'),
                    onPressed:
                        parsed == null ||
                            parsed.requiresPriceConfirmation ||
                            _micBusy ||
                            _controller.state == VoiceInputState.listening
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
                      if (parsed.requiresPriceConfirmation)
                        PriceModeSelector(
                          key: const Key('voice_price_meaning'),
                          keyPrefix: 'voice_price_meaning',
                          value: null,
                          onChanged: (value) => setState(
                            () => _parsed = ParsedItemCandidate(
                              name: parsed.name,
                              rawText: parsed.rawText,
                              brand: parsed.brand,
                              category: parsed.category,
                              quantity: parsed.quantity,
                              unitCode: parsed.unitCode,
                              unitPrice: parsed.unitPrice,
                              currencyCode: parsed.currencyCode,
                              priceDestination: parsed.priceDestination,
                              isUnitPrice: value,
                              priceUnitCode: value == true
                                  ? parsed.priceUnitCode ?? parsed.unitCode
                                  : null,
                            ),
                          ),
                        ),
                      Text('${l10n.itemNameLabel}: ${parsed.name}'),
                      Text(
                        '${l10n.quantityLabel}: '
                        '${parsed.quantity?.toDbString() ?? '-'}',
                      ),
                      Text(
                        '${l10n.unitLabel}: ${parsed.unitCode?.dbCode ?? '-'}',
                      ),
                      Text(
                        '${parsed.priceDestination == VoicePriceDestination.actual ? l10n.actualPriceLabel : l10n.plannedPriceLabel}: '
                        '${parsed.unitPrice?.toDbString() ?? '-'} ${parsed.currencyCode ?? ''}',
                      ),
                      if (parsed.unitPrice != null &&
                          !parsed.requiresPriceConfirmation)
                        Text(
                          '${l10n.pricingModeLabel}: ${parsed.isUnitPrice == true ? l10n.pricingModeUnitPrice : l10n.pricingModeLineTotal}'
                          '${parsed.isUnitPrice == true && (parsed.priceUnitCode ?? parsed.unitCode) != null ? ' / ${unitDisplayName((parsed.priceUnitCode ?? parsed.unitCode)!, l10n)}' : ''}',
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
