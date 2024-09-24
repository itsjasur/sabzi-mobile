import 'package:flutter/material.dart';
import 'package:sabzi_app/components/scaled_tap.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;

  final EdgeInsetsGeometry? padding;
  final double iconSize;
  final Function()? onTap;
  final Color? color;
  const CustomIconButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.iconSize,
    this.color,
    this.padding = const EdgeInsets.all(5),
  });

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        color: Colors.transparent,
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
