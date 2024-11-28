import 'package:flutter/material.dart';

class ScaleTapWidget extends StatefulWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;

  const ScaleTapWidget({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<ScaleTapWidget> createState() => _ScaleTapWidgetState();
}

class _ScaleTapWidgetState extends State<ScaleTapWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  void _handleLongPress() {
    _controller.reverse();
    widget.onLongPress?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onLongPress: _handleLongPress,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
