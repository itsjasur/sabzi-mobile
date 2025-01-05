import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_provider.dart';
import 'package:flutter_sabzi/app/bottom_navigation/bottom_navigation_state.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class BottomNavWidget extends ConsumerWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(navigationProvider);

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            offset: const Offset(0, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: BottomNavs.values
                .map(
                  (navigationItem) => ScaledTap(
                    onTap: () => ref.read(navigationProvider.notifier).setPage(navigationItem),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5),
                        Icon(
                          navigationItem == state.currentPage ? navigationItem.info.activeIcon : navigationItem.info.icon,
                          size: 26,
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(navigationItem == state.currentPage ? 255 : 100),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          navigationItem.info.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            height: 1,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(navigationItem == state.currentPage ? 255 : 100),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
