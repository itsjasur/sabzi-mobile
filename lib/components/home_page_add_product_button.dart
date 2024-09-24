import 'package:flutter/material.dart';
import 'package:sabzi_app/components/custom_button.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/theme.dart';
import 'package:uicons/uicons.dart';

class HomePageActionButton extends StatefulWidget {
  final bool pageScrolled;
  const HomePageActionButton({super.key, required this.pageScrolled});

  @override
  State<HomePageActionButton> createState() => _HomePageActionButtonState();
}

class _HomePageActionButtonState extends State<HomePageActionButton> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return CustomButton(
      elevation: 1,
      // style: ElevatedButton.styleFrom(
      //   splashFactory: NoSplash.splashFactory,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(60),
      //   ),
      //   padding: EdgeInsets.zero,
      // ),
      onTap: () {
        // print('button onpressed clicked');
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        child: widget.pageScrolled
            ? SizedBox(
                width: 60,
                height: 60,
                child: Icon(
                  UIcons.boldRounded.plus,
                  size: 20,
                  color: colors.onMain,
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
    );
  }
}
