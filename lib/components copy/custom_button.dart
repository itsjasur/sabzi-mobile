import 'package:flutter/material.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/theme.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final void Function()? onTap;
  final double elevation;
  const CustomButton({super.key, this.color, this.child, this.onTap, this.elevation = 0});

  void _handlePress() {
    print('ScaledTap onTap triggered');
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);
    final ThemeData theme = Theme.of(context);

    return ScaledTap(
      onTap: _handlePress,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(30),
        color: color ?? colors.main,
        child: DefaultTextStyle(
          style: theme.textTheme.bodyMedium!.copyWith(color: colors.onMain),
          child: IconTheme(
            data: theme.iconTheme.copyWith(color: colors.onMain),
            child: child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}
