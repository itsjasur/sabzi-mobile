import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_repository.dart';
import 'package:flutter_sabzi/app/auth/auth_state.dart';
import 'package:flutter_sabzi/core/services/http_service.dart';
// import 'dart:developer' as developer;

class AuthProvider extends Notifier<AuthState> {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    ref.onDispose(() {
      state.phoneNumberController;
      state.verCodeController;
    });

    _authRepository = ref.watch(authRepositoryProvider);
    return AuthState(
      isLoggedIn: false,
      isLoading: false,
      phoneNumberController: TextEditingController(text: '11 111 1111'),
      verCodeController: TextEditingController(text: '123456'),
      isNewUser: true,
      isCodeRequested: false,
    );
  }

  void changeIsCodeRequested(bool value) {
    state = state.copyWith(isCodeRequested: value);
  }

  Future<void> getCode() async {
    state = state.copyWith(isLoading: true, error: null, isCodeRequested: true);

    try {
      final response = await _authRepository.getCode(state.phoneNumberController.text);
      final verificationToken = response['verification_token']?.toString();

      state = state.copyWith(
        isLoading: false,
        error: null,
        verificationToken: verificationToken,
      );
    } catch (e, stackTrace) {
      // print(e);
      // print(stackTrace);

      state = state.copyWith(
        isLoading: false,
        error: e is CustomHttpException ? e.message : e.toString(),
      );
    }
  }

  Future<bool> verifyCode() async {
    if (state.verificationToken == null) return false;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.verifyCode(state.verCodeController.text, state.verificationToken!);
      state = state.copyWith(
        isLoggedIn: true,
        isLoading: false,
        error: null,
        isNewUser: response['is_new_user'],
      );
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);

      final errorCode = e is CustomHttpException ? e.message : e.toString();
      if (errorCode == 'INVALID_OR_EXPIRED_TOKEN') {
        state = state.copyWith(isCodeRequested: false);
      }
      state = state.copyWith(isLoading: false, error: errorCode);
    }

    return true;
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } catch (e) {
      print('Logout error: $e');
    } finally {
      // even if logout fails on server, clear local state
      state = state.copyWith(
        isLoading: false,
        error: null,
        isLoggedIn: false,
      );
    }
  }
}

final authProvider = NotifierProvider<AuthProvider, AuthState>(() => AuthProvider());
