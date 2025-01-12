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
            height: 50,
            constraints: const BoxConstraints(minWidth: 50),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: homePageScrolled
                ? Icon(
                    PhosphorIcons.plus(PhosphorIconsStyle.bold),
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Text(
                    'Add product',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
