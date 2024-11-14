// app.dart

import 'package:flutter/material.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_widget.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

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
