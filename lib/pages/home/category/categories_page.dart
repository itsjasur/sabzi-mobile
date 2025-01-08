import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/models/category_model.dart';
import 'package:flutter_sabzi/core/widgets/app_back_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/home/category/categories_provider.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CategoryModel> categories = [
      CategoryModel(id: 1, name: 'Electronics', imagUrl: "assets/iphone.png"),
      CategoryModel(id: 2, name: 'Furniture & interior', imagUrl: "assets/iphone.png"),
    ];

    final state = ref.watch(categoriesProvider);
    final notifier = ref.read(categoriesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(isX: true),
        title: const Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          spacing: 12,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...state.categories.map(
              (category) => ScaledTap(
                onTap: () {
                  notifier.toggleCategorySelect();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
                    borderRadius: BorderRadius.circular(5),
                    // border: state.selectedCategoryId == category.id
                    //     ? Border.all(
                    //         color: Theme.of(context).colorScheme.primary.withAlpha(100),
                    //         width: 3,
                    //       )
                    //     : Border.all(
                    //         color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
                    //         width: 3,
                    //       ),
                  ),
                  child: Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(20),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(
                          "assets/iphone.png",
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Electronics',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomRadio(
                        value: category.id,
                        groupValue: state.selectedCategoryId,
                        onChanged: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
