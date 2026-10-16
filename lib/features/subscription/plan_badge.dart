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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tip = '$label · ${AppLocalizations.of(context).tipPlan}';
    final iconOnly = MediaQuery.textScalerOf(context).scale(14) > 18;
    return Tooltip(
      key: badgeKey,
      message: tip,
      child: InkWell(
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: SizedBox(
          height: 48,
          child: Center(
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: active
                    ? scheme.primaryContainer.withValues(alpha: 0.7)
                    : scheme.surfaceContainerHighest.withValues(alpha: 0.7),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: iconOnly ? 8 : 10, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trial ? Icons.hourglass_top : Icons.workspace_premium,
                      size: 14,
                      color: active ? scheme.primary : scheme.onSurfaceVariant,
                    ),
                    if (!iconOnly) ...[
                      const SizedBox(width: 4),
                      Text(label, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
