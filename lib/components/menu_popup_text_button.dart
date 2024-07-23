import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuPopupTextButton extends StatefulWidget {
  final String title;
  final TextStyle? textStyle;
  final List<Map> items;
  const MenuPopupTextButton({super.key, required this.title, this.textStyle, required this.items});

  @override
  State<MenuPopupTextButton> createState() => _MenuPopupTextButtonState();
}

class _MenuPopupTextButtonState extends State<MenuPopupTextButton> with TickerProviderStateMixin {
  final GlobalKey _menuTextButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: _menuTextButtonKey,
      borderRadius: BorderRadius.circular(4),
      onTap: _showCustomPopup,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: widget.textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(Icons.expand_more)
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
              top: offset.dy + size.height + 3,
              child: ScaleTransition(
                alignment: Alignment.topLeft,
                scale: scaleAnimation,
                child: Material(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  // elevation: 1,
                  borderRadius: BorderRadius.circular(6),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 35, minWidth: 150),
                    child: Material(
                      color: Colors.transparent,
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.items
                              .map(
                                (i) => InkWell(
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
            ),
          ],
        ),
      ),
    );

    overlayState.insert(overlayEntry);
    animationController.forward();
  }
}
