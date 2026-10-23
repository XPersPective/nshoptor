import 'dart:convert';

import 'package:napp_core/napp_core.dart';

/// Optional native review prompts after a completed shopping journey.
/// No custom rating dialog, reward, shopping interruption or positive-score gate.
class ReviewMoments {
  ReviewMoments({required this.store, DateTime Function()? now,
    Future<bool> Function(RatePromptPolicy, DateTime)? request})
    : _now = now ?? DateTime.now,
      _request = request ?? ReviewService().maybePromptInApp {
    final today = _now();
    DateTime? stamp(Object? value) {
      if (value is! int || value < 0 || value > 8640000000000000) return null;
      final date = DateTime.fromMillisecondsSinceEpoch(value);
      return date.isAfter(today) ? null : date;
    }
    final first = stamp(store.getInt(_firstKey));
    final prompted = <DateTime>[];
    try {
      final raw = jsonDecode(store.getString(_promptsKey) ?? '[]');
      if (raw is List && raw.length <= 16) {
        for (final item in raw) {
          final date = stamp(item);
          if (date != null) prompted.add(date);
        }
      }
    } on FormatException { /* A damaged preference must not block shopping. */ }
    _policy.restore(firstSeen: first,
      promptedAt: prompted, positiveMoments: (store.getInt(_momentsKey) ?? 0).clamp(0, 1000000));
    _policy.markFirstSeen(today);
    _persist();
  }

  static ReviewMoments? instance;
  static const _firstKey = 'review.first_seen';
  static const _promptsKey = 'review.prompts';
  static const _momentsKey = 'review.completed_shoppings';
  static const _manualKey = 'review.manual_request';
  final SettingsStore store;
  final DateTime Function() _now;
  final Future<bool> Function(RatePromptPolicy, DateTime) _request;
  final _policy = RatePromptPolicy(minPositiveMoments: 3);
  bool _busy = false;

  /// Opening the explicit rating action is enough intent to stop reminders.
  /// It does not claim that a rating was actually submitted.
  void manualRequest() => store.setBool(_manualKey, true);

  /// Returns true when a native prompt was attempted, so callers avoid stacking
  /// a full-screen advertisement on the same completed-shopping moment.
  Future<bool> afterShopping() async {
    if (_busy) return true;
    _policy.markPositiveMoment();
    _persist();
    if (store.getBool(_manualKey) == true) return false;
    _busy = true;
    final before = _policy.snapshot().promptedAt.length;
    try {
      await _request(_policy, _now());
    } catch (_) {
      // A store without review support never blocks the completed journey.
    } finally {
      _busy = false;
      _persist();
    }
    return _policy.snapshot().promptedAt.length > before;
  }

  void _persist() {
    final state = _policy.snapshot();
    store.setInt(_firstKey, state.firstSeen!.millisecondsSinceEpoch);
    store.setInt(_momentsKey, state.positiveMoments);
    store.setString(_promptsKey, jsonEncode([
      for (final date in state.promptedAt)
        if (date.isAfter(_now().subtract(const Duration(days: 365)))) date.millisecondsSinceEpoch,
    ]));
  }
}
