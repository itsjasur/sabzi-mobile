// Extracted to a separate widget for better performance
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/models/item_model.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  const ItemCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: () {
        print('ontap called');
      },
      child: Container(
        color: Colors.transparent,
        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(right: 15, left: 15),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.amber,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ScaledTap(
                        onTap: () {
                          print('more clicked');
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Icon(
                            PhosphorIcons.dotsThreeVertical(PhosphorIconsStyle.bold),
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                            size: 23,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13.5,
                        // color: Theme.of(context).colorScheme.secondary,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      children: [
                        TextSpan(text: item.distanceFromMe),
                        const TextSpan(text: ' • '),
                        TextSpan(text: item.datePosted),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.price.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
