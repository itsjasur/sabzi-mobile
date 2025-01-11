import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final HttpService _httpService;

  AuthRepository(this._httpService);

  Future<Map<String, dynamic>> checkNewUser(String phoneNumber) async {
    final response = await _httpService.post('/auth/check-new-user', body: {'phone_number': phoneNumber});
    return response;
  }

  Future<Map<String, dynamic>> getCode(String phoneNumber) async {
    final response = await _httpService.post('/auth/send-code', body: {'phone_number': phoneNumber});
    return response;
  }

  Future<Map<String, dynamic>> verifyCode(String verificationCode, String verificationToken) async {
    final response = await _httpService.post(
      '/auth/verify-code',
      body: {
        'verification_code': verificationCode,
        'verification_token': verificationToken,
      },
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', response['access_token']);

    return response;
  }

  Future<void> logout() async {
    try {
      await _httpService.post('/auth/logout');
    } finally {
      //clear tokens even if logout API fails
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
    }
  }
}

final authRepositoryProvider = Provider((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return AuthRepository(httpService);
});
