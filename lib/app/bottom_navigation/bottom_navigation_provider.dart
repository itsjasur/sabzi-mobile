import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';

class BottomNavigationNotifier extends Notifier<NavigationState> {
  @override
  NavigationState build() {
    final pageController = PageController();

    // Register cleanup for PageController
    ref.onDispose(() {
      pageController.dispose();
    });

    return NavigationState(currentPage: BottomNavs.home, pageController: pageController);
  }

  void setPage(BottomNavs navItem) {
    if (state.currentPage == navItem) return;

    state.pageController.jumpToPage(navItem.index);
    state = state.copyWith(currentPage: navItem);
  }

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: BottomNavs.values[index]);
  }
}

final navigationProvider = NotifierProvider<BottomNavigationNotifier, NavigationState>(() {
  return BottomNavigationNotifier();
});
