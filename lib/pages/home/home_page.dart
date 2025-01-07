import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/models/listing_model.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/widgets/home_add_product_button.dart';
import 'package:flutter_sabzi/pages/home/widgets/home_page_item_card.dart';
import 'package:flutter_sabzi/pages/home/home_page_provider.dart';
import 'package:flutter_sabzi/pages/radius/my_radius_page.dart';
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
                    builder: (BuildContext context) => const MyRadiusPage());
              },
              child: Row(
                spacing: 5,
                children: [
                  const Text(
                    'My radius',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    PhosphorIcons.mapPinArea(PhosphorIconsStyle.regular),
                    size: 16,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(width: 20),
            ScaledTap(
              onTap: () {},
              child: Icon(
                PhosphorIcons.list(PhosphorIconsStyle.bold),
              ),
            ),
            const SizedBox(width: 15),
            ScaledTap(
              onTap: ref.read(themeProvider.notifier).toggleTheme,
              child: Icon(ref.watch(themeProvider) == ThemeMode.light ? PhosphorIconsBold.moon : PhosphorIconsBold.sun),
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
