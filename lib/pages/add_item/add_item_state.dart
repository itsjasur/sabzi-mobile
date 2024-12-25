import 'package:photo_manager/photo_manager.dart';

class AddItemState {
  final List<String> selectedAssetEntityList;

  AddItemState({required this.selectedAssetEntityList});

  AddItemState copyWith({List<String>? selectedAssetEntityList}) {
    return AddItemState(selectedAssetEntityList: selectedAssetEntityList ?? this.selectedAssetEntityList);
  }
}
