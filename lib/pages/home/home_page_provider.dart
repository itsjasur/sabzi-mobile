import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app_provider.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/pages/home/home_page_state.dart';
import 'package:flutter_sabzi/test/categories.dart';
import 'package:flutter_sabzi/test/items.dart';

class HomePageNotifier extends Notifier<HomePageState> with ScrollMixin<HomePageState> {
  @override
  HomePageState build() {
    // Initialize
    initializeScroll();

    // register cleanup
    ref.onDispose(() {
      disposeScroll();
    });

    // call fetchCategories in the next frame update
    Future.microtask(() {
      _fetchCategories();
      fetchItems();
    });

    return HomePageState(categories: [], items: []);
  }

  // ApiService get _apiService => ref.watch(apiServiceProvider);
  void _fetchCategories() async {
    ref.read(appProvider.notifier).setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(categories: categoriesList);
    ref.read(appProvider.notifier).setLoading(false);
  }

  void fetchItems() async {
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(items: itemsList);
  }

  @override
  void updateScrollState(bool isScrolled, double offset, bool isScrollReachedBottom) {
    state = state.copyWith(isScrolled: isScrolled);

    if (!state.isScrollReachedBottom && isScrollReachedBottom) {
      state = state.copyWith(isScrollReachedBottom: true);
    }
  }

  void setCategories(List<CategoryModel> categories) {
    state = state.copyWith(categories: categories);
  }

  void selectCategory(CategoryModel category) {
    state = state.copyWith(selectedCategory: category);
  }
}

final homePageProvider = NotifierProvider<HomePageNotifier, HomePageState>(() {
  return HomePageNotifier();
});
