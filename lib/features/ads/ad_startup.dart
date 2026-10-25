import 'dart:async';

/// Consent/SDK work is optional and must never delay an ad-free launch.
class AdStartup {
  AdStartup({
    required this.isAdFree,
    required this.initialize,
    required this.onReady,
    required this.load,
  });
  final bool Function() isAdFree;
  final Future<bool> Function() initialize;
  final void Function() onReady;
  final FutureOr<void> Function() load;
  Future<void>? _pending;

  Future<void> ensureReady() {
    if (isAdFree()) return Future.value();
    return _pending ??= _prepare().whenComplete(() => _pending = null);
  }

  Future<void> _prepare() async {
    try {
      if (!await initialize()) return;
      onReady();
      // Entitlement may have changed while a consent sheet was open.
      if (!isAdFree()) await load();
    } catch (_) {
      // Optional advertising fails closed; shopping remains usable.
    }
  }
}
