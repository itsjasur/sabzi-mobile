import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view.dart';

class ImagePickerContainer extends StatefulWidget {
  final bool multipleUploable;
  final Function(List<File>)? getImages;

  const ImagePickerContainer({super.key, this.getImages, this.multipleUploable = true});

  @override
  State<ImagePickerContainer> createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  final List<File> _images = [];
  final double _containerSize = 75;

  @override
  void initState() {
    super.initState();
  }

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
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      useSafeArea: true,
                      isDismissible: false,
                      barrierColor: Theme.of(context).colorScheme.surface,
                      builder: (_) => const GalleryView(),
                    );
                  },
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
                        const Icon(
                          Icons.camera_alt,
                          size: 25,
                          // color: colors.secondary.withOpacity(0.4),
                        ),
                        const SizedBox(height: 2),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
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
                            decoration: const BoxDecoration(
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
}
