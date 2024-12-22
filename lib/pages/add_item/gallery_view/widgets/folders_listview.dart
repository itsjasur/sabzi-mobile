import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view_provider.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoldersListview extends ConsumerStatefulWidget {
  const FoldersListview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FoldersListviewState();
}

class _FoldersListviewState extends ConsumerState<FoldersListview> {
  @override
  Widget build(BuildContext context) {
    final selectedFolder = ref.watch(galleryViewProvider.select((state) => state.selectedFolder));
    final foldersInfolist = ref.watch(galleryViewProvider.select((state) => state.foldersInfoList));
    final folders = ref.watch(galleryViewProvider.select((state) => state.folders));

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
                itemCount: foldersInfolist.length,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 40),
                itemBuilder: (context, index) {
                  CustomFolderModel folderInfo = foldersInfolist[index];
                  // only show if there is an image in the folder
                  if (folderInfo.count <= 0) return null;

                  return ScaledTap(
                    onTap: () {
                      ref.read(galleryViewProvider.notifier).changeFolder(folders[index]);
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
              // custom drag handle
              Container(
                color: Theme.of(context).colorScheme.surface,
                width: double.infinity,
                height: 35,
                child: Align(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
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
              selectedFolder != null
                  ? selectedFolder.name
                  : folders.isNotEmpty
                      ? 'Select folder'
                      : '',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 5),
          Icon(
            PhosphorIcons.caretDown(PhosphorIconsStyle.fill),
            size: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}
