import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    // surface: Colors.grey.shade200, //appbar background, scaffold background etc...
    surface: Colors.white, //appbar background, scaffold background etc...
    primary: Colors.orange,
    onPrimary: Colors.white,
    secondary: Colors.grey,
    tertiary: Colors.grey.shade200,
  ),
);
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, //appbar background, scaffold background etc...
    primary: Colors.orange,
    secondary: Colors.white,
    tertiary: Colors.white24,
  ),
);
