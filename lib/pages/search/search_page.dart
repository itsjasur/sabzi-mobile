import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/enums/listing_status.dart';
import 'package:flutter_sabzi/core/models/listing_model.dart';
import 'package:flutter_sabzi/core/widgets/custom_checkbox.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/test.dart';
import 'package:flutter_sabzi/pages/home/widgets/home_page_item_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller = TextEditingController();

  final List<String> _previousSearchWords = ['samsung', 'iphone', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei'];
  final List<String> _suggestedSearchWords = ['samsung', 'iphone', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei', 'xiaomi', 'nokia', 'oppo', 'honor', 'huwei'];

  // final List<ListingModel> _foundListings = listingsList;
  final List<ListingModel> _foundListings = [];

  bool _isReceiveNotificationsChecked = true;
  bool _searchRequested = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            child: Row(
              // spacing: 10,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: TextFormField(
                      controller: _controller,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      focusNode: _focusNode,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onSurface.withAlpha(20),
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                        suffixIconConstraints: const BoxConstraints(maxHeight: 22),
                        prefixIconConstraints: const BoxConstraints(maxHeight: 22),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(left: 8, right: 5),
                          child: ScaledTap(
                            onTap: () {},
                            child: Icon(
                              PhosphorIconsRegular.magnifyingGlass,
                              size: 21,
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                            ),
                          ),
                        ),
                        suffixIcon: _controller.text.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: ScaledTap(
                                  child: Icon(
                                    PhosphorIconsFill.xCircle,
                                    color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                                    size: 21,
                                  ),
                                  onTap: () {
                                    _controller.clear();
                                    setState(() {});
                                  },
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _focusNode.hasFocus
                      ? Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: ScaledTap(
                            onTap: _focusNode.unfocus,
                            child: const Text(
                              'Close',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            // FOCUSED, BUT NOT TYPED NOR SEARCHED -> SHOW RECENT SEARCHED KEYWORDS
            if (_controller.text.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent searches',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ScaledTap(
                        onTap: () {},
                        child: Text(
                          'Delete all',
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // FOCUSED, BUT NOT TYPED NOR SEARCHED -> SHOW RECENT SEARCHED KEYWORDS
            if (_controller.text.isEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: _previousSearchWords.length,
                  (context, prevSearchWordIndex) {
                    return ScaledTap(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(
                              PhosphorIconsRegular.clock,
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                              size: 20,
                            ),
                            Text(
                              _previousSearchWords[prevSearchWordIndex],
                              style: const TextStyle(fontSize: 15),
                            ),
                            const Spacer(),
                            ScaledTap(
                              onTap: () {},
                              child: Icon(
                                PhosphorIconsRegular.x,
                                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            // WHEN FOCUSED AND TYPED -> SHOW SUGGESTED KEYWRODS (FROM API)
            if (_focusNode.hasFocus && _controller.text.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: _suggestedSearchWords.length,
                  (context, suggestedSearchWordIndex) {
                    return ScaledTap(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(
                              PhosphorIconsRegular.magnifyingGlass,
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                              size: 20,
                            ),
                            Text(
                              _suggestedSearchWords[suggestedSearchWordIndex],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            // SEARCH REQUESTED -> SHOW ADD NOTIFICATION KEYBOARD 1
            if (!_focusNode.hasFocus && _searchRequested)
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        spacing: 7,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              'Receive notifications whenever a new listing is added with this keyword: ${_controller.text}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          ScaledTap(
                            onTap: () {
                              _isReceiveNotificationsChecked = !_isReceiveNotificationsChecked;
                              setState(() {});
                            },
                            child: Icon(
                              _isReceiveNotificationsChecked ? PhosphorIconsFill.checkSquare : PhosphorIconsRegular.checkSquare,
                              color: _isReceiveNotificationsChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withAlpha(80),
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Divider(
                      height: 6,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(15),
                      thickness: 6,
                    )
                  ],
                ),
              ),

            // SEARCHED AND LISTINGS FOUND 1
            if (!_focusNode.hasFocus && _foundListings.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: _foundListings.length,
                  (context, foundListingsIndex) {
                    return Column(
                      children: [
                        ListingCard(listing: _foundListings[foundListingsIndex]),
                        if (foundListingsIndex != _foundListings.length - 1)
                          Divider(
                            height: 20,
                            indent: 17,
                            endIndent: 17,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(20),
                          ),
                      ],
                    );
                  },
                ),
              ),

            // SEARCHED BUT NO LISTING FOUND
            if (!_focusNode.hasFocus && _searchRequested && _foundListings.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/nothing.png",
                        height: 80,
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nothing found for the keyword: ${_controller.text}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 50))
          ],
        ),
      ),
    );
  }
}
