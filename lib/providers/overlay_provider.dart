import 'package:flutter/material.dart';

class OverlayProvider with ChangeNotifier {
  bool _active = false;
  Widget? _overlayWidget;
  GlobalKey? _widgetKey;

  // Widget? _overlayWidget = Container(
  //   color: Colors.red,
  //   child: const Text('Overlay text'),
  // );

  bool get active => _active;
  Widget? get overlayWidget => _overlayWidget;
  GlobalKey? get widgetKey => _widgetKey;

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
    _overlayWidget = null;
    _active = false;
    notifyListeners();
  }

  void updateOverlayWidget(Widget? widget, GlobalKey widgetKey) {
    _overlayWidget = widget;
    _widgetKey = widgetKey;
  }
}
