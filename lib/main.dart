import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_app/pages/chats.dart';
import 'package:sabzi_app/pages/home.dart';
import 'package:sabzi_app/pages/item.dart';
import 'package:sabzi_app/pages/primary.dart';
import 'package:sabzi_app/providers/bottom_navigation_provider.dart';
import 'package:sabzi_app/providers/neighborhood_provider.dart';
import 'package:sabzi_app/providers/theme_provider.dart';
import 'package:sabzi_app/theme.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as inityandex;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('initializing main');
  await inityandex.initMapkit(apiKey: '402ef709-b76a-4c64-8e9c-c7e25f4dd4de');
  print('initializing main finished');

  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => NeighborhoodProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: themeProvider.themeMode,
        // onGenerateRoute: (settings) {
        //   switch (settings.name) {
        //     case '/':
        //       return MaterialPageRoute(builder: (_) => const Primary());
        //     case '/item':
        //       final args = settings.arguments as Map<String, dynamic>;
        //       return MaterialPageRoute(builder: (_) => ItemPage(itemId: args['itemId']));
        //   }
        //   return null;
        // },

        // initialRoute: '/',

        // themeMode: ThemeMode.dark,
        // home: const TestPage(),
        // home: const Main(),
        // home: const ItemPage(itemId: 1),
        // home: const YandexTest(),
        // home: AddItemPage(),
        home: const ChatsPage(),
      ),
    );
  }
}
