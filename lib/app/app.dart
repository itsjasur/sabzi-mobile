// app.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_widget.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // body: Consumer<BottomNavigationProvider>(
      //   builder: (context, bottomNavigationProvider, _) => PageView(
      //     physics: const NeverScrollableScrollPhysics(),
      //     controller: bottomNavigationProvider.pageController,
      //     onPageChanged: bottomNavigationProvider.onPageChanged,
      //     children: BottomNavs.values.map((nav) => nav.info.page).toList(),
      //   ),
      // ),

      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: ref.watch(navigationProvider).pageController,
        onPageChanged: ref.read(navigationProvider.notifier).onPageChanged,
        children: BottomNavs.values.map((nav) => nav.info.page).toList(),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}
