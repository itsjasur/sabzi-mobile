import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;
  final String? label;
  final TextStyle? labelStyle;
  final bool isCircle;
  final double? size;
  final double borderRadius;
  final Widget? trailingIcon;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.size = 24,
    this.borderRadius = 3,
    this.labelStyle,
    this.trailingIcon,
    this.isCircle = true,
  });

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: () => onChanged?.call(!value), // toggles the current value
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          if (isCircle)
            Icon(
              value ? PhosphorIconsFill.checkCircle : PhosphorIconsRegular.circle,
              color: value ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withAlpha(80),
              size: size,
            ),
          if (!isCircle)
            Icon(
              value ? PhosphorIconsFill.checkSquare : PhosphorIconsRegular.square,
              color: value ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withAlpha(80),
              size: size,
            ),
          if (label != null)
            Expanded(
              child: Text(
                label!,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          if (trailingIcon != null) trailingIcon!
        ],
      ),
    );
  }
}
