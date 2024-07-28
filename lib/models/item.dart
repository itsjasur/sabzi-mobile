import 'package:sabzi_mobile/utils/custom_localizers.dart';

class Item {
  final int id;
  final String title;
  final String description;
  final String price;
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

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
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
  });

  // Create Item from Map
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: CustomLocalizers().costFormatter(map['price']),
      isNegotiable: map['negotiable'],
      status: map['status'],
      sellerId: map['seller_id'],
      categoryId: map['category_id'],
      imageUrls: List<String>.from(map['image_urls']),
      datePosted: CustomLocalizers().getRelativeTime(map['date_posted']),
      chatCount: map['chat_count'],
      likeCount: map['like_count'],
      viewCount: map['view_count'],
      distanceFromMe: map['distance_from_me'],
    );
  }

  // // Convert Item to Map
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
  // Item copyWith({
  //   String? id,
  //   String? title,

  //   bool? isSold,
  // }) {
  //   return Item(
  //     id: id ?? this.id,

  //   );
  // }
}
