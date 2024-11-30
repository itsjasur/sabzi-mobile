import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/area_button/area_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AreaButton extends ConsumerWidget {
  const AreaButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(areaProvider); //initialized here to avoid loading once sheet opened
    return ScaledTap(
      onTap: () {
        showModalBottomSheet(
          enableDrag: true,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return Consumer(
              builder: (context, ref, child) {
                final bottomSheetProvider = ref.watch(areaProvider);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 30),
                      itemCount: bottomSheetProvider.areas.length + 1,
                      itemBuilder: (context, index) {
                        if (index < bottomSheetProvider.areas.length) {
                          return ScaledTap(
                            onTap: () {
                              ref.read(areaProvider.notifier).changeArea(bottomSheetProvider.areas[index].id);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    bottomSheetProvider.areas[index].name,
                                    style: const TextStyle(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  RadioWidget(
                                    isSelected: bottomSheetProvider.selectedAreaId == bottomSheetProvider.areas[index].id,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return ScaledTap(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Edit my areas",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: const Row(
        children: [
          Text(
            '동동돌',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 5),
          Icon(
            PhosphorIconsBold.caretDown,
            size: 16,
          ),
        ],
      ),
    );
  }
}
