import 'package:flutter/material.dart';

class AppTheme {

  static final Color dayStartGradient = HexColor("#32D2F8");
  static final Color dayEndGradient = HexColor("#005ED8");  
  static final Color nightStartGradient = HexColor("#42039D");
  static final Color nightEndGradient = HexColor("#03072D");
  static final Color primaryText = HexColor("#ffffff");
  static final Color secondaryDayText = HexColor("#8DCBF3");
  static final Color secondaryNightText = HexColor("#A299BB");
  static final Color divider = HexColor("#FFD0D0D0");
  static final Color cardNearTransparent = HexColor("#40ffffff");
  static final Color tabBarNearTransparent = HexColor("#66ffffff");
  static final Color darkerText =HexColor("#FF253840");

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}