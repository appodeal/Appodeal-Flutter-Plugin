/// Class representing the content type of the native media view.
///
/// [contentName] The name of the content type.
class NativeMediaViewContentType {
  final String contentName;

  /// Auto content type.
  static const Auto = NativeMediaViewContentType._(contentName: "auto");

  /// NoVideo content type.
  static const NoVideo = NativeMediaViewContentType._(contentName: "static");

  /// Video content type.
  static const Video = NativeMediaViewContentType._(contentName: "video");

  const NativeMediaViewContentType._({required this.contentName});
}
