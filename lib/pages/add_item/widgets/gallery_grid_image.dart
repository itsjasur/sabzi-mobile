import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryGridImage extends StatelessWidget {
  final Uint8List image;
  final AssetEntity assetEntity;
  const GalleryGridImage({super.key, required this.image, required this.assetEntity});

  // bool _isSelected = false;
  // int index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedAssetEntityList = ref.watch(addItemNotifier.select((state) => state.selectedAssetEntityList));
        final notifier = ref.read(addItemNotifier.notifier);

        int index = selectedAssetEntityList.indexWhere((entity) => entity.id == assetEntity.id) + 1;
        bool isSelected = index != 0;

        return ScaledTap(
          onTap: () {
            if (isSelected) {
              notifier.removeAssetEntity(assetEntity);
            } else {
              notifier.addAssetEntity(assetEntity);
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
                  child: Image.memory(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (isSelected)
                const Positioned.fill(
                  child: Material(
                    color: Colors.white30,
                  ),
                ),
              if (isSelected && index > 0)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    padding: const EdgeInsets.all(2),
                    child: Align(
                      child: Text(
                        index.toString(),
                        style: const TextStyle(
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
      },
    );
  }
}
