import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData screensStyle = ThemeData(
    primarySwatch: const MaterialColor(
      0x00012030,
      {
        50: Color(0xFFe1e4e6),
        100: Color(0xFFb3bcc1),
        200: Color(0xFF809098),
        300: Color(0xFF4d636e),
        400: Color(0xFF27414f),
        500: Color(0xFF012030),
        600: Color(0xFF011c2b),
        700: Color(0xFF011824),
        800: Color(0xFF01131e),
        900: Color(0xFF000b13),
      },
    ),
    appBarTheme: const AppBarTheme(color: Color(0xFF012030)),
  );

  static const String mapStyle = '';
}
