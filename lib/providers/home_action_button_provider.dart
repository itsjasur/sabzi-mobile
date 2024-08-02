import 'package:flutter/material.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';

class HomeActionButtonProvider with ChangeNotifier {
  final OverlayProvider _overlayProvider;

  HomeActionButtonProvider(this._overlayProvider);

  bool _menuActive = true;
  bool _scrollAtTop = true;
  final GlobalKey _key = GlobalKey();

  bool get scrollAtTop => _scrollAtTop;
  bool get menuActive => _menuActive;
  GlobalKey? get key => _key;

  void openMenu() {
    _overlayProvider.activate();
    _menuActive = true;
  }

  void closeMenu() {
    _overlayProvider.deactivate();
    _menuActive = false;
  }

  void setIsScrollAtTop(bool isAtTop) {
    if (_scrollAtTop != isAtTop) {
      _scrollAtTop = isAtTop;
      notifyListeners();
    }
  }
}
