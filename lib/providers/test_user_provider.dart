import 'package:flutter/material.dart';
import 'package:sabzi_app/utils/api_util.dart';

class UserProvider extends ChangeNotifier {
  // final ApiUtil _apiService = ApiUtil();
  // List<User> _users = [];
  // bool _isLoading = false;
  // String _error = '';
  // int _currentPage = 1;

  // List<User> get users => _users;
  // bool get isLoading => _isLoading;
  // String get error => _error;

  // Future<void> fetchUsers({bool loadMore = false}) async {
  //   if (!loadMore) {
  //     _currentPage = 1;
  //     _users = [];
  //   }

  //   if (_isLoading) return;

  //   _isLoading = true;
  //   _error = '';
  //   notifyListeners();

  //   try {
  //     final newUsers = await _apiService.fetchUsers(_currentPage);
  //     _users.addAll(newUsers);
  //     _currentPage++;
  //   } catch (e) {
  //     _error = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
