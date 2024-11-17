class PaginationStateModel {
  final int currentPage;
  final int perPage;
  final bool isLoading;
  final bool hasMore;
  final String? error;

  const PaginationStateModel({
    this.currentPage = 0,
    this.perPage = 10,
    this.isLoading = false,
    this.hasMore = true,
    this.error,
  });

  PaginationStateModel copyWith({
    int? currentPage,
    int? perPage,
    bool? isLoading,
    bool? hasMore,
    String? error,
  }) {
    return PaginationStateModel(
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
    );
  }
}
