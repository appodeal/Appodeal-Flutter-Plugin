abstract class NativeAd {
  final AdChoicePosition? adChoicePosition;

  NativeAd({this.adChoicePosition});
}

enum AdChoicePosition {
  start_top,
  start_bottom,
  end_top,
  end_bottom,
}