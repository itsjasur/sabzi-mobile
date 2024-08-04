import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/pages/item.dart';
import 'package:sabzi_mobile/pages/wrapper/wrapper.dart';
import 'package:sabzi_mobile/providers/bottom_navigation_provider.dart';
import 'package:sabzi_mobile/providers/home_action_button_provider.dart';
import 'package:sabzi_mobile/providers/neighborhood_provider.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';
import 'package:sabzi_mobile/providers/theme_provider.dart';
import 'package:sabzi_mobile/theme.dart';
import 'package:sabzi_mobile/yandextest.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // await AndroidYandexMap.init();
  // AndroidYandexMap.register(apiKey: "YOUR_API_KEY");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OverlayProvider()),
        ChangeNotifierProvider(create: (_) => HomeActionButtonProvider(Provider.of<OverlayProvider>(_, listen: false))),
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
        themeMode: themeProvider.themeMode,
        // home: const Wrapper(),
        home: const ItemPage(itemId: 1),
        // home: YandexMapTest(),
      ),
    );
  }
}
