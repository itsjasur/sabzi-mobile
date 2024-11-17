import 'package:flutter_sabzi/core/utils/custom_localizers.dart';

class ItemModel {
  final int id;
  final String title;
  final String description;
  final String price;
  final String currency;
  final bool isNegotiable;
  final int sellerId;
  final String status;
  final int categoryId;
  final List<String> imageUrls;
  final String datePosted;
  final String distanceFromMe;
  final int? chatCount;
  final int? likeCount;
  final int? viewCount;
  bool isAddedToFavourites;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.isNegotiable,
    required this.sellerId,
    required this.status,
    required this.categoryId,
    required this.imageUrls,
    required this.datePosted,
    required this.distanceFromMe,
    this.chatCount,
    this.likeCount,
    this.viewCount,
    required this.isAddedToFavourites,
  });

  // Create ItemModel from Map
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      currency: map['currency'] as String,
      price: CustomFormatters().currencyFormat(map['price'], map['currency']),
      isNegotiable: map['negotiable'] as bool,
      status: map['status'] as String,
      sellerId: map['seller_id'] as int,
      categoryId: map['category_id'],
      imageUrls: List<String>.from(map['image_urls']),
      datePosted: CustomFormatters().getRelativeTime(map['date_posted']),
      chatCount: map['chat_count'],
      likeCount: map['like_count'],
      viewCount: map['view_count'],
      distanceFromMe: map['distance_from_me'],
      isAddedToFavourites: false,
    );
  }
}




  // // Convert ItemModel to Map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'price': price,
  //     'status': status,
  //     'sellerId': sellerId,
  //     'category': categoryId,
  //     'imageUrls': imageUrls,
  //     'datePosted': datePosted.toIso8601String(),
  //   };
  // }

  // // Copy with method for easy modification
  // ItemModel copyWith({
  //   String? id,
  //   String? title,

  //   bool? isSold,
  // }) {
  //   return ItemModel(
  //     id: id ?? this.id,

  //   );
  // }