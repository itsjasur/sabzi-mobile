import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppBarBackButton extends StatelessWidget {
  final bool isX;
  const AppBarBackButton({super.key, this.isX = false});

  @override
  Widget build(BuildContext context) {
    return Navigator.canPop(context)
        ? ScaledTap(
            onTap: () => Navigator.pop(context),
            child: Icon(
              isX ? PhosphorIconsBold.x : PhosphorIconsBold.caretLeft,
              size: 25,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )
        : const SizedBox.shrink();
  }
}
