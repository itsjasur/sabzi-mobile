import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T>? onChanged;
  final Widget? child;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return ScaledTap(
      onTap: () {
        if (!isSelected && onChanged != null) {
          onChanged!(value);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.transparent,
                  border: Border.all(
                    width: 2,
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
          if (child != null)
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: child!,
            ),
        ],
      ),
    );
  }
}
