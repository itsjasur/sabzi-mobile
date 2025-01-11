import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/services/http_service.dart';

class CategoriesRepository {
  final HttpService _httpService;

  CategoriesRepository(this._httpService);

  Future<Map<String, dynamic>> fetchCategories(String verificationCode, String verificationToken) async {
    final response = await _httpService.post(
      '/category/fetch-all',
      body: {},
      headers: {},
      isProtected: true,
    );
    return response;
  }
}

final categoriesRepositoryProvider = Provider((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return CategoriesRepository(httpService);
});
