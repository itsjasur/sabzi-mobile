import 'package:flutter/material.dart';
import 'package:sabzi_mobile/theme.dart';
import 'package:uicons/uicons.dart';

class AppBarBackButton extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;
  const AppBarBackButton({super.key, this.iconColor, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            UIcons.regularStraight.angle_left,
            color: iconColor ?? colors.secondary,
            size: iconSize ?? 22,
          ),
        ),
        onTap: () {
          Navigator.of(context).maybePop();
        },
      ),
    );
  }
}
