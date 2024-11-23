import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/pages/home/home_page_state.dart';

class HomePageNotifier extends StateNotifier<HomePageState> with ScrollMixin<HomePageState> {
  HomePageNotifier() : super(HomePageState(categories: [])) {
    initializeScroll(); // initializes scroll controller
  }

  @override
  void updateScrollState(bool isScrolled, double offset, bool isAtBottom) {
    state = state.copyWith(isScrolled: isScrolled);
  }
  // if (state.isScrolled != isScrolled)

  void setCategories(List<CategoryModel> categories) {
    state = state.copyWith(categories: categories);
  }

  void selectCategory(CategoryModel category) {
    state = state.copyWith(selectedCategory: category);
  }

  @override
  void dispose() {
    disposeScroll(); // cleans up scroll controller
    super.dispose();
  }
}

final homePageProvider = StateNotifierProvider<HomePageNotifier, HomePageState>((ref) {
  return HomePageNotifier();
});
