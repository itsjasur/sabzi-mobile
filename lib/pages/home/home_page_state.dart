import 'package:flutter_sabzi/core/models/category_model.dart';

class HomePageState {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final bool isScrolled;

  HomePageState({
    required this.categories,
    this.selectedCategory,
    this.isScrolled = false,
  });

  HomePageState copyWith({
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    bool? isScrolled,
  }) {
    return HomePageState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isScrolled: isScrolled ?? this.isScrolled,
    );
  }
}
