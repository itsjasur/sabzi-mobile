import 'package:flutter/material.dart';

mixin ScrollMixin<T> {
  late ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  void initializeScroll() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final isScrolled = offset > 50;
      final isAtBottom = offset >= _scrollController.position.maxScrollExtent;

      updateScrollState(isScrolled, offset, isAtBottom);
    });
  }

  Future<void> scrollToTop({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) async {
    await _scrollController.animateTo(0, duration: duration, curve: curve);
  }

  Future<void> scrollToBottom({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  void disposeScroll() {
    _scrollController.dispose();
  }

  void updateScrollState(bool isScrolled, double offset, bool isAtBottom);
  // void updateStateWhenScrolled(bool isScrolled);
}
