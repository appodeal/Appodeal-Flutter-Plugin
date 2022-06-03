import 'dart:io';

class AppodealAdType {
  final int android, ios, sios;

  static const NONE = AppodealAdType(android: 0, ios: 0, sios: 0);

  static const BANNER = AppodealAdType(android: 4, ios: 4, sios: 8);
  static const BANNER_BOTTOM = AppodealAdType(android: 8, ios: 4, sios: 8);
  static const BANNER_TOP = AppodealAdType(android: 16, ios: 4, sios: 4);
  static const BANNER_LEFT = AppodealAdType(android: 1024, ios: 4, sios: 64);
  static const BANNER_RIGHT = AppodealAdType(android: 2048, ios: 4, sios: 128);

  static const INTERSTITIAL = AppodealAdType(android: 3, ios: 1, sios: 1);
  static const REWARDED_VIDEO = AppodealAdType(android: 128, ios: 16, sios: 16);
  static const MREC = AppodealAdType(android: 256, ios: 32, sios: 0);
  static const NATIVE = AppodealAdType(android: 512, ios: 8, sios: 0);

  static const ALL = AppodealAdType(android: 4095, ios: 61, sios: 0);

  const AppodealAdType({
    required this.android,
    required this.ios,
    required this.sios,
  });

  int get platformType => Platform.isAndroid ? android : ios;

  int get platformShowType => Platform.isAndroid ? android : sios;
}
