import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/widgets/gallery_grid_image.dart';
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
    _fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ScaledTap(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              enableDrag: true,
              clipBehavior: Clip.hardEdge,
              builder: (_) => Stack(
                alignment: Alignment.topCenter,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: _foldersInfoList.length,
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 40),
                    itemBuilder: (context, index) {
                      CustomFolderModel folderInfo = _foldersInfoList[index];

                      // only show if there is an image in the folder
                      if (folderInfo.count <= 0) return null;

                      return ScaledTap(
                        onTap: () {
                          _currentFolder = _folders[index];
                          _fetchMediaForCurrentAlbum();
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: folderInfo.entityBytes != null
                                  ? Image.memory(
                                      height: 70,
                                      width: 70,
                                      folderInfo.entityBytes!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 70,
                                      width: 70,
                                      color: Theme.of(context).colorScheme.tertiary,
                                    ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    folderInfo.name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    folderInfo.count.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  // custom drag handle
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: double.infinity,
                    height: 35,
                    child: Align(
                      child: Container(
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  _currentFolder != null
                      ? _currentFolder!.name
                      : _folders.isNotEmpty
                          ? 'Select folder'
                          : '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                PhosphorIcons.caretDown(PhosphorIconsStyle.fill),
                size: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
        ),
        actions: [
          const SizedBox(width: 10),
          ScaledTap(
            onTap: () {},
            child: RichText(
              maxLines: 1,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface,
                  overflow: TextOverflow.ellipsis,
                ),
                children: [
                  TextSpan(
                    // text: _selectedAssetEntityList.length.toString(),
                    text: '000',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
                  (context, index) {
                    if (index == 0) {
                      return ScaledTap(
                        onTap: () {
                          // tap to take picture goes here
                          _takePicture();
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

                    int imageIndex = index - 1;

                    if (imageIndex < _images.length) {
                      final asset = _images[imageIndex];
                      return FutureBuilder<Uint8List?>(
                        future: asset.thumbnailData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
                            return GalleryGridImage(assetEntity: asset, image: snapshot.data!);
                          }

                          return const SizedBox.shrink();
                        },
                      );
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  Future<void> _takePicture() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90, // Adjust quality as needed (0-100)
      );

      if (photo != null) {
        // Convert the new photo to an asset using PhotoManager
        final File photoFile = File(photo.path);
        await PhotoManager.editor.saveImage(
          await photoFile.readAsBytes(),
          title: 'Camera_${DateTime.now().millisecondsSinceEpoch}.jpg',
          filename: 'image',
        );

        // Refresh the gallery to show the new photo
        await _fetchMediaForCurrentAlbum();
      }
    } catch (e) {
      // Show error dialog
      if (mounted) {
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
  }

  List<AssetPathEntity> _folders = [];
  AssetPathEntity? _currentFolder;
  final List<CustomFolderModel> _foldersInfoList = [];
  List<AssetEntity> _images = [];

  Future<void> _fetchAlbums() async {
    // rquests permissions if not already granted
    var permissionStatus = await PhotoManager.requestPermissionExtend();
    // print(permissionStatus);
    if (permissionStatus == PermissionState.authorized || permissionStatus == PermissionState.limited) {
      // fetchs only image folders
      _folders = await PhotoManager.getAssetPathList(type: RequestType.image);
      setState(() {});

      if (_folders.isNotEmpty) {
        _currentFolder = _folders.first;
        await _fetchMediaForCurrentAlbum();
      }

      _getFolderInfoList();
    } else {
      // Handle the case where permissions are denied
      PhotoManager.openSetting();
    }
  }

  void _getFolderInfoList() async {
    _foldersInfoList.clear();
    // List<CustomFolderModel> foldersInfo = [];
    for (AssetPathEntity folder in _folders) {
      final entity = await folder.getAssetListPaged(page: 0, size: 1);
      // final firsEntityBytes = entity.isNotEmpty ? await entity.first.file : null;
      final firsEntityBytes = entity.isNotEmpty ? await entity.first.thumbnailData : null;
      final name = folder.name;
      final count = await folder.assetCountAsync;
      _foldersInfoList.add(CustomFolderModel(name: name, count: count, entityBytes: firsEntityBytes));
    }
  }

  Future<void> _fetchMediaForCurrentAlbum() async {
    _images = await _currentFolder!.getAssetListPaged(page: 0, size: 20);
    setState(() {});
  }
}

class CustomFolderModel {
  final String name;
  final int count;
  final Uint8List? entityBytes;

  CustomFolderModel({required this.name, required this.count, required this.entityBytes});
}
