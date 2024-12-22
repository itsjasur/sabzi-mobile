import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/widgets/camera_button.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/widgets/folders_listview.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/widgets/gallery_grid_image.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryView extends ConsumerWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFolderImages = ref.watch(galleryViewProvider.select((state) => state.currentFolderImages));
    // ref.read(galleryViewProvider.notifier);
    // final selectedFolder = ref.watch(galleryViewProvider.select((state) => state.selectedFolder));

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const FoldersListview(),
        actions: [
          const SizedBox(width: 10),
          ScaledTap(
            onTap: () {},
            child: RichText(
              maxLines: 1,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: ref.watch(galleryViewProvider.select((state) => state.folders)).length.toString(),
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const TextSpan(text: ' '),
                  const TextSpan(text: 'Done'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            cacheExtent: 1000,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  // height: 200,
                  color: Theme.of(context).colorScheme.tertiary,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'If you allow access to all images you can easily upload images.',
                        style: TextStyle(fontSize: 14.5),
                      ),
                      SizedBox(height: 7),
                      ScaledTap(
                        onTap: PhotoManager.openSetting,
                        child: Text(
                          'Allow access',
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
                delegate: SliverChildBuilderDelegate(
                  addAutomaticKeepAlives: true,
                  childCount: currentFolderImages.length + 1,
                  // childCount: 10,
                  addSemanticIndexes: true,
                  (context, index) {
                    if (index == 0) return const CameraButton();
                    // return GalleryGridFutureImage(
                    //   index: imageIndex,
                    // );

                    int imageIndex = index - 1;
                    if (imageIndex < currentFolderImages.length) {
                      final asset = currentFolderImages[imageIndex];
                      return GalleryGridImage(
                        key: ValueKey(asset.id),
                        asset: asset,
                      );
                    }

                    // return Container(color: Colors.amber);

                    // return null;
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// final container = ProviderContainer();

// int _imagesLength() {
//   final currentImages = container.read(galleryViewProvider).currentFolderImages;
//   return currentImages.length;
// }

// bool _isAvailable(index) {
//   print('_isAvailable called');
//   print(index);
//   final currentImages = container.read(galleryViewProvider).currentFolderImages;

//   // print(currentImages);

//   print("currentImages.length ${currentImages.length}");

//   print("isAvilable ${currentImages.length < index}");
//   return currentImages.length <= index;
// }
