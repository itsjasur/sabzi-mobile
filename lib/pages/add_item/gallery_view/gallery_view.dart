import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view_state.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/widgets/gallery_grid_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  void initState() {
    super.initState();
    _fetchFolders();
  }

  final ImagePicker _picker = ImagePicker();

  final GlobalKey<SliverAnimatedGridState> _listKey = GlobalKey<SliverAnimatedGridState>();

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while fetching
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Debug print to verify data
    print('Current folder images length: ${_currentFolderImages.length}');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: const FoldersListview(),
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
                    // text: ref.watch(galleryViewProvider.select((state) => state.folders)).length.toString(),
                    text: '24',
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
              SliverAnimatedGrid(
                key: _listKey,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.0,
                ),
                initialItemCount: _currentFolderImages.length + 1,
                itemBuilder: (context, index, animation) {
                  final curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  );

                  if (index == 0) {
                    return FadeTransition(
                      opacity: curvedAnimation,
                      child: SizeTransition(
                        sizeFactor: curvedAnimation,
                        child: ScaledTap(
                          onTap: () async {
                            try {
                              final XFile? photo = await _picker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 90,
                              );

                              if (photo != null) {
                                final File photoFile = File(photo.path);
                                final Uint8List bytes = await photoFile.readAsBytes();

                                final AssetEntity asset = await PhotoManager.editor.saveImage(
                                  bytes,
                                  title: 'Camera_${DateTime.now().millisecondsSinceEpoch}.jpg',
                                  filename: 'image',
                                );

                                await Future.delayed(const Duration(seconds: 1));

                                _insertImage(asset);
                              }
                            } catch (e) {
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: Text('Failed to take picture: ${e.toString()}'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.camera(PhosphorIconsStyle.regular),
                                size: 35,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                'Camera',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  final imageIndex = index - 1;
                  //  safety check
                  if (imageIndex >= _currentFolderImages.length) return const SizedBox();

                  final asset = _currentFolderImages[imageIndex];
                  return FadeTransition(
                    opacity: curvedAnimation,
                    child: ScaleTransition(
                      scale: curvedAnimation,
                      child: GalleryGridImage(
                        key: ValueKey(asset.id),
                        asset: asset,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _insertImage(AssetEntity asset) {
    // _currentFolderImages.insert(0, asset);
    setState(() {
      _currentFolderImages.insert(0, asset);
    });

    _listKey.currentState?.insertItem(
      1,
      duration: const Duration(milliseconds: 300),
    );
  }

  List<AssetEntity> _currentFolderImages = [];
  List<AssetPathEntity> _folders = [];
  final List<CustomFolderModel> _foldersInfoList = [];

  bool _isLoading = true;

  Future<void> _fetchFolders() async {
    var permissionStatus = await PhotoManager.requestPermissionExtend();

    if (permissionStatus == PermissionState.authorized || permissionStatus == PermissionState.limited) {
      _folders = await PhotoManager.getAssetPathList(type: RequestType.image);

      if (_folders.isNotEmpty) {
        await _changeFolder(_folders.first);
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  // this gets new folder and fetches folder images from device and calls _convertToFolderInfoList
  Future<void> _changeFolder(AssetPathEntity folder) async {
    _currentFolderImages = await folder.getAssetListPaged(page: 0, size: 500);
    await _convertToFolderInfoList();
  }

  Future<void> _convertToFolderInfoList() async {
    _foldersInfoList.clear();
    for (AssetPathEntity folder in _folders) {
      final entity = await folder.getAssetListPaged(page: 0, size: 1);
      final firsEntityBytes = entity.isNotEmpty ? await entity.first.thumbnailData : null;
      final name = folder.name;
      final count = await folder.assetCountAsync;
      _foldersInfoList.add(CustomFolderModel(name: name, count: count, entityBytes: firsEntityBytes));
    }
  }
}
