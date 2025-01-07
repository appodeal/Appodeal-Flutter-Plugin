/// Enum representing the type of Appodeal purchases, with associated integer values.
enum AppodealPurchaseType {
  /// Consumable purchase.
  consumable(0),

  /// Non-consumable purchase.
  nonConsumable(1),

  /// Auto-renewable subscription.
  autoRenewableSubscription(2),

  /// Non-renewing subscription.
  nonRenewingSubscription(3),

  /// In-app purchase for Play Store.
  inapp(0),

  /// Subscription purchase for Play Store.
  subscription(1);

  /// Integer value associated with the purchase type.
  final int value;

  const AppodealPurchaseType(this.value);
}

/// Abstract class representing a purchase for Appodeal.
abstract class AppodealPurchase {
  /// Converts the purchase details into a `Map` for serialization.
  Map<String, dynamic> get toMap;
}

/// Represents an App Store purchase for Appodeal.
class AppodealAppStorePurchase extends AppodealPurchase {
  /// Type of the purchase.
  final AppodealPurchaseType type;

  /// Unique identifier for the purchase order.
  final String orderId;

  /// Price of the purchase.
  final String price;

  /// Currency of the purchase (e.g., USD, EUR).
  final String currency;

  /// Unique transaction identifier.
  final String transactionId;

  /// Additional parameters for the purchase.
  final Map<String, String> additionalParameters;

  /// Constructor for consumable purchases.
  AppodealAppStorePurchase.consumable({
    required this.orderId,
    required this.price,
    required this.currency,
    required this.transactionId,
    this.additionalParameters = const {},
  }) : type = AppodealPurchaseType.consumable;

  /// Constructor for non-consumable purchases.
  AppodealAppStorePurchase.nonConsumable({
    required this.orderId,
    required this.price,
    required this.currency,
    required this.transactionId,
    this.additionalParameters = const {},
  }) : type = AppodealPurchaseType.nonConsumable;

  /// Constructor for auto-renewable subscriptions.
  AppodealAppStorePurchase.autoRenewableSubscription({
    required this.orderId,
    required this.price,
    required this.currency,
    required this.transactionId,
    this.additionalParameters = const {},
  }) : type = AppodealPurchaseType.autoRenewableSubscription;

  /// Constructor for non-renewing subscriptions.
  AppodealAppStorePurchase.nonRenewingSubscription({
    required this.orderId,
    required this.price,
    required this.currency,
    required this.transactionId,
    this.additionalParameters = const {},
  }) : type = AppodealPurchaseType.nonRenewingSubscription;

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        "type": type.value,
        "orderId": orderId,
        "price": price,
        "currency": currency,
        "transactionId": transactionId,
        "additionalParameters": additionalParameters,
      };
}

/// Represents a Play Store purchase for Appodeal.
class AppodealPlayStorePurchase extends AppodealPurchase {
  /// Type of the purchase.
  final AppodealPurchaseType type;

  /// Unique identifier for the purchase order.
  final String orderId;

  /// Price of the purchase.
  final String price;

  /// Currency of the purchase (e.g., USD, EUR).
  final String currency;

  /// Public key for verifying the purchase.
  final String? publicKey;

  /// Signature for verifying the purchase.
  final String? signature;

  /// Data associated with the purchase.
  final String? purchaseData;

  /// Developer-specific payload.
  final String? developerPayload;

  /// Stock keeping unit (SKU) of the item.
  final String? sku;

  /// Token for the purchase.
  final String? purchaseToken;

  /// Timestamp of the purchase in milliseconds since epoch.
  final int purchaseTimestamp;

  /// Additional parameters for the purchase.
  final Map<String, String> additionalParameters;

  /// Constructor for in-app purchases.
  AppodealPlayStorePurchase.inapp({
    required this.orderId,
    required this.price,
    required this.currency,
    this.publicKey,
    this.signature,
    this.purchaseData,
    this.developerPayload,
    this.sku,
    this.purchaseToken,
    this.purchaseTimestamp = 0,
    this.additionalParameters = const {},
  }) : type = AppodealPurchaseType.inapp;

  /// Constructor for subscription purchases.
  AppodealPlayStorePurchase.subscription({
    required this.orderId,
    required this.price,
    required this.currency,
    this.publicKey,
    this.signature,
    this.purchaseData,
    this.developerPayload,
    this.sku,
    this.purchaseToken,
    this.purchaseTimestamp = 0,
    this.additionalParameters = const {},
  }) : type = AppodealPurchaseType.subscription;

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        "type": type.value,
        "orderId": orderId,
        "price": price,
        "currency": currency,
        "publicKey": publicKey,
        "signature": signature,
        "purchaseData": purchaseData,
        "developerPayload": developerPayload,
        "sku": sku,
        "purchaseToken": purchaseToken,
        "purchaseTimestamp": purchaseTimestamp,
        "additionalParameters": additionalParameters,
      };
}
