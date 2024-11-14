// bottom_navigation_bar_widget.dart

import 'package:flutter/material.dart';

import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  // final List<BottomNavigationModel> _bottomNavigations = [
  //   BottomNavigationModel(
  //     label: 'Home',
  //     pageName: BottomNavs.home,
  //     icon: PhosphorIcons.house(PhosphorIconsStyle.regular),
  //     activeIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
  //   ),
  //   BottomNavigationModel(
  //     label: 'Search',
  //     pageName: BottomNavs.search,
  //     icon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
  //     activeIcon: PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
  //   ),
  //   BottomNavigationModel(
  //     label: 'Chat',
  //     pageName: BottomNavs.chat,
  //     icon: PhosphorIcons.chatsCircle(PhosphorIconsStyle.regular),
  //     activeIcon: PhosphorIcons.chatsCircle(PhosphorIconsStyle.fill),
  //   ),
  //   BottomNavigationModel(
  //     label: 'Profile',
  //     pageName: BottomNavs.profile,
  //     icon: PhosphorIcons.user(PhosphorIconsStyle.regular),
  //     activeIcon: PhosphorIcons.user(PhosphorIconsStyle.fill),
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Consumer<BottomNavigationProvider>(
          builder: (context, bottomNavigationProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: BottomNavs.values
                  .map(
                    (navigationItem) => GestureDetector(
                      onTap: () => bottomNavigationProvider.setPage(navigationItem),
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5),
                            Icon(
                              navigationItem == bottomNavigationProvider.currentPage ? navigationItem.info.activeIcon : navigationItem.info.icon,
                              size: 26,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              navigationItem.info.label,
                              style: const TextStyle(
                                fontSize: 11,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
