class AppState {
  final bool isGlobalLoading;

  AppState({
    required this.isGlobalLoading,
  });

  AppState copyWith({
    bool? isGlobalLoading,
  }) {
    return AppState(
      isGlobalLoading: isGlobalLoading ?? this.isGlobalLoading,
    );
  }
}
