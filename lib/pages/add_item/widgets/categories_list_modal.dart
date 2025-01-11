import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/app_back_button.dart';

import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_provider.dart';
import 'package:flutter_sabzi/pages/category/categories_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CategoriesListModal extends ConsumerWidget {
  const CategoriesListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider).categories;
    final notifier = ref.read(addListingProvider.notifier);
    final state = ref.watch(addListingProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(isX: true),
        title: const Text('Choose category'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                ...categories.map(
                  (category) => Column(
                    children: [
                      ScaledTap(
                        onTap: () async {
                          notifier.selectCategory(category.id);
                          if (context.mounted) Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            spacing: 10,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (category.id == state.selectedCategoryId)
                                Icon(
                                  PhosphorIconsFill.checkCircle,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 0,
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(20),
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
