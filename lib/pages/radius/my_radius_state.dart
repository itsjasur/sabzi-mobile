class MyRadiusState {
  final List<double> radiuses;
  final List<double> zoomLevels;
  final double currentIndex;

  MyRadiusState({required this.radiuses, required this.zoomLevels, required this.currentIndex});

  MyRadiusState copyWith({
    List<double>? radiuses,
    List<double>? zoomLevels,
    double? currentIndex,
  }) {
    return MyRadiusState(
      radiuses: radiuses ?? this.radiuses,
      zoomLevels: zoomLevels ?? this.zoomLevels,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
