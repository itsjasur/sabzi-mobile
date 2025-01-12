import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/models/listing_model.dart';

class SearchState {
  final TextEditingController searchTextController;
  // final String searchKeyword;
  final FocusNode focusNode;

  final Set<String> recentSearchKeywords;
  final Set<String> suggestedSearchKeywords;
  final List<ListingModel> foundListings;
  final bool isSearchRequested;
  final bool isSearching;
  final bool isReceiveNotificationsChecked;
  final bool isShowOnlyAvailableChecked;

  SearchState({
    required this.searchTextController,
    // required this.searchKeyword,
    required this.focusNode,
    required this.recentSearchKeywords,
    required this.suggestedSearchKeywords,
    required this.foundListings,
    required this.isSearchRequested,
    required this.isSearching,
    required this.isReceiveNotificationsChecked,
    required this.isShowOnlyAvailableChecked,
  });

  SearchState copyWith({
    // String? searchKeyword,
    Set<String>? recentSearchKeywords,
    Set<String>? suggestedSearchKeywords,
    List<ListingModel>? foundListings,
    bool? isSearchRequested,
    bool? isSearching,
    bool? isReceiveNotificationsChecked,
    bool? isShowOnlyAvailableChecked,
  }) {
    return SearchState(
      searchTextController: searchTextController,
      // searchKeyword: searchKeyword ?? this.searchKeyword,
      focusNode: focusNode,
      recentSearchKeywords: recentSearchKeywords ?? this.recentSearchKeywords,
      suggestedSearchKeywords: suggestedSearchKeywords ?? this.suggestedSearchKeywords,
      foundListings: foundListings ?? this.foundListings,
      isSearchRequested: isSearchRequested ?? this.isSearchRequested,
      isSearching: isSearching ?? this.isSearching,
      isReceiveNotificationsChecked: isReceiveNotificationsChecked ?? this.isReceiveNotificationsChecked,
      isShowOnlyAvailableChecked: isShowOnlyAvailableChecked ?? this.isShowOnlyAvailableChecked,
    );
  }
}
