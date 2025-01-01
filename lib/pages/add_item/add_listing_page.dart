import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/formatters/currency_formatter.dart';
import 'package:flutter_sabzi/core/widgets/back_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_text_form_field.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_listing_provider.dart';
import 'package:flutter_sabzi/pages/add_item/images_row.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_provider.dart';
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
      LocationCordinates? currentLocationCordination = ref.watch(areaSettingsProvider.select((state) => state.currentLocationCordination));
      if (currentLocationCordination != null) return;
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
                  ref.read(addListingProvider.notifier).saveDraft();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Draft saved'),
                      duration: Duration(seconds: 4),
                    ),
                  );
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 120),
                  child: Text(
                    'Save draft',
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: SingleChildScrollView(
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
                        controller: ref.watch(addListingProvider).titleController,
                        hintText: 'What are you selling or giving away?',
                        errorText: _validator('title'),
                        onChanged: (String value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 30),
                      _titleBuilder('Price'),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        controller: ref.watch(addListingProvider).priceController,
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
                                            ref.read(addListingProvider.notifier).updateCurrency(value);
                                            Navigator.pop(context);
                                          },
                                          value: 'USD',
                                          groupValue: ref.watch(addListingProvider).selectedCurrency,
                                          child: const Text("USD \$"), ////translate
                                        ),
                                        CustomRadio(
                                          onChanged: (value) {
                                            ref.read(addListingProvider.notifier).updateCurrency(value);
                                            Navigator.pop(context);
                                          },
                                          value: 'UZS',
                                          groupValue: ref.watch(addListingProvider).selectedCurrency,
                                          child: const Text("UZS So'm"), //translate
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
                                    Icon(
                                      PhosphorIcons.arrowsClockwise(PhosphorIconsStyle.regular),
                                      size: 14,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      ref.watch(addListingProvider).selectedCurrency == 'UZS' ? "So'm" : "\$", //translate
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    VerticalDivider(
                                      width: 20,
                                      color: Theme.of(context).colorScheme.secondary,
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
                        onChanged: (String value) {
                          // setState(() {});
                        },
                      ),
                      const SizedBox(height: 7),
                      ScaledTap(
                        onTap: () {
                          ref.read(addListingProvider.notifier).togglePriceNegotiable();
                        },
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
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.5,
                                    ),
                                    value: ref.watch(addListingProvider).isPriceNegotiable,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                              const Text("Open to offers"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _titleBuilder('Description'),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: ref.watch(addListingProvider).descriptionController,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        hintMaxLines: null,
                        hintText: """Write about your item. e.g. brand, material, condition and size. \n \nInclude anything that you think your neighbors would like to know\n""",
                        errorText: _validator('description'),
                        onChanged: (String value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 30),
                      const SizedBox(height: 30),
                      PrimaryButton(
                        onTap: () {
                          _submitted = true;
                          setState(() {});
                        },
                        child: const Text('Post'),
                      ),
                      const SizedBox(height: 20),
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

    if (value == 'title') {
      if (ref.watch(addListingProvider).titleController.text.isEmpty) return 'Please fill in the title.';
    }
    if (value == 'description') {
      if (ref.watch(addListingProvider).descriptionController.text.isEmpty) return 'Please fill in the description.';
    }

    return null;
  }
}
