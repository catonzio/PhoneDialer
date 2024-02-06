import 'package:flutter/material.dart';

const Color yellow = Color(0xFFefc682);
const Color black = Color(0xFF010101);
const Color darkGrey = Color(0xFF1b1b1b);
const Color dividerGrey = Color(0xFF393939);

getLightTheme() {
  ThemeData light = ThemeData.light(useMaterial3: true);
  return light;
}

ThemeData getDarkTheme() {
  ThemeData dark = ThemeData.dark(useMaterial3: true);
  return dark.copyWith(
    colorScheme: dark.colorScheme.copyWith(
      background: black, // Color(0xFF141115), // Color(0xFF1c1c28),
      surface: darkGrey, // Color(0xFF2c2c3c),
      //Color(0xFF87BCDE),
    ),
    dividerTheme: dark.dividerTheme.copyWith(color: dividerGrey, thickness: 1),
    appBarTheme: dark.appBarTheme.copyWith(
      backgroundColor: black, // Color(0xFF2c2c3c),
    ),
  );
}
