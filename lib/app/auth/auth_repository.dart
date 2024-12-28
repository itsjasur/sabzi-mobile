import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/utils/http_service.dart';

class AuthRepository {
  final HttpService _httpService;

  AuthRepository(this._httpService);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _httpService.post(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }

  Future<void> logout() async {
    await _httpService.post('/auth/logout');
  }
}

final authRepositoryProvider = Provider((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return AuthRepository(httpService);
});
