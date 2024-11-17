import 'package:flutter/material.dart';

mixin ScrollMixin on ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  void initializeScroll() {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    bool scrolled = _scrollController.offset - 50 >= _scrollController.position.minScrollExtent;
    if (_isScrolled != scrolled) {
      _isScrolled = scrolled;
      notifyListeners();
    }
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void disposeScroll() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }
}
