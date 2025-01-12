import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_provider.dart';
import 'package:flutter_sabzi/pages/gallery_view/gallery_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ImagesRow extends ConsumerWidget {
  const ImagesRow({super.key});

  @override
  build(BuildContext context, WidgetRef ref) {
    double containerSize = 65;
    final images = ref.watch(addListingProvider.select((state) => state.selectedImages));

    Widget itemBuilder(int index) {
      return Container(
        alignment: Alignment.bottomCenter,
        key: ValueKey(index),
        margin: const EdgeInsets.only(left: 12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.memory(
                images[index],
                height: containerSize,
                width: containerSize,
                fit: BoxFit.cover,
              ),
            ),
            if (index == 0)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                  child: Container(
                    color: Colors.black87,
                    height: 20,
                    alignment: Alignment.center,
                    child: const Text(
                      'Main',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: -4,
              right: -4,
              child: ScaledTap(
                onTap: () => ref.read(addListingProvider.notifier).removeImageWithIndex(index),
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.surface,
                    size: 14.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Material(
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: containerSize + 5,
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 15, right: 30),
            shrinkWrap: true,
            proxyDecorator: (child, index, animation) => itemBuilder(index),
            onReorder: (int oldIndex, int newIndex) {
              // print('oldindex, $oldIndex');
              // print('newindex $newIndex');
              HapticFeedback.lightImpact();
              ref.read(addListingProvider.notifier).swapItemPosition(oldIndex, newIndex);
            },
            header: ScaledTap(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  useSafeArea: true,
                  isDismissible: false,
                  barrierColor: Theme.of(context).colorScheme.surface,
                  builder: (_) => const GalleryView(),
                );
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: containerSize,
                  width: containerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIcons.camera(PhosphorIconsStyle.fill),
                        size: 30,
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
                          ),
                          children: [
                            TextSpan(
                              text: images.length.toString(),
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ),
                            const TextSpan(text: '/10'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            children: [
              ...List.generate(
                images.length,
                (index) {
                  return itemBuilder(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
