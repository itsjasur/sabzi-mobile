import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/home_page_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class HoomeAddProductButton extends StatelessWidget {
  final bool homePageScrolled;
  const HoomeAddProductButton({super.key, required this.homePageScrolled});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<HomeProvider>(context, listen: true);

    return ScaledTap(
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
