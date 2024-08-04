import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/components/appbar_back_button.dart';
import 'package:sabzi_mobile/components/custom_icon_button.dart';
import 'package:sabzi_mobile/components/map_with_marker.dart';
import 'package:sabzi_mobile/pages/wrapper/wrapper.dart';
import 'package:sabzi_mobile/providers/theme_provider.dart';
import 'package:sabzi_mobile/theme.dart';
import 'package:uicons/uicons.dart';

class ItemPage extends StatefulWidget {
  final int itemId;
  const ItemPage({super.key, required this.itemId});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List _items = [];

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 0,
        leading: const SizedBox(),
        actions: [
          const AppBarBackButton(
            iconColor: Colors.white,
          ),
          CustomIconButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Wrapper()));
            },
            icon: UIcons.regularRounded.home,
            iconSize: 22,
            color: Colors.white,
          ),
          const Spacer(),
          CustomIconButton(
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: UIcons.regularRounded.moon,
            iconSize: 22,
            color: Colors.white,
          ),
          CustomIconButton(
            onTap: () {},
            icon: UIcons.regularRounded.share,
            iconSize: 22,
            color: Colors.white,
          ),
          CustomIconButton(
            onTap: () {},
            icon: Icons.more_vert,
            iconSize: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 5)
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Image.network(
              "https://down-sg.img.susercontent.com/file/sg-11134201-7rblo-lprrj6hww4f4a4",
              width: double.infinity,
              fit: BoxFit.cover,
              height: 400,
              // height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Seller Cat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '10 km',
                            style: TextStyle(
                              color: colors.secondary.withOpacity(0.6),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      UIcons.regularRounded.info,
                      color: colors.secondary.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(indent: 15, endIndent: 15, height: 0),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Iphone 15 plus almost new',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.secondary.withOpacity(0.5),
                          ),
                          children: const [
                            TextSpan(text: 'Electronics', style: TextStyle(decoration: TextDecoration.underline)),
                            TextSpan(text: ' • '),
                            TextSpan(text: '3 hours ago'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        """Here's a short description of the iPhone 15: The iPhone 15 is Apple's 2023 flagship smartphone. It features a 6.1-inch Super Retina XDR OLED display, A16 Bionic chip, and a dual-camera system with 48MP main and 12MP ultra-wide lenses.""",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Selling location',
                            style: TextStyle(
                              color: colors.secondary.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            UIcons.regularStraight.angle_right,
                            size: 12,
                            color: colors.secondary.withOpacity(0.7),
                          )
                        ],
                      ),
                      const SizedBox(height: 3),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: MapWithMarker(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.secondary.withOpacity(0.5),
                          ),
                          children: const [
                            TextSpan(text: 'Seen 23'),
                            TextSpan(text: ' • '),
                            TextSpan(text: 'Interested 223'),
                            TextSpan(text: ' • '),
                            TextSpan(text: 'Chats 12'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Report this listing',
                        style: TextStyle(
                          fontSize: 15,
                          color: colors.secondary.withOpacity(0.6),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 40, indent: 15, endIndent: 15),
                const Text(
                  'Similiar items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Image.network(_items[index]);
              },
              childCount: _items.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 200)),
        ],
      ),
    );
  }
}
