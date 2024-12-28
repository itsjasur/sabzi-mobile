import 'dart:typed_data';

import 'package:flutter/material.dart';

class AddListingState {
  final List<MapEntry<String, Uint8List>> selectedAssetEntityList;
  final String selectedCurrency;
  final bool isPriceNegotiable;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  AddListingState({
    required this.selectedAssetEntityList,
    required this.selectedCurrency,
    required this.isPriceNegotiable,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
  });

  // Don't forget to update copyWith
  AddListingState copyWith({
    List<MapEntry<String, Uint8List>>? selectedAssetEntityList,
    String? selectedCurrency,
    bool? isPriceNegotiable,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    TextEditingController? priceController,
  }) {
    return AddListingState(
      selectedAssetEntityList: selectedAssetEntityList ?? this.selectedAssetEntityList,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      isPriceNegotiable: isPriceNegotiable ?? this.isPriceNegotiable,
      titleController: titleController ?? this.titleController,
      descriptionController: descriptionController ?? this.descriptionController,
      priceController: priceController ?? this.priceController,
    );
  }
}
