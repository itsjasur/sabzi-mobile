// simplified_auth_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:flutter_sabzi/app/auth/auth_repository.dart';
import 'package:flutter_sabzi/app/auth/auth_state.dart';
import 'package:flutter_sabzi/app/auth/signin/signin_state.dart';
import 'package:flutter_sabzi/core/services/http_service.dart';

class SigninProvider extends Notifier<SigninState> {
  Timer? _timer;

  @override
  SigninState build() {
    ref.onDispose(() {
      state.phoneController.dispose();
      state.codeController.dispose();
      _timer?.cancel();
    });

    final phoneController = TextEditingController();
    final codeController = TextEditingController();

    return SigninState(phoneController: phoneController, codeController: codeController);
  }

  void isUserTermsAgreeChecked(bool value) => state = state.copyWith(isUserTermsAgreeChecked: value);
  void isPrivacyAgreeChecked(bool value) => state = state.copyWith(isPrivacyAgreeChecked: value);
  void isMarketingAgreeChecked(bool value) => state = state.copyWith(isMarketingAgreeChecked: value);

// this updates if the user account is new
  Future<bool> checkNewUser() async {
    state = state.copyWith(isLoading: true, error: null);
    final response = await ref.read(authRepositoryProvider).checkNewUser(state.phoneController.text);
    final isNewUser = response['is_new_user'] ?? true;

    print("is new user: $isNewUser");

    return isNewUser;
  }

  void updateLoadingState(bool isLoading) {
    state = state.copyWith(isLoading: false);
  }

  void resetSentState() {
    state = state.copyWith(
      verificationCodeSent: false,
      isLoading: false,
    );
  }

  void resetState() {
    state.codeController.clear();
    state.phoneController.clear();
    state = state.copyWith(
      verificationCodeSent: false,
      isLoading: false,
      isUserTermsAgreeChecked: false,
      isMarketingAgreeChecked: false,
      isPrivacyAgreeChecked: false,
      error: null,
      verificationToken: null,
    );
  }

  Future<void> requestCode() async {
    state.codeController.clear();
    state = state.copyWith(isLoading: true, error: null);

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final response = await ref.read(authRepositoryProvider).getCode(state.phoneController.text);
      state = state.copyWith(
        isLoading: false,
        verificationCodeSent: true,
        verificationToken: response['verification_token'],
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> verifyCode() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);

    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await ref.read(authRepositoryProvider).verifyCode(state.codeController.text, state.verificationToken!);
      state = state.copyWith(isLoading: false, error: null);

      print('Before auth update: ${ref.read(authProvider).isAuthenticated}');
      ref.read(authProvider.notifier).authenticated();
      print('After auth update: ${ref.read(authProvider).isAuthenticated}');
    } catch (e) {
      if (e is CustomHttpException) {
        state = state.copyWith(
          isLoading: false,
          error: e.message.toString(),
          verificationCodeSent: e.message.toString() == 'INVALID_OR_EXPIRED_TOKEN' ? false : null,
        );
      }
    }
  }
}

final signinProvider = NotifierProvider<SigninProvider, SigninState>(() => SigninProvider());
