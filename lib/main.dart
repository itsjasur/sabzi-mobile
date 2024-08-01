import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/pages/wrapper/wrapper.dart';
import 'package:sabzi_mobile/providers/bottom_navigation_provider.dart';
import 'package:sabzi_mobile/providers/neighborhood_provider.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';
import 'package:sabzi_mobile/providers/theme_provider.dart';
import 'package:sabzi_mobile/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OverlayProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => NeighborhoodProvider()),
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
        theme: lightTheme(),
        darkTheme: darkTheme(),
        // themeMode: ThemeMode.light,
        themeMode: themeProvider.themeMode,
        home: const Wrapper(),
      ),
    );
  }
}
