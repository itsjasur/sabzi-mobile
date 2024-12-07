import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/models/item_model.dart';

class HomePageState {
  final bool isScrolled;
  // final bool hasScrollReachedEnd;

  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;

  final List<ItemModel> items;
  final int currentItemsPageNumber;
  final bool isLoadingMoreItems;
  final bool hasMoreItems;

  HomePageState({
    this.isScrolled = false,
    // this.hasScrollReachedEnd = false,
    //
    required this.categories,
    this.selectedCategory,
    //
    required this.items,
    required this.currentItemsPageNumber,
    this.isLoadingMoreItems = false,
    required this.hasMoreItems,
  });

  HomePageState copyWith({
    bool? isScrolled,
    bool? hasScrollReachedEnd,
    //
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    //
    List<ItemModel>? items,
    int? currentItemsPageNumber,
    bool? isLoadingMoreItems,
    bool? hasMoreItems,
  }) {
    return HomePageState(
      isScrolled: isScrolled ?? this.isScrolled,
      // hasScrollReachedEnd: hasScrollReachedEnd ?? this.hasScrollReachedEnd,
      //
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      //
      items: items ?? this.items,
      currentItemsPageNumber: currentItemsPageNumber ?? this.currentItemsPageNumber,
      isLoadingMoreItems: isLoadingMoreItems ?? this.isLoadingMoreItems,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
    );
  }
}
