import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<AssetPathEntity> _albums = [];
  List<AssetEntity> _images = [];

  AssetPathEntity? _selectedAlbum;

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  bool _isShowingAlbums = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedAlbum != null
            ? ScaledTap(
                onTap: () {},
                child: Text(_selectedAlbum!.name),
              )
            : const Text('Unknown'),
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
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
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
                      return FutureBuilder<Uint8List?>(
                        future: _images[imageIndex].thumbnailData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                            return Image.memory(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            );
                          }
                          return Container(color: Colors.grey);
                        },
                      );
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.surface,
            child: ListView.builder(
              itemCount: _albumsInfoList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _albumsInfoList[index].entityBytes != null
                            ? Image.file(
                                height: 70,
                                width: 70,
                                _albumsInfoList[index].entityBytes!,
                                fit: BoxFit.cover,
                              )
                            : Container()),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _albumsInfoList[index].name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            _albumsInfoList.length.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
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
        imageQuality: 85, // Adjust quality as needed (0-100)
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

  Future<void> _fetchAlbums() async {
    // Request permissions if not already granted
    var permissionStatus = await PhotoManager.requestPermissionExtend();
    // print(permissionStatus);
    if (permissionStatus == PermissionState.authorized || permissionStatus == PermissionState.limited) {
      // Fetch only image folders
      List<AssetPathEntity> folders = await PhotoManager.getAssetPathList(
        // onlyAll: true,
        // hasAll: true,
        type: RequestType.image,
      );
      _albums = folders;

      // print(_albums);

      if (_albums.isNotEmpty) {
        _selectedAlbum = _albums.first;
        await _fetchMediaForCurrentAlbum();
      }

      _fetchlbumsInfolist();

      setState(() {});
    } else {
      // Handle the case where permissions are denied
      PhotoManager.openSetting();
    }
  }

  Future<void> _fetchMediaForCurrentAlbum() async {
    final List<AssetEntity> media = await _selectedAlbum!.getAssetListPaged(page: 0, size: 600);
    _images = media;
    setState(() {});
  }

  bool _albumsInfoListLoaded = false;
  final List<AlbumInfo> _albumsInfoList = [];

  void _fetchlbumsInfolist() async {
    for (var album in _albums) {
      final entity = await album.getAssetListPaged(page: 0, size: 1);
      // final firsEntity = entity.isNotEmpty ? entity.first : null;
      final firsEntityBytes = entity.isNotEmpty ? await entity.first.file : null;
      final name = album.name;
      final count = await album.assetCountAsync;

      _albumsInfoList.add(AlbumInfo(name: name, count: count, entityBytes: firsEntityBytes));
    }

    setState(() {});
  }
}

class AlbumInfo {
  final String name;
  final int count;
  final File? entityBytes;

  AlbumInfo({required this.name, required this.count, required this.entityBytes});
}
