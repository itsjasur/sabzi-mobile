import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryGridFutureImage extends ConsumerStatefulWidget {
  final AssetEntity asset;
  const GalleryGridFutureImage({super.key, required this.asset});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GalleryGridFutureImageState();
}

class _GalleryGridFutureImageState extends ConsumerState<GalleryGridFutureImage> {
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    print('gallery stfl grid image initiated');
    Future.microtask(() async {
      _loadImage();
    });
  }

  Future<void> _loadImage() async {
    _image = await widget.asset.thumbnailData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedAssetEntityList = ref.watch(addItemProvider.select((state) => state.selectedAssetEntityList));

    int index = selectedAssetEntityList.indexWhere((entity) => entity.id == widget.asset.id) + 1;
    bool isSelected = index != 0;

    final notifier = ref.read(addItemProvider.notifier);

    return ScaledTap(
      key: ValueKey(widget.asset.id),
      onTap: () {
        if (isSelected) {
          notifier.removeAssetEntity(widget.asset);
        } else {
          notifier.addAssetEntity(widget.asset);
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
              child: _image != null
                  ? Image.memory(
                      key: ValueKey(widget.asset.id),
                      _image!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey.shade100,
                    ),
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
