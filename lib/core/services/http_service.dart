import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/auth/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Map<String, String>> _getHeaders({required bool isProtected, bool isMultiPart = false}) async {
    final headers = {'Device-Lang': 'en'};

    if (!isMultiPart) {
      headers['Content-Type'] = 'application/json';
    }

    if (isProtected) {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? "";
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    try {
      final statusCode = response.statusCode;
      final body = response.body;

      // Check for authentication errors
      if (statusCode == 401 || statusCode == 403) {
        // TODO
        ref.read(authProvider.notifier).unAuthenticated();
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

  Future<dynamic> get(String endpoint, {Map<String, String>? headers, bool isProtected = false}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _getHeaders(isProtected: isProtected),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
      // print(e);
      // throw CustomHttpException(e.toString());
    }
  }

  Future<dynamic> post(String endpoint, {dynamic body, Map<String, String>? headers, bool isProtected = false}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _getHeaders(isProtected: isProtected),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
      // print(e);
      // throw CustomHttpException(e.toString());
    }
  }

  Future<dynamic> multipart(String endpoint, {required Map<String, String> fields, required Map<String, File> files, bool isProtected = false}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('POST', uri);

      final headers = await _getHeaders(isProtected: isProtected, isMultiPart: true);
      request.headers.addAll(headers);
      request.fields.addAll(fields);

      // adds files
      for (var entry in files.entries) {
        final file = entry.value;
        final stream = http.ByteStream(file.openRead());
        final length = await file.length();

        final multipartFile = http.MultipartFile(
          entry.key,
          stream,
          length,
          filename: file.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      // sends request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

//   final result = await httpService.multipart(
//   '/upload',
//   fields: {
//     'user_id': '123',
//     'description': 'Profile update'
//   },
//   files: {
//     'profile_picture': File('path/to/image.jpg'),
//     'document': File('path/to/document.pdf')
//   },
//   isProtected: true,
// );
}

final httpServiceProvider = Provider((ref) {
  return HttpService(ref, baseUrl: 'http://127.0.0.1:8000/api');
});
