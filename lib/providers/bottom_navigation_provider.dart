import 'package:flutter/material.dart';
import 'package:sabzi_app/enums/bottom_navigations.dart';

class BottomNavigationProvider extends ChangeNotifier {
  MainBottomNavs _currentNavPage = MainBottomNavs.home;

  MainBottomNavs get currentNavPage => _currentNavPage;

  Future<void> change(MainBottomNavs nav) async {
    _currentNavPage = nav;
    notifyListeners();
  }
}
