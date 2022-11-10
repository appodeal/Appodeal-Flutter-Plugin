import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class AppodealAdRevenue {
  final AppodealAdType adType;
  final String networkName;
  final String demandSource;
  final String adUnitName;
  final String placement;
  final double revenue;
  final String currency;
  final String revenuePrecision;

  AppodealAdRevenue.fromArgs(dynamic arguments)
      : adType = AppodealAdType.byPlatformType(arguments['adType']),
        networkName = arguments['networkName'],
        demandSource = arguments['demandSource'],
        adUnitName = arguments['adUnitName'],
        placement = arguments['placement'],
        revenue = arguments['revenue'],
        currency = arguments['currency'],
        revenuePrecision = arguments['revenuePrecision'];

  Map<String, dynamic> get toMap => <String, dynamic>{
        'adType': adType,
        'networkName': networkName,
        'demandSource': demandSource,
        'adUnitName': adUnitName,
        'placement': placement,
        'revenue': revenue,
        'currency': currency,
        'revenuePrecision': revenuePrecision
      };
}
