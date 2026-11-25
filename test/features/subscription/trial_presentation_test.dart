import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/subscription/plan_badge.dart';
import 'package:nshoptor/features/subscription/subscription_paywall.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

class _NoStore extends SubscriptionService {
  _NoStore(SettingsStore store) : super(store: store);
  @override
  Future<List<SubscriptionOffer>> loadOffers() async => [];
}

Widget app(
  Widget home, {
  String locale = 'tr',
  bool dark = false,
  double scale = 1,
}) => MaterialApp(
  locale: Locale(locale),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  theme: ThemeData(brightness: dark ? Brightness.dark : Brightness.light),
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: home,
);

void main() {
  for (final locale in ['tr', 'en', 'ar']) {
    for (final dark in [false, true]) {
      testWidgets('trial status fits 320dp 2x $locale dark=$dark', (
        tester,
      ) async {
        await tester.binding.setSurfaceSize(const Size(320, 700));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final service = _NoStore(SettingsStore())
          ..initializeTrial(now: () => DateTime.utc(2026, 10, 25));
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpWidget(
            app(
              SubscriptionPaywall(service: service),
              locale: locale,
              dark: dark,
              scale: 2,
            ),
          );
          await tester.pumpAndSettle();
          final context = tester.element(
            find.byKey(const Key('plans_current_status')),
          );
          final l10n = AppLocalizations.of(context);
          expect(find.text(l10n.planTrialDaysLeft(7)), findsOneWidget);
          expect(find.textContaining(l10n.planLegacyRights), findsNothing);
          expect(tester.takeException(), isNull);
          await tester.pumpWidget(
            app(
              Scaffold(
                appBar: AppBar(
                  actions: [
                    PlanBadge(
                      badgeKey: const Key('badge'),
                      label: 'Pro',
                      trial: true,
                      active: true,
                      remaining: l10n.planTrialDaysLeft(7),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              locale: locale,
              dark: dark,
              scale: 2,
            ),
          );
          await tester.pumpAndSettle();
          expect(
            find.byTooltip(
              'Pro · ${l10n.planTrialDaysLeft(7)} · ${l10n.tipPlan}',
            ),
            findsOneWidget,
          );
          expect(tester.takeException(), isNull);
          await tester.pumpWidget(const SizedBox.shrink());
        } finally {
          service.dispose();
          semantics.dispose();
        }
      });
    }
  }

  testWidgets(
    'expiry can continue with Free once without changing shopping data',
    (tester) async {
      final store = SettingsStore()
        ..setInt(
          'first_open_at',
          DateTime.utc(2026, 10, 1).millisecondsSinceEpoch,
        );
      final service = _NoStore(store)
        ..initializeTrial(now: () => DateTime.utc(2026, 10, 9));
      final db = AppDatabase(NativeDatabase.memory());
      final repository = ListRepository(db);
      await repository.createList(title: 'Preserved list', currencyCode: 'TRY');
      await tester.pumpWidget(
        app(
          HomeShell(db: db, listRepository: repository, subscriptions: service),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('trial_continue_free')), findsOneWidget);
      await tester.tap(find.byKey(const Key('trial_continue_free')));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(service.tier, Tier.free);
      expect(
        (await db.select(db.shoppingLists).get())
            .single
            .title,
        'Preserved list',
      );
      await tester.pumpWidget(const SizedBox.shrink());
      service.dispose();
      final reloaded = _NoStore(store)
        ..initializeTrial(now: () => DateTime.utc(2026, 10, 9));
      await tester.pumpWidget(
        app(
          HomeShell(
            db: db,
            listRepository: repository,
            subscriptions: reloaded,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('trial_continue_free')), findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
      reloaded.dispose();
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    },
  );
}
