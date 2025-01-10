class ListingDraftModel {
  final String title;
  final String description;
  final String price;
  final String currency;
  final bool isPriceNegotiable;
  final List<String> imagePaths; // Store just the IDs of assets
  final int categoryId;

  ListingDraftModel({
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.isPriceNegotiable,
    required this.imagePaths,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'price': price,
        'currency': currency,
        'isPriceNegotiable': isPriceNegotiable,
        'imagePaths': imagePaths,
        'categoryId': categoryId,
      };

  factory ListingDraftModel.fromJson(Map<String, dynamic> json) => ListingDraftModel(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        price: json['price'] ?? '',
        currency: json['currency'] ?? 'UZS',
        isPriceNegotiable: json['isPriceNegotiable'] ?? true,
        imagePaths: ((json['imagePaths'] ?? []) as List).map((e) => e as String).toList(),
        categoryId: json['categoryId'] ?? -1,
      );
}
