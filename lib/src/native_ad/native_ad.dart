abstract class NativeAd {
  final AdChoicePosition? adChoicePosition;
  NativeAd({this.adChoicePosition  = AdChoicePosition.START_TOP});
}

enum AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }
