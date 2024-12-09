import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app.dart';
import 'package:flutter_sabzi/core/utils/snackbar_service.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_page.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_page.dart';

import 'package:flutter_sabzi/theme/app_them_provider.dart';
import 'package:flutter_sabzi/theme/app_theme.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as inityandex;

// final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await inityandex.initMapkit(apiKey: '402ef709-b76a-4c64-8e9c-c7e25f4dd4de');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeProvider),
      theme: lightMode,
      darkTheme: darkMode,

      // home: const App(),
      // home: const MyAreaSettingsPage(),
      // home: ScreenPointDemo(),
      // home: const MainTestPage(),
      home: const AddItemPage(),
    );
  }
}
