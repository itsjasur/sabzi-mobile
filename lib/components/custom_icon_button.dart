import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double width;
  final double height;
  final double iconSize;
  final Function()? onTap;
  final Color? color;
  const CustomIconButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.iconSize,
    this.color,
    this.width = 40,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
