import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sabzi_app/models/bottom_nav_item.dart';
import 'package:sabzi_app/pages/chatrooms.dart';
import 'package:sabzi_app/pages/home.dart';
import 'package:sabzi_app/pages/profile.dart';
import 'package:sabzi_app/pages/search.dart';

enum MainBottomNavs {
  home,
  search,
  chat,
  profile;

  NavItem get info {
    switch (this) {
      case MainBottomNavs.home:
        return NavItem(
          page: const HomePage(),
          label: 'Home',
          // icon: UIcons.regularRounded.home,
          icon: PhosphorIcons.house(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
          // activeIcon: UIcons.solidRounded.home,
        );
      case MainBottomNavs.search:
        return NavItem(
          page: const SearchPage(),
          label: 'Search',
          // icon: UIcons.regularRounded.search,
          // activeIcon: UIcons.solidRounded.search,
          icon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
        );
      case MainBottomNavs.chat:
        return NavItem(
          page: const ChatRoomsPage(),
          label: 'Chats',
          // icon: UIcons.regularRounded.comments,
          // activeIcon: UIcons.solidRounded.comments,
          icon: PhosphorIcons.chatsTeardrop(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.chatsTeardrop(PhosphorIconsStyle.fill),
        );
      case MainBottomNavs.profile:
        return NavItem(
          page: const ProfilePage(),
          label: 'Profile',
          // icon: UIcons.regularRounded.user,
          // activeIcon: UIcons.solidRounded.user,
          icon: PhosphorIcons.user(PhosphorIconsStyle.regular),
          activeIcon: PhosphorIcons.user(PhosphorIconsStyle.fill),
        );
    }
  }

  // convenience getters
  String get label => info.label;
  IconData get icon => info.icon;
  IconData get activeIcon => info.activeIcon;
  Widget get page => info.page;

  // gets all NavItems for use in BottomNavigationBar
  static List<NavItem> get items => MainBottomNavs.values.map((nav) => nav.info).toList();

  // gets next and previous nav items (with wrapping)
  MainBottomNavs get next => MainBottomNavs.values[(index + 1) % MainBottomNavs.values.length];
  MainBottomNavs get previous => MainBottomNavs.values[(index - 1 + MainBottomNavs.values.length) % MainBottomNavs.values.length];
}
