import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final String? authToken;

  ApiService({
    required this.baseUrl,
    this.authToken,
  });

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw const HttpException('Failed to fetch data');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      throw const HttpException('Failed to post data');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Add other methods like put, delete, etc.
}

// ApiService provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(
    baseUrl: 'https://your-api-base-url.com',
    // authToken: ref.watch('authTokenProvider'), // If you have auth
  );
});
