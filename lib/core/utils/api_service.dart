import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message ${statusCode != null ? '($statusCode)' : ''}';
}

class ApiService {
  final String _baseUrl;
  final String? _authToken;

  ApiService({
    required String baseUrl,
    String? authToken,
  })  : _baseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/',
        _authToken = authToken;

  // private helper method for headers
  Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  // private helper to handle response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }

    throw ApiException(
      message: _getErrorMessage(response),
      statusCode: response.statusCode,
      data: 'data',
    );
  }

  String _getErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      return body['message'] ?? body['error'] ?? 'Unknown error occurred';
    } catch (_) {
      switch (response.statusCode) {
        case 400:
          return 'Bad request';
        case 401:
          return 'Unauthorized';
        case 403:
          return 'Forbidden';
        case 404:
          return 'Not found';
        case 500:
          return 'Internal server error';
        default:
          return 'Something went wrong';
      }
    }
  }

  static const timeout = Duration(seconds: 30);

  Future<T> get<T>(String endpoint) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http.get(uri, headers: _getHeaders()).timeout(timeout);

      return _handleResponse(response) as T;
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on TimeoutException {
      throw ApiException(message: 'Request timeout');
    } on FormatException {
      throw ApiException(message: 'Invalid response format');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<T> post<T>(String endpoint, Map map, {Map<String, dynamic>? data}) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http.post(uri, headers: _getHeaders(), body: data != null ? jsonEncode(data) : null).timeout(timeout);

      return _handleResponse(response) as T;
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on TimeoutException {
      throw ApiException(message: 'Request timeout');
    } on FormatException {
      throw ApiException(message: 'Invalid response format');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  // other methods like put, delete, etc.
}

// provider with environment configuration
final apiServiceProvider = Provider<ApiService>((ref) {
  //  gets these from environment config
  const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://your-api-base-url.com',
  );

  // watch an auth provider for the token
  // final authToken = ref.watch(authProvider).token;

  return ApiService(
    baseUrl: baseUrl,
    // authToken: authToken,
  );
});
