import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app_provider.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/pages/home/home_page_state.dart';
import 'package:flutter_sabzi/test/categories.dart';
import 'package:flutter_sabzi/test/items.dart';

class HomePageProvider extends Notifier<HomePageState> with ScrollMixin<HomePageState> {
  @override
  HomePageState build() {
    // Initialize
    initializeScroll();

    // register cleanup
    ref.onDispose(() {
      disposeScroll();
    });

    // calls _fetchCategories & _fetchNextItems in the next frame update
    Future.microtask(() async {
      ref.read(appProvider.notifier).setLoading(true);
      // await _fetchCategories();
      await _fetchNextItems();
      ref.read(appProvider.notifier).setLoading(false);
    });

    return HomePageState(items: [], currentItemsPageNumber: 1, hasMoreItems: true);
  }

  // ApiService get _apiService => ref.watch(apiServiceProvider);
  // Future<void> _fetchCategories() async {
  //   await Future.delayed(const Duration(microseconds: 100));

  //   try {
  //     state = state.copyWith(categories: categoriesList, selectedCategory: categoriesList[0]);

  //     // FETCH ITEMS ARE CALLED AFTER CATEGORIES with categoryId
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> refreshItems() async {
    state = state.copyWith(currentItemsPageNumber: 1, hasMoreItems: true);
    await _fetchNextItems();
  }

  Future<void> _fetchNextItems() async {
    // return if not more items or currently loading more
    if (state.isLoadingMoreItems || !state.hasMoreItems) return;

    print('fetch items calleld');
    print('isLoadingMoreItems ${state.isLoadingMoreItems}');
    print('hasMoreItems ${state.hasMoreItems}');
    print('pageNumber ${state.currentItemsPageNumber}');

    // change to loading more items
    state = state.copyWith(isLoadingMoreItems: true);

    // API CALL HERE
    try {
      await Future.delayed(const Duration(microseconds: 100));
      // has no more items
      if (itemsList.isEmpty) {
        state = state.copyWith(hasMoreItems: false);
        return;
      }

      // if more items received
      state = state.copyWith(items: [...state.items + itemsList], currentItemsPageNumber: state.currentItemsPageNumber + 1);
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoadingMoreItems: false);
    }
  }

  @override
  void updateScrollState(bool isScrolled, double offset, bool hasScrollReachedBottom) {
    state = state.copyWith(isScrolled: isScrolled);

    if (hasScrollReachedBottom && !state.isLoadingMoreItems && state.hasMoreItems) {
      print('scrolled reached bottom');
      _fetchNextItems();
    }

    // if (!state.hasScrollReachedEnd && hasScrollReachedBottom) {
    //   state = state.copyWith(hasScrollReachedEnd: true);
    // }
  }

  // void setCategories(List<CategoryModel> categories) {
  //   state = state.copyWith(categories: categories);
  // }

  // void selectCategory(CategoryModel category) {
  //   state = state.copyWith(selectedCategory: category);
  // }
}

final homePageProvider = NotifierProvider<HomePageProvider, HomePageState>(() {
  return HomePageProvider();
});
