import 'package:flutter_sabzi/core/models/listing_model.dart';
import 'package:flutter_sabzi/core/models/pagination.dart';

class HomePageState {
  final bool isPageScrolled;
  final Pagination<ListingModel> listings;

  // final List<ListingModel> listings;
  // final int currentListingsPageNumber;

  // final int? randomListingsSeedNumber;
  // final bool isLoadingMoreListings;
  // final bool hasMoreListings;

  HomePageState({
    this.isPageScrolled = false,
    required this.listings,
    // this.randomListingsSeedNumber,
    // required this.currentListingsPageNumber,
    // this.isLoadingMoreListings = false,
    // required this.hasMoreListings,
  });

  HomePageState copyWith({
    bool? isPageScrolled,
    Pagination<ListingModel>? listings,
    // bool? hasScrollReachedEnd,
    // int? currentListingsPageNumber,
    // int? randomListingsSeedNumber,
    // bool? isLoadingMoreListings,
    // bool? hasMoreListings,
  }) {
    return HomePageState(
      isPageScrolled: isPageScrolled ?? this.isPageScrolled,
      listings: listings ?? this.listings,

      // currentListingsPageNumber: currentListingsPageNumber ?? this.currentListingsPageNumber,
      // randomListingsSeedNumber: randomListingsSeedNumber ?? this.randomListingsSeedNumber,
      // isLoadingMoreListings: isLoadingMoreListings ?? this.isLoadingMoreListings,
      // hasMoreListings: hasMoreListings ?? this.hasMoreListings,
    );
  }
}
