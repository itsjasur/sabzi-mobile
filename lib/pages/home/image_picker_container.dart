import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/gallery_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePickerContainer extends StatefulWidget {
  final bool multipleUploable;
  final Function(List<File>)? getImages;

  const ImagePickerContainer({super.key, this.getImages, this.multipleUploable = true});

  @override
  State<ImagePickerContainer> createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  List<File> _images = [];
  double _containerSize = 75;

  @override
  build(BuildContext context) {
    return Material(
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                ScaledTap(
                  onTap: pickImagesFromGallery,
                  child: Container(
                    height: _containerSize,
                    width: _containerSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        // color: colors.secondary.withOpacity(0.35),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 25,
                          // color: colors.secondary.withOpacity(0.4),
                        ),
                        const SizedBox(height: 2),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              // color: colors.secondary.withOpacity(0.6),
                            ),
                            children: [
                              TextSpan(
                                text: _images.length.toString(),
                                // style: TextStyle(color: colors.main),
                              ),
                              const TextSpan(text: '/10'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ...List.generate(
                  _images.length,
                  (index) => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            _images[index],
                            height: _containerSize,
                            width: _containerSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: ScaledTap(
                          onTap: () {
                            setState(() {
                              _images.removeAt(index);
                            });

                            // showCustomSnackBar('asds');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: colors.secondary,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImagesFromGallery() async {
    // await Permission.storage.request();
    // await Permission.camera.request();

    // await getImageFolders();

    print('permission requested');

    if (mounted) {
      showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (_) => const GalleryView(),
      );
    }
  }

  // Future<List<AssetPathEntity>> getImageFolders() async {
  //   // Request permissions if not already granted
  //   var permissionStatus = await PhotoManager.requestPermissionExtend();
  //   if (permissionStatus.isAuth) {
  //     // Fetch only image folders
  //     List<AssetPathEntity> folders = await PhotoManager.getAssetPathList(
  //       onlyAll: true,
  //       type: RequestType.image,
  //     );

  //     print(folders.length);

  //     return folders;
  //   } else {
  //     // Handle the case where permissions are denied
  //     PhotoManager.openSetting();
  //     return [];
  //   }
  // }

  // Future<void> pickImagesFromGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   try {
  //     final List<XFile> xFiles = await picker.pickMultiImage();
  //     // List<String> originalFilenames = xFiles.map((xFile) => xFile.name).toList();

  //     if (xFiles.isNotEmpty) {
  //       // converts XFile list to File list
  //       List<File> files = xFiles.map((xFile) => File(xFile.path)).toList();
  //       _images.addAll(files);
  //       // _images = xFiles.map((xFile) => File(xFile.path)).toList();
  //       setState(() {});

  //       // widget.getImages?.call(files);ytytttrftt
  //     } else {
  //       showCustomSnackBar('No images selected');
  //     }
  //   } catch (e) {
  //     showCustomSnackBar('Error picking images: $e');
  //   }
  // }
}
