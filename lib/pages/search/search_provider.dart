import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/mixins/scroll_mixin.dart';
import 'package:flutter_sabzi/core/models/pagination.dart';
import 'package:flutter_sabzi/pages/home/test.dart';
import 'package:flutter_sabzi/pages/search/search_state.dart';

class SearchProvider extends Notifier<SearchState> with ScrollMixin<SearchState> {
  @override
  build() {
    initializeScroll();
    final FocusNode focusNode = FocusNode();
    final TextEditingController searchTextController = TextEditingController();

    focusNode.addListener(() {
      state = state.copyWith();
    });
    // searchTextController.addListener(() {
    // print('searchcontroller changed');
    // });

    ref.onDispose(() {
      focusNode.dispose();
      searchTextController.dispose();
      disposeScroll();
    });

    return SearchState(
      searchTextController: searchTextController,
      isSearchRequested: false,
      focusNode: focusNode,
      recentSearchKeywords: {'samsung', 'iphone', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei'},
      suggestedSearchKeywords: {'samsung', 'iphone', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei'},
      isReceiveNotificationsChecked: false,
      isShowOnlyAvailableChecked: false,
      listings: Pagination(items: [], pageNumber: 1, hasMoreItems: true, isLoading: false),
    );
  }

  void toggleCheckboxForNotifications() {
    state = state.copyWith(isReceiveNotificationsChecked: !state.isReceiveNotificationsChecked);
  }

  void toggleCheckboxForListingStatus() {
    state = state.copyWith(isShowOnlyAvailableChecked: !state.isShowOnlyAvailableChecked);
  }

  void updateSearchkeyword(String value) {
    print('setsearchkeyword called');
    state.searchTextController.text = value;
    state = state.copyWith(
      isSearchRequested: false,
      listings: state.listings.copyWith(items: [], pageNumber: 1, hasMoreItems: true, isLoading: false),
    );
  }

  void removeRecentSearchkeyword(String value) {
    Set<String> updatedList = state.recentSearchKeywords;
    updatedList.remove(value);

    state = state.copyWith(recentSearchKeywords: updatedList);
  }

  void deleteAllRecentSearchkeywords() {
    state = state.copyWith(recentSearchKeywords: {});
  }

  void clearSearchKeywordInputText() {
    state.searchTextController.clear();

    state = state.copyWith(
      isSearchRequested: false,
      listings: state.listings.copyWith(items: [], pageNumber: 1, hasMoreItems: true, isLoading: false),
    );
  }

  Future<void> refreshListings() async {
    state = state.copyWith(listings: state.listings.copyWith(items: [], pageNumber: 1, hasMoreItems: true, isLoading: false));
    await fetchListings();
  }

  Future<void> fetchListings() async {
    if (state.listings.isLoading || !state.listings.hasMoreItems) return;

    print('searchListings called');
    state.focusNode.unfocus();

    state = state.copyWith(
      isSearchRequested: true,
      recentSearchKeywords: {state.searchTextController.text, ...state.recentSearchKeywords},
      listings: state.listings.copyWith(pageNumber: state.listings.pageNumber + 1, isLoading: true),
    );

    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      listings: state.listings.copyWith(items: [...listingsList, ...state.listings.items], hasMoreItems: false, isLoading: false),
    );
  }

  @override
  void updateScrollState(bool isScrolled, double offset, bool hasScrollReachedBottom) {
    if (hasScrollReachedBottom) {
      if (state.listings.hasMoreItems && !state.listings.isLoading) {
        print('LOADING MORE ITEMS');
      }
    }
  }
}

final searchProvider = NotifierProvider<SearchProvider, SearchState>(() => SearchProvider());
