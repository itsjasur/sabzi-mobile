// app.dart

import 'package:flutter/material.dart';
import 'package:flutter_sabzi/app/bottom_navigation_bar_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final PageController _pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavigationProvider, _) => PageView(
          controller: bottomNavigationProvider.pageController,
          onPageChanged: bottomNavigationProvider.onPageChanged,
          children: BottomNavs.values.map((nav) => nav.info.page).toList(),
        ),
      ),
      bottomNavigationBar: const BottomNavView(),
    );
  }
}
