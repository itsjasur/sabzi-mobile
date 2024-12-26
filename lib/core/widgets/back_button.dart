import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.amber,
        child: Icon(
          PhosphorIcons.x(PhosphorIconsStyle.bold),
          // size: 26,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
