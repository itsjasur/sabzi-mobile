import 'package:flutter/material.dart';

const AppBarTheme _appBarTheme = AppBarTheme(
  scrolledUnderElevation: 0,
  centerTitle: true,
);
final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  dragHandleSize: const Size(40, 3),
  surfaceTintColor: Colors.transparent,
);

final _sanckbarTheme = SnackBarThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  behavior: SnackBarBehavior.floating,
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
  // applyElevationOverlayColor: true,
  dialogTheme: dialogTheme,
  snackBarTheme: _sanckbarTheme.copyWith(contentTextStyle: const TextStyle(fontSize: 15, color: Colors.white)),
  bottomSheetTheme: _bottomSheetTheme,
  appBarTheme: _appBarTheme,
  colorScheme: ColorScheme.light(
    surface: Colors.white, //appbar background, scaffold background etc...
    primary: Colors.orange,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade500,
    tertiary: Colors.red,
  ),
);
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  // applyElevationOverlayColor: true,
  dialogTheme: dialogTheme,
  snackBarTheme: _sanckbarTheme.copyWith(contentTextStyle: const TextStyle(fontSize: 15, color: Colors.black)),
  appBarTheme: _appBarTheme,
  bottomSheetTheme: _bottomSheetTheme,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, //appbar background, scaffold background etc...
    primary: Colors.orange,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade700,
    tertiary: Colors.red,
  ),
);
