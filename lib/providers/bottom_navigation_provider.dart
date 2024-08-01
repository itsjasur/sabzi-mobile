import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Future<void> change(int newIndex) async {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
