import 'package:flutter/material.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';

class HomeActionButtonProvider with ChangeNotifier {
  final OverlayProvider _overlayProvider;

  HomeActionButtonProvider(this._overlayProvider) {
    _overlayProvider.addListener(_onOverlayStateChanged);
  }

  bool _menuActive = false;
  bool _scrollAtTop = true;
  final GlobalKey _key = GlobalKey();

  bool get scrollAtTop => _scrollAtTop;
  bool get menuActive => _menuActive;
  GlobalKey? get key => _key;

  void _onOverlayStateChanged() {
    _menuActive = _overlayProvider.active;
    notifyListeners();
  }

  void openMenu() {
    _overlayProvider.activate();
    _menuActive = true;
    notifyListeners();
  }

  void closeMenu() {
    _overlayProvider.deactivate();
    _menuActive = false;
    notifyListeners();
  }

  void setIsScrollAtTop(bool isAtTop) {
    if (_scrollAtTop != isAtTop) {
      _scrollAtTop = isAtTop;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _overlayProvider.removeListener(_onOverlayStateChanged);
    super.dispose();
  }
}
