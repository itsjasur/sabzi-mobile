import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/app_back_button.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/camera_grid_item.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/done_action_button.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/folder_select_modal.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_grid_image.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  PermissionState _permissionStatus = PermissionState.notDetermined;
  final ScrollController _scrollController = ScrollController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        leading: const AppBarBackButton(isX: true),
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
        actions: const [
          SizedBox(width: 10),
          DoneActionButton(),
          SizedBox(width: 15),
        ],
      ),
      body: _isPageLoading
          ? null
          : Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  cacheExtent: 1000,
                  slivers: [
                    if (_permissionStatus != PermissionState.authorized)
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: Theme.of(context).colorScheme.tertiary,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'If you allow access to all images you can easily upload images.',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 7),
                              ScaledTap(
                                onTap: PhotoManager.openSetting,
                                child: Text(
                                  'Allow access',
                                  style: TextStyle(
                                    fontSize: 15,
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
                        if (index == 0) return CameraGridItem(onImageCaptured: _insertImage);

                        final imageIndex = index - 1;
                        MapEntry<AssetEntity, Uint8List?> entry = _currentFolderImagesCache[imageIndex];

                        if (entry.value != null) {
                          return GalleryGridImage(
                            // key: ValueKey(entry.key),
                            image: entry.value!,
                            asset: entry.key,
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

  final List<MapEntry<AssetEntity, Uint8List?>> _currentFolderImagesCache = [];

  List<AssetPathEntity> _folders = [];
  final List<CustomFolderModel> _foldersInfoList = [];
  bool _isPageLoading = true;

  int _currentFolderPage = 0;
  bool _folderHasMoreImages = true;
  bool _isLoadingMoreImages = false;
  AssetPathEntity? _currentFolder;

  Future<void> _fetchFolders() async {
    _permissionStatus = await PhotoManager.requestPermissionExtend();

    if (_permissionStatus == PermissionState.authorized || _permissionStatus == PermissionState.limited) {
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
      print(asset);
      final img = await asset.thumbnailDataWithSize(const ThumbnailSize(300, 300), quality: 80);
      _currentFolderImagesCache.add(MapEntry(asset, img));
    }

    _currentFolderPage++;
    _isLoadingMoreImages = false;
    setState(() {});
  }

  Future<void> _insertImage(AssetEntity asset) async {
    Uint8List? image = await asset.thumbnailDataWithSize(const ThumbnailSize(300, 300), quality: 80);
    _currentFolderImagesCache.insert(0, MapEntry(asset, image));
    setState(() {});
  }

  Future<void> _convertToFolderInfoList() async {
    _foldersInfoList.clear();

    for (AssetPathEntity folder in _folders) {
      final entity = await folder.getAssetListPaged(page: 0, size: 1);
      final firsEntityBytes = entity.isNotEmpty ? await entity.first.thumbnailDataWithSize(const ThumbnailSize(300, 300), quality: 80) : null;
      final name = folder.name;
      final count = await folder.assetCountAsync;
      _foldersInfoList.add(CustomFolderModel(name: name, count: count, entityBytes: firsEntityBytes));
    }
  }
}
