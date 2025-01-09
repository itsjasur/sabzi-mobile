import 'package:photo_manager/photo_manager.dart';

class GalleryViewState {
  final List<AssetEntity> selectedAssetEntityList;

  GalleryViewState({required this.selectedAssetEntityList});

  GalleryViewState copyWith({
    List<AssetEntity>? selectedAssetEntityList,
  }) {
    return GalleryViewState(selectedAssetEntityList: selectedAssetEntityList ?? this.selectedAssetEntityList);
  }
}
