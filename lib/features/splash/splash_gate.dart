import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/brand_wordmark.dart';

/// Açılışta uygulama simgesi, adı ve sloganı kısa süre gösterir, sonra [child]
/// açılır. Sloganlar Flutter metniyle çizildiği için her dilde doğru görünür.
/// Süre sıfırsa (testler) doğrudan [child] gösterilir.
class SplashGate extends StatefulWidget {
  const SplashGate({super.key, required this.duration, required this.child});

  final Duration duration;
  final Widget child;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  late bool _visible = widget.duration > Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (_visible) {
      _timer = Timer(widget.duration, () {
        if (mounted) setState(() => _visible = false);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _visible ? const _SplashPage() : widget.child;
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final wordmark = BrandWordmark.style(36);
    // Yerel açılış ekranıyla aynı koyu marka yeşili: siyah/beyaz ara ekran olmaz.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        key: const Key('splash_screen'),
        backgroundColor: AppTheme.splashBackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/brand/icon_1024.png',
                    key: const Key('splash_icon'),
                    width: 120,
                    height: 120,
                    excludeFromSemantics: true,
                  ),
                  const SizedBox(height: 20),
                  Semantics(
                    label: 'NShoptor',
                    excludeSemantics: true,
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: 'N',
                          style: wordmark.copyWith(color: AppTheme.splashAccent),
                        ),
                        TextSpan(
                          text: 'Shoptor',
                          style: wordmark.copyWith(color: Colors.white),
                        ),
                      ]),
                      key: const Key('splash_wordmark'),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.slogan,
                    key: const Key('splash_slogan'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.splashAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
