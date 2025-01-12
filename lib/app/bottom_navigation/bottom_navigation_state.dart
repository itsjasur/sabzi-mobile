// nav enum and its extension method
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/pages/chat/chat_page.dart';
import 'package:flutter_sabzi/pages/home/home_page.dart';
import 'package:flutter_sabzi/pages/search/search_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNavigationModel {
  final Widget page;
  final IconData icon;
  final IconData activeIcon;
  BottomNavigationModel({required this.page, required this.icon, required this.activeIcon});
}

class BottomNavigationState {
  final BottomNav currentPage;
  final PageController pageController;

  BottomNavigationState({
    required this.currentPage,
    required this.pageController,
  });

  BottomNavigationState copyWith({
    BottomNav? currentPage,
    // PageController? pageController,
  }) {
    return BottomNavigationState(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController,
    );
  }
}

enum BottomNav {
  home,
  search,
  chat,
  profile;

  BottomNavigationModel get info {
    switch (this) {
      case BottomNav.home:
        return BottomNavigationModel(
          page: const HomePage(),
          icon: PhosphorIcons.house(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
        );
      case BottomNav.search:
        return BottomNavigationModel(
          page: const SearchPage(),
          icon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
        );
      case BottomNav.chat:
        return BottomNavigationModel(
          page: const ChatPage(),
          icon: PhosphorIcons.chatTeardropDots(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.chatTeardropDots(PhosphorIconsStyle.fill),
        );
      case BottomNav.profile:
        return BottomNavigationModel(
          page: Container(color: Colors.blueAccent, height: double.infinity, width: double.infinity),
          icon: PhosphorIcons.user(PhosphorIconsStyle.fill),
          activeIcon: PhosphorIcons.user(PhosphorIconsStyle.fill),
        );
    }
  }
}
