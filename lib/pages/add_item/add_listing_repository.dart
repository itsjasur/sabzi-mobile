import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddListingRepository {
  final HttpService _httpService;

  AddListingRepository(this._httpService);

  Future<Map<String, dynamic>> addListing(String verificationCode, String verificationToken) async {
    final response = await _httpService.post(
      '/listing/add-new',
      body: {
        'verification_code': verificationCode,
      },
    );
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

final addListingRepositoryProvider = Provider((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return AddListingRepository(httpService);
});
