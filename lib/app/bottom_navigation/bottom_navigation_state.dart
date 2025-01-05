// nav enum and its extension method
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/pages/home/home_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNavigationModel {
  final Widget page;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  BottomNavigationModel({required this.page, required this.label, required this.icon, required this.activeIcon});
}

//  navigation state
class NavigationState {
  final BottomNavs currentPage;
  final PageController pageController;

  NavigationState({
    required this.currentPage,
    required this.pageController,
  });

  NavigationState copyWith({
    BottomNavs? currentPage,
    PageController? pageController,
  }) {
    return NavigationState(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController ?? this.pageController,
    );
  }
}

enum BottomNavs {
  home,
  search,
  chat,
  profile;

  BottomNavigationModel get info {
    switch (this) {
      case BottomNavs.home:
        return BottomNavigationModel(
          page: const HomePage(),
          label: 'Home',
          icon: PhosphorIcons.house(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
        );
      case BottomNavs.search:
        return BottomNavigationModel(
          page: Container(color: Colors.pink, height: double.infinity, width: double.infinity),
          label: 'Search',
          icon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
        );
      case BottomNavs.chat:
        return BottomNavigationModel(
          page: Container(color: Colors.purple, height: double.infinity, width: double.infinity),
          label: 'Chat',
          icon: PhosphorIcons.chatTeardropDots(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.chatTeardropDots(PhosphorIconsStyle.fill),
        );
      case BottomNavs.profile:
        return BottomNavigationModel(
          page: Container(color: Colors.blueAccent, height: double.infinity, width: double.infinity),
          label: 'Profile',
          icon: PhosphorIcons.user(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.user(PhosphorIconsStyle.fill),
        );
    }
  }
}
