import 'package:flutter/material.dart';

class OverlayProvider with ChangeNotifier {
  bool _active = false;
  bool get active => _active;

  // void toggle(Widget? widget) {
  //   _active = !_active;
  //   _overlayWidget = widget;
  //   notifyListeners();
  // }

  void activate() {
    _active = true;
    notifyListeners();
  }

  void deactivate() {
    _active = false;
    notifyListeners();
  }
}
