import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
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

    return HomePageState(listings: [], currentListingsPageNumber: 1, hasMoreListings: true);
  }

  Future<void> refreshListings() async {
    state = state.copyWith(currentListingsPageNumber: 1, hasMoreListings: true);
    await _fetchListings();
  }

  Future<void> _fetchListings() async {
    if (state.isLoadingMoreListings || !state.hasMoreListings) return;

    print('pageNumber ${state.currentListingsPageNumber}');

    // change to loading more listings
    state = state.copyWith(isLoadingMoreListings: true, currentListingsPageNumber: state.currentListingsPageNumber + 1);

    // API CALL HERE
    try {
      await Future.delayed(const Duration(microseconds: 100));
      state = state.copyWith(listings: [...state.listings + listingsList]);
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoadingMoreListings: false);
    }
  }

  @override
  void updateScrollState(bool isScrolled, double offset, bool hasScrollReachedBottom) {
    state = state.copyWith(isPageScrolled: isScrolled);

    if (hasScrollReachedBottom && !state.isLoadingMoreListings && state.hasMoreListings) {
      print('scrolled reached bottom');
      // _fetchListings();
    }

    // if (!state.hasScrollReachedEnd && hasScrollReachedBottom) {
    //   state = state.copyWith(hasScrollReachedEnd: true);
    // }
  }
}

final homePageProvider = NotifierProvider<HomePageProvider, HomePageState>(() {
  return HomePageProvider();
});
