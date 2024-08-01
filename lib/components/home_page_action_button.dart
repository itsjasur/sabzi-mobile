import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';
import 'package:sabzi_mobile/theme.dart';
import 'package:uicons/uicons.dart';

class HomePageActionButton extends StatefulWidget {
  final bool isScrollAtTop;
  const HomePageActionButton({super.key, required this.isScrollAtTop});

  @override
  State<HomePageActionButton> createState() => _HomePageActionButtonState();
}

class _HomePageActionButtonState extends State<HomePageActionButton> with TickerProviderStateMixin {
  final GlobalKey _buttonKey = GlobalKey();

  bool _menuOpen = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Consumer<OverlayProvider>(
      builder: (context, overlayProvider, child) {
        final RenderBox renderBox = overlayProvider.widgetKey?.currentContext!.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        // final size = renderBox.size;
        // final bottomEndPosition = offset.dy + size.height;
        // final rightEndPosition = offset.dx + size.width;

        return Positioned(
          right: MediaQuery.of(context).size.width - offset.dx,
          bottom: MediaQuery.of(context).size.height - offset.dy,
          child: ElevatedButton(
            key: _buttonKey,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              padding: EdgeInsets.zero,
            ),
            // onPressed: showCustomAnchorMenu,
            onPressed: () {
              // OverlayState? overlayState = Overlay.of(context);
              // late OverlayEntry overlayEntry;
              // final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
              // final size = renderBox.size;

              // final offset = renderBox.localToGlobal(Offset.zero);
              // final bottomEndPosition = offset.dy + size.height;
              // final rightEndPosition = offset.dx + size.width;

              overlayProvider.activate();
            },
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: !overlayProvider.active && widget.isScrollAtTop
                  ? Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Icon(
                            UIcons.boldRounded.plus,
                            size: 14,
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            'Add product',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(
                        UIcons.boldRounded.plus,
                        size: 20,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  void showCustomAnchorMenu() {
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
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
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: ElevatedButton(
                onPressed: () {},
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Icon(
                    UIcons.boldRounded.plus,
                    size: 20,
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




  // Popup content
            // Positioned(
            //   left: offset.dx,
            //   // right: 20,
            //   top: offset.dy - size.height,
            //   // top: offset.dy - size.height - 20,
            //   child: ScaleTransition(
            //     alignment: Alignment.bottomCenter,
            //     scale: scaleAnimation,
            //     child: Material(
            //       // color: Theme.of(context).colorScheme.primaryContainer,
            //       // color: Theme.of(context).colorScheme.onPrimary,
            //       // elevation: 1,
            //       borderRadius: BorderRadius.circular(6),
            //       child: ConstrainedBox(
            //         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 35, minWidth: 150),
            //         child: const Material(
            //           color: Colors.transparent,
            //           child: IntrinsicWidth(
            //             child: Column(
            //               children: [
            //                 Text('Item 1'),
            //                 Text('Item 2'),
            //                 Text('Item 3'),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),