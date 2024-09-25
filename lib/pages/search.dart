import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/models/category.dart';
import 'package:sabzi_app/test/categories.dart';
import 'package:sabzi_app/theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  final List<String> _previousSearchList = ['laptop', 'apple', 'samsung', 'iphone', 'laptop', 'apple', 'samsung', 'iphone', 'laptop', 'apple', 'samsung', 'iphone'];
  final List<ItemCategory> _categories = categoriesList;
  final List<String> _suggestedSearchWords = ['ipad tablet', 'samsung tab', 'microsoft desktop', 'sony playstation asdjaslkdja;sldjaskldj aslkdjaslkdjl;askjd;laskj'];
  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    super.build(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              const SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  controller: _searchTextController,
                  focusNode: _searchFocus,
                  style: const TextStyle(fontSize: 15),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    isCollapsed: true,
                    // isDense: true,
                    fillColor: colors.secondary.withOpacity(0.07),

                    hintText: 'Search here',
                    hintStyle: TextStyle(
                      color: colors.secondary.withOpacity(0.3),
                      fontSize: 15,
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),

                    constraints: const BoxConstraints(maxHeight: 40),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchTextController.clear();
                        });
                      },
                      child: Icon(
                        Icons.cancel,
                        color: colors.secondary.withOpacity(0.3),
                        size: 20,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  onTap: () {
                    print(_searchFocus.hasFocus);
                  },
                ),
              ),
              const SizedBox(width: 15)
            ],
          ),
          body: _searchTextController.text.isNotEmpty
              // SUGGESTED SEARCH WORDS
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: _suggestedSearchWords.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return ScaledTap(
                      onTap: () {
                        print('suggested word tapped');
                      },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 30),
                        child: Row(
                          children: [
                            Icon(
                              // UIcons.regularRounded.search,
                              PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
                              size: 17,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                _suggestedSearchWords[index],
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              //SEARCH HISTORY & CATEGORIES
              : SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (_previousSearchList.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Previous searches',
                                  style: TextStyle(fontSize: 14),
                                ),
                                const Spacer(),
                                ScaledTap(
                                  onTap: () {
                                    setState(() => _previousSearchList.clear());
                                  },
                                  child: Text(
                                    'Clear all',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colors.secondary.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_previousSearchList.isNotEmpty)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: List.generate(
                                  _previousSearchList.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: colors.secondary.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(_previousSearchList[index]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: const Text(
                            'Categories',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        if (_categories.isNotEmpty)
                          ...List.generate(
                            _categories.length,
                            (index) => Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ScaledTap(
                                onTap: () {
                                  print(_categories[index].name);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: colors.secondary.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.asset(
                                          _categories[index].imagUrl ?? "assets/images/smartphone.jpg",
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _categories[index].name,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
          // : Container(
          //     width: double.infinity,
          //     color: Colors.purple,
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: List.generate(100, (index) => Text('item $index')),
          //       ),
          //     ),
          //   ),
          ),
    );
  }
}
