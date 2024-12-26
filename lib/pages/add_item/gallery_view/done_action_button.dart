import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_provider.dart';

class DoneActionButton extends ConsumerWidget {
  const DoneActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaledTap(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: RichText(
          maxLines: 1,
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
              overflow: TextOverflow.ellipsis,
              // fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ref.watch(addItemProvider.select((state) => state.selectedAssetEntityList.length.toString())),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(text: ' '),
              const TextSpan(text: 'Done'),
            ],
          ),
        ),
      ),
    );
  }
}
