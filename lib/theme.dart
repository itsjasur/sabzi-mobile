import 'package:flutter/material.dart';

class AppColorPalette {
  final Color main;
  final Color onMain;
  final Color surface;
  final Color secondary;
  final Color terniary;
  final Color text;
  final Color buttonText;

  const AppColorPalette({
    required this.main,
    required this.onMain,
    required this.surface,
    required this.secondary,
    required this.terniary,
    required this.text,
    required this.buttonText,
  });

  static const light = AppColorPalette(
    main: Colors.green,
    onMain: Colors.white,
    surface: Colors.white,
    secondary: Colors.black,
    terniary: Colors.grey,
    text: Colors.black87,
    buttonText: Colors.white,
  );

  static const dark = AppColorPalette(
    main: Colors.green,
    onMain: Colors.white,
    surface: Color.fromARGB(255, 33, 33, 34),
    secondary: Colors.white,
    terniary: Colors.white,
    text: Colors.white,
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
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      surface: palette.surface,
      primary: palette.main,
      surfaceTint: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.surface,
      titleSpacing: 20,
    ),
    // iconTheme: const IconThemeData(
    //   applyTextScaling: true,
    // ),

    // highlightColor: palette.secondary.withOpacity(0.1),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: palette.surface,
      constraints: const BoxConstraints(maxWidth: 500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    dividerTheme: DividerThemeData(
      color: palette.secondary.withOpacity(0.08),
      thickness: 1,
    ),

    textTheme: TextTheme(
      bodyMedium: TextStyle(color: palette.text, fontSize: 14),
      // bodySmall: TextStyle(fontSize: 7),
      // displayMedium: TextStyle(fontSize: 4),
      // displaySmall: TextStyle(fontSize: 4),
      // labelMedium: TextStyle(fontSize: 4),
      // titleMedium: TextStyle(fontSize: 4),
      // headlineMedium: TextStyle(fontSize: 4),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.main,
        foregroundColor: palette.onMain,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),

    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      actionsPadding: const EdgeInsets.all(10),
    ),
  );
}

ThemeData darkTheme() {
  AppColorPalette palette = AppColorPalette.dark;

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      surface: palette.surface,
      primary: palette.main,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.surface,
      titleSpacing: 20,
    ),
    // iconTheme: const IconThemeData(
    //   applyTextScaling: true,
    // ),

    // highlightColor: palette.secondary.withOpacity(0.5),

    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: palette.surface,
      constraints: const BoxConstraints(maxWidth: 500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    dividerTheme: DividerThemeData(
      color: palette.secondary.withOpacity(0.08),
      thickness: 1,
    ),

    textTheme: TextTheme(
      bodyMedium: TextStyle(color: palette.text, fontSize: 14),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.main,
        foregroundColor: palette.onMain,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),

    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      actionsPadding: const EdgeInsets.all(10),
    ),
  );
}
