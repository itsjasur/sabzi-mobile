import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';

class BottomNavigationNotifier extends Notifier<NavigationState> {
  @override
  NavigationState build() {
    ref.onDispose(() {});

    return NavigationState(currentPage: BottomNav.search);
  }

  void setPage(BottomNav navItem) {
    if (state.currentPage == navItem) return;
    state = state.copyWith(currentPage: navItem);
  }

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: BottomNav.values[index]);
  }
}

final navigationProvider = NotifierProvider<BottomNavigationNotifier, NavigationState>(() {
  return BottomNavigationNotifier();
});
