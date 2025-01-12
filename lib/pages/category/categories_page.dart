import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/app_back_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/category/categories_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesProvider);
    final notifier = ref.read(categoriesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(isX: true),
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              spacing: 12,
              children: [
                ...state.categories.map(
                  (category) => ScaledTap(
                    onTap: () async {
                      await notifier.selectCategory(category.id);
                      if (context.mounted) Navigator.pop(context);
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
                              size: 25,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          // IgnorePointer(
                          //   child: CustomRadio(
                          //     value: category.id,
                          //     groupValue: state.selectedCategoryId,
                          //     onChanged: null,
                          //   ),
                          // )
                        ],
                      ),
                    ),
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
