import 'package:flutter/material.dart';

import 'colors.dart';

class ColorConstant {
  ColorConstant._();

  static Color light1 = hexToColor("#EFF2F9");
  static const Color light2 = Color(0xFFF0F7FF);

  // Neutral
  static Color neutral50 = hexToColor("#F5F6F9");
  static const Color neutral100 = Color(0xFFE6E9F0);
  static Color neutral200 = hexToColor("#e5e5e5");
  static Color neutral300 = hexToColor("#D7DBE6");
  static Color neutral400 = hexToColor("#BAC1D4");
  static const Color neutral500 = Color(0xFF9CA6C1);
  static Color neutral600 = hexToColor("#818EB0");
  static Color neutral700 = hexToColor("#546286");
  static const Color neutral800 = Color(0xFF323B50);
  static Color neutral900 = hexToColor("#11141B");

  // Primary
  static Color primary50 = hexToColor("#F2F8FF");
  static Color primary100 = hexToColor("#CCE4FF");
  static Color primary200 = hexToColor("#A6D0FF");
  static Color primary300 = hexToColor("#80BDFF");
  static Color primary400 = hexToColor("#59a9ff");
  static Color primary500 = hexToColor("#007AFF");
  static Color primary600 = hexToColor("#005FC6");
  static Color primary700 = hexToColor("#00448E");
  static Color primary800 = hexToColor("#130E62");
  static Color primary900 = hexToColor("#000E1C");

  // Success
  static Color success50 = hexToColor("#F0FDF4");
  static Color success100 = hexToColor("#DCFCE7");
  static Color success200 = hexToColor("#BBF7D0");
  static Color success300 = hexToColor("#86EFAC");
  static Color success400 = hexToColor("#4ADE80");
  static Color success500 = hexToColor("#22C55E");
  static Color success600 = hexToColor("#16A34A");
  static Color success700 = hexToColor("#15803D");
  static Color success800 = hexToColor("#166534");
  static Color success900 = hexToColor("#14532D");

  // Warning
  static Color warning50 = hexToColor("#FFFBEB");
  static Color warning100 = hexToColor("#FEF3C7"); //use
  static Color warning200 = hexToColor("#FDE68A");
  static Color warning300 = hexToColor("#FCD34D"); //use
  static Color warning400 = hexToColor("#FBBF24");
  static Color warning500 = hexToColor("#F59E0B"); //use
  static Color warning600 = hexToColor("#D97706"); //use
  static Color warning700 = hexToColor("#B45309");
  static Color warning800 = hexToColor("#92400E");
  static Color warning900 = hexToColor("#78350F");

  // Destructive
  static Color destructive50 = hexToColor("#FEF2F2");
  static Color destructive100 = hexToColor("#FEE2E2");
  static Color destructive200 = hexToColor("#FECACA");
  static Color destructive300 = hexToColor("#FCA5A5");
  static const Color destructive400 = Color(0xFFF87171);
  static Color destructive500 = hexToColor("#EF4444");
  static Color destructive600 = hexToColor("#DC2626");
  static Color destructive700 = hexToColor("#B91C1C");
  static Color destructive800 = hexToColor("#7F1D1D");
  static Color destructive900 = hexToColor("#7F1D1D");

  // Shades
  static const Color shade00 = Color(0xFFFFFFFF);
  static Color shade100 = hexToColor("#000000");
  static Color transparent = Colors.transparent;

  static Color chatSurface = hexToColor("#FFFFFF");
  static Color tabSurface = hexToColor("#11141B");
  static Color previewBg = hexToColor("#11141B");
  static Color introBg = hexToColor("#000E1C").withOpacity(0.5);
  static const Color shadowColor = Color(0x19101828);
//semantics
}
