import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  final bool isSelected;
  const RadioWidget({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
