import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/formatters/currency_formatter.dart';
import 'package:flutter_sabzi/core/formatters/currency_with_suffix_formatter.dart';
import 'package:flutter_sabzi/core/widgets/app_back_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_text_form_field.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_provider.dart';
import 'package:flutter_sabzi/pages/add_item/images_row.dart';
import 'package:flutter_sabzi/pages/add_item/widgets/categories_list_modal.dart';
import 'package:flutter_sabzi/pages/category/categories_page.dart';
import 'package:flutter_sabzi/pages/category/categories_provider.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddListingPage extends ConsumerStatefulWidget {
  const AddListingPage({super.key});

  @override
  ConsumerState<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends ConsumerState<AddListingPage> {
  @override
  void initState() {
    super.initState();

    // Show popup after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // LocationCordinates? currentLocationCordination = ref.watch(areaSettingsProvider.select((state) => state.currentLocationCordination));
      // if (currentLocationCordination != null) return;
      // showDialog(context: context, builder: (context) => const VerifyLocationAlert());
    });
  }

  final FocusNode _pageFocusNode = FocusNode();

  @override
  void dispose() {
    _pageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addListingProvider);
    final notifier = ref.read(addListingProvider.notifier);

    return Focus(
      focusNode: _pageFocusNode,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: const AppBarBackButton(),
            title: const Text(
              'New listing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            actions: [
              ScaledTap(
                onTap: () {
                  notifier.saveDraft();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Draft saved'),
                      duration: Duration(seconds: 4),
                    ),
                  );
                },
                child: Icon(
                  PhosphorIconsFill.fileDashed,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 5),
                const ImagesRow(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleBuilder('Title'),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: state.titleController,
                        hintText: 'What are you selling or giving away?',
                        errorText: _validator('title'),
                        onChanged: (String value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 20),

                      //
                      _titleBuilder('Category'),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        key: ValueKey(state.selectedCategoryId),
                        hintText: 'Select category',
                        initialValue: notifier.categoryName,
                        readOnly: true,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // Makes it full-screen if needed
                            useSafeArea: true,
                            isDismissible: false,
                            barrierColor: Theme.of(context).colorScheme.surface,
                            builder: (BuildContext context) => const CategoriesListModal(),
                          );
                        },
                        errorText: _validator('category'),
                        suffixIcon: Icon(
                          PhosphorIconsRegular.caretDown,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _titleBuilder('Price'),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        controller: state.priceController,
                        hintText: '0',
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: IntrinsicWidth(
                            child: ScaledTap(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => AlertDialog(
                                    contentPadding: const EdgeInsets.all(20),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        CustomRadio(
                                          onChanged: (value) {
                                            notifier.updateCurrency(value);
                                            Navigator.pop(context);
                                          },
                                          value: 'USD',
                                          groupValue: state.selectedCurrency,
                                          child: const Text("USD \$"), // TODO: translate
                                        ),
                                        CustomRadio(
                                          onChanged: (value) {
                                            notifier.updateCurrency(value);
                                            Navigator.pop(context);
                                          },
                                          value: 'UZS',
                                          groupValue: state.selectedCurrency,
                                          child: const Text("UZS So'm"), // TODO: translate
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      PhosphorIconsRegular.arrowsClockwise,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      state.selectedCurrency == 'UZS' ? "So'm" : "\$", // TODO: translate
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    VerticalDivider(
                                      width: 20,
                                      color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
                                      indent: 7,
                                      endIndent: 7,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        inputFormatters: [CurrencyTextInputFormatter()],
                      ),
                      const SizedBox(height: 7),
                      ScaledTap(
                        onTap: notifier.togglePriceNegotiable,
                        child: IntrinsicWidth(
                          child: Row(
                            spacing: 7,
                            children: [
                              SizedBox(
                                height: 18.5,
                                width: 18.5,
                                child: IgnorePointer(
                                  child: Checkbox(
                                    side: BorderSide(
                                      color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
                                      width: 1,
                                    ),
                                    value: state.isPriceNegotiable,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                              const Text(
                                "Open to offers",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _titleBuilder('Description'),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: state.descriptionController,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        hintMaxLines: null,
                        hintText: "Write about your item. e.g. brand, material, condition and size. \n \nInclude anything that you think your neighbors would like to know\n",
                        errorText: _validator('description'),
                        onChanged: (String value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: SafeArea(
              child: PrimaryButton(
                onTap: () {
                  _submitted = true;
                  setState(() {});
                },
                child: const Text('Post'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _submitted = false;
  Widget _titleBuilder(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  String? _validator(String? value) {
    if (!_submitted) return null;

    final state = ref.watch(addListingProvider);

    if (value == 'title') {
      if (state.titleController.text.isEmpty) return 'Please fill in the title';
    }

    if (value == 'category') {
      if (state.selectedCategoryId == -1) return 'Please choose category';
    }

    if (value == 'description') {
      if (state.descriptionController.text.isEmpty) return 'Please fill in the description';
    }

    return null;
  }
}
