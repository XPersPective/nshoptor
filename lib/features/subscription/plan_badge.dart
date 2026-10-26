import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import 'subscription_service.dart';

/// Plan adı: Ücretsiz, Pro ya da Max. Geçici Pro (ödüllü hediye) ücretsiz
/// katmanda "Pro" gösterir (Ayarlar ile aynı kural).
String planLabel(
  AppLocalizations l10n, {
  required Tier tier,
  required bool proUnlocked,
}) => switch (tier) {
  Tier.max => 'Max',
  Tier.pro => 'Pro',
  Tier.free => proUnlocked ? 'Pro' : l10n.planFree,
};

/// Paywall başlığındaki açık durum: "Mevcut: Pro · 7 gün ücretsiz".
String planStatusText(
  AppLocalizations l10n, {
  required String label,
  required bool trial,
}) => trial
    ? '${l10n.planCurrent}: $label · ${l10n.planTrial}'
    : '${l10n.planCurrent}: $label';

String? trialRemainingLabel(
  AppLocalizations l10n,
  SubscriptionService? service,
) {
  if (service?.promotionalTrial != true) return null;
  final left = service!.trialRemaining;
  if (left <= Duration.zero) return null;
  int rounded(Duration unit) =>
      1 + (left.inMicroseconds - 1) ~/ unit.inMicroseconds;
  return left > const Duration(days: 1)
      ? l10n.planTrialDaysLeft(rounded(const Duration(days: 1)))
      : l10n.planTrialHoursLeft(rounded(const Duration(hours: 1)));
}

/// Plan simgesi: ana sayfa ve Ayarlar'da aynı görünür, dokununca plan sayfası açılır.
class PlanBadge extends StatelessWidget {
  const PlanBadge({
    super.key,
    required this.badgeKey,
    required this.label,
    required this.trial,
    required this.active,
    required this.onPressed,
    this.remaining,
  });

  final Key badgeKey;
  final String label;
  final bool trial;
  final bool active;
  final VoidCallback onPressed;
  final String? remaining;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final display = remaining == null ? label : '$label · $remaining';
    final tip = '$display · ${AppLocalizations.of(context).tipPlan}';
    final iconOnly = MediaQuery.textScalerOf(context).scale(14) > 18;
    return Tooltip(
      key: badgeKey,
      message: tip,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 48,
          maxWidth: MediaQuery.sizeOf(context).width * .48,
        ),
        child: InkWell(
          onTap: onPressed,
          customBorder: const StadiumBorder(),
          child: SizedBox(
            height: 48,
            child: Center(
              widthFactor: 1,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: active
                      ? scheme.primaryContainer.withValues(alpha: 0.7)
                      : scheme.surfaceContainerHighest.withValues(alpha: 0.7),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: iconOnly ? 8 : 10,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trial ? Icons.hourglass_top : Icons.workspace_premium,
                        size: 14,
                        color: active
                            ? scheme.primary
                            : scheme.onSurfaceVariant,
                      ),
                      if (!iconOnly) ...[
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            display,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
