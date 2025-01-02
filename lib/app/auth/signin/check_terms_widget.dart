import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/custom_checkbox.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class CheckTermsWidget extends ConsumerWidget {
  final Function(bool?) onCheck;
  final Function()? onOpen;
  final bool value;
  final String title;
  const CheckTermsWidget({super.key, required this.onCheck, required this.value, required this.title, this.onOpen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.amber,
      child: CustomCheckbox(
        onChanged: onCheck,
        borderRadius: 20,
        size: 18,
        value: value,
        child: Expanded(
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14),
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
      ),
    );
  }
}
