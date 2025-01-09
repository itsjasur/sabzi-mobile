// auth_state.dart

class AuthState {
  final bool isAuthenticated;
  // final bool isLoading;
  // final String? error;

  AuthState({
    required this.isAuthenticated,
    // required this.isLoading,
    // this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    // bool? isLoading,
    // bool? isNewUser,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      // isLoading: isLoading ?? this.isLoading,
    );
  }
}
