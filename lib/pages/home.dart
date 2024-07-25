import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  bool get wantKeepAlive => true;

  final List _pageContentList = ['categories', 'items', 'loadingMoreIcon'];

  final List<String> _categories = ["all", "electronics", "appliances", "vehicles", "furniture", "clothing", "books", "toys"];
  final List<Category> _categoryList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      // width: double.infinity,
      // color: Colors.amber,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          if (index == 1) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  _categories.length,
                  (categoryIndex) {
                    return Container(
                      margin: categoryIndex == 0 ? const EdgeInsets.only(left: 20, right: 10) : const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(_categories[categoryIndex]),
                    );
                  },
                ),
              ),
            );
          }
          return Container(color: Colors.amber);
        },
      ),
    );
  }
}
