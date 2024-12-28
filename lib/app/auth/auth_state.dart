class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? userData;

  AuthState({
    required this.isLoggedIn,
    required this.isLoading,
    this.error,
    this.userData,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? userData,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userData: userData ?? this.userData,
    );
  }
}
