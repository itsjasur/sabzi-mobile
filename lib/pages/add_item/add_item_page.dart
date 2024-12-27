import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/formatters/currency_formatter.dart';
import 'package:flutter_sabzi/core/formatters/currency_with_suffix_formatter.dart';
import 'package:flutter_sabzi/core/models/currency_model.dart';
import 'package:flutter_sabzi/core/widgets/back_button.dart';
import 'package:flutter_sabzi/core/widgets/custom_text_form_field.dart';
import 'package:flutter_sabzi/core/widgets/radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_provider.dart';
import 'package:flutter_sabzi/pages/add_item/images_row.dart';
import 'package:flutter_sabzi/pages/add_item/widgets/verify_location_alert.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_provider.dart';

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
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _titleController,
                      hintText: 'What are you selling or giving away?',
                      errorText: _validator('title'),
                      onChanged: (String value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      hintText: '${_selectedCurrency.label} price',
                      errorText: _validator('title'),
                      prefixIcon: Container(
                        // color: Colors.amber,
                        padding: const EdgeInsets.only(left: 12),
                        child: IntrinsicWidth(
                          child: ScaledTap(
                            onTap: () {
                              print('currency tapped');
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
                                    // runSpacing: 20,
                                    // spacing: 20,
                                    children: List.generate(
                                      _currencyList.length,
                                      (index) => CustomRadio(
                                        onChanged: (value) {
                                          _selectedCurrency = value;
                                          Navigator.pop(context);
                                          setState(() {});
                                          // print(value);
                                        },
                                        value: _currencyList[index],
                                        groupValue: _selectedCurrency,
                                        child: Text("${_currencyList[index].code} ${_currencyList[index].label}"),
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
                                  Container(
                                    constraints: const BoxConstraints(minWidth: 20),
                                    child: Text(
                                      _selectedCurrency.label,
                                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                      textAlign: TextAlign.center,
                                    ),
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
                      inputFormatters: [
                        // CurrencyInputFormatterWithSuffix(currencyName: _currency.label),
                        CurrencyTextInputFormatter(),
                      ],
                      onChanged: (String value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CurrencyModel _selectedCurrency = CurrencyModel(code: 'UZS', label: "So'm");
  final List<CurrencyModel> _currencyList = [
    CurrencyModel(code: 'UZS', label: "So'm"),
    CurrencyModel(code: 'USD', label: "\$"),
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _validator(String? value) {
    print('validator called');
    if (_titleController.text.isEmpty) return 'Please fill title';
    if (_titleController.text.length < 5) return 'Title is too short';

    return null;
  }
}
