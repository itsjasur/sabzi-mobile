import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app_provider.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view_state.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryViewProvider extends Notifier<GalleryViewState> {
  @override
  GalleryViewState build() {
    Future.microtask(() async {
      ref.read(appProvider.notifier).setLoading(true);
      await fetchFolders();
      ref.read(appProvider.notifier).setLoading(false);
    });

    return GalleryViewState(folders: [], currentFolderImages: [], foldersInfoList: [], selectedFolder: null);
  }

  Future<void> fetchFolders() async {
    // requests permissions if not already granted
    var permissionStatus = await PhotoManager.requestPermissionExtend();

    if (permissionStatus == PermissionState.authorized || permissionStatus == PermissionState.limited) {
      // fetchs only image folders
      final folders = await PhotoManager.getAssetPathList(type: RequestType.image);

      if (folders.isNotEmpty) {
        state = state.copyWith(folders: folders);
        await changeFolder(folders.first);
      }
    } else {
      //handles the case where permissions are denied
      PhotoManager.openSetting();
    }
  }

  // this gets new folder and fetches folder images from device and calls _convertToFolderInfoList
  Future<void> changeFolder(AssetPathEntity folder) async {
    final images = await folder.getAssetListPaged(page: 0, size: 500);
    state = state.copyWith(currentFolderImages: images, selectedFolder: folder);
    await _convertToFolderInfoList();
  }

  Future<void> _convertToFolderInfoList() async {
    List<CustomFolderModel> foldersInfoList = [];
    for (AssetPathEntity folder in state.folders) {
      final entity = await folder.getAssetListPaged(page: 0, size: 1);
      final firsEntityBytes = entity.isNotEmpty ? await entity.first.thumbnailData : null;
      final name = folder.name;
      final count = await folder.assetCountAsync;
      foldersInfoList.add(CustomFolderModel(name: name, count: count, entityBytes: firsEntityBytes));
    }
    state = state.copyWith(foldersInfoList: foldersInfoList);
  }

  Future<void> addNewImage(AssetEntity newAsset) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    state = state.copyWith(currentFolderImages: [newAsset, ...state.currentFolderImages]);
  }
}

final galleryViewProvider = NotifierProvider<GalleryViewProvider, GalleryViewState>(() {
  return GalleryViewProvider();
});
