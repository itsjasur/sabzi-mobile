import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/custom_checkbox.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/core/widgets/listing_card.dart';
import 'package:flutter_sabzi/pages/search/search_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final state = ref.watch(searchProvider);
    final notifier = ref.read(searchProvider.notifier);

    return GestureDetector(
      onTap: () {
        state.focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: TextFormField(
                      controller: state.searchTextController,
                      onFieldSubmitted: (v) => notifier.fetchListings(),
                      onChanged: notifier.updateSearchkeyword,
                      focusNode: state.focusNode,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(fontSize: 15),
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onSurface.withAlpha(20),
                        // isCollapsed: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                        suffixIconConstraints: const BoxConstraints(maxHeight: 22),
                        prefixIconConstraints: const BoxConstraints(maxHeight: 22),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(left: 8, right: 5),
                          child: ScaledTap(
                            onTap: () {},
                            child: Icon(
                              PhosphorIconsRegular.magnifyingGlass,
                              size: 20,
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                            ),
                          ),
                        ),
                        suffixIcon: state.searchTextController.text.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: ScaledTap(
                                  onTap: notifier.clearSearchKeywordInputText,
                                  child: Icon(
                                    PhosphorIconsFill.xCircle,
                                    color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                                    size: 20,
                                  ),
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
                  child: state.focusNode.hasFocus
                      ? Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: ScaledTap(
                            onTap: state.focusNode.unfocus,
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
        body: RefreshIndicator(
          onRefresh: notifier.refreshListings,
          child: CustomScrollView(
            controller: notifier.scrollController,
            slivers: [
              // FOCUSED, BUT NOT TYPED NOR SEARCHED -> SHOW RECENT SEARCHED KEYWORDS
              if (!state.isSearchRequested && state.searchTextController.text.isEmpty)
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
                          onTap: notifier.deleteAllRecentSearchkeywords,
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
              if (!state.isSearchRequested && state.searchTextController.text.isEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.recentSearchKeywords.length,
                    (context, recentSearchKeywordIndex) {
                      return ScaledTap(
                        onTap: () {
                          notifier.updateSearchkeyword(state.recentSearchKeywords.elementAt(recentSearchKeywordIndex));
                          notifier.fetchListings();
                        },
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
                                state.recentSearchKeywords.elementAt(recentSearchKeywordIndex),
                                style: const TextStyle(fontSize: 15),
                              ),
                              const Spacer(),
                              ScaledTap(
                                onTap: () => notifier.removeRecentSearchkeyword(state.recentSearchKeywords.elementAt(recentSearchKeywordIndex)),
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
              if (!state.isSearchRequested && state.searchTextController.text.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.suggestedSearchKeywords.length,
                    (context, suggestedSearchKetwordIndex) {
                      return ScaledTap(
                        onTap: () {
                          notifier.updateSearchkeyword(state.suggestedSearchKeywords.elementAt(suggestedSearchKetwordIndex));
                          notifier.fetchListings();
                        },
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
                                state.suggestedSearchKeywords.elementAt(suggestedSearchKetwordIndex),
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
              if (state.isSearchRequested)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Receive notifications whenever a new listing is added with this keyword: ${state.searchTextController.text}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            ScaledTap(
                              onTap: notifier.toggleCheckboxForNotifications,
                              child: Icon(
                                state.isReceiveNotificationsChecked ? PhosphorIconsFill.checkSquare : PhosphorIconsRegular.checkSquare,
                                color: state.isReceiveNotificationsChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withAlpha(80),
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
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: IntrinsicWidth(
                          child: CustomCheckbox(
                            size: 24,
                            onChanged: (value) => notifier.toggleCheckboxForListingStatus(),
                            value: state.isShowOnlyAvailableChecked,
                            label: 'Only show available listing',
                            labelStyle: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),

              // SEARCH REQUESTED -> SHOW LOADING
              if (state.isSearchRequested && state.listings.isLoading)
                const SliverFillRemaining(
                  fillOverscroll: true,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

              // SEARCHED AND LISTINGS FOUND
              if (state.isSearchRequested && !state.listings.isLoading && state.listings.items.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.listings.items.length,
                    (context, foundListingsIndex) {
                      return Column(
                        children: [
                          ListingCard(listing: state.listings.items[foundListingsIndex]),
                          if (foundListingsIndex != state.listings.items.length - 1)
                            Divider(
                              height: 30,
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
              if (state.isSearchRequested && !state.listings.isLoading && state.listings.items.isEmpty)
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
                          'Nothing found for the keyword: ${state.searchTextController.text}',
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
      ),
    );
  }
}
