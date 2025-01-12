import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_page.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class HoomeAddProductButton extends ConsumerWidget {
  final bool homePageScrolled;
  const HoomeAddProductButton({super.key, required this.homePageScrolled});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaledTap(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddListingPage()));
      },
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
        elevation: 1,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          child: Container(
            alignment: Alignment.center,
            // constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            child: homePageScrolled
                ? SizedBox(
                    height: 55,
                    width: 55,
                    child: Icon(
                      PhosphorIconsBold.plus,
                      size: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Add listing',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
