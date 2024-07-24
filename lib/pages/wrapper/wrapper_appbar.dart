import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/components/menu_popup_text_button.dart';
import 'package:sabzi_mobile/providers/neighborhood.dart';
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
    return AppBar(
      title: _titleBuilder(),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 10),
          child: IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              // visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            icon: Icon(
              UIcons.regularRounded.bell,
              // size: 26,
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleBuilder() {
    // NeighborhoodProvider neighborhoodProvider = Provider.of<NeighborhoodProvider>(context, listen: false);
    final neighborhoodProvider = context.read<NeighborhoodProvider>();

    return MenuPopupTextButton(
      title: neighborhoodProvider.currentNeighborHood ?? "Add neighborhood",
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      items: const [
        {'label': 'Yunusobod', 'code': 'YUN'},
        {'label': 'Uchtepa', 'code': 'UCH'},
      ],
    );
  }
}
