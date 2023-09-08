class NativeFullOptions {
  final MediaViewPosition mediaViewPosition;

  const NativeFullOptions({
    this.mediaViewPosition = MediaViewPosition.BOTTOM,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
    'mediaViewPosition': mediaViewPosition,
  };
}

enum MediaViewPosition { TOP, BOTTOM, }