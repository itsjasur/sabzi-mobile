import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sabzi_mobile/models/category.dart';
import 'package:sabzi_mobile/models/item.dart';
import 'package:sabzi_mobile/pages/test.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) {
            return index != 0
                ? Divider(
                    color: colorScheme.secondary.withOpacity(0.07),
                    height: 30,
                    indent: 20,
                    endIndent: 20,
                  )
                : const SizedBox(height: 20);
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
                            color: colorScheme.secondaryContainer,
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
                                  border: _selectedCategory == _categories[categoryIndex].code ? Border.all(color: colorScheme.secondary) : null,
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: colorScheme.secondary.withOpacity(0.5),
                                size: 23,
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${item.distanceFromMe} • ${item.datePosted}',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.price.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
          bottom: 15,
          right: 15,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: EdgeInsets.zero,
            ),
            onPressed: () {},
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: _isScrollAtTop
                  ? Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Icon(
                            UIcons.boldRounded.plus,
                            size: 14,
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            'Add product',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(
                        UIcons.boldRounded.plus,
                        size: 20,
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }

  Widget _actionCountBuilder(int count, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          size: 13,
        ),
        const SizedBox(width: 3),
        Text(
          CustomFormatters().commafy(count),
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
