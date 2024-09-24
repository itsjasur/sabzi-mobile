import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
import 'package:sabzi_app/components/home_page_add_product_button.dart';
import 'package:sabzi_app/components/neighborhood_menu_button.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/models/category.dart';
import 'package:sabzi_app/models/item.dart';
import 'package:sabzi_app/pages/item.dart';
import 'package:sabzi_app/test/categories.dart';
import 'package:sabzi_app/test/items.dart';
import 'package:sabzi_app/providers/theme_provider.dart';
import 'package:sabzi_app/theme.dart';
import 'package:sabzi_app/utils/custom_localizers.dart';
import 'package:uicons/uicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = ScrollController();

  String _selectedCategory = "all";

  final List<Item> _items = items;

  bool _homePageScrolled = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        _homePageScrolled = _scrollController.offset - 50 >= _scrollController.position.minScrollExtent;
      });
    });
  }

  final List<ItemCategory> _categories = categoriesList;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = AppColorPalette.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(width: 15),
          const NeighborhoodMenuButton(),
          const Spacer(),
          const SizedBox(width: 20),
          CustomIconButton(
            onTap: Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
            icon: UIcons.regularRounded.moon,
            iconSize: 22,
          ),
          const SizedBox(width: 20),
          CustomIconButton(
            onTap: () {},
            icon: UIcons.regularRounded.bell,
            iconSize: 22,
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        _categories.length,
                        (categoryIndex) {
                          ItemCategory category = _categories[categoryIndex];
                          return Container(
                            margin: EdgeInsets.only(left: categoryIndex == 0 ? 15 : 0, right: categoryIndex == _categories.length - 1 ? 15 : 10),
                            child: ScaledTap(
                              onTap: () {
                                _selectedCategory = category.code;
                                setState(() {});
                              },
                              child: Container(
                                constraints: const BoxConstraints(minWidth: 50),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: colors.secondary.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(6),
                                  border: _selectedCategory == category.code ? Border.all(color: colors.secondary.withOpacity(0.5)) : null,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                child: Text(category.name),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // ITEMS
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: _items.length,
                  (context, itemsIndex) {
                    //ITEM CARD
                    Item item = _items[itemsIndex];
                    return Column(
                      children: [
                        ScaledTap(
                          onTap: () {
                            print('ontap called');
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemPage(itemId: 1)));
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //item image
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
                                              style: TextStyle(
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold,
                                                fontWeight: FontWeight.w500,
                                                color: colors.text,
                                              ),
                                            ),
                                          ),
                                          ScaledTap(
                                            onTap: () {
                                              print('more clicked');
                                            },
                                            child: Icon(
                                              Icons.more_vert,
                                              color: colors.secondary.withOpacity(0.5),
                                              size: 23,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: colors.secondary.withOpacity(0.5),
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
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: colors.text,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Wrap(
                                          spacing: 7,
                                          runSpacing: 10,
                                          alignment: WrapAlignment.end,
                                          runAlignment: WrapAlignment.end,
                                          crossAxisAlignment: WrapCrossAlignment.end,
                                          children: [
                                            if (item.viewCount != null)
                                              _countsBuilder(
                                                item.viewCount!,
                                                UIcons.regularStraight.eye,
                                              ),
                                            if (item.likeCount != null)
                                              _countsBuilder(
                                                item.likeCount!,
                                                UIcons.regularStraight.heart,
                                              ),
                                            if (item.chatCount != null)
                                              _countsBuilder(
                                                item.chatCount!,
                                                UIcons.regularStraight.comments,
                                              )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (itemsIndex < _items.length - 1) const Divider(height: 10, indent: 14, endIndent: 14),
                      ],
                    );
                  },
                ),
              )
            ],
          ),

          //this determines homeaction button positions
          Positioned(
            bottom: 15,
            right: 15,
            child: HomePageActionButton(
              pageScrolled: _homePageScrolled,
            ),
          ),
        ],
      ),
    );
  }

  Widget _countsBuilder(int count, IconData icon) {
    final colors = AppColorPalette.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: colors.secondary.withOpacity(0.5),
          size: 13,
        ),
        const SizedBox(width: 3),
        Text(
          CustomFormatters().commafy(count),
          style: TextStyle(
            color: colors.secondary.withOpacity(0.5),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

     
// showPopupMenu(context, _buttonKey);
// showModalBottomSheet(
//   context: context,
//   builder: (BuildContext context) {
//     return SizedBox(
//       // height: 200,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Modal bottom sheet'),
//             ElevatedButton(
//               child: const Text('Close'),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );