import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showCustomPopup(BuildContext context, GlobalKey key) {
  OverlayState? overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);

  // animation controller
  final animationController = AnimationController(
    vsync: Overlay.of(context),
    duration: const Duration(milliseconds: 300),
  );

  // scale animation
  final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeIn,
    ),
  );

  // opacity animation for overlay background
  final opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeIn,
    ),
  );

  overlayEntry = OverlayEntry(
    builder: (context) => AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Stack(
        children: [
          // Overlay background with animated opacity
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                animationController.reverse().then((_) {
                  overlayEntry.remove();
                  animationController.dispose();
                });
              },
              child: AnimatedBuilder(
                animation: opacityAnimation,
                builder: (context, child) => Container(
                  color: Colors.black.withOpacity(opacityAnimation.value),
                ),
              ),
            ),
          ),
          // Popup content
          Positioned(
            left: offset.dx,
            // right: 20,
            top: offset.dy + size.height + 5,
            child: ScaleTransition(
              alignment: Alignment.topLeft,
              scale: scaleAnimation,
              child: Material(
                color: Colors.white,
                // elevation: 1,
                borderRadius: BorderRadius.circular(6),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Material(
                    color: Colors.transparent,
                    child: IntrinsicWidth(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              // animationController.reverse().then((_) {
                              //   overlayEntry.remove();
                              // animationController.dispose();
                              // });
                            },
                            child: Container(
                              // constraints: BoxConstraints(minWidth: double.infinity),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Text('My home neighbourhood'),
                            ),
                            // child: const Text('item asdlkasj'),
                          ),
                          InkWell(
                            onTap: () {
                              // animationController.reverse().then((_) {
                              //   overlayEntry.remove();
                              // });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Text('My work place neighbourhood'),
                            ),
                            // child: const Text('item asdlkasj'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  overlayState.insert(overlayEntry);
  animationController.forward();
}
