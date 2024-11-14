// bottom_navigation_bar_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_model.dart';
import 'package:flutter_sabzi/pages/home/home_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum BottomNavs {
  home,
  search,
  chat,
  profile;

  BottomNavigationModel get info {
    switch (this) {
      case BottomNavs.home:
        return BottomNavigationModel(
          // page: Container(color: Colors.orange, height: double.infinity, width: double.infinity),
          page: const HomePage(),
          label: 'Home',
          icon: PhosphorIcons.house(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
        );
      case BottomNavs.search:
        return BottomNavigationModel(
          page: Container(color: Colors.pink, height: double.infinity, width: double.infinity),
          label: 'Search',
          icon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
        );
      case BottomNavs.chat:
        return BottomNavigationModel(
          page: Container(color: Colors.purple, height: double.infinity, width: double.infinity),
          label: 'Chat',
          icon: PhosphorIcons.chatsCircle(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.chatsCircle(PhosphorIconsStyle.fill),
        );
      case BottomNavs.profile:
        return BottomNavigationModel(
          page: Container(color: Colors.blueAccent, height: double.infinity, width: double.infinity),
          label: 'Profile',
          icon: PhosphorIcons.user(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.user(PhosphorIconsStyle.fill),
        );
    }
  }
}

class BottomNavigationProvider extends ChangeNotifier {
  BottomNavs _currentPage = BottomNavs.home;
  final PageController pageController = PageController();

  BottomNavs get currentPage => _currentPage;

  void setPage(BottomNavs navItem) {
    if (_currentPage == navItem) return;

    _currentPage = navItem;
    // pageController.animateToPage(
    //   page.index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
    pageController.jumpToPage(navItem.index);
    notifyListeners();
  }

  void onPageChanged(int index) {
    _currentPage = BottomNavs.values[index];
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
