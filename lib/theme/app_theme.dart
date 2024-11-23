import 'package:flutter/material.dart';

const AppBarTheme _appBarTheme = AppBarTheme(scrolledUnderElevation: 0);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  applyElevationOverlayColor: true,
  appBarTheme: _appBarTheme,
  colorScheme: ColorScheme.light(
    surface: Colors.white, //appbar background, scaffold background etc...
    primary: Colors.orange,
    onPrimary: Colors.white,
    secondary: Colors.grey,
    tertiary: Colors.grey.shade200,

    // surfaceTint: Colors.transparent,
  ),
);
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  appBarTheme: _appBarTheme,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, //appbar background, scaffold background etc...
    primary: Colors.orange,
    onPrimary: Colors.white,
    secondary: Colors.white,
    tertiary: Colors.white24,
  ),
);
