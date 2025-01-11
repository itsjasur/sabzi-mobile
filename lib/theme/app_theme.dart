import 'package:flutter/material.dart';

ColorScheme lightColorScheme = ColorScheme.light(
  surface: Colors.white, //appbar background, scaffold background etc...
  primary: Colors.orange.shade700,
  onPrimary: Colors.white,
  secondary: Colors.grey.shade500,
  tertiary: Colors.red,
);

ColorScheme darkColorScheme = ColorScheme.dark(
  surface: Colors.grey.shade900, //appbar background, scaffold background etc...
  primary: Colors.orange.shade700,
  onPrimary: Colors.white,
  secondary: Colors.grey.shade700,
  tertiary: Colors.red,
);

AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );

final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  dragHandleSize: const Size(40, 3),
  surfaceTintColor: Colors.transparent,
);

SnackBarThemeData _sanckbarTheme(ColorScheme colorScheme) => SnackBarThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      behavior: SnackBarBehavior.floating,
      contentTextStyle: TextStyle(
        fontSize: 15,
        color: colorScheme.surface,
      ),
    );

final DialogTheme dialogTheme = DialogTheme(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  // applyElevationOverlayColor: true,
  dialogTheme: dialogTheme,
  snackBarTheme: _sanckbarTheme(lightColorScheme),
  bottomSheetTheme: _bottomSheetTheme,
  appBarTheme: _appBarTheme(lightColorScheme),
  colorScheme: lightColorScheme,
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  // applyElevationOverlayColor: true,
  dialogTheme: dialogTheme,
  snackBarTheme: _sanckbarTheme(darkColorScheme),
  appBarTheme: _appBarTheme(darkColorScheme),
  bottomSheetTheme: _bottomSheetTheme,
  colorScheme: darkColorScheme,
);
