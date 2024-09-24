import 'package:flutter/material.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
import 'package:sabzi_app/theme.dart';
import 'package:uicons/uicons.dart';

class AppBarBackButton extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;
  const AppBarBackButton({super.key, this.iconColor, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: CustomIconButton(
        onTap: () {
          Navigator.of(context).maybePop();
        },
        icon: UIcons.regularStraight.angle_left,
        iconSize: 22,
        color: iconColor ?? colors.secondary,
      ),
    );
  }
}
