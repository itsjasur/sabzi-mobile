import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/custom_bottom_sheet_drag.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

class CustomFolderModel {
  final String name;
  final int count;
  final Uint8List? entityBytes;

  CustomFolderModel({required this.name, required this.count, required this.entityBytes});
}

class FolderSelectModal extends StatelessWidget {
  final List<CustomFolderModel> foldersInfoList;
  final List<AssetPathEntity> folders;
  final AssetPathEntity? currentFolder;
  final Function(AssetPathEntity) changeFolder;
  const FolderSelectModal({super.key, required this.foldersInfoList, required this.folders, this.currentFolder, required this.changeFolder});

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          enableDrag: true,
          clipBehavior: Clip.hardEdge,
          builder: (_) => Stack(
            alignment: Alignment.topCenter,
            children: [
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount: foldersInfoList.length,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 40),
                itemBuilder: (context, index) {
                  CustomFolderModel folderInfo = foldersInfoList[index];
                  // only show if there is an image in the folder
                  if (folderInfo.count <= 0) return null;

                  return ScaledTap(
                    onTap: () {
                      changeFolder(folders[index]);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: folderInfo.entityBytes != null
                              ? Image.memory(
                                  height: 70,
                                  width: 70,
                                  folderInfo.entityBytes!,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 70,
                                  width: 70,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                folderInfo.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                folderInfo.count.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              // custom drag handle icon
              const CustomBottomSheetDrag()
            ],
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              currentFolder != null
                  ? currentFolder!.name
                  : folders.isNotEmpty
                      ? 'Select folder'
                      : '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 7),
          Icon(
            PhosphorIcons.caretDown(PhosphorIconsStyle.fill),
            size: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
    );
    ;
  }
}
