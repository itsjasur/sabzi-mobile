import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/pages/home.dart';
import 'package:sabzi_mobile/pages/search.dart';
import 'package:sabzi_mobile/pages/wrapper/wrapper_appbar.dart';
import 'package:sabzi_mobile/providers/bottom_navigation.dart';
import 'package:uicons/uicons.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: const WrapperAppbar(),
        body: _pages[provider.currentIndex],
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
    );
  }
}
