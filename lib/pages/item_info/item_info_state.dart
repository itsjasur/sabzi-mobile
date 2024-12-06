class ItemInfoState {
  final int itemId;
  final bool isInfoLoaded;

  ItemInfoState({
    required this.itemId,
    required this.isInfoLoaded,
  });

  ItemInfoState copyWith({
    int? itemId,
    bool? isInfoLoaded,
  }) {
    return ItemInfoState(
      itemId: itemId ?? this.itemId,
      isInfoLoaded: isInfoLoaded ?? this.isInfoLoaded,
    );
  }
}
