import 'dart:convert';
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
      selectedAssetEntityList: [],
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
    final updatedList = [...state.selectedAssetEntityList];
    // adjusts the newIndex if it's after the removal point
    if (newIndex > oldIndex) newIndex -= 1;

    final removedItem = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, removedItem);
    state = state.copyWith(selectedAssetEntityList: updatedList);
  }

  void removeAssetEntity(String assetId) {
    final updatedList = state.selectedAssetEntityList.where((item) => item.key != assetId).toList();
    state = state.copyWith(selectedAssetEntityList: updatedList);
  }

  Future<void> addAssetEntity(String assetId) async {
    try {
      final asset = await AssetEntity.fromId(assetId);
      if (asset == null) {
        removeAssetEntity(assetId); //removes assetid from list if asset not found
        return;
      }
      final thumbnail = await asset.thumbnailDataWithSize(const ThumbnailSize(200, 200), quality: 80);

      if (thumbnail != null) {
        final newList = [...state.selectedAssetEntityList, MapEntry(assetId, thumbnail)];
        state = state.copyWith(selectedAssetEntityList: newList);
      }
    } catch (e) {
      print('Error adding asset: $e');
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
        );
        // loads assets
        for (final assetId in draft.assetIds) {
          await addAssetEntity(assetId);
        }
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
      assetIds: state.selectedAssetEntityList.map((e) => e.key).toList(),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('item_draft', jsonEncode(draft.toJson()));
  }

  void saveListing() {}
}

final addListingProvider = NotifierProvider<AddListingProvider, AddListingState>(() => AddListingProvider());
