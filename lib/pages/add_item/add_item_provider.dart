import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_state.dart';
import 'package:photo_manager/photo_manager.dart';

class AddItemProvider extends Notifier<AddItemState> {
  @override
  AddItemState build() => AddItemState(selectedAssetEntityList: []);

  void swapItemPosition(int oldIndex, int newIndex) {
    final updatedList = [...state.selectedAssetEntityList];
    // adjusts the newIndex if it's after the removal point
    if (newIndex > oldIndex) newIndex -= 1;

    final removedItem = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, removedItem);
    state = state.copyWith(selectedAssetEntityList: updatedList);
  }

  void removeAssetEntity(String assetId) {
    final updatedList = state.selectedAssetEntityList.where((item) => item.key != assetId).toList();
    state = state.copyWith(selectedAssetEntityList: updatedList);
  }

  void addAssetEntity(String assetId) async {
    try {
      final asset = await AssetEntity.fromId(assetId);
      if (asset == null) return;
      final thumbnail = await asset.thumbnailDataWithSize(const ThumbnailSize(200, 200), quality: 80);

      if (thumbnail != null) {
        final newList = [...state.selectedAssetEntityList, MapEntry(assetId, thumbnail)];
        state = state.copyWith(selectedAssetEntityList: newList);
      }
    } catch (e) {
      print('Error adding asset: $e');
    }
  }
}

final addItemProvider = NotifierProvider<AddItemProvider, AddItemState>(() => AddItemProvider());
