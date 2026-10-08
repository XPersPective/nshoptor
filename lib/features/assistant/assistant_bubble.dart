import 'package:flutter/material.dart';
import 'package:napp_core/napp_core.dart';

import '../../core/l10n/generated/app_localizations.dart';

/// Asistanın görünürlüğü (Ayarlar'dan açılıp kapanır; PB-057).
class AssistantPrefs {
  AssistantPrefs._();

  static const key = 'assistant_visible';
  static final visible = ValueNotifier<bool>(true);
  static SettingsStore? _store;

  static void attach(SettingsStore store) {
    _store = store;
    visible.value = store.getBool(key) ?? true;
  }

  static void set(bool value) {
    visible.value = value;
    _store?.setBool(key, value);
  }
}

enum AssistantAction { newList, voiceList, textList, scanReceipt, spending }

/// Asistan sayfasının sonucu: seçilen eylem ve (varsa) yazılan cümle.
typedef AssistantChoice = ({AssistantAction action, String? text});

/// Sağ altta küçük avatar; dokununca "Ne yapmak istiyorsun?" sayfası.
class AssistantBubble extends StatelessWidget {
  const AssistantBubble({super.key, required this.onChoice});

  final ValueChanged<AssistantChoice> onChoice;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.assistantTitle,
      child: Material(
        key: const Key('assistant_bubble'),
        color: scheme.primary,
        shape: const CircleBorder(),
        elevation: 4,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () async {
            final choice = await showModalBottomSheet<AssistantChoice>(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (_) => const AssistantSheet(),
            );
            if (choice != null) onChoice(choice);
          },
          child: SizedBox.square(
            dimension: 52,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shopping_basket_outlined, color: scheme.onPrimary, size: 26),
                Positioned(
                  right: 9,
                  top: 8,
                  child: Icon(Icons.auto_awesome, color: scheme.onPrimary, size: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AssistantSheet extends StatefulWidget {
  const AssistantSheet({super.key});

  @override
  State<AssistantSheet> createState() => _AssistantSheetState();
}

class _AssistantSheetState extends State<AssistantSheet> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _pick(AssistantAction action, [String? text]) =>
      Navigator.of(context).pop<AssistantChoice>((action: action, text: text));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final actions = [
      (AssistantAction.newList, Icons.add_circle_outline, l10n.assistantNewList),
      (AssistantAction.voiceList, Icons.mic_none, l10n.assistantVoiceList),
      (AssistantAction.textList, Icons.edit_note, l10n.assistantTextList),
      (AssistantAction.scanReceipt, Icons.receipt_long_outlined, l10n.assistantScanReceipt),
      (AssistantAction.spending, Icons.insights_outlined, l10n.assistantSpending),
    ];
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16, right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.assistantGreeting, style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final (action, icon, label) in actions)
                  ActionChip(
                    key: Key('assistant_${action.name}'),
                    avatar: Icon(icon, size: 18),
                    label: Text(label),
                    onPressed: () => _pick(action),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('assistant_text'),
              controller: _text,
              textInputAction: TextInputAction.send,
              onSubmitted: (v) => v.trim().isEmpty ? null : _pick(AssistantAction.textList, v.trim()),
              decoration: InputDecoration(
                hintText: l10n.quickListHint,
                suffixIcon: IconButton(
                  key: const Key('assistant_send'),
                  icon: const Icon(Icons.send),
                  onPressed: () => _text.text.trim().isEmpty
                      ? null
                      : _pick(AssistantAction.textList, _text.text.trim()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
