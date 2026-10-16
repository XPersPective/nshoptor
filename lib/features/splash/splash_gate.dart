import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';

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
    return Scaffold(
      key: const Key('splash_screen'),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/brand/icon_1024.png', width: 128, height: 128),
                const SizedBox(height: 20),
                Text(
                  l10n.appTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.slogan,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
