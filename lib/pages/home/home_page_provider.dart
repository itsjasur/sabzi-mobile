import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/utils/api_service.dart';
import 'package:flutter_sabzi/pages/home/home_page_state.dart';
import 'package:flutter_sabzi/test/categories.dart';
import 'package:flutter_sabzi/test/items.dart';

class HomePageProvider extends StateNotifier<HomePageState> with ScrollMixin<HomePageState> {
  final ApiService _apiService;

  HomePageProvider({
    required ApiService apiService,
  })  : _apiService = apiService,
        super(HomePageState(categories: [], items: [])) {
    initializeScroll(); // initializes scroll controller
    fetchCategories();
    fetchItems();
  }

// TODO: implement this
  void fetchCategories() async {
    // await Future.delayed(const Duration(seconds: 2));
    try {
      state = state.copyWith(categories: categoriesList);
      // final response = await _apiService.post('categories', {});
    } catch (e) {
      print(e);
    }
  }

// TODO: implement this
  void fetchItems() async {
    // await Future.delayed(const Duration(seconds: 2));
    try {
      state = state.copyWith(items: itemsList);
      // final response = await _apiService.post('categories', {});

      // change to this when item list comes empty
      // state = state.copyWith(haveMoreItems: false);
    } catch (e) {
      print(e);
    }
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

  @override
  void dispose() {
    disposeScroll(); // cleans up scroll controller
    super.dispose();
  }
}

final homePageProvider = StateNotifierProvider<HomePageProvider, HomePageState>((ref) {
  return HomePageProvider(
    apiService: ref.watch(apiServiceProvider),
  );
});
