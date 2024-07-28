import 'package:flutter/material.dart';
import 'package:sabzi_mobile/models/category.dart';
import 'package:sabzi_mobile/models/item.dart';
import 'package:sabzi_mobile/utils/custom_localizers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // final List _pageContentList = ['categories', 'items', 'loadingMoreIcon'];

  final List<ItemCategory> _categories = [
    ItemCategory(id: 1, name: 'All', code: 'all'),
    ItemCategory(id: 2, name: 'Electronics', code: 'electronics'),
    ItemCategory(id: 3, name: 'Appliances', code: 'appliances'),
    ItemCategory(id: 3, name: 'Vehicles', code: 'vehicles'),
    ItemCategory(id: 3, name: 'Furniture', code: 'furniture'),
  ];

  String _selectedCategory = "all";

  final List<Item> _items = [
    Item(
      id: 1,
      title: 'Iphone 15 Plus',
      description: 'Iphone 15 in good condition',
      price: CustomLocalizers().costFormatter(434570),
      isNegotiable: true,
      sellerId: 1,
      distanceFromMe: '5.4 km',
      status: 'available',
      categoryId: 1,
      imageUrls: [],
      datePosted: CustomLocalizers().getRelativeTime('2024-07-28 15:04'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) {
        return index != 0
            ? Divider(
                color: colorScheme.secondary.withOpacity(0.2),
                height: 20,
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
                    const Text(
                      // item.title,
                      'sakldja sdlaskdjaskld aslkjh aklsjdhas',
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${item.distanceFromMe} • ${item.datePosted}',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      item.price.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('')
                  ],
                ),
              ),
              //info
            ],
          ),
        );
      },
    );
  }
}


   // '•',