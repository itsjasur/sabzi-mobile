import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_state.dart';
import 'package:flutter_sabzi/pages/add_item/models/listing_draft_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddListingProvider extends Notifier<AddListingState> {
  @override
  AddListingState build() {
    final state = AddListingState(
      selectedImages: [],
      selectedCurrency: 'UZS',
      isPriceNegotiable: true,
      titleController: TextEditingController(),
      descriptionController: TextEditingController(),
      priceController: TextEditingController(text: '0'),
    );

    // disposal
    ref.onDispose(() {
      state.titleController.dispose();
      state.descriptionController.dispose();
      state.priceController.dispose();
    });
    _loadDraft();
    return state;
  }

  void updateCurrency(String val) {
    state = state.copyWith(selectedCurrency: val);
  }

  void togglePriceNegotiable() {
    state = state.copyWith(isPriceNegotiable: !state.isPriceNegotiable);
  }

  void swapItemPosition(int oldIndex, int newIndex) {
    final updatedList = [...state.selectedImages];
    // adjusts the newIndex if it's after the removal point
    if (newIndex > oldIndex) newIndex -= 1;

    final removedItem = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, removedItem);
    state = state.copyWith(selectedImages: updatedList);
  }

  void removeImageWithIndex(int index) {
    final List<Uint8List> updatedList = [...state.selectedImages];
    updatedList.removeAt(index);
    state = state.copyWith(selectedImages: updatedList);
  }

  Future<void> saveAssetsAsBytes(List<AssetEntity> assets) async {
    for (AssetEntity asset in assets) {
      final image = await asset.originBytes;
      if (image != null) {
        state = state.copyWith(selectedImages: [...state.selectedImages, image]);
      }
    }
  }

  Future<void> _loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final draftJson = prefs.getString('item_draft');

    if (draftJson != null) {
      try {
        final draft = ListingDraftModel.fromJson(jsonDecode(draftJson));

        List<Uint8List> images = [];
        for (String path in draft.imagePaths) {
          final file = File(path);
          if (await file.exists()) {
            images.add(await file.readAsBytes());
          }
        }

        state.titleController.text = draft.title;
        state.descriptionController.text = draft.description;
        state.priceController.text = draft.price;

        state = state.copyWith(
          selectedCurrency: draft.currency,
          isPriceNegotiable: draft.isPriceNegotiable,
          selectedImages: images,
        );
      } catch (e, trace) {
        print('Error loading draft: $e');
        print('Error loading draft: $trace');
      }
    }
  }

  void saveDraft() async {
    final directory = await getApplicationDocumentsDirectory();
    List<String> imagePaths = [];

    for (int i = 0; i < state.selectedImages.length; i++) {
      final timestamp = DateTime.now().millisecondsSinceEpoch; //  timestamp to prevent filename conflicts
      final imagePath = '${directory.path}/draft_image_${timestamp}_$i.jpg';
      final file = File(imagePath);
      await file.writeAsBytes(state.selectedImages[i]);
      imagePaths.add(imagePath);
    }

    final draft = ListingDraftModel(
      title: state.titleController.text,
      description: state.descriptionController.text,
      price: state.priceController.text,
      currency: state.selectedCurrency,
      isPriceNegotiable: state.isPriceNegotiable,
      imagePaths: imagePaths,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('item_draft', jsonEncode(draft.toJson()));
  }

  void saveListing() {}
}

final addListingProvider = NotifierProvider<AddListingProvider, AddListingState>(() => AddListingProvider());
