import 'package:flutter/services.dart';

/// Only the native bridge may construct this snapshot from verified StoreKit
/// current entitlements. The server independently verifies its signed JWS.
class AppleSubscription {
  const AppleSubscription({
    required this.productId,
    required this.signedTransaction,
    required this.expiresAt,
    required this.originalTransactionId,
  });

  final String productId;
  final String signedTransaction;
  final DateTime expiresAt;
  final String originalTransactionId;

  static AppleSubscription? fromNative(Object? value) {
    if (value is! Map ||
        value['verified'] != true ||
        value['revoked'] != false) {
      return null;
    }
    final id = value['productId'];
    final jws = value['signedTransaction'];
    final expires = value['expiresAt'];
    final original = value['originalTransactionId'];
    if (id is! String ||
        jws is! String ||
        expires is! int ||
        original is! String ||
        !RegExp(r'^[0-9]{1,20}$').hasMatch(original) ||
        jws.length > 8192 ||
        expires <= 0 ||
        expires > 8640000000000000 ||
        !RegExp(r'^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$')
            .hasMatch(jws)) {
      return null;
    }
    return AppleSubscription(
      productId: id,
      signedTransaction: jws,
      expiresAt: DateTime.fromMillisecondsSinceEpoch(expires, isUtc: true),
      originalTransactionId: original,
    );
  }
}

class AppleSubscriptionStore {
  const AppleSubscriptionStore();
  static const channel = MethodChannel('nshoptor/apple_subscriptions');

  /// Called only after local verified benefits are delivered. Native code
  /// independently rechecks the exact snapshot and matching purchase lineage.
  Future<void> finishDeliveredTransactions(
    List<AppleSubscription> delivered,
  ) async {
    if (delivered.isEmpty) return;
    await channel.invokeMethod<int>('finishDeliveredTransactions', [
      for (final item in delivered)
        {
          'productId': item.productId,
          'originalTransactionId': item.originalTransactionId,
          'signedTransaction': item.signedTransaction,
        },
    ]);
  }

  /// Exclude automatic introductory prices before presenting a paid plan.
  Future<Set<String>> eligibleAnnualProductIds(Set<String> ids) async {
    final values = await channel.invokeListMethod<String>(
      'eligibleAnnualProducts',
      ids.toList(),
    );
    if (values == null) throw StateError('apple_catalog_unavailable');
    return values.where(ids.contains).toSet();
  }

  /// This never calls AppStore.sync or prompts for authentication. Explicit
  /// restore continues to use the purchase plugin's restore API.
  Future<List<AppleSubscription>> currentEntitlements() async {
    final values = await channel.invokeListMethod<Object?>(
      'currentEntitlements',
    );
    if (values == null) throw StateError('apple_entitlements_unavailable');
    return values.map(AppleSubscription.fromNative).nonNulls.toList();
  }
}
