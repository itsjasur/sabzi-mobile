// auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_repository.dart';
import 'package:flutter_sabzi/app/auth/auth_state.dart';

class AuthProvider extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(isAuthenticated: false, isLoading: false);
  }

  void checkNewUser(bool val) {
    state = state.copyWith(isNewUser: true);
  }

  void authenticated() {
    state = state.copyWith(isAuthenticated: true);
  }

  void unAuthenticated() {
    state = state.copyWith(isAuthenticated: false);
    ref.read(authRepositoryProvider).logout();
  }
}

final authProvider = NotifierProvider<AuthProvider, AuthState>(() => AuthProvider());
