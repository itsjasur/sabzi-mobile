import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/pages/home/category/categories_state.dart';

class CategoriesProvider extends Notifier<CategoriesState> {
  @override
  build() {
    Future.microtask(() {
      _fetchCategories();
    });

    return CategoriesState();
  }

  void toggleCategorySelect() {
    state = state.copyWith(selectedCategoryId: state.selectedCategoryId);
  }

  void _fetchCategories() {
    final List<CategoryModel> categories = [
      CategoryModel(id: 1, name: 'Electronics', imagUrl: "assets/iphone.png"),
      CategoryModel(id: 2, name: 'Furniture & interior', imagUrl: "assets/iphone.png"),
      CategoryModel(id: 3, name: 'Women\'s fashion', imagUrl: "assets/iphone.png"),
    ];

    state = state.copyWith(categories: categories);
  }
}

final categoriesProvider = NotifierProvider<CategoriesProvider, CategoriesState>(() => CategoriesProvider());