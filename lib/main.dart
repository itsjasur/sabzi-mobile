import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app.dart';
import 'package:flutter_sabzi/app/auth/signin/signin_page.dart';
import 'package:flutter_sabzi/app/auth/welcome_page.dart';
import 'package:flutter_sabzi/core/widgets/map_view/models.dart';
import 'package:flutter_sabzi/core/widgets/map_view/my_radius_map_view.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_page.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view.dart';
import 'package:flutter_sabzi/pages/home/category/categories_page.dart';
import 'package:flutter_sabzi/pages/radius/my_radius_page.dart';
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

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
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

      home: const App(),
      // home: const MyAreaSettingsPage(),
      // home: const MyRadiusMapView(cordinates: LocationCordinates(latitude: 41.302542, longitude: 69.238718)),
      // home: MyRadiusPage(),
      // home: const MainTestPage(),
      // home: const AddListingPage(),
      // home: const WelcomePage(),
      // home: const SigninPage(isNewUser: true),
      // home: const GalleryView(),
      // home: const CategoriesPage(),
    );
  }
}
