import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';

// navigation notifier
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(NavigationState(currentPage: BottomNavs.home, pageController: PageController()));

  void setPage(BottomNavs navItem) {
    if (state.currentPage == navItem) return;

    state.pageController.jumpToPage(navItem.index);
    state = state.copyWith(currentPage: navItem);
  }

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: BottomNavs.values[index]);
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) => NavigationNotifier());
