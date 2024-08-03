import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/components/custom_icon_button.dart';
import 'package:sabzi_mobile/components/neighborhood_menu_button.dart';
import 'package:sabzi_mobile/providers/neighborhood_provider.dart';
import 'package:sabzi_mobile/providers/theme_provider.dart';
import 'package:sabzi_mobile/theme.dart';
import 'package:uicons/uicons.dart';

class WrapperAppbar extends StatefulWidget implements PreferredSizeWidget {
  const WrapperAppbar({super.key});

  @override
  State<WrapperAppbar> createState() => _WrapperAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _WrapperAppbarState extends State<WrapperAppbar> {
  @override
  Widget build(BuildContext context) {
    // final colors = AppColorPalette.of(context);

    return AppBar(
      title: _titleBuilder(),
      centerTitle: false,
      leadingWidth: 0,
      leading: const SizedBox(),
      actions: [
        CustomIconButton(
          onTap: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: UIcons.regularRounded.moon,
          iconSize: 22,
        ),
        CustomIconButton(
          onTap: () {},
          icon: UIcons.regularRounded.bell,
          iconSize: 22,
        ),
        const SizedBox(width: 5)
      ],
    );
  }

  Widget _titleBuilder() {
    // NeighborhoodProvider neighborhoodProvider = Provider.of<NeighborhoodProvider>(context, listen: false);
    final neighborhoodProvider = context.read<NeighborhoodProvider>();

    return NeighborhoodMenuButton(
      title: neighborhoodProvider.currentNeighborHood ?? "Add neighborhood",
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      items: const [
        {'label': 'Yunusobod', 'code': 'YUN'},
        {'label': 'Uchtepa', 'code': 'UCH'},
      ],
    );
  }
}
