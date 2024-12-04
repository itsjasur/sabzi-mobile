import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/models/item_model.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/my_area_settings/area_button/area_button.dart';
import 'package:flutter_sabzi/pages/home/home_add_product_button.dart';
import 'package:flutter_sabzi/pages/home/home_page_item_card.dart';
import 'package:flutter_sabzi/pages/home/home_page_provider.dart';
import 'package:flutter_sabzi/theme/app_them_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            const AreaButton(),
            const Spacer(),
            const SizedBox(width: 20),
            ScaledTap(
              onTap: ref.read(themeProvider.notifier).toggleTheme,
              child: Icon(ref.watch(themeProvider) == ThemeMode.light ? PhosphorIconsRegular.moon : PhosphorIconsBold.sun),
            ),
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
                      return Column(
                        children: [
                          ItemCard(
                            item: item,
                          ),
                          if (itemsIndex != items.length - 1)
                            Divider(
                              height: 20,
                              indent: 20,
                              endIndent: 20,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                        ],
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
