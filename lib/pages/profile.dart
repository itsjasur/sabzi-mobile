import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/providers/theme_provider.dart';
import 'package:sabzi_app/theme.dart';
import 'package:uicons/uicons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(width: 20),
          CustomIconButton(
            onTap: Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
            icon: UIcons.regularRounded.moon,
            iconSize: 22,
          ),
          const SizedBox(width: 20),
          CustomIconButton(
            onTap: () {},
            icon: UIcons.regularRounded.settings,
            iconSize: 22,
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.only(top: 10),
                    color: colors.secondary.withOpacity(0.1),
                    child: Image.asset(
                      'assets/images/user.png',
                      color: colors.secondary.withOpacity(0.2),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Jason Statham',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          _titleMaker("My items"),
          const SizedBox(height: 10),
          _itemMaker(
            // icon: UIcons.regularRounded.heart,
            icon: PhosphorIcons.heart(PhosphorIconsStyle.regular),
            onTap: () {},
            text: "Favourites",
          ),
          _itemMaker(
            icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
            onTap: () {},
            text: "My locations",
          ),
          _itemMaker(
            // icon: UIcons.regularRounded.receipt,
            icon: PhosphorIcons.receipt(PhosphorIconsStyle.regular),
            onTap: () {},
            text: "My items",
          ),
          _itemMaker(
            // icon: UIcons.regularRounded.receipt,
            icon: PhosphorIcons.shoppingBag(PhosphorIconsStyle.regular),
            onTap: () {},
            text: "Purchases",
          ),
          const SizedBox(height: 25),
          _titleMaker("System"),
          const SizedBox(height: 10),
          _itemMaker(
            // icon: UIcons.regularRounded.heart,
            icon: PhosphorIcons.bell(PhosphorIconsStyle.regular),
            onTap: () {},
            text: "Notifications",
          ),
          _itemMaker(
            // icon: UIcons.regularRounded.heart,
            icon: Theme.of(context).brightness == Brightness.light ? PhosphorIcons.moon(PhosphorIconsStyle.regular) : PhosphorIcons.sun(PhosphorIconsStyle.regular),
            onTap: () {},
            text: "Theme",
          ),
          _itemMaker(
            icon: PhosphorIcons.globeHemisphereEast(PhosphorIconsStyle.regular),
            onTap: () {},
            text: "Language",
          ),
        ],
      ),
    );
  }

  Widget _titleMaker(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _itemMaker({
    required String text,
    required IconData icon,
    required void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ScaledTap(
        onTap: () {},
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
