import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_provider.dart';
import 'package:flutter_sabzi/pages/add_item/images_row.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New listing',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
        actions: [
          ScaledTap(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Save draft',
                style: TextStyle(
                  fontSize: 16,
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
            ...List.generate(100, (index) => Text('sdfkjsdfkjsdf skjdfhlkjshfksdjfjk')),
          ],
        ),
      ),
    );
  }
}
