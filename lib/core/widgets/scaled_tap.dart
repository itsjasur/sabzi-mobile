import 'package:flutter/material.dart';

class ScaledTap extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  // final Function(TapDownDetails)? onTapDown;
  // final Function(TapUpDetails)? onTapUp;

  const ScaledTap({
    super.key,
    required this.child,
    this.onTap,
    // this.onTapDown,
    // this.onTapUp,
  });

  @override
  State<ScaledTap> createState() => _ScaledTapState();
}

class _ScaledTapState extends State<ScaledTap> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _scalingDown = false;

  void _handleTapDown(TapDownDetails details) async {
    _scalingDown = true;
    await _controller.forward();
    _scalingDown = false;
  }

  void _handleTapUp(TapUpDetails details) async {
    if (_scalingDown) await _controller.forward();
    widget.onTap?.call();
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}