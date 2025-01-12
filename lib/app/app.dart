// app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app_provider.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';
import 'package:flutter_sabzi/pages/signin/welcome_page.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_widget.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listens to authProvider & removes below pages in nav stack
    ref.listen(authProvider, (previous, next) {
      if (previous?.isAuthenticated != next.isAuthenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      }
    });

    final isAuthenticated = ref.watch(authProvider).isAuthenticated;

    if (isAuthenticated) {
      return Stack(
        children: [
          Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: ref.watch(navigationProvider).pageController,
              // onPageChanged: ref.read(navigationProvider.notifier).onPageChanged,

              children: BottomNav.values.map((nav) => nav.info.page).toList(),
            ),
            bottomNavigationBar: const BottomNavWidget(),
          ),
          if (ref.watch(appProvider.select((state) => state.isGlobalLoading)))
            Positioned.fill(
              child: Material(
                color: Colors.black26,
                child: Align(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      );
    } else {
      return const WelcomePage();
    }
  }
}
