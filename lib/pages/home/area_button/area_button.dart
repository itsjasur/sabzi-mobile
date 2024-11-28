import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AreaButton extends ConsumerWidget {
  const AreaButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _itemBuilder() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ScaledTap(
          onTap: () {},
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              'Golden area',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    return ScaledTap(
      onTap: () {
        showModalBottomSheet(
          enableDrag: true,
          // isScrollControlled: true,
          // showDragHandle: true,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    _itemBuilder(),
                    _itemBuilder(),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          Text(
            '동동돌',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 5),
          Icon(
            PhosphorIconsBold.caretDown,
            size: 16,
          ),
        ],
      ),
    );
  }
}
