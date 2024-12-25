import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/folder_select_modal.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_grid_image.dart';
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

    // scroll listener to fetch more images
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 1000 && !_isLoadingMoreImages && _folderHasMoreImages) {
        _loadFolderImages(_folders.first);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (_isPageLoading) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FolderSelectModal(
          foldersInfoList: _foldersInfoList,
          folders: _folders,
          currentFolder: _currentFolder,
          changeFolder: (AssetPathEntity newFolder) {
            _currentFolder = newFolder;
            _changeFolder();
          },
        ),
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
            controller: _scrollController,
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
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  // childAspectRatio: 1.0,
                ),
                itemCount: _currentFolderImagesCache.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ScaledTap(
                      onTap: () async {
                        try {
                          final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 90);

                          if (photo != null) {
                            final File photoFile = File(photo.path);
                            final Uint8List bytes = await photoFile.readAsBytes();
                            final AssetEntity asset = await PhotoManager.editor.saveImage(
                              bytes,
                              title: 'Camera_${DateTime.now().millisecondsSinceEpoch}.jpg',
                              filename: 'image',
                            );
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
                    );
                  }

                  final imageIndex = index - 1;
                  MapEntry<String, Uint8List?> entry = _currentFolderImagesCache[imageIndex];

                  if (entry.value != null) {
                    return GalleryGridImage(
                      key: ValueKey(entry.key),
                      image: entry.value!,
                      assetId: entry.key,
                    );
                  }

                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  final List<MapEntry<String, Uint8List?>> _currentFolderImagesCache = [];
  List<AssetPathEntity> _folders = [];
  final List<CustomFolderModel> _foldersInfoList = [];
  bool _isPageLoading = true;

  int _currentFolderPage = 0;
  bool _folderHasMoreImages = true;
  bool _isLoadingMoreImages = false;
  AssetPathEntity? _currentFolder;

  Future<void> _fetchFolders() async {
    var permissionStatus = await PhotoManager.requestPermissionExtend();

    if (permissionStatus == PermissionState.authorized || permissionStatus == PermissionState.limited) {
      _folders = await PhotoManager.getAssetPathList(type: RequestType.image);

      await _convertToFolderInfoList();

      if (_folders.isNotEmpty) {
        _currentFolder = _folders.first;
        await _changeFolder(); //sets folder for first time
        _isPageLoading = false;
        setState(() {});
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<void> _changeFolder() async {
    _currentFolderImagesCache.clear();
    _currentFolderPage = 0;
    _folderHasMoreImages = true;
    _loadFolderImages(_currentFolder!);
  }

  Future<void> _loadFolderImages(AssetPathEntity currentFolder) async {
    print('load more called ');
    _isLoadingMoreImages = true;

    List<AssetEntity> newAssets = await currentFolder.getAssetListPaged(page: _currentFolderPage, size: 30);

    if (newAssets.isEmpty) {
      _folderHasMoreImages = false;
      _isLoadingMoreImages = false;
      return;
    }

    for (AssetEntity asset in newAssets) {
      final img = await asset.thumbnailData;
      _currentFolderImagesCache.add(MapEntry(asset.id, img));
    }

    _currentFolderPage++;
    _isLoadingMoreImages = false;
    setState(() {});
  }

  Future<void> _insertImage(AssetEntity asset) async {
    Uint8List? image = await asset.thumbnailData;
    _currentFolderImagesCache.insert(0, MapEntry(asset.id, image));
    setState(() {});
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
