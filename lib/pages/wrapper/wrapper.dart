import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/pages/home.dart';
import 'package:sabzi_mobile/pages/search.dart';
import 'package:sabzi_mobile/pages/wrapper/wrapper_appbar.dart';
import 'package:sabzi_mobile/providers/bottom_navigation_provider.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';
import 'package:uicons/uicons.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const HomePage(),
    const HomePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OverlayProvider>(
      builder: (context, overlayProvider, child) {
        return Stack(
          children: [
            Consumer<BottomNavigationProvider>(
              builder: (context, provider, child) => Scaffold(
                appBar: const WrapperAppbar(),
                // body: _pages[provider.currentIndex],
                body: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    provider.change(index);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: _pages,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: const TextStyle(fontSize: 12),
                  unselectedLabelStyle: const TextStyle(fontSize: 12),
                  showUnselectedLabels: true,
                  currentIndex: provider.currentIndex,
                  useLegacyColorScheme: true,
                  iconSize: 22,
                  onTap: (newValue) {
                    provider.change(newValue);
                    _pageController.jumpToPage(newValue);
                    // print(_pageController.initialPage);
                    // print(newValue);
                    // setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(UIcons.regularRounded.home),
                      activeIcon: Icon(UIcons.solidRounded.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Search',
                      icon: Icon(UIcons.regularRounded.search),
                      activeIcon: Icon(UIcons.solidRounded.search),
                    ),
                    BottomNavigationBarItem(
                      label: 'Chat',
                      icon: Icon(UIcons.regularRounded.comments),
                      activeIcon: Icon(UIcons.solidRounded.comments),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(UIcons.regularRounded.user),
                      activeIcon: Icon(UIcons.solidRounded.user),
                    ),
                  ],
                ),
              ),
            ),
            if (overlayProvider.active)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    overlayProvider.deactivate();
                  },
                  child: Container(color: Colors.black54),
                ),
              ),
            if (overlayProvider.overlayWidget != null) overlayProvider.overlayWidget!
          ],
        );
      },
    );
  }
}
