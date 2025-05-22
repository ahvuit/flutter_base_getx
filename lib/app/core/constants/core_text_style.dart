import 'dart:ui';

import 'package:flutter_base_getx/gen/fonts.gen.dart';

class CoreTextStyle {
  static const String fontFamily = FontFamily.sFProDisplay;

  static TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );

  static TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle overLine = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );

  static TextStyle custom(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customWithColor(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }

  static TextStyle customWithDecoration(
      double fontSize, FontWeight fontWeight, TextDecoration decoration) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      decoration: decoration,
    );
  }

  static TextStyle customWithAll(
      double fontSize, FontWeight fontWeight, Color color, TextDecoration decoration) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
      decoration: decoration,
    );
  }
}