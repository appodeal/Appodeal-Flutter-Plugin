class AppodealPurchase {
  final String type;
  final String price;
  final String currency;
  String? publicKey;
  String? signature;
  String? purchaseData;
  String? developerPayload;
  String? sku;
  String? orderId;
  String? purchaseToken;
  int purchaseTimestamp = 0;
  Map<String, String> additionalParameters = {};

  AppodealPurchase.InApp({required this.price, required this.currency})
      : type = "InApp";

  AppodealPurchase.Subs({required this.price, required this.currency})
      : type = "Subs";

  AppodealPurchase({
    required this.type,
    required this.price,
    required this.currency,
    this.publicKey,
    this.signature,
    this.purchaseData,
    this.developerPayload,
    this.sku,
    this.orderId,
    this.purchaseToken,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
        "type": type,
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

// var appodealPurchase = AppodealPurchase.Subs(", ")
//   ..publicKey = ""
//   ..signature = ""
//   ..purchaseData = ""
//   ..developerPayload = ""
//   ..sku = ""
//   ..orderId = ""
//   ..purchaseToken = ""
//   ..additionalParameters = {};
