// Extracted to a separate widget for better performance
import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/enums/listing_status.dart';
import 'package:flutter_sabzi/core/models/listing_model.dart';
import 'package:flutter_sabzi/core/utils/custom_localizers.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListingCard extends StatelessWidget {
  final ListingModel listing;

  const ListingCard({required this.listing, super.key});

  @override
  Widget build(BuildContext context) {
    return ScaledTap(
      onTap: () {
        print('ontap called');
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: 15, left: 15),
        child: Row(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey.shade100,
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          listing.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ScaledTap(
                        onTap: () {
                          print('more clicked');
                        },
                        child: Icon(
                          PhosphorIconsFill.dotsThreeOutlineVertical,
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                          size: 18,
                        ),
                      ),
                    ],
                  ),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                      ),
                      children: [
                        TextSpan(text: listing.distanceFromMe),
                        const TextSpan(text: ' • '),
                        TextSpan(text: listing.datePosted),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 3),
                  Row(
                    spacing: 3,
                    children: [
                      if (listing.status == ListingStatus.sold)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            'sold',
                            // listing.status.value, //TODO TRANSLATE
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                      Text(
                        CustomFormatters().currencyFormat(listing.price, listing.currency).toLowerCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // spacing: 1,
                    children: [
                      if (listing.chatCount != null && listing.chatCount! > 0) ...[
                        Icon(
                          PhosphorIconsFill.chatCircleDots,
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                          size: 16,
                        ),
                        Text(
                          listing.chatCount.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                            fontSize: 13,
                            height: 1,
                          ),
                        ),
                      ],
                      if (listing.chatCount != null && listing.chatCount! > 0) ...[
                        const SizedBox(width: 5),
                        Icon(
                          PhosphorIconsFill.heart,
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                          size: 16,
                        ),
                        Text(
                          listing.likeCount.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                            fontSize: 13,
                            height: 1,
                          ),
                        ),
                      ],
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
