import Flutter
import StoreKit

/// The Flutter plugin's historical Transaction.all API is deliberately unused:
/// expired, upgraded and refunded transactions must not grant local benefits.
final class AppleSubscriptionBridge {
  private let channel: FlutterMethodChannel
  private static let productIDs: Set<String> = [
    "nshoptor_pro_v2", "nshoptor_max_v2", "nshoptor_pro", "nshoptor_max",
  ]
  private struct Entitlement {
    let transaction: Transaction
    let signedTransaction: String
    let expiresAt: Date
  }

  /// Grace is granted only from a verified status/renewal pair for the same
  /// purchase lineage. Billing retry without a future grace date grants none.
  private static func expiry(for transaction: Transaction) async -> Date? {
    guard transaction.productType == .autoRenewable,
          productIDs.contains(transaction.productID),
          transaction.revocationDate == nil, !transaction.isUpgraded,
          let expiry = transaction.expirationDate else { return nil }
    if expiry > Date() { return expiry }
    guard let groupID = transaction.subscriptionGroupID else { return nil }
    do {
      for status in try await Product.SubscriptionInfo.status(for: groupID) {
        guard status.state == .inGracePeriod,
              case .verified(let current) = status.transaction,
              current.originalID == transaction.originalID,
              current.productID == transaction.productID,
              current.revocationDate == nil, !current.isUpgraded,
              case .verified(let renewal) = status.renewalInfo,
              renewal.originalTransactionID == transaction.originalID,
              renewal.currentProductID == transaction.productID,
              let grace = renewal.gracePeriodExpirationDate,
              grace > Date() else { continue }
        return grace
      }
    } catch { return nil }
    return nil
  }

  private static func current() async -> [Entitlement] {
    var owned: [Entitlement] = []
    var count = 0
    for await verification in Transaction.currentEntitlements {
      count += 1
      // Four recognized products; fail closed on an unexpected huge snapshot.
      if count > 32 { return [] }
      guard case .verified(let transaction) = verification,
            let expiry = await expiry(for: transaction) else { continue }
      owned.append(Entitlement(transaction: transaction,
                               signedTransaction: verification.jwsRepresentation,
                               expiresAt: expiry))
    }
    return owned
  }

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(name: "nshoptor/apple_subscriptions", binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      if call.method == "eligibleAnnualProducts" {
        guard let ids = call.arguments as? [String], ids.count <= 4 else {
          result(FlutterError(code: "invalid_products", message: nil, details: nil))
          return
        }
        Task { @MainActor in
          do {
            let products = try await Product.products(for: ids)
            let eligible = products.filter { product in
              guard product.type == .autoRenewable,
                    let subscription = product.subscription else { return false }
              return subscription.subscriptionPeriod.unit == .year &&
                subscription.subscriptionPeriod.value == 1 &&
                subscription.introductoryOffer == nil
            }.map { $0.id }
            result(eligible)
          } catch {
            result(FlutterError(code: "apple_catalog_unavailable", message: nil, details: nil))
          }
        }
        return
      }
      if call.method == "finishDeliveredTransactions" {
        guard let delivered = call.arguments as? [[String: String]], delivered.count <= 4 else {
          result(FlutterError(code: "invalid_delivered", message: nil, details: nil))
          return
        }
        Task { @MainActor in
          // Reverify current ownership rather than trusting Dart arguments or
          // historical purchases. Exact signed snapshot binds local delivery.
          let current = await Self.current()
          let eligible = current.filter { item in
            delivered.contains { delivered in
              delivered["productId"] == item.transaction.productID &&
              delivered["originalTransactionId"] == String(item.transaction.originalID) &&
              delivered["signedTransaction"] == item.signedTransaction
            }
          }
          var finished = 0
          var scanned = 0
          for await verification in Transaction.unfinished {
            scanned += 1
            if scanned > 256 { break }
            guard case .verified(let transaction) = verification,
                  transaction.productType == .autoRenewable,
                  transaction.revocationDate == nil, !transaction.isUpgraded,
                  eligible.contains(where: { item in
                    item.transaction.originalID == transaction.originalID &&
                    item.transaction.productID == transaction.productID &&
                    item.expiresAt > Date()
                  }) else { continue }
            await transaction.finish()
            finished += 1
          }
          result(finished)
        }
        return
      }
      guard call.method == "currentEntitlements" else {
        result(FlutterMethodNotImplemented)
        return
      }
      Task { @MainActor in
        let current = await Self.current()
        let owned: [[String: Any]] = current.map { item in
          [
            "productId": item.transaction.productID,
            "originalTransactionId": String(item.transaction.originalID),
            "signedTransaction": item.signedTransaction,
            "expiresAt": Int64(item.expiresAt.timeIntervalSince1970 * 1000),
            "verified": true,
            "revoked": false,
          ]
        }
        result(owned)
      }
    }
  }

  func dispose() { channel.setMethodCallHandler(nil) }
}
