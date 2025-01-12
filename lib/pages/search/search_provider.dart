import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/home/test.dart';
import 'package:flutter_sabzi/pages/search/search_state.dart';

class SearchProvider extends Notifier<SearchState> {
  @override
  build() {
    final FocusNode focusNode = FocusNode();
    final TextEditingController searchTextController = TextEditingController();

    focusNode.addListener(() {
      state = state.copyWith();
    });
    searchTextController.addListener(() {
      // print('searchcontroller changed');
      // state = state.copyWith(isSearchRequested: false);
    });

    ref.onDispose(() {
      focusNode.dispose();
      searchTextController.dispose();
    });

    return SearchState(
      searchTextController: searchTextController,
      isSearchRequested: false,
      focusNode: focusNode,
      recentSearchKeywords: {'samsung', 'iphone', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei'},
      suggestedSearchKeywords: {'samsung', 'iphone', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei'},
      foundListings: [],
      isSearching: false,
      isReceiveNotificationsChecked: false,
      isShowOnlyAvailableChecked: false,
    );
  }

  void updateSearchkeyword(String value) {
    print('setsearchkeyword called');
    state.searchTextController.text = value;
    state = state.copyWith(isSearchRequested: false, foundListings: []);
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
    state = state.copyWith(isSearchRequested: false, foundListings: [], isSearching: false);
  }

  void toggleCheckboxForNotifications() {
    state = state.copyWith(isReceiveNotificationsChecked: !state.isReceiveNotificationsChecked);
  }

  void toggleCheckboxForListingStatus() {
    state = state.copyWith(isShowOnlyAvailableChecked: !state.isShowOnlyAvailableChecked);
  }

  void searchListings() async {
    print('searchListings called');
    state.focusNode.unfocus();

    state = state.copyWith(isSearchRequested: true, isSearching: true, recentSearchKeywords: {state.searchTextController.text, ...state.recentSearchKeywords});
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isSearching: false,
      foundListings: listingsList,
    );
  }
}

final searchProvider = NotifierProvider<SearchProvider, SearchState>(() => SearchProvider());
