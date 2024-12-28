import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

// HTTP service class
class HttpService {
  final Ref ref;
  final String baseUrl;

  HttpService(this.ref, {required this.baseUrl});

  // Add auth token to headers
  Map<String, String> _getHeaders([Map<String, String>? additionalHeaders]) {
    final headers = {
      'Content-Type': 'application/json',
      // Add your auth token here if needed
      // 'Authorization': 'Bearer ${_getAuthToken()}'
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    final statusCode = response.statusCode;
    final body = response.body;

    // Check for authentication errors
    if (statusCode == 401 || statusCode == 403) {
      ref.read(authProvider.notifier).logout();
      throw ApiException('Authentication failed', statusCode: statusCode);
    }

    // Handle successful responses
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isEmpty) return null;
      return json.decode(body);
    }

    // Handle other errors
    throw ApiException(
      'Request failed with status: $statusCode',
      statusCode: statusCode,
    );
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}

final httpServiceProvider = Provider((ref) {
  return HttpService(ref, baseUrl: 'https://your-api-base-url.com');
});
