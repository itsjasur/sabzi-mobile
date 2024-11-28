import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/models/item_model.dart';

class HomePageState {
  final bool isScrolled;
  final bool isScrollReachedBottom;

  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;

  final List<ItemModel> items;
  final bool isMoreItemsLoading;
  final bool haveMoreItems;

  HomePageState({
    this.isScrolled = false,
    this.isScrollReachedBottom = false,
    //
    required this.categories,
    this.selectedCategory,
    //
    required this.items,
    this.isMoreItemsLoading = false,
    this.haveMoreItems = false,
  });

  HomePageState copyWith({
    bool? isScrolled,
    bool? isScrollReachedBottom,
    //
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    //
    List<ItemModel>? items,
    bool? isMoreItemsLoading,
    bool? haveMoreItems,
  }) {
    return HomePageState(
      isScrolled: isScrolled ?? this.isScrolled,
      isScrollReachedBottom: isScrollReachedBottom ?? this.isScrollReachedBottom,
      //
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      //
      items: items ?? this.items,
      isMoreItemsLoading: isMoreItemsLoading ?? this.isMoreItemsLoading,
      haveMoreItems: haveMoreItems ?? this.haveMoreItems,
    );
  }
}
