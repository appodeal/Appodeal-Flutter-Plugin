import 'dart:ui';

extension ColorToHex on Color {
  String toHex() {
    String hex = this.value.toRadixString(16).toUpperCase();
    return "#${hex.padLeft(8, '0')}"; // Pad with zeros to get the #AARRGGBB format
  }
}
