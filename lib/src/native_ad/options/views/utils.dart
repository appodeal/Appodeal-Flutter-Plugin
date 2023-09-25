import 'dart:ui';

class Utils {
  static int? convertColorToInt(Color? color) {
    if (color == null) return null;
    final hexColor = color.value.toRadixString(16).toUpperCase();
    return int.parse(hexColor, radix: 16);
  }
}
