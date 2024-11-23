import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/utils/api_service.dart';
import 'package:flutter_sabzi/pages/home/home_page_state.dart';

class HomePageNotifier extends StateNotifier<HomePageState> with ScrollMixin<HomePageState> {
  final ApiService _apiService;

  HomePageNotifier({
    required ApiService apiService,
  })  : _apiService = apiService,
        super(HomePageState(categories: [])) {
    initializeScroll(); // initializes scroll controller
    fetchCategories();
  }

  void fetchCategories() async {
    // This method has issues:
    await Future.delayed(const Duration(seconds: 2)); // This line has no effect

    try {
      final response = await _apiService.post('categories', {});
      // final categories = state = state.copyWith(categories: categories);
    } catch (e) {
      // state = state.copyWith(error: e.toString());
    }
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
  return HomePageNotifier(
    apiService: ref.watch(apiServiceProvider),
  );
});
