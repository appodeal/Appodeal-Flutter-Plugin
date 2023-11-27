import 'dart:io';

class AppodealAdType {
  final int android, ios, sios;

  /// Constant for SDK initialization without declaration types.
  /// If you want to run attribution and session metrics before you use ads
  static const None = AppodealAdType._(android: 0, ios: 0, sios: 0);

  /// Rectangular ads that appear at the top/right/bottom/left or view of the device screen.
  static const Banner = AppodealAdType._(android: 4, ios: 4, sios: 8);
  static const BannerBottom = AppodealAdType._(android: 8, ios: 4, sios: 8);
  static const BannerTop = AppodealAdType._(android: 16, ios: 4, sios: 4);
  static const BannerLeft = AppodealAdType._(android: 1024, ios: 4, sios: 64);
  static const BannerRight = AppodealAdType._(android: 2048, ios: 4, sios: 128);

  /// Interstitial ads are full-screen ads that cover the interface of their host app.
  static const Interstitial = AppodealAdType._(android: 3, ios: 1, sios: 1);

  /// Ads that reward users for watching short videos and interacting with playable ads and surveys.
  static const RewardedVideo =
      AppodealAdType._(android: 128, ios: 16, sios: 16);

  /// Rectangular ads (with defined size 300x250 dp) that appear at the view of the device screen.
  static const MREC = AppodealAdType._(android: 256, ios: 32, sios: 0);

  /// Native ad is a flexible type of advertising. You can adapt the display to your UI by preparing a template.
  static const NativeAd = AppodealAdType._(android: 512, ios: 8, sios: 0);

  /// Сonstant for internal SDK usage. We recommend using types separately and consciously.
  static const All = AppodealAdType._(android: 4095, ios: 61, sios: 0);

  const AppodealAdType._({
    required this.android,
    required this.ios,
    required this.sios,
  });

  factory AppodealAdType.byPlatformType(int platformType) {
    if (Interstitial.platformType == platformType) return Interstitial;
    if (RewardedVideo.platformType == platformType) return RewardedVideo;
    if (Banner.platformType == platformType ||
        BannerBottom.platformType == platformType ||
        BannerTop.platformType == platformType ||
        BannerLeft.platformType == platformType ||
        BannerRight.platformType == platformType) return Banner;
    if (MREC.platformType == platformType) return MREC;
    if (NativeAd.platformType == platformType) return NativeAd;
    return None;
  }

  int get platformType => Platform.isAndroid ? android : ios;

  int get platformShowType => Platform.isAndroid ? android : sios;
}
