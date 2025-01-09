// auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/auth/auth_repository.dart';
import 'package:flutter_sabzi/pages/auth/auth_state.dart';

class AuthProvider extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(isAuthenticated: true);
  }

  void authenticated() {
    print('AuthProvider: Setting authenticated state to true');
    state = state.copyWith(isAuthenticated: true);
  }

  void unAuthenticated() {
    state = state.copyWith(isAuthenticated: false);
    ref.read(authRepositoryProvider).logout();
  }
}

final authProvider = NotifierProvider<AuthProvider, AuthState>(() => AuthProvider());
