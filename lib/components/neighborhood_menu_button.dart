import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/providers/neighborhood_provider.dart';

class NeighborhoodMenuButton extends StatefulWidget {
  const NeighborhoodMenuButton({super.key});

  @override
  State<NeighborhoodMenuButton> createState() => NeighborhoodMenuButtonState();
}

class NeighborhoodMenuButtonState extends State<NeighborhoodMenuButton> with TickerProviderStateMixin {
  final GlobalKey _menuTextButtonKey = GlobalKey();

  final List<Map> _items = const [
    {'label': 'Yunusobod', 'code': 'YUN'},
    {'label': 'Uchtepa', 'code': 'UCH'},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NeighborhoodProvider>(
      builder: (context, provider, child) => ScaledTap(
        key: _menuTextButtonKey,
        onTap: _showCustomPopup,
        child: Row(
          children: [
            Text(
              provider.currentNeighborHood ?? 'Not selected',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 3),
            const Icon(
              Icons.expand_more,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  void _showCustomPopup() {
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    final RenderBox renderBox = _menuTextButtonKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // animation controller
    final animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // scale animation
    final scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        // curve: Curves.easeIn,
        // reverseCurve: Curves.easeIn,
        curve: Curves.ease,
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
                child: Container(
                  color: Colors.transparent,
                  child: AnimatedBuilder(
                    animation: opacityAnimation,
                    builder: (context, child) => Container(
                      color: Colors.black.withOpacity(opacityAnimation.value),
                    ),
                  ),
                ),
              ),
            ),
            // Popup content
            Positioned(
              left: offset.dx,
              // right: 20,
              top: offset.dy + size.height + 3,
              child: ScaleTransition(
                alignment: Alignment.topLeft,
                // alignment: Alignment.topCenter,
                scale: scaleAnimation,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 35, minWidth: 150),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _items
                            .map(
                              (i) => ScaledTap(
                                onTap: () {
                                  animationController.reverse().then((_) {
                                    overlayEntry.remove();
                                    animationController.dispose();
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Text(
                                    i['label'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
}
