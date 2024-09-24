import 'package:flutter/material.dart';

class ScaledTap extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapDown;
  final GestureTapCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressCallback? onLongPressUp;
  final GestureDragDownCallback? onPanDown;
  final GestureDragStartCallback? onPanStart;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final GestureDragCancelCallback? onPanCancel;
  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;

  const ScaledTap({
    super.key,
    required this.child,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onLongPressUp,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
  });

  @override
  State<ScaledTap> createState() => _ScaledTapState();
}

class _ScaledTapState extends State<ScaledTap> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward().whenComplete(() => widget.onTapDown?.call());
  }

  void _onTap() {
    _controller.forward().whenComplete(() => _controller.reverse().whenComplete(() => widget.onTap?.call()));
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse().whenComplete(() => widget.onTapUp?.call());
  }

  void _onTapCancel() {
    _controller.reverse().whenComplete(() => widget.onTapCancel?.call());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      // onTap: () {
      //   _controller.forward().whenComplete(() {
      //     // only calls onTap after the forward animation is complete.
      //     widget.onTap?.call();
      //     _controller.reverse(); // Start the reverse animation.
      //   });
      // },
      onTapDown: (details) => _onTapDown(details),
      onTapUp: (details) => _onTapUp(details),
      onTapCancel: _onTapCancel,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      onLongPressStart: widget.onLongPressStart,
      onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
      onLongPressEnd: widget.onLongPressEnd,
      onLongPressUp: widget.onLongPressUp,
      onPanDown: widget.onPanDown,
      onPanStart: widget.onPanStart,
      onPanUpdate: widget.onPanUpdate,
      onPanEnd: widget.onPanEnd,
      onPanCancel: widget.onPanCancel,
      onScaleStart: widget.onScaleStart,
      onScaleUpdate: widget.onScaleUpdate,
      onScaleEnd: widget.onScaleEnd,

      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double scale = 1.0 - (0.1 * _controller.value);
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
