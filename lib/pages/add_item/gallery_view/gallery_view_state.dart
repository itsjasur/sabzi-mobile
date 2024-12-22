import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class CustomFolderModel {
  final String name;
  final int count;
  final Uint8List? entityBytes;

  CustomFolderModel({required this.name, required this.count, required this.entityBytes});
}

class GalleryViewState {
  final List<AssetEntity> currentFolderImages;
  final List<AssetPathEntity> folders;
  final AssetPathEntity? selectedFolder;
  final List<CustomFolderModel> foldersInfoList;

  GalleryViewState({
    required this.folders,
    required this.currentFolderImages,
    required this.foldersInfoList,
    required this.selectedFolder,
  });

  GalleryViewState copyWith({
    List<AssetPathEntity>? folders,
    List<AssetEntity>? currentFolderImages,
    List<CustomFolderModel>? foldersInfoList,
    AssetPathEntity? selectedFolder,
  }) {
    return GalleryViewState(
      folders: folders ?? this.folders,
      currentFolderImages: currentFolderImages ?? this.currentFolderImages,
      foldersInfoList: foldersInfoList ?? this.foldersInfoList,
      selectedFolder: selectedFolder ?? this.selectedFolder,
    );
  }
}
