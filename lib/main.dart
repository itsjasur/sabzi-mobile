import 'package:flutter/material.dart';

import 'package:flutter_sabzi/app/app.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_provider.dart';
import 'package:flutter_sabzi/core/providers/theme_provider.dart';
import 'package:flutter_sabzi/core/themes.dart';
import 'package:flutter_sabzi/pages/home/home_page_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.themeMode,
        theme: lightMode,
        darkTheme: darkMode,
        home: const App(),
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     ThemeMode mode = Provider.of<ThemeProvider>(context, listen: true).themeMode;
    
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // themeMode: themeProvider.themeMode,
//       themeMode: mode,
//       theme: lightMode,
//       darkTheme: darkMode,
//       home: const App(),
//     );
//   }
// }
