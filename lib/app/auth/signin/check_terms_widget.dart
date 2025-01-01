import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class CheckTermsWidget extends ConsumerWidget {
  final Function(bool?) onCheck;
  final Function()? onOpen;
  final bool value;
  final String title;
  const CheckTermsWidget({super.key, required this.onCheck, required this.value, required this.title, this.onOpen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaledTap(
      onTap: () => onCheck(!value),
      child: Padding(
        // color: Colors.amber,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    size: 20,
                    color: value ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            if (onOpen != null)
              ScaledTap(
                onTap: onOpen,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
