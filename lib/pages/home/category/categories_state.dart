import 'package:flutter_sabzi/core/models/category_model.dart';

class CategoriesState {
  final int? selectedCategoryId;
  final List<CategoryModel> categories;

  CategoriesState({this.selectedCategoryId, this.categories = const <CategoryModel>[]});

  CategoriesState copyWith({
    int? selectedCategoryId,
    List<CategoryModel>? categories,
  }) {
    return CategoriesState(
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      categories: categories ?? this.categories,
    );
  }
}
