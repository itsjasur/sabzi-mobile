import 'dart:typed_data';

class ListingDraftModel {
  final String title;
  final String description;
  final String price;
  final String currency;
  final bool isPriceNegotiable;
  final List<Uint8List> images; // Store just the IDs of assets

  ListingDraftModel({
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.isPriceNegotiable,
    required this.images,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'price': price,
        'currency': currency,
        'isPriceNegotiable': isPriceNegotiable,
        'images': images,
      };

  factory ListingDraftModel.fromJson(Map<String, dynamic> json) => ListingDraftModel(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        price: json['price'] ?? '',
        currency: json['currency'] ?? 'UZS',
        isPriceNegotiable: json['isPriceNegotiable'] ?? true,
        images: List<Uint8List>.from(json['images'] ?? []),
      );
}
