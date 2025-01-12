class Pagination<T> {
  final List<T> items;
  final int pageNumber;
  final bool hasMoreItems;
  final bool isLoading;

  Pagination({
    required this.items,
    required this.pageNumber,
    required this.hasMoreItems,
    required this.isLoading,
  });

  Pagination<T> copyWith({
    List<T>? items,
    int? pageNumber,
    bool? hasMoreItems,
    bool? isLoading,
  }) {
    return Pagination<T>(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
