import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';

/// Home screen welcome card highlighting the genuine 7-day no-card Free Pro trial.
class FreeProPromoCard extends StatelessWidget {
  const FreeProPromoCard({
    super.key,
    required this.onTap,
    required this.onDismiss,
    this.remainingLabel,
  });

  final VoidCallback onTap;
  final VoidCallback onDismiss;
  final String? remainingLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final dark = theme.brightness == Brightness.dark;
    final tintStart = Color.lerp(
      scheme.primaryContainer,
      dark ? scheme.surfaceContainerLow : scheme.surfaceContainerLowest,
      dark ? 0.45 : 0.35,
    )!;
    final tintEnd = Color.lerp(
      scheme.secondaryContainer,
      dark ? scheme.surfaceContainer : scheme.surfaceContainerLow,
      0.5,
    )!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const Key('home_pro_promo_card'),
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [tintStart, tintEnd],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: scheme.primary.withValues(alpha: dark ? 0.42 : 0.32),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (MediaQuery.sizeOf(context).width >= 360 ||
                    MediaQuery.textScalerOf(context).scale(1) < 1.5) ...[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: scheme.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            l10n.homeProPromoTitle,
                            key: const Key('home_pro_promo_title'),
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface,
                            ),
                          ),
                          if (remainingLabel case final left?)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: scheme.primary.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                left,
                                key: const Key('home_pro_promo_remaining'),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        l10n.homeProPromoSubtitle,
                        key: const Key('home_pro_promo_subtitle'),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  key: const Key('home_pro_promo_dismiss'),
                  onPressed: onDismiss,
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: scheme.onSurfaceVariant,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
