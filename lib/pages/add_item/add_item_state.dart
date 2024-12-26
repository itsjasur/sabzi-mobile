import 'dart:typed_data';

class AddItemState {
  // final List<String> selectedAssetEntityList;
  final List<MapEntry<String, Uint8List>> selectedAssetEntityList;

  AddItemState({required this.selectedAssetEntityList});

  AddItemState copyWith({List<MapEntry<String, Uint8List>>? selectedAssetEntityList}) {
    return AddItemState(selectedAssetEntityList: selectedAssetEntityList ?? this.selectedAssetEntityList);
  }
}
