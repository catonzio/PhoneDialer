import 'package:flutter/material.dart';

getLightTheme() {
  ThemeData light = ThemeData.light(useMaterial3: true);
  return light;
}

ThemeData getDarkTheme() {
  ThemeData dark = ThemeData.dark(useMaterial3: true);
  return dark.copyWith(
      colorScheme: dark.colorScheme.copyWith(
    background: Color(0xFF141115), // Color(0xFF1c1c28),
    surface: Color(0xFF2c2c3c),
    primary: Color(0xFF87BCDE),
  ));
}
