import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/pagination.dart';
import 'package:flutter_sabzi/pages/home/home_page_state.dart';
import 'package:flutter_sabzi/pages/home/test.dart';

class HomePageProvider extends Notifier<HomePageState> with ScrollMixin<HomePageState> {
  @override
  HomePageState build() {
    // Initialize
    initializeScroll();

    // register cleanup
    ref.onDispose(() {
      disposeScroll();
    });

    Future.microtask(() {
      _fetchListings();
    });

    return HomePageState(listings: Pagination(items: [], pageNumber: 1, hasMoreItems: true, isLoading: false));
  }

  Future<void> refreshListings() async {
    state = state.copyWith(listings: state.listings.copyWith(items: [], pageNumber: 1, hasMoreItems: true, isLoading: false));

    await _fetchListings();
  }

  Future<void> _fetchListings() async {
    if (state.listings.isLoading || !state.listings.hasMoreItems) return;

    print('pageNumber ${state.listings.pageNumber}');

    // change to loading more listings
    state = state.copyWith(listings: state.listings.copyWith(pageNumber: state.listings.pageNumber + 1, isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    // API CALL HERE
    try {
      state = state.copyWith(listings: state.listings.copyWith(items: [...listingsList, ...state.listings.items], hasMoreItems: false, isLoading: false));
    } catch (e) {
      print(e);
    }
  }

  @override
  void updateScrollState(bool isScrolled, double offset, bool hasScrollReachedBottom) {
    state = state.copyWith(isPageScrolled: isScrolled);

    if (hasScrollReachedBottom) {
      if (state.listings.hasMoreItems && !state.listings.isLoading) {
        print('LOADING MORE ITEMS');
      }
    }
  }
}

final homePageProvider = NotifierProvider<HomePageProvider, HomePageState>(() {
  return HomePageProvider();
});
