class MyAreaState {
  final List<double> radiuses;
  final List<double> zoomLevels;
  final double currentIndex;

  MyAreaState({required this.radiuses, required this.zoomLevels, required this.currentIndex});

  MyAreaState copyWith({
    List<double>? radiuses,
    List<double>? zoomLevels,
    double? currentIndex,
  }) {
    return MyAreaState(
      radiuses: radiuses ?? this.radiuses,
      zoomLevels: zoomLevels ?? this.zoomLevels,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
