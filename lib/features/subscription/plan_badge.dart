import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import 'subscription_service.dart';

/// Plan adı: Ücretsiz, Pro ya da Max. Geçici Pro (ödüllü hediye) ücretsiz
/// katmanda "Pro" gösterir (Ayarlar ile aynı kural).
String planLabel(AppLocalizations l10n, {required Tier tier, required bool proUnlocked}) =>
    switch (tier) {
      Tier.max => 'Max',
      Tier.pro => 'Pro',
      Tier.free => proUnlocked ? 'Pro' : l10n.planFree,
    };

/// Paywall başlığındaki açık durum: "Mevcut: Pro · 7 gün ücretsiz".
String planStatusText(AppLocalizations l10n, {required String label, required bool trial}) =>
    trial ? '${l10n.planCurrent}: $label · ${l10n.planTrial}' : '${l10n.planCurrent}: $label';

/// Plan simgesi: ana sayfa ve Ayarlar'da aynı görünür, dokununca plan sayfası açılır.
class PlanBadge extends StatelessWidget {
  const PlanBadge({
    super.key,
    required this.badgeKey,
    required this.label,
    required this.trial,
    required this.active,
    required this.onPressed,
  });

  final Key badgeKey;
  final String label;
  final bool trial;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final tip = '$label · ${AppLocalizations.of(context).tipPlan}';
    final icon = Icon(
      trial ? Icons.hourglass_top : Icons.workspace_premium,
      size: 18,
      color: active ? Theme.of(context).colorScheme.primary : null,
    );
    if (MediaQuery.textScalerOf(context).scale(14) > 18) {
      return IconButton(
        key: badgeKey,
        tooltip: tip,
        icon: icon,
        onPressed: onPressed,
      );
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 4),
      child: ActionChip(
        key: badgeKey,
        avatar: icon,
        label: Text(label),
        tooltip: tip,
        onPressed: onPressed,
      ),
    );
  }
}
