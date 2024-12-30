import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:http/http.dart' as http;

class CustomHttpException implements Exception {
  final String message;
  final int? statusCode;

  CustomHttpException(this.message, {this.statusCode});

  @override
  String toString() => 'CustomHttpException: $message (Status Code: $statusCode)';
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
    try {
      final statusCode = response.statusCode;
      final body = response.body;

      // Check for authentication errors
      if (statusCode == 401 || statusCode == 403) {
        ref.read(authProvider.notifier).logout();
        throw CustomHttpException('Authentication failed', statusCode: statusCode);
      }

      // Handle successful responses
      if (statusCode >= 200 && statusCode < 300) {
        if (body.isEmpty) return null;
        return json.decode(body);
      }

      // Handle other errors
      String errorMessage;
      try {
        final errorBody = json.decode(body);
        errorMessage = errorBody["detail"] ?? errorBody["message"] ?? "Unexpected error";
      } catch (_) {
        errorMessage = body.isNotEmpty ? body : "Unexpected error";
      }

      // throw Exception(body);
      throw CustomHttpException(errorMessage, statusCode: statusCode);
    } on FormatException {
      throw CustomHttpException("Invalid response format");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
      // print(e);
      // throw CustomHttpException(e.toString());
    }
  }

  Future<dynamic> post(String endpoint, {dynamic body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(headers),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
      // print(e);
      // throw CustomHttpException(e.toString());
    }
  }
}

final httpServiceProvider = Provider((ref) {
  return HttpService(ref, baseUrl: 'http://127.0.0.1:8000/api');
});
