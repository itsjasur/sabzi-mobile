import 'dart:typed_data';

import 'package:flutter/material.dart';

class AddListingState {
  final List<Uint8List> selectedImages;
  final String selectedCurrency;
  final bool isPriceNegotiable;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  final int selectedCategoryId;

  AddListingState({
    required this.selectedImages,
    required this.selectedCurrency,
    required this.isPriceNegotiable,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    this.selectedCategoryId = -1,
  });

  AddListingState copyWith({
    List<Uint8List>? selectedImages,
    String? selectedCurrency,
    bool? isPriceNegotiable,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    TextEditingController? priceController,
    int? selectedCategoryId,
  }) {
    return AddListingState(
      selectedImages: selectedImages ?? this.selectedImages,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      isPriceNegotiable: isPriceNegotiable ?? this.isPriceNegotiable,
      titleController: titleController ?? this.titleController,
      descriptionController: descriptionController ?? this.descriptionController,
      priceController: priceController ?? this.priceController,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}
