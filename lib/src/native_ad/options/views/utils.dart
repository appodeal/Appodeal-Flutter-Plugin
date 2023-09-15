import 'dart:ui';

class Utils {
  static int? convertColorToInt(Color? color) {
    if (color == null) return null;
    final hexColor = color.value.toRadixString(16).toUpperCase();
    return int.parse('0xFF$hexColor', radix: 16);
  }
}