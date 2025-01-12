import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/models/listing_model.dart';
import 'package:flutter_sabzi/core/models/pagination.dart';

class SearchState {
  final TextEditingController searchTextController;
  final FocusNode focusNode;
  final Set<String> recentSearchKeywords;
  final Set<String> suggestedSearchKeywords;
  final bool isSearchRequested;
  final bool isReceiveNotificationsChecked;
  final bool isShowOnlyAvailableChecked;

  final Pagination<ListingModel> listings;

  SearchState({
    required this.searchTextController,
    required this.focusNode,
    required this.recentSearchKeywords,
    required this.suggestedSearchKeywords,
    required this.isSearchRequested,
    required this.isReceiveNotificationsChecked,
    required this.isShowOnlyAvailableChecked,
    required this.listings,
  });

  SearchState copyWith({
    Set<String>? recentSearchKeywords,
    Set<String>? suggestedSearchKeywords,
    bool? isSearchRequested,
    bool? isReceiveNotificationsChecked,
    bool? isShowOnlyAvailableChecked,
    Pagination<ListingModel>? listings,
  }) {
    return SearchState(
      searchTextController: searchTextController,
      focusNode: focusNode,
      recentSearchKeywords: recentSearchKeywords ?? this.recentSearchKeywords,
      suggestedSearchKeywords: suggestedSearchKeywords ?? this.suggestedSearchKeywords,
      isSearchRequested: isSearchRequested ?? this.isSearchRequested,
      isReceiveNotificationsChecked: isReceiveNotificationsChecked ?? this.isReceiveNotificationsChecked,
      isShowOnlyAvailableChecked: isShowOnlyAvailableChecked ?? this.isShowOnlyAvailableChecked,
      listings: listings ?? this.listings,
    );
  }
}
