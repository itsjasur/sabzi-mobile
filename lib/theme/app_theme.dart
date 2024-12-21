import 'package:flutter/material.dart';

const AppBarTheme _appBarTheme = AppBarTheme(scrolledUnderElevation: 0);
final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  dragHandleSize: const Size(40, 3),
  surfaceTintColor: Colors.transparent,
);

final DialogTheme dialogTheme = DialogTheme(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
);

// final RadioThemeData _radioThemeData = RadioThemeData(
//   fillColor: WidgetStatePropertyAll(Colors.red),
//   visualDensity: VisualDensity.compact,
// );

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  applyElevationOverlayColor: true,
  dialogTheme: dialogTheme,
  bottomSheetTheme: _bottomSheetTheme,
  appBarTheme: _appBarTheme,
  colorScheme: ColorScheme.light(
    surface: Colors.white, //appbar background, scaffold background etc...
    primary: Colors.orange,
    onPrimary: Colors.white,
    secondary: Colors.grey,
    tertiary: Colors.grey.shade200,
  ),
);
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  applyElevationOverlayColor: true,
  dialogTheme: dialogTheme,
  appBarTheme: _appBarTheme,
  bottomSheetTheme: _bottomSheetTheme,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, //appbar background, scaffold background etc...
    primary: Colors.orange,
    onPrimary: Colors.white,
    secondary: Colors.white,
    tertiary: Colors.grey.shade800,
  ),
);
