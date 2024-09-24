import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiUtil {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const int _usersPerPage = 5;

  // Future<List<User>> fetchUsers(int page) async {
  //   final response = await http.get(
  //     Uri.parse('$_baseUrl/users?_page=$page&_limit=$_usersPerPage')
  //   );
  //   if (response.statusCode == 200) {
  //     final List<dynamic> userJson = json.decode(response.body);
  //     return userJson.map((json) => User.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load users');
  //   }
  // }
}
