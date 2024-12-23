import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

class CameraGridItem extends StatelessWidget {
  final Function(AssetEntity) onImageCaptured;

  const CameraGridItem({super.key, required this.onImageCaptured});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return ScaledTap(
      onTap: () async {
        try {
          final XFile? photo = await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 90,
          );

          if (photo != null) {
            final File photoFile = File(photo.path);
            final Uint8List bytes = await photoFile.readAsBytes();

            final AssetEntity asset = await PhotoManager.editor.saveImage(
              bytes,
              title: 'Camera_${DateTime.now().millisecondsSinceEpoch}.jpg',
              filename: 'image',
            );

            onImageCaptured(asset);
          }
        } catch (e) {
          if (context.mounted) {
            // Show error dialog
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.camera(PhosphorIconsStyle.regular),
            size: 35,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(height: 3),
          const Text(
            'Camera',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
