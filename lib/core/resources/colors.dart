import 'dart:ui';

Color hexToColor(String hex) {
  return hex.color;
}

extension ColorExtension on String {
  Color get color {
    return toColor();
  }

  Color toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}