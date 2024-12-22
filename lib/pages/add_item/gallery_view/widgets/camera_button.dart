import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/gallery_view/gallery_view_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

class CameraButton extends ConsumerWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(galleryViewProvider.notifier);
    final picker = ImagePicker(); //camera image take/picker

    return ScaledTap(
      onTap: () async {
        // tap to take picture
        try {
          final XFile? photo = await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 90, // quality  (0-100)
          );

          if (photo != null) {
            final File photoFile = File(photo.path);
            final Uint8List bytes = await photoFile.readAsBytes();

            // saves the image using PhotoManager
            final AssetEntity asset = await PhotoManager.editor.saveImage(
              bytes,
              title: 'Camera_${DateTime.now().millisecondsSinceEpoch}.jpg',
              filename: 'image',
            );
            print('Image saved successfully');
            notifier.addNewImage(asset);
          }
        } catch (e) {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text('Failed to take picture: ${e.toString()}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
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
