import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_state.dart';

class AddItemProvider extends Notifier<AddItemState> {
  @override
  AddItemState build() {
    return AddItemState(selectedAssetEntityList: []);
  }

  void removeAssetEntity(String assetId) {
    final updatedList = state.selectedAssetEntityList.where((id) => id != assetId).toList();
    state = state.copyWith(selectedAssetEntityList: updatedList);
  }

  void addAssetEntity(String assetId) {
    if (!state.selectedAssetEntityList.any((id) => id == assetId)) {
      final updatedList = [...state.selectedAssetEntityList, assetId];
      state = state.copyWith(selectedAssetEntityList: updatedList);
    }
  }
}

final addItemProvider = NotifierProvider<AddItemProvider, AddItemState>(() {
  return AddItemProvider();
});
