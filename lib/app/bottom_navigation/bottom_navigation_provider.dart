import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';

class BottomNavigationNotifier extends Notifier<BottomNavigationState> {
  @override
  BottomNavigationState build() {
    const initialPage = BottomNav.chat;
    final controller = PageController(initialPage: initialPage.index);

    ref.onDispose(() {
      controller.dispose();
    });

    return BottomNavigationState(currentPage: initialPage, pageController: controller);
  }

  void setPage(BottomNav navItem) {
    if (state.currentPage == navItem) return;
    state.pageController.jumpToPage(navItem.index);
    // state.pageController.jumpToPage(navItem.index);
    state = state.copyWith(currentPage: navItem);
  }

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: BottomNav.values[index]);
  }
}

final navigationProvider = NotifierProvider<BottomNavigationNotifier, BottomNavigationState>(() {
  return BottomNavigationNotifier();
});
