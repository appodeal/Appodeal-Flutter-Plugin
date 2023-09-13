abstract class NativeAd {
  final AdChoicePosition? adChoicePosition;

  NativeAd({this.adChoicePosition});

  Map<String, dynamic> toMap();
}

enum AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }
