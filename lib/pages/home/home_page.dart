import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/home_add_product_button.dart';
import 'package:flutter_sabzi/pages/home/home_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, homeProvider, child) => Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            CustomScrollView(
              controller: homeProvider.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        ...List.generate(homeProvider.categories.length, (categoryIndex) {
                          CategoryModel category = homeProvider.categories[categoryIndex];

                          return ScaledTap(
                            onTap: () => homeProvider.setCategory(category),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              margin: const EdgeInsets.only(right: 10),
                              constraints: const BoxConstraints(minWidth: 50, minHeight: 35),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Theme.of(context).colorScheme.tertiary,
                                border: homeProvider.selectedCategory?.code == category.code ? Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)) : null,
                              ),
                              child: Text(category.name),
                            ),
                          );
                        }),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 100,
                    (context, index) {
                      return Text('data');
                    },
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: HoomeAddProductButton(homePageScrolled: homeProvider.isScrolled),
            )
          ],
        ),
      ),
    );
  }
}
