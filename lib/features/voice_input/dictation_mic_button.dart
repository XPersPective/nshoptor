import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import 'stt_speech_service.dart';
import 'voice_input_service.dart';

/// Ses hatası kodunun kullanıcı metni (tüm ses yüzeyleri aynı dili konuşur).
String voiceErrorText(AppLocalizations l10n, String? code) => switch (code) {
  'unsupportedLanguage' => l10n.voiceUnsupportedLanguage,
  'modelDownloading' => l10n.voiceModelDownloading,
  _ => l10n.voiceUnavailable,
};

/// Tek alana dikte: tanınan metni [controller]'a canlı yazar; tekrar
/// dokunuş durdurur. Kayıt yine kullanıcının onayıyla olur (C-004).
class DictationMicButton extends StatefulWidget {
  const DictationMicButton({
    super.key,
    required this.controller,
    this.speechService,
  });

  final TextEditingController controller;

  /// Test enjeksiyonu; verilmezse cihaz içi Android tanıyıcı.
  final SpeechService? speechService;

  @override
  State<DictationMicButton> createState() => _DictationMicButtonState();
}

class _DictationMicButtonState extends State<DictationMicButton> {
  VoiceInputController? _voice;
  bool _busy = false;
  String? _error;
  final _tooltip = GlobalKey<TooltipState>();

  bool get _listening => _voice?.state == VoiceInputState.listening;

  @override
  void dispose() {
    _voice?.removeListener(_onVoice);
    _voice?.dispose();
    super.dispose();
  }

  void _onVoice() {
    final voice = _voice!;
    if (voice.state == VoiceInputState.error) {
      // Bottom sheets hide root snackbars: the message stays on the button.
      _error = voiceErrorText(AppLocalizations.of(context), voice.errorMessage);
      voice.state = VoiceInputState.idle;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _tooltip.currentState?.ensureTooltipVisible(),
      );
    } else if (voice.transcript.isNotEmpty &&
        voice.transcript != widget.controller.text) {
      widget.controller.value = TextEditingValue(
        text: voice.transcript,
        selection: TextSelection.collapsed(offset: voice.transcript.length),
      );
    }
    if (mounted) setState(() {});
  }

  Future<void> _toggle() async {
    if (_busy) return;
    final voice = _voice ??= VoiceInputController(
      service: widget.speechService ?? SttSpeechService(),
    )..addListener(_onVoice);
    setState(() => _busy = true);
    try {
      if (_listening) {
        await voice.stop();
      } else {
        voice.transcript = '';
        _error = null;
        if (await voice.initialize() && mounted) {
          await voice.start(
            locale: Localizations.localeOf(context).toLanguageTag(),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      key: _tooltip,
      message:
          _error ??
          (_listening ? l10n.voiceStopListening : l10n.voiceStartListening),
      showDuration: const Duration(seconds: 4),
      child: IconButton(
        isSelected: _listening,
        icon: Icon(
          _error == null ? Icons.mic_none : Icons.mic_off_outlined,
          color: _error == null ? null : Theme.of(context).colorScheme.error,
        ),
        selectedIcon: Icon(
          Icons.stop_circle,
          color: Theme.of(context).colorScheme.error,
        ),
        onPressed: _busy ? null : _toggle,
      ),
    );
  }
}
