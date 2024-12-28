import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_provider.dart';

class GalleryGridImage extends ConsumerWidget {
  final Uint8List image;
  final String assetId;

  const GalleryGridImage({super.key, required this.image, required this.assetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAssetEntityList = ref.watch(addListingProvider.select((state) => state.selectedAssetEntityList));
    final index = selectedAssetEntityList.indexWhere((item) => item.key == assetId) + 1;
    // print('INDEX BELOW');
    // print(index);
    bool isSelected = index != 0;
    final notifier = ref.read(addListingProvider.notifier);

    return ScaledTap(
      onTap: () {
        if (isSelected) {
          notifier.removeAssetEntity(assetId);
        } else {
          if (selectedAssetEntityList.length >= 9) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You can select up to 9 images'),
                duration: Duration(seconds: 4),
              ),
            );
          } else {
            notifier.addAssetEntity(assetId);
          }
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Material(
            child: Container(
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(
                        width: 3,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
              child: Image.memory(image, fit: BoxFit.cover),
            ),
          ),
          if (isSelected)
            const Positioned.fill(
              child: Material(
                color: Colors.white24,
              ),
            ),
          if (isSelected && index > 0)
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                constraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Align(
                  child: Text(
                    index.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
