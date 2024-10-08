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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Uint8List?>(
            future: _images[index].thumbnailData,
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
        },
      ),
    );
  }

  // Future<void> _fetchAlbums() async {
  //   final PermissionState ps = await PhotoManager.requestPermissionExtend();
  //   if (ps.isAuth) {
  //     List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(onlyAll: true);
  //     setState(() {
  //       _albums = albums;
  //       if (albums.isNotEmpty) {
  //         _selectedAlbum = albums.first;
  //         _fetchMediaForCurrentAlbum();
  //       }
  //     });
  //   } else {
  //     // Handle permission denied
  //   }
  // }

  Future<void> _fetchAlbums() async {
    // Request permissions if not already granted
    var permissionStatus = await PhotoManager.requestPermissionExtend();
    if (permissionStatus.isAuth) {
      // Fetch only image folders
      List<AssetPathEntity> folders = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      _albums = folders;

      if (_albums.isNotEmpty) {
        _selectedAlbum = _albums.first;
        await _fetchMediaForCurrentAlbum();
      }
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
