import 'package:photo_manager/photo_manager.dart';

class AddItemState {
  final List<AssetEntity> selectedAssetEntityList;

  AddItemState({required this.selectedAssetEntityList});

  AddItemState copyWith({List<AssetEntity>? selectedAssetEntityList}) {
    return AddItemState(selectedAssetEntityList: selectedAssetEntityList ?? this.selectedAssetEntityList);
  }
}
