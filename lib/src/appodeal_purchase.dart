abstract class AppodealPurchase {
  Map<String, dynamic> get toMap;
}

class AppodealAppStorePurchase extends AppodealPurchase {
  final int _type;
  final String orderId;
  final String price;
  final String currency;
  final String transactionId;
  Map<String, String> additionalParameters = {};

  AppodealAppStorePurchase.consumable(
      {required this.orderId,
      required this.price,
      required this.currency,
      required this.transactionId,
      this.additionalParameters = const {}})
      : _type = 0;

  AppodealAppStorePurchase.nonConsumable(
      {required this.orderId,
      required this.price,
      required this.currency,
      required this.transactionId,
      this.additionalParameters = const {}})
      : _type = 1;

  AppodealAppStorePurchase.autoRenewableSubscription(
      {required this.orderId,
      required this.price,
      required this.currency,
      required this.transactionId,
      this.additionalParameters = const {}})
      : _type = 2;

  AppodealAppStorePurchase.nonRenewingSubscription(
      {required this.orderId,
      required this.price,
      required this.currency,
      required this.transactionId,
      this.additionalParameters = const {}})
      : _type = 3;

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        "type": _type,
        "orderId": orderId,
        "price": price,
        "currency": currency,
        "transactionId": transactionId,
        "additionalParameters": additionalParameters,
      };
}

class AppodealPlayStorePurchase extends AppodealPurchase {
  final int _type;
  final String orderId;
  final String price;
  final String currency;
  String? publicKey;
  String? signature;
  String? purchaseData;
  String? developerPayload;
  String? sku;
  String? purchaseToken;
  String? purchaseTimestamp;
  Map<String, String> additionalParameters = {};

  AppodealPlayStorePurchase.inapp(
      {required this.orderId,
      required this.price,
      required this.currency,
      this.additionalParameters = const {}})
      : _type = 0;

  AppodealPlayStorePurchase.subscription(
      {required this.orderId,
      required this.price,
      required this.currency,
      this.additionalParameters = const {}})
      : _type = 1;

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        "type": _type,
        "price": price,
        "currency": currency,
        "publicKey": publicKey,
        "signature": signature,
        "purchaseData": purchaseData,
        "developerPayload": developerPayload,
        "sku": sku,
        "orderId": orderId,
        "purchaseToken": purchaseToken,
        "purchaseTimestamp": purchaseTimestamp,
        "additionalParameters": additionalParameters,
      };
}
