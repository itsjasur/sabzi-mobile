import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_repository.dart';
import 'package:flutter_sabzi/app/auth/auth_state.dart';
import 'package:flutter_sabzi/core/utils/http_service.dart';

class AuthProvider extends Notifier<AuthState> {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return AuthState(isLoggedIn: false, isLoading: false);
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.login(email, password);
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        userData: response,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: false,
        error: e is ApiException ? e.message : e.toString(),
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.logout();
    } catch (e) {
      // even if logout fails on server, clear local state
      print('Logout error: $e');
    }

    state = AuthState(isLoggedIn: false, isLoading: false);
  }
}

final authProvider = NotifierProvider<AuthProvider, AuthState>(() => AuthProvider());
