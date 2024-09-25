import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/enums/bottom_navigations.dart';
import 'package:sabzi_app/providers/bottom_navigation_provider.dart';
import 'package:sabzi_app/theme.dart';

class Primary extends StatefulWidget {
  const Primary({super.key});

  @override
  State<Primary> createState() => _PrimaryState();
}

class _PrimaryState extends State<Primary> {
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
          // constraints: const BoxConstraints(minHeight: 60),
          padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
          decoration: BoxDecoration(
              color: colors.surface,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: colors.secondary.withOpacity(0.08),
                ),
              )),
          child: SafeArea(
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
                        // color: Colors.amber,
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              nav == bottomNavigationProvider.currentNavPage ? nav.info.activeIcon : nav.info.icon,
                              size: 24,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              nav.info.label,
                              style: const TextStyle(fontSize: 11),
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
