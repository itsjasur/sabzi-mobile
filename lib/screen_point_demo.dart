import 'package:flutter/material.dart';

class ScreenPointDemo extends StatefulWidget {
  const ScreenPointDemo({super.key});

  @override
  State<ScreenPointDemo> createState() => _ScreenPointDemoState();
}

class _ScreenPointDemoState extends State<ScreenPointDemo> {
  // Store touch position
  Offset? _touchPosition;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      // Get the global position of the tap
      _touchPosition = details.globalPosition;
    });
  }

  // Convert screen coordinates to logical pixels
  Offset _getLogicalPixels(BuildContext context, Offset screenPoint) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Offset(screenPoint.dx / devicePixelRatio, screenPoint.dy / devicePixelRatio);
  }

  // Get position relative to a specific widget
  Offset _getRelativePosition(BuildContext context, Offset screenPoint, RenderBox box) {
    return box.globalToLocal(screenPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('ScreenPoint Demo')),
      body: GestureDetector(
        onTapDown: _handleTapDown,
        child: Container(
          color: Colors.grey[200],
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              if (_touchPosition != null)
                Positioned(
                  left: _touchPosition!.dx - 25,
                  top: _touchPosition!.dy - 25,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              Center(
                child: Text(
                  _touchPosition != null ? 'Tap Position: (${_touchPosition!.dx.toStringAsFixed(0)}, ${_touchPosition!.dy.toStringAsFixed(0)})' : 'Tap anywhere on the screen',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
