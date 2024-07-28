import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white, //background
    primary: Colors.green, //buttons, containers, checkboxes, radios etc...
    // onPrimary: Colors.white,

    secondary: Colors.grey.shade700,
    secondaryContainer: Colors.grey.shade200,

    // primaryContainer: Colors.white, //popups background color
    // secondaryContainer: Colors.grey.shade200,

    // outline: Colors.grey.shade300, //outlined button, textfield outlines
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

    // selectedIconTheme: const IconThemeData(color: Colors.black),
    // selectedLabelStyle: const TextStyle(color: Colors.black),
    // unselectedIconTheme: IconThemeData(color: Colors.black.withOpacity(0.8)),
  ),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 44, 44, 44), //background
    primary: Colors.green, //buttons, containers, checkboxes, radios etc...
    // onPrimary: Colors.white,
    secondary: Colors.white60,

    secondaryContainer: Colors.grey.shade900,

    // onPrimary: Colors.white, // color of items on primary
    // outline: Colors.grey.shade300, //outlined button, textfield outlines
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    backgroundColor: Color.fromARGB(255, 44, 44, 44),
  ),
  iconTheme: const IconThemeData(
    applyTextScaling: true,
  ),
  splashColor: Colors.transparent,
  // highlightColor: Colors.transparent,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
    unselectedIconTheme: IconThemeData(color: Colors.white),
    selectedIconTheme: IconThemeData(color: Colors.white),
  ),
);
