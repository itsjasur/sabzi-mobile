import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';

class BottomNavWidget extends ConsumerWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: BottomNavs.values
              .map(
                (navigationItem) => GestureDetector(
                  onTap: () => ref.read(navigationProvider.notifier).setPage(navigationItem),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5),
                        Icon(
                          navigationItem == ref.watch(navigationProvider).currentPage ? navigationItem.info.activeIcon : navigationItem.info.icon,
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
        ),
      ),
    );
  }
}
