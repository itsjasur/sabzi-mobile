// auth_state.dart
import 'package:flutter/material.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  // final bool isNewUser;
  final String? error;

  AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    // required this.isNewUser,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    bool? isNewUser,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      // isNewUser: isNewUser ?? this.isNewUser,
    );
  }
}
