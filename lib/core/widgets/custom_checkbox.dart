import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final String title;
  final double? size;
  final double? spacing;
  final double borderRadius;
  final TextStyle? labelStyle;
  final Widget? trailingIcon;
  // final Color? checkboxColor;
  // final double? borderWidth;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.size = 20,
    this.spacing = 7.0,
    this.borderRadius = 3,
    this.labelStyle,
    this.trailingIcon,
    // this.checkboxColor,
    // this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: () => onChanged(!value), // toggles the current value
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: value ? Theme.of(context).colorScheme.primary : null,
              border: value
                  ? null
                  : Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
            ),
            child: value
                ? Transform.scale(
                    scale: 0.8,
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: size,
                        color: Colors.white,
                        weight: 800,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          if (trailingIcon != null) trailingIcon!
        ],
      ),
    );
  }
}
