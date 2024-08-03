import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/providers/home_action_button_provider.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';
import 'package:sabzi_mobile/theme.dart';
import 'package:uicons/uicons.dart';

class HomePageActionButton extends StatefulWidget {
  const HomePageActionButton({super.key});

  @override
  State<HomePageActionButton> createState() => _HomePageActionButtonState();
}

class _HomePageActionButtonState extends State<HomePageActionButton> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculatePosition();
    });
  }

  double _right = 0;
  double _bottom = 0;

  _calculatePosition() {
    final RenderBox renderBox = context.read<HomeActionButtonProvider>().key?.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    _right = offset.dx + size.width;
    _bottom = offset.dy + size.height;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Consumer<HomeActionButtonProvider>(
      builder: (context, homeActionButtonProvider, child) => Positioned(
        right: MediaQuery.of(context).size.width - _right,
        bottom: MediaQuery.of(context).size.height - _bottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              child: homeActionButtonProvider.menuActive
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  : const SizedBox(width: 100),
            ),

            // Animated
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                backgroundColor: homeActionButtonProvider.menuActive ? colors.background : colors.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                // context.read<OverlayProvider>().toggle();
              },
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: !homeActionButtonProvider.scrollAtTop || homeActionButtonProvider.menuActive
                    ? SizedBox(
                        width: 60,
                        height: 60,
                        child: Icon(
                          UIcons.boldRounded.plus,
                          size: 20,
                          color: !homeActionButtonProvider.scrollAtTop ? colors.onMain : colors.secondary,
                        ),
                      )
                    : Container(
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
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
