import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/formatters/currency_formatter.dart';
import 'package:flutter_sabzi/core/formatters/currency_with_suffix_formatter.dart';
import 'package:flutter_sabzi/core/models/currency_model.dart';
import 'package:flutter_sabzi/core/widgets/back_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_text_form_field.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_provider.dart';
import 'package:flutter_sabzi/pages/add_item/images_row.dart';
import 'package:flutter_sabzi/pages/add_item/widgets/verify_location_alert.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddItemPage extends ConsumerStatefulWidget {
  const AddItemPage({super.key});

  @override
  ConsumerState<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends ConsumerState<AddItemPage> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
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
              onTap: () {},
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
              ImagesRow(
                key: ValueKey(ref.read(addItemProvider).selectedAssetEntityList.length),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleBuilder('Title'),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _titleController,
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
                      controller: _priceController,
                      hintText: '${_selectedCurrency.label} price',
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
                                    children: List.generate(
                                      _currencyList.length,
                                      (index) => SizedBox(
                                        width: double.infinity,
                                        child: CustomRadio(
                                          onChanged: (value) {
                                            _selectedCurrency = _currencyList.firstWhere((currency) => currency.code == value);
                                            Navigator.pop(context);
                                          },
                                          value: _currencyList[index].code,
                                          groupValue: _selectedCurrency.code,
                                          child: Text("${_currencyList[index].code} ${_currencyList[index].label}"),
                                        ),
                                      ),
                                    ),
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
                                    _selectedCurrency.label,
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
                        _priceNegotiable = !_priceNegotiable;
                        setState(() {});
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
                                    width: 1,
                                  ),
                                  value: _priceNegotiable,
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
                      controller: _descriptionController,
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
                    PrimaryButton(
                      onTap: () {},
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
    );
  }

  Widget _titleBuilder(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  bool _priceNegotiable = true;

  CurrencyModel _selectedCurrency = CurrencyModel(code: 'UZS', label: "So'm");
  final List<CurrencyModel> _currencyList = [
    CurrencyModel(code: 'UZS', label: "So'm"),
    CurrencyModel(code: 'USD', label: "\$"),
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController(text: '0');
  final TextEditingController _descriptionController = TextEditingController();

  String? _validator(String? value) {
    if (value == 'title') {
      if (_titleController.text.isEmpty) return 'Please fill in the title.';
    }
    if (value == 'description') {
      if (_descriptionController.text.isEmpty) return 'Please fill in the description.';
    }

    return null;
  }
}
