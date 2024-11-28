import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/models/item_model.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/area_button/area_button.dart';
import 'package:flutter_sabzi/pages/home/home_add_product_button.dart';
import 'package:flutter_sabzi/pages/home/home_page_item_card.dart';
import 'package:flutter_sabzi/pages/home/home_page_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    //  gets the notifier once
    final homeNotifier = ref.read(homePageProvider.notifier);

    // watchers for specific parts of the state
    final categories = ref.watch(homePageProvider.select((state) => state.categories));
    final selectedCategory = ref.watch(homePageProvider.select((state) => state.selectedCategory));
    final items = ref.watch(homePageProvider.select((state) => state.items));
    final isScrolled = ref.watch(homePageProvider.select((state) => state.isScrolled));

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: [
            const SizedBox(width: 15),
            AreaButton(),
            const Spacer(),
            const SizedBox(width: 20),
            // CustomIconButton(
            //   onTap: Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
            //   icon: UIcons.regularRounded.moon,
            //   iconSize: 22,
            // ),
            // const SizedBox(width: 20),
            // CustomIconButton(
            //   onTap: () {},
            //   icon: UIcons.regularRounded.bell,
            //   iconSize: 22,
            // ),
            const SizedBox(width: 15),
          ],
        ),
        body: Stack(
          children: [
            CustomScrollView(
              controller: homeNotifier.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        ...List.generate(
                          categories.length,
                          (categoryIndex) {
                            CategoryModel category = categories[categoryIndex];

                            return ScaledTap(
                              onTap: () => homeNotifier.selectCategory(category),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                margin: const EdgeInsets.only(right: 10),
                                constraints: const BoxConstraints(minWidth: 50, minHeight: 35),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Theme.of(context).colorScheme.tertiary,
                                  border: selectedCategory?.code == category.code ? Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.7)) : null,
                                ),
                                child: Text(category.name),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: items.length,
                    (context, itemsIndex) {
                      ItemModel item = items[itemsIndex];
                      return ItemCard(
                        item: item,
                        isLastItem: itemsIndex == items.length - 1,
                      );
                    },
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: HoomeAddProductButton(homePageScrolled: isScrolled),
            )
          ],
        ),
      ),
    );
  }
}
