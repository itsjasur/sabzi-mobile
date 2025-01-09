import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view_state.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryViewProvider extends Notifier<GalleryViewState> {
  @override
  build() {
    return GalleryViewState(selectedAssetEntityList: []);
  }

  void removeAssetEntity(AssetEntity asset) {
    state = state.copyWith(
      selectedAssetEntityList: state.selectedAssetEntityList.where((element) => element.id != asset.id).toList(),
    );
  }

  void addAssetEntity(AssetEntity asset) {
    state = state.copyWith(selectedAssetEntityList: [...state.selectedAssetEntityList, asset]);
  }

  void cleanUp() {
    state = state.copyWith(selectedAssetEntityList: []);
  }
}

final galleryViewProvider = NotifierProvider<GalleryViewProvider, GalleryViewState>(() => GalleryViewProvider());
