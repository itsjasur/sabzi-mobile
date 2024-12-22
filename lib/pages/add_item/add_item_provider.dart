import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_state.dart';
import 'package:photo_manager/photo_manager.dart';

class AddItemProvider extends Notifier<AddItemState> {
  @override
  AddItemState build() {
    return AddItemState(selectedAssetEntityList: []);
  }

  void removeAssetEntity(AssetEntity assetEntity) {
    final updatedList = state.selectedAssetEntityList.where((entity) => entity.id != assetEntity.id).toList();
    state = state.copyWith(selectedAssetEntityList: updatedList);
  }

  void addAssetEntity(AssetEntity assetEntity) {
    if (!state.selectedAssetEntityList.any((entity) => entity.id == assetEntity.id)) {
      final updatedList = [...state.selectedAssetEntityList, assetEntity];
      state = state.copyWith(selectedAssetEntityList: updatedList);
    }
  }
}

final addItemProvider = NotifierProvider<AddItemProvider, AddItemState>(() {
  return AddItemProvider();
});
