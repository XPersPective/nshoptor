import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import 'plan_badge.dart';
import 'subscription_service.dart';

/// Ücretsiz / yıllık Pro. Eski Pro/Max hakları korunur. Fiyatlar mağazadan;
/// geri yükleme, otomatik yenileme ve iptal bilgisi (Play politikası).
class SubscriptionPaywall extends StatefulWidget {
  const SubscriptionPaywall({super.key, required this.service});

  final SubscriptionService service;

  @override
  State<SubscriptionPaywall> createState() => _SubscriptionPaywallState();
}

class _SubscriptionPaywallState extends State<SubscriptionPaywall> {
  // Mağaza yanıt vermezse sonsuz yükleme yerine 'şu an mağazada yok' ve yeniden dene.
  late Future<List<SubscriptionOffer>> _offers = _load();

  Future<List<SubscriptionOffer>> _load() =>
      widget.service.loadOffers().timeout(const Duration(seconds: 15));

  @override
  void initState() {
    super.initState();
    widget.service.addListener(_changed);
  }

  @override
  void dispose() {
    widget.service.removeListener(_changed);
    super.dispose();
  }

  void _changed() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final current = widget.service.tier;
    final status = planStatusText(
      l10n,
      label: planLabel(l10n, tier: current, proUnlocked: current != Tier.free),
      trial: current == Tier.pro && widget.service.inTrial(),
    );
    final busy = widget.service.busy;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.plansTitle)),
      body: FutureBuilder<List<SubscriptionOffer>>(
        future: _offers,
        builder: (context, snap) {
          final offers = snap.data ?? const <SubscriptionOffer>[];
          final proOffer = offers
              .where(
                (o) => o.productId == SubscriptionService.proId && o.yearly,
              )
              .firstOrNull;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                key: const Key('plans_current_status'),
                color: theme.colorScheme.primaryContainer,
                child: ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: Text(
                    status,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.plansHeadline,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(l10n.plansSubhead, style: theme.textTheme.bodyMedium),
              if (current != Tier.free)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '${l10n.planLegacyRights}\n${current == Tier.max ? 'Max' : 'Pro'}: ${widget.service.monthlyAllowance}',
                  ),
                ),
              if (busy) const LinearProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                l10n.plansYearly,
                key: const Key('plans_period'),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              _PlanCard(
                key: const Key('plan_free'),
                title: l10n.planFree,
                price: l10n.planFreePrice,
                benefits: [
                  l10n.planFreeAi,
                  l10n.planFreeAds,
                  l10n.planCoreFeatures,
                ],
                current: current == Tier.free,
              ),
              _PlanCard(
                key: const Key('plan_pro'),
                title: 'Pro',
                price: proOffer?.price,
                period: l10n.plansPerYear,
                benefits: [l10n.planProAi, l10n.planNoAds, l10n.planBackup],
                current: false,
                highlight: true,
                loading: snap.connectionState != ConnectionState.done,
                unavailableText: l10n.planUnavailable,
                onBuy: busy || proOffer == null
                    ? null
                    : () => widget.service.buy(proOffer),
              ),
              if (snap.connectionState == ConnectionState.done &&
                  proOffer == null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.plansStoreUnavailable),
                      TextButton(
                        onPressed: () => setState(() => _offers = _load()),
                        child: Text(l10n.retryAction),
                      ),
                    ],
                  ),
                ),
              if (widget.service.lastError != null)
                Text(
                  l10n.plansPurchaseFailed,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              const SizedBox(height: 8),
              TextButton.icon(
                key: const Key('plans_restore'),
                onPressed: busy ? null : widget.service.restore,
                icon: const Icon(Icons.restore),
                label: Text(l10n.plansRestore),
              ),
              const SizedBox(height: 8),
              Text(l10n.plansLegal, style: theme.textTheme.bodySmall),
            ],
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    super.key,
    required this.title,
    required this.benefits,
    required this.current,
    this.price,
    this.period,
    this.highlight = false,
    this.loading = false,
    this.onBuy,
    this.unavailableText,
  });

  final String title;
  final String? price;
  final String? period;
  final List<String> benefits;
  final bool current;
  final bool highlight;
  final bool loading;
  final VoidCallback? onBuy;

  /// Mağazadan fiyat gelmediyse gösterilir (yükleme bitti, teklif yok).
  final String? unavailableText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      color: highlight ? scheme.primaryContainer : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: current
            ? BorderSide(color: scheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 8,
              runSpacing: 8,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (current)
                  _Badge(
                    key: const Key('plan_current_badge'),
                    text: l10n.planCurrent,
                    strong: true,
                  ),
              ],
            ),
            if (price != null)
              Text(
                '$price${period == null ? '' : ' $period'}',
                style: theme.textTheme.titleMedium,
              )
            else if (loading)
              const LinearProgressIndicator()
            else if (unavailableText != null)
              Text(
                unavailableText!,
                key: const Key('plan_unavailable'),
                style: theme.textTheme.bodySmall,
              ),
            const SizedBox(height: 8),
            for (final b in benefits)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 18, color: scheme.primary),
                    const SizedBox(width: 8),
                    Expanded(child: Text(b)),
                  ],
                ),
              ),
            if (onBuy != null && !current) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onBuy,
                  child: Text(l10n.planChoose),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Küçük etiket (Mevcut, deneme): kart başlığını ezmeyen boyutta.
class _Badge extends StatelessWidget {
  const _Badge({super.key, required this.text, this.strong = false});

  final String text;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = strong ? scheme.onPrimary : scheme.onSecondaryContainer;
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: strong ? scheme.primary : scheme.secondaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: fg, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kota mesajlarından planlara geçiş (abonelik servisi bağlı değilse no-op).
Future<void> openPlans(BuildContext context) async {
  final service = SubscriptionService.instance;
  if (service == null) return;
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => SubscriptionPaywall(service: service),
    ),
  );
}
