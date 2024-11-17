import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/item_model.dart';
import 'package:flutter_sabzi/core/models/pagination_state_model.dart';
import 'package:flutter_sabzi/test/categories.dart';
import 'package:flutter_sabzi/test/items.dart';

class HomePageProvider with ChangeNotifier, ScrollMixin {
  HomePageProvider() {
    initializeScroll();
    setCategories(categoriesList);
    setCategory(_categories[0]);
  }

  // category handlers
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  CategoryModel? _selectedCategory;
  CategoryModel? get selectedCategory => _selectedCategory;
  void setCategories(List<CategoryModel> c) {
    _categories = c;
    notifyListeners();
  }

  void setCategory(CategoryModel c) {
    _selectedCategory = c;
    notifyListeners();
  }

  // items handler
  List<ItemModel> _items = [];
  List<ItemModel> get items => _items;

  PaginationStateModel _paginationState = const PaginationStateModel(currentPage: 0, perPage: 10);
  PaginationStateModel get paginationState => _paginationState;

  void fetchItems() {
    if (_paginationState.isLoading || !_paginationState.hasMore) return;

    try {
      _paginationState = _paginationState.copyWith(isLoading: true);
      notifyListeners();

      _items = itemsList;

      // //  API call
      // final newItems = await apiCall(
      //   page: _paginationState.currentPage,
      //   perPage: _paginationState.perPage,
      // );

      // if (newItems.isEmpty) {
      //   _paginationState = _paginationState.copyWith(hasMore: false);
      // } else {
      //   _items.addAll(newItems);
      //   _paginationState = _paginationState.copyWith(
      //     currentPage: _paginationState.currentPage + 1,
      //   );
      // }
    } catch (e) {
      _paginationState = _paginationState.copyWith(error: e.toString());
    } finally {
      _paginationState = _paginationState.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void resetPagination() {
    _items.clear();
    _paginationState = const PaginationStateModel();
    notifyListeners();
  }

  @override
  void dispose() {
    disposeScroll();
    super.dispose();
  }
}
