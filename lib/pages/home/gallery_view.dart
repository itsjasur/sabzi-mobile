import 'dart:typed_data';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedAlbum != null ? Text(_selectedAlbum!.name) : Text('asd'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              // height: 200,
              color: Colors.blue,
              child: const Center(child: Text('Full Width Item')),
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
                  return const Center(child: Text('Full Width Item'));
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
                return const SizedBox.shrink();
              },
              // childCount: 12, // Number of grid items
            ),
          )
        ],
      ),
    );
  }

  Future<void> _fetchAlbums() async {
    // Request permissions if not already granted
    var permissionStatus = await PhotoManager.requestPermissionExtend();
    // var permissionStatus = await PhotoManager.getPermissionState(requestOption: const PermissionRequestOption(iosAccessLevel: IosAccessLevel.addOnly));
    print(permissionStatus);
    if (permissionStatus == PermissionState.authorized || permissionStatus == PermissionState.limited) {
      // Fetch only image folders
      List<AssetPathEntity> folders = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      _albums = folders;

      print(_albums);

      if (_albums.isNotEmpty) {
        _selectedAlbum = _albums.first;
        await _fetchMediaForCurrentAlbum();
      }

      setState(() {});
    } else {
      // Handle the case where permissions are denied
      PhotoManager.openSetting();
    }
  }

  Future<void> _fetchMediaForCurrentAlbum() async {
    final List<AssetEntity> media = await _selectedAlbum!.getAssetListPaged(page: 0, size: 600);
    setState(() {
      _images = media;
    });
  }
}
