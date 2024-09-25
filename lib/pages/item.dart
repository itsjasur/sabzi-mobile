import 'package:flutter/material.dart';
import 'package:sabzi_app/components/icon_buttons/appbar_back.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
import 'package:sabzi_app/components/icon_buttons/go_to_home.dart';
import 'package:sabzi_app/components/icon_buttons/share.dart';
import 'package:sabzi_app/components/icon_buttons/theme_toggle.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/models/item.dart';
import 'package:sabzi_app/theme.dart';
import 'package:sabzi_app/utils/custom_localizers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ItemPage extends StatefulWidget {
  final int itemId;
  const ItemPage({super.key, required this.itemId});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  void initState() {
    super.initState();
  }

  final Item _item = Item(
    id: 1,
    title: 'Iphone 15 Plus',
    description: 'Iphone 15 in good condition',
    price: CustomFormatters().currencyFormat(434570, 'USD'),
    currency: 'USD',
    isNegotiable: true,
    sellerId: 1,
    distanceFromMe: '5.4 km',
    status: 'available',
    categoryId: 1,
    imageUrls: [
      "http://down-sg.img.susercontent.com/file/sg-11134201-7rblo-lprrj6hww4f4a4",
      "http://down-sg.img.susercontent.com/file/sg-11134201-7rblo-lprrj6hww4f4a4",
      "http://down-sg.img.susercontent.com/file/sg-11134201-7rblo-lprrj6hww4f4a4",
    ],
    datePosted: CustomFormatters().getRelativeTime('2024-07-24 15:04'),
    chatCount: 1222,
    likeCount: 42,
    viewCount: 5,
    isAddedToFavourites: false,
  );

  bool _pageLoading = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        actions: [
          const SizedBox(width: 15),
          const AppBarBackButton(
            iconColor: Colors.white,
          ),
          const SizedBox(width: 15),
          GoToHomeButton(iconColor: colors.onMain),
          const Spacer(),
          const SizedBox(width: 15),
          ThemeToggleButton(iconColor: colors.onMain),
          const SizedBox(width: 15),
          ShareButton(iconColor: colors.onMain),
          const SizedBox(width: 15),
          CustomIconButton(
            onTap: () {},
            icon: Icons.more_vert,
            iconSize: 30,
            color: Colors.white,
            // padding: const EdgeInsets.all(0),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: _pageLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 400,
                        child: PageView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: _item.imageUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              _item.imageUrls[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ScaledTap(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
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
                                // UIcons.regularRounded.info,
                                PhosphorIcons.info(PhosphorIconsStyle.regular),
                                color: colors.secondary.withOpacity(0.4),
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
                                    fontSize: 17,
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
                                    const Text(
                                      'Selling location',
                                      style: TextStyle(
                                        // color: colors.secondary.withOpacity(0.8),
                                        fontSize: 15,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    Icon(
                                      // UIcons.regularStraight.angle_right,
                                      PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                                      size: 14,
                                      // color: colors.secondary.withOpacity(0.4),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 3),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Colors.grey.shade50,
                                    height: 120,
                                    width: double.infinity,
                                    // child: const YandexTest(
                                    //   scrollGesturesEnabled: false,
                                    // ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 13,
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
                        ],
                      ),
                    ),
                    //this will build another scrollable list horizontally
                    // SliverList(
                    //   delegate: SliverChildBuilderDelegate(
                    //     (BuildContext context, int index) {
                    //       return Image.network(_items[index]);
                    //     },
                    //     childCount: _items.length,
                    //   ),
                    // ),
                    const SliverToBoxAdapter(child: SizedBox(height: 150)),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      border: Border(
                        top: BorderSide(
                          color: colors.secondary.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      bottom: true,
                      left: true,
                      right: true,
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            CustomIconButton(
                              // icon: _item.isAddedToFavourites ? UIcons.solidRounded.heart : UIcons.regularRounded.heart,
                              icon: _item.isAddedToFavourites ? PhosphorIcons.heart(PhosphorIconsStyle.fill) : PhosphorIcons.heart(PhosphorIconsStyle.regular),
                              color: _item.isAddedToFavourites ? Colors.red : colors.secondary.withOpacity(0.5),
                              iconSize: 30,
                              onTap: () {
                                _item.isAddedToFavourites = !_item.isAddedToFavourites;
                                setState(() {});
                              },
                            ),
                            VerticalDivider(
                              color: colors.secondary.withOpacity(0.1),
                              width: 20,
                            ),
                            const SizedBox(width: 15),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _item.price,
                                    // '123912839012 83091283 091283091',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (!_item.isNegotiable)
                                    Text(
                                      'Nonnegotiable',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: colors.secondary.withOpacity(0.5),
                                      ),
                                    ),
                                  if (_item.isNegotiable)
                                    ScaledTap(
                                      child: Text(
                                        'Offer a price',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: colors.main,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                          decorationColor: colors.main,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Chat'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
