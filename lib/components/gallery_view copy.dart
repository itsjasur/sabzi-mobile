import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sabzi_app/components/scaled_tap.dart';

class CustomGalleryPicker extends StatefulWidget {
  final Function(List<AssetEntity>) onSelect;

  const CustomGalleryPicker({super.key, required this.onSelect});

  @override
  State<CustomGalleryPicker> createState() => _CustomGalleryPickerState();
}

class _CustomGalleryPickerState extends State<CustomGalleryPicker> {
  List<AssetPathEntity> _albums = [];
  List<AssetEntity> _mediaList = [];
  int _currentPage = 0;
  late AssetPathEntity _selectedAlbum;

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(onlyAll: true);
      setState(() {
        _albums = albums;
        if (albums.isNotEmpty) {
          _selectedAlbum = albums.first;
          _fetchMediaForCurrentAlbum();
        }
      });
    } else {
      // Handle permission denied
    }
  }

  Future<void> _fetchMediaForCurrentAlbum() async {
    final List<AssetEntity> media = await _selectedAlbum.getAssetListPaged(page: _currentPage, size: 60);
    setState(() {
      _mediaList = media;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          DropdownButton<AssetPathEntity>(
            value: _selectedAlbum,
            items: _albums.map((album) {
              return DropdownMenuItem<AssetPathEntity>(
                value: album,
                child: Text(album.name),
              );
            }).toList(),
            onChanged: (AssetPathEntity? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedAlbum = newValue;
                  _currentPage = 0;
                  _fetchMediaForCurrentAlbum();
                });
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: _mediaList.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Uint8List?>(
            future: _mediaList[index].thumbnailData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                return ScaledTap(
                  onTap: () {
                    widget.onSelect([_mediaList[index]]);
                    Navigator.of(context).pop();
                  },
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Container(color: Colors.grey);
            },
          );
        },
      ),
    );
  }
}
