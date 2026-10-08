import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import 'subscription_service.dart';

/// Ücretsiz / Pro / Max (PB-055). Fiyatlar mağazadan; dürüst faydalar,
/// geri yükleme, otomatik yenileme ve iptal bilgisi (Play politikası).
class SubscriptionPaywall extends StatefulWidget {
  const SubscriptionPaywall({super.key, required this.service, this.onLifetime});

  final SubscriptionService service;

  /// "Ömür boyu reklamsız" (napp_pro paywall'ı); null ise gizli.
  final VoidCallback? onLifetime;

  @override
  State<SubscriptionPaywall> createState() => _SubscriptionPaywallState();
}

class _SubscriptionPaywallState extends State<SubscriptionPaywall> {
  late Future<List<SubscriptionOffer>> _offers = widget.service.loadOffers();
  bool _yearly = false;

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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.plansTitle)),
      body: FutureBuilder<List<SubscriptionOffer>>(
        future: _offers,
        builder: (context, snap) {
          final offers = snap.data ?? const <SubscriptionOffer>[];
          SubscriptionOffer? find(Tier t) => offers
              .where((o) => o.tier == t && o.yearly == _yearly)
              .firstOrNull;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l10n.plansHeadline, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(l10n.plansSubhead, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
              Center(
                child: SegmentedButton<bool>(
                  key: const Key('plans_period'),
                  segments: [
                    ButtonSegment(value: false, label: Text(l10n.plansMonthly)),
                    ButtonSegment(value: true, label: Text(l10n.plansYearly)),
                  ],
                  selected: {_yearly},
                  onSelectionChanged: (s) => setState(() => _yearly = s.first),
                ),
              ),
              const SizedBox(height: 16),
              _PlanCard(
                key: const Key('plan_free'),
                title: l10n.planFree,
                price: l10n.planFreePrice,
                benefits: [l10n.planFreeAi, l10n.planFreeAds, l10n.planCoreFeatures],
                current: current == Tier.free,
              ),
              _PlanCard(
                key: const Key('plan_pro'),
                title: 'Pro',
                price: find(Tier.pro)?.price,
                period: _yearly ? l10n.plansPerYear : l10n.plansPerMonth,
                trial: find(Tier.pro)?.hasTrial == true ? l10n.planTrial : null,
                benefits: [l10n.planProAi, l10n.planNoAds, l10n.planBackup],
                current: current == Tier.pro,
                highlight: true,
                loading: snap.connectionState != ConnectionState.done,
                onBuy: find(Tier.pro) == null ? null : () => widget.service.buy(find(Tier.pro)!),
              ),
              _PlanCard(
                key: const Key('plan_max'),
                title: 'Max',
                price: find(Tier.max)?.price,
                period: _yearly ? l10n.plansPerYear : l10n.plansPerMonth,
                benefits: [l10n.planMaxAi, l10n.planNoAds, l10n.planBackup, l10n.planMaxFamily],
                current: current == Tier.max,
                loading: snap.connectionState != ConnectionState.done,
                onBuy: find(Tier.max) == null ? null : () => widget.service.buy(find(Tier.max)!),
              ),
              if (snap.connectionState == ConnectionState.done && offers.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(children: [
                    Expanded(child: Text(l10n.plansStoreUnavailable)),
                    TextButton(
                      onPressed: () => setState(() => _offers = widget.service.loadOffers()),
                      child: Text(l10n.retryAction),
                    ),
                  ]),
                ),
              if (widget.service.lastError != null)
                Text(l10n.plansPurchaseFailed, style: TextStyle(color: theme.colorScheme.error)),
              const SizedBox(height: 8),
              if (widget.onLifetime != null)
                ListTile(
                  key: const Key('plan_lifetime'),
                  leading: const Icon(Icons.block_outlined),
                  title: Text(l10n.planLifetimeTitle),
                  subtitle: Text(l10n.planLifetimeSubtitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: widget.onLifetime,
                ),
              TextButton.icon(
                key: const Key('plans_restore'),
                onPressed: widget.service.restore,
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
    this.trial,
    this.highlight = false,
    this.loading = false,
    this.onBuy,
  });

  final String title;
  final String? price;
  final String? period;
  final String? trial;
  final List<String> benefits;
  final bool current;
  final bool highlight;
  final bool loading;
  final VoidCallback? onBuy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      color: highlight ? scheme.primaryContainer : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: current ? BorderSide(color: scheme.primary, width: 2) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                if (current) Chip(label: Text(l10n.planCurrent)),
                if (!current && trial != null) Chip(avatar: const Icon(Icons.card_giftcard, size: 16), label: Text(trial!)),
              ],
            ),
            if (price != null)
              Text('$price${period == null ? '' : ' $period'}', style: theme.textTheme.titleMedium)
            else if (loading)
              const LinearProgressIndicator(),
            const SizedBox(height: 8),
            for (final b in benefits)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(children: [
                  Icon(Icons.check_circle, size: 18, color: scheme.primary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(b)),
                ]),
              ),
            if (onBuy != null && !current) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: onBuy, child: Text(trial != null ? l10n.planStartTrial : l10n.planChoose)),
              ),
            ],
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
    MaterialPageRoute<void>(builder: (_) => SubscriptionPaywall(service: service)),
  );
}
