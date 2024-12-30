import 'package:flutter/material.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;
  final String? verificationToken;
  final bool isNewUser;
  final bool isCodeRequested;

  // final Map<String, dynamic>? userData;
  final TextEditingController phoneNumberController;
  final TextEditingController verCodeController;

  AuthState({
    required this.isLoggedIn,
    required this.isLoading,
    required this.isNewUser,
    this.error,
    this.verificationToken,
    required this.isCodeRequested,
    // this.userData,
    required this.phoneNumberController,
    required this.verCodeController,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    bool? isNewUser,
    bool? isCodeRequested,
    String? error,
    String? verificationToken,
    // Map<String, dynamic>? userData,
    TextEditingController? phoneNumberController,
    TextEditingController? verCodeController,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      verificationToken: verificationToken ?? this.verificationToken,
      // userData: userData ?? this.userData,
      isCodeRequested: isCodeRequested ?? this.isCodeRequested,
      phoneNumberController: phoneNumberController ?? this.phoneNumberController,
      verCodeController: verCodeController ?? this.verCodeController,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }
}
