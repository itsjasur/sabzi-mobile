import 'package:flutter_sabzi/core/models/category_model.dart';

class CategoriesState {
  final int selectedCategoryId;
  final List<CategoryModel> categories;

  CategoriesState({this.selectedCategoryId = -1, this.categories = const <CategoryModel>[]});

  CategoriesState copyWith({
    int? selectedCategoryId,
    // int? Function()? selectedCategoryId,
    List<CategoryModel>? categories,
  }) {
    return CategoriesState(
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      // selectedCategoryId: selectedCategoryId != null ? selectedCategoryId() : this.selectedCategoryId,
      categories: categories ?? this.categories,
    );
  }
}
