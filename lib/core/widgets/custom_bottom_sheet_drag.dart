import 'package:flutter/material.dart';

class CustomBottomSheetDrag extends StatelessWidget {
  const CustomBottomSheetDrag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      width: double.infinity,
      height: 35,
      child: Align(
        child: Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
