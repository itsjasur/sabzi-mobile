// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
// import 'package:flutter_sabzi/core/models/category_model.dart';
// import 'package:flutter_sabzi/core/models/item_model.dart';
// import 'package:flutter_sabzi/pages/home/home_page_state.dart';
// import 'package:flutter_sabzi/test/categories.dart';
// import 'package:flutter_sabzi/test/items.dart';

// class HomePageNotifier extends AsyncNotifier<HomePageState> with ScrollMixin<HomePageState> {
//   @override
//   Future<HomePageState> build() async {
//     // initialize scroll
//     initializeScroll();

//     // register cleanup
//     ref.onDispose(() {
//       disposeScroll();
//     });

//     // fetch data
//     final categories = await _fetchCategories();
//     final items = await _fetchItems();

//     // return complete initial state
//     return HomePageState(
//       categories: categories,
//       items: items,
//     );
//   }

//   Future<List<CategoryModel>> _fetchCategories() async {
//     try {
//       // navigatorKey.currentState.context.

//       // SnackBarService.show('Done fetching!');
//       await Future.delayed(const Duration(seconds: 2));
//       // return categoriesList;
//       return [];
//     } catch (e, stack) {
//       print('Error fetching categories: $e\n$stack');
//       rethrow;
//     }
//   }

//   Future<List<ItemModel>> _fetchItems() async {
//     try {
//       // final response = await _apiService.post('items', {});
//       await Future.delayed(const Duration(seconds: 2));
//       // return itemsList;
//       return [];
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }

//   // Other methods remain the same
//   @override
//   void updateScrollState(bool isScrolled, double offset, bool isScrollReachedBottom) {
//     if (state.valueOrNull == null) return;

//     state = AsyncData(state.value!.copyWith(isScrolled: isScrolled));

//     if (!state.value!.isScrollReachedBottom && isScrollReachedBottom) {
//       state = AsyncData(state.value!.copyWith(isScrollReachedBottom: true));
//     }
//   }

//   void setCategories(List<CategoryModel> categories) {
//     if (state.valueOrNull == null) return;
//     state = AsyncData(state.value!.copyWith(categories: categories));
//   }

//   void selectCategory(CategoryModel category) {
//     if (state.valueOrNull == null) return;
//     state = AsyncData(state.value!.copyWith(selectedCategory: category));
//   }

//   Future<void> refresh() async {
//     state = const AsyncLoading();
//     try {
//       final categories = await _fetchCategories();
//       final items = await _fetchItems();
//       state = AsyncData(HomePageState(
//         categories: categories,
//         items: items,
//         isScrolled: false,
//         isScrollReachedBottom: false,
//       ));
//     } catch (e, stack) {
//       state = AsyncError(e, stack);
//     }
//   }

//   void setLoading() {
//     state = const AsyncLoading();
//   }

//   void setError(Object error, StackTrace stackTrace) {
//     state = AsyncError(error, stackTrace);
//   }
// }

// final homePageProvider = AsyncNotifierProvider<HomePageNotifier, HomePageState>(() {
//   return HomePageNotifier();
// });
