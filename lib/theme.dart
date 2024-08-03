import 'package:flutter/material.dart';

class AppColorPalette {
  final Color main;
  final Color onMain;
  final Color background;
  final Color secondary;
  final Color terniary;
  final Color text;
  // final Color button;
  final Color buttonText;

  const AppColorPalette._({
    required this.main,
    required this.onMain,
    required this.background,
    required this.secondary,
    required this.terniary,
    required this.text,
    // required this.button,
    required this.buttonText,
  });

  static const light = AppColorPalette._(
    main: Colors.green,
    onMain: Colors.white,
    background: Colors.white,
    // secondary: Color.fromARGB(255, 32, 32, 32), //blackish
    secondary: Colors.black,
    terniary: Colors.grey,

    text: Colors.black87,
    // button: Colors.green,
    buttonText: Colors.white,
  );

  static const dark = AppColorPalette._(
    main: Colors.green,
    onMain: Colors.white,
    background: Color.fromARGB(255, 33, 33, 34),
    // secondary: Color.fromARGB(255, 228, 228, 228), //whitish
    secondary: Colors.white,
    terniary: Colors.white,
    text: Colors.white,
    // button: Colors.green,
    buttonText: Colors.white,
  );

  static AppColorPalette of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? light : dark;
  }
}

ThemeData lightTheme() {
  AppColorPalette palette = AppColorPalette.light;

  return ThemeData(
    colorScheme: ColorScheme.light(
      background: palette.background,
      primary: palette.main,
      surfaceTint: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.background,
      titleSpacing: 20,
    ),
    // iconTheme: const IconThemeData(
    //   applyTextScaling: true,
    // ),

    // splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: palette.secondary,
      unselectedItemColor: palette.secondary.withOpacity(0.8),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: palette.background,
      constraints: const BoxConstraints(maxWidth: 500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    dividerTheme: DividerThemeData(
      color: palette.secondary.withOpacity(0.08),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: palette.text,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.main,
        foregroundColor: palette.onMain,
      ),
    ),
  );
}

ThemeData darkTheme() {
  AppColorPalette palette = AppColorPalette.dark;

  return ThemeData(
    colorScheme: ColorScheme.dark(
      background: palette.background,
      primary: palette.main,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.background,
      titleSpacing: 20,
    ),
    // iconTheme: const IconThemeData(
    //   applyTextScaling: true,
    // ),
    splashColor: Colors.transparent,

    // highlightColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: palette.secondary,
      unselectedItemColor: palette.secondary.withOpacity(0.8),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: palette.background,
      constraints: const BoxConstraints(maxWidth: 500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    dividerTheme: DividerThemeData(
      color: palette.secondary.withOpacity(0.08),
    ),

    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: palette.text,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.main,
        foregroundColor: palette.onMain,
      ),
    ),
  );
}
