import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white, //background
    primary: Colors.green, //buttons, containers, checkboxes, radios etc...
    secondary: Colors.grey.shade700,
    secondaryContainer: Colors.grey.shade200,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleSpacing: 20,
  ),
  iconTheme: const IconThemeData(
    applyTextScaling: true,
  ),
  splashColor: Colors.transparent,
  // highlightColor: Colors.transparent,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black.withOpacity(0.8),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white,
    constraints: const BoxConstraints(maxWidth: 500),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 44, 44, 44), //background
    primary: Colors.green, //buttons, containers, checkboxes, radios etc...
    secondary: Colors.white60,
    secondaryContainer: Colors.grey.shade900,

    // onPrimary: Colors.white, // color of items on primary
    // outline: Colors.grey.shade300, //outlined button, textfield outlines
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 44, 44, 44),
    titleSpacing: 20,
  ),
  iconTheme: const IconThemeData(
    applyTextScaling: true,
  ),
  splashColor: Colors.transparent,
  // highlightColor: Colors.transparent,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.white70,
    unselectedItemColor: Colors.white70,
  ),
);
