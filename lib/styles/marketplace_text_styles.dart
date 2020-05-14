import 'package:flutter/material.dart';

class MarketPlaceTextStyles extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String languageCode;
  final String fontFamily;
  final TextDecoration decoration;
  final double height;

  const MarketPlaceTextStyles({
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.size = 14,
    this.languageCode,
    this.fontFamily,
    this.decoration,
    this.height,
  }) : super(
          color: Colors.white,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
          decoration: decoration,
          height: height,
        );

  static TextStyle withLocale({
    Color color,
    FontWeight fontWeight,
    double size,
    String fontFamily,
    String languageCode,
    TextDecoration decoration = TextDecoration.none,
    double height,
  }) {
    return TextStyle(
      height: height,
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      decoration: decoration,
      fontFamily: fontFamily != null
          ? fontFamily
          : languageCode == 'en' ? 'Roboto' : 'Kanit',
    );
  }
}
