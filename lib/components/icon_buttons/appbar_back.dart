import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
import 'package:sabzi_app/theme.dart';

class AppBarBackButton extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;
  const AppBarBackButton({super.key, this.iconColor, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return CustomIconButton(
      onTap: () {
        Navigator.of(context).maybePop();
      },
      // icon: UIcons.regularStraight.angle_left,
      icon: PhosphorIcons.caretLeft(PhosphorIconsStyle.regular),
      color: iconColor ?? colors.secondary,
    );
  }
}
