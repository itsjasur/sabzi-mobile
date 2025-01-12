import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onTap;

  final Widget child;
  final double borderRadius;
  final double? height;
  final Color? backgroundColor;
  final double elevation;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.child,
    this.borderRadius = 6,
    this.backgroundColor,
    this.elevation = 0,
    this.height = 45,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: Material(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(borderRadius),
          elevation: elevation,
          color: isLoading ? Theme.of(context).colorScheme.onSurface : backgroundColor ?? Theme.of(context).colorScheme.primary,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: isLoading
                    ? Transform.scale(
                        scale: 0.7,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
