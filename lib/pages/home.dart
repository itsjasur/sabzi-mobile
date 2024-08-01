import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/components/home_page_action_button.dart';
import 'package:sabzi_mobile/models/category.dart';
import 'package:sabzi_mobile/models/item.dart';
import 'package:sabzi_mobile/pages/test.dart';
import 'package:sabzi_mobile/providers/overlay_provider.dart';
import 'package:sabzi_mobile/theme.dart';
import 'package:sabzi_mobile/utils/custom_localizers.dart';
import 'package:uicons/uicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // final List _pageContentList = ['categories', 'items', 'loadingMoreIcon'];

  final ScrollController _scrollController = ScrollController();

  bool _isScrollAtTop = true;

  final List<ItemCategory> _categories = [
    ItemCategory(id: 1, name: 'All', code: 'all'),
    ItemCategory(id: 2, name: 'Electronics', code: 'electronics'),
    ItemCategory(id: 3, name: 'Appliances', code: 'appliances'),
    ItemCategory(id: 3, name: 'Vehicles', code: 'vehicles'),
    ItemCategory(id: 3, name: 'Furniture', code: 'furniture'),
  ];

  String _selectedCategory = "all";

  final List<Item> _items = items;

  @override
  void initState() {
    super.initState();

    context.read<OverlayProvider>().updateOverlayWidget(
          HomePageActionButton(isScrollAtTop: _isScrollAtTop),
          _buttonKey,
        );

    _scrollController.addListener(() {
      print(_scrollController.offset);
      setState(() {
        _isScrollAtTop = _scrollController.offset <= _scrollController.position.minScrollExtent;
      });
      print('scrolled');
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = AppColorPalette.of(context);

    return Stack(
      children: [
        ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) {
            return index != 0 ? const Divider(height: 30, indent: 20, endIndent: 20) : const SizedBox(height: 20);
          },
          itemCount: 1 + _items.length, //first (0) for categories
          itemBuilder: (context, index) {
            if (index == 0) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _categories.length,
                    (categoryIndex) {
                      return Padding(
                        padding: categoryIndex == 0 ? const EdgeInsets.only(left: 15, right: 10) : const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Material(
                            color: colors.secondary.withOpacity(0.08),
                            child: InkWell(
                              onTap: () {
                                _selectedCategory = _categories[categoryIndex].code;
                                setState(() {});
                              },
                              child: Container(
                                constraints: const BoxConstraints(minWidth: 50),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: _selectedCategory == _categories[categoryIndex].code ? Border.all(color: colors.secondary.withOpacity(0.5)) : null,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                child: Text(_categories[categoryIndex].name),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            //ITEM CARD
            Item item = _items[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
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
                              Icon(
                                Icons.more_vert,
                                color: colors.secondary.withOpacity(0.5),
                                size: 23,
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${item.distanceFromMe} • ${item.datePosted}',
                            style: TextStyle(
                              fontSize: 14,
                              color: colors.secondary,
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
                                  _actionCountBuilder(
                                    item.viewCount!,
                                    UIcons.regularStraight.eye,
                                  ),
                                if (item.likeCount != null)
                                  _actionCountBuilder(
                                    item.likeCount!,
                                    UIcons.regularStraight.heart,
                                  ),
                                if (item.chatCount != null)
                                  _actionCountBuilder(
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
            );
          },
        ),
        Positioned(
            key: _buttonKey,
            bottom: 15,
            right: 15,
            // child: HomePageActionButton(
            //   isScrollAtTop: _isScrollAtTop,
            // ),
            child: const SizedBox()),
      ],
    );
  }

  Widget _actionCountBuilder(int count, IconData icon) {
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