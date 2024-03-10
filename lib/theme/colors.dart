import 'package:flutter/material.dart';

class MyColors {
  static const Color mainColor = Color(0xFFD11F2F);
  static const Color scaffoldColor = Color(0xFFF5EEE6);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color redColor = Color(0xFFA52D01);
  static const Color redBottomNavBarColor = Color(0xFFAD01F30);
  static const Color gray = Color(0xFFF8F8F8);
  static const Color green = Color(0xFF23CB15);
  static const Color black = Color(0xFF1D1D25);

  static const MaterialColor mainColorSwatch = MaterialColor(
    _colorswatchPrimaryValue,
    <int, Color>{
      50: Color(0xFFD11F2F),
      100: Color(0xFFD11F2F),
      200: Color(0xFFD11F2F),
      300: Color(0xFFD11F2F),
      400: Color(0xFFD11F2F),
      500: Color(_colorswatchPrimaryValue),
      600: Color(0xFFD11F2F),
      700: Color(0xFFD11F2F),
      800: Color(0xFFD11F2F),
      900: Color(0xFFD11F2F),
    },
  );

  static const int _colorswatchPrimaryValue = 0xFFD11F2F;
}
