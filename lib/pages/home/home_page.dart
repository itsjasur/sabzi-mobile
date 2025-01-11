import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/models/listing_model.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/category/categories_page.dart';
import 'package:flutter_sabzi/pages/category/categories_provider.dart';
import 'package:flutter_sabzi/pages/home/widgets/home_add_product_button.dart';
import 'package:flutter_sabzi/pages/home/widgets/home_page_item_card.dart';
import 'package:flutter_sabzi/pages/home/home_page_provider.dart';
import 'package:flutter_sabzi/pages/area/my_area_page.dart';
import 'package:flutter_sabzi/pages/notifications/notifications_page.dart';
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
    final state = ref.watch(homePageProvider);

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: [
            const SizedBox(width: 15),
            ScaledTap(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Makes it full-screen if needed
                  useSafeArea: true,
                  isDismissible: false,
                  barrierColor: Theme.of(context).colorScheme.surface,
                  builder: (BuildContext context) => const MyAreaPage(),
                );
              },
              child: const Icon(PhosphorIconsRegular.mapPinArea
                  // size: 25,
                  ),
            ),
            const Spacer(),
            const SizedBox(width: 20),
            ScaledTap(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Makes it full-screen if needed
                    useSafeArea: true,
                    isDismissible: false,
                    enableDrag: false,
                    barrierColor: Theme.of(context).colorScheme.surface,
                    builder: (BuildContext context) => const CategoriesPage(),
                  );
                },
                child: Badge(
                  isLabelVisible: ref.watch(categoriesProvider).selectedCategoryId != -1,
                  backgroundColor: Colors.red,
                  smallSize: 12,
                  child: const Icon(PhosphorIconsRegular.list),
                )),
            const SizedBox(width: 15),
            ScaledTap(
              onTap: ref.read(themeProvider.notifier).toggleTheme,
              child: Icon(ref.watch(themeProvider) == ThemeMode.light ? PhosphorIconsRegular.moon : PhosphorIconsRegular.sun),
            ),
            const SizedBox(width: 15),
            ScaledTap(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
              },
              child: const Icon(PhosphorIconsRegular.bell),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: homeNotifier.refreshListings,
              child: CustomScrollView(
                controller: homeNotifier.scrollController,
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 5)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.listings.length,
                      (context, listingsIndex) {
                        ListingModel listing = state.listings[listingsIndex];
                        return Column(
                          children: [
                            ListingCard(listing: listing),
                            if (listingsIndex != state.listings.length - 1)
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
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),

                  // TODO: temporary
                  if (state.isLoadingMoreListings)
                    const SliverToBoxAdapter(
                      child: Align(
                        child: Text('Loading more'),
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 30)),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: HoomeAddProductButton(homePageScrolled: state.isPageScrolled),
            )
          ],
        ),
      ),
    );
  }
}
