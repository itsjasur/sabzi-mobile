// simplified_auth_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:flutter_sabzi/app/auth/auth_repository.dart';
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

    final phoneController = TextEditingController(text: '12312312');
    final codeController = TextEditingController();

    return SigninState(phoneController: phoneController, codeController: codeController);
  }

  void isUserTermsAgreeChecked(bool value) => state = state.copyWith(isUserTermsAgreeChecked: value);
  void isPrivacyAgreeChecked(bool value) => state = state.copyWith(isPrivacyAgreeChecked: value);
  void isMarketingAgreeChecked(bool value) => state = state.copyWith(isMarketingAgreeChecked: value);

  Future<bool?> checkNewUser() async {
    if (state.isLoading) return null;
    state = state.copyWith(isLoading: true, error: null);

    final response = await ref.read(authRepositoryProvider).checkNewUser(state.phoneController.text);
    final isNewUser = response['is_new_user'] ?? true;
    print('isnewuser ${isNewUser}');
    return isNewUser;
  }

  void updateLoadingState(bool isLoading) {
    state = state.copyWith(isLoading: false);
  }

  Future<void> requestCode() async {
    if (state.isLoading) return;

    state.codeController.clear();
    state = state.copyWith(isLoading: true, error: null);

    await Future.delayed(const Duration(seconds: 1));

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
      // state = state.copyWith(isLoading: false, error: null);
      // final isNewUser = response["is_new_user"] ?? true;
      ref.read(authProvider.notifier).authenticated();
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
