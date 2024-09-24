import 'package:flutter/material.dart';

class NeighborhoodProvider extends ChangeNotifier {
  String? _currentNeighborHood;

  String? get currentNeighborHood => _currentNeighborHood;

  Future<void> update(String newNeighborhood) async {
    _currentNeighborHood = newNeighborhood;
    notifyListeners();
  }

  Future<void> remove() async {
    _currentNeighborHood = null;
    notifyListeners();
  }
}
