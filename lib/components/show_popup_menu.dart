import 'package:flutter/material.dart';

void showPopupMenu(BuildContext context, GlobalKey key) {
  // gets the RenderBox of the button
  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);

  showDialog(
    context: context,
    useSafeArea: false,
    builder: (context) => Stack(
      children: [
        Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5,
          child: Material(
            elevation: 4.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                children: [
                  InkWell(
                    child: const Text('Item 1'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: const Text('Item 2'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
