import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_state.dart';
import 'package:flutter_sabzi/pages/add_item/models/listing_draft_model.dart';
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

        state.titleController.text = draft.title;
        state.descriptionController.text = draft.description;
        state.priceController.text = draft.price;

        state = state.copyWith(
          selectedCurrency: draft.currency,
          isPriceNegotiable: draft.isPriceNegotiable,
          selectedImages: draft.images,
        );
      } catch (e) {
        print('Error loading draft: $e');
      }
    }
  }

  void saveDraft() async {
    final draft = ListingDraftModel(
      title: state.titleController.text,
      description: state.descriptionController.text,
      price: state.priceController.text,
      currency: state.selectedCurrency,
      isPriceNegotiable: state.isPriceNegotiable,
      images: state.selectedImages,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('item_draft', jsonEncode(draft.toJson()));
  }

  void saveListing() {}
}

final addListingProvider = NotifierProvider<AddListingProvider, AddListingState>(() => AddListingProvider());
