import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#f5f5f5');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color grey = HexColor.fromHex('#737477');
  static Color lightGrey = HexColor.fromHex('#9e9e9e');

  //new colours
  static Color grey1 = HexColor.fromHex('#707070');
  static Color error = HexColor.fromHex('#e61f34');
  static Color black = HexColor.fromHex('#000000');
  static Color secondary = HexColor.fromHex('#00659F');
  static Color sky = HexColor.fromHex('#f2f1f6');
}

extension HexColor on Color {
  static Color fromHex(String hexcolorString) {
    hexcolorString = hexcolorString.replaceAll('#', '');
    if (hexcolorString.length == 6) {
      hexcolorString = 'FF' + hexcolorString;
    }
    return Color(int.parse(hexcolorString, radix: 16));
  }
}
