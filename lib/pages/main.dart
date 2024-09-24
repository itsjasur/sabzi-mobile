import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/enums/bottom_navigations.dart';
import 'package:sabzi_app/providers/bottom_navigation_provider.dart';
import 'package:sabzi_app/theme.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: Provider.of<BottomNavigationProvider>(context, listen: false).currentNavPage.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Consumer<BottomNavigationProvider>(
      builder: (context, bottomNavigationProvider, child) => Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            bottomNavigationProvider.change(MainBottomNavs.values[index]);
          },
          physics: const NeverScrollableScrollPhysics(),
          children: MainBottomNavs.values.map((nav) => nav.info.page).toList(),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          decoration: BoxDecoration(
              color: colors.surface,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: colors.secondary.withOpacity(0.08),
                ),
              )),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: MainBottomNavs.values
                  .map(
                    (nav) => ScaledTap(
                      onTap: () {
                        bottomNavigationProvider.change(nav);
                        _pageController.jumpToPage(nav.index);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              nav == bottomNavigationProvider.currentNavPage ? nav.info.activeIcon : nav.info.icon,
                              size: 20,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              nav.info.label,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
