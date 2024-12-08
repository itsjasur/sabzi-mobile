import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/pages/home/home_page.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_page.dart';
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

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          // title: const Text('Welcome'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify location',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Please verify your location to sell your items.'),
              const SizedBox(height: 15),
              Row(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      height: 40,
                      onTap: () {
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(builder: (context) => const HomePage()),
                        //   (route) => false,
                        // );

                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Text(
                        'Cancel',
                        maxLines: 1,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      elevation: 0,
                      height: 40,
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyAreaSettingsPage()));
                      },
                      child: const Text(
                        'Verify location',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          // actions: [

          // ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              200,
              (index) => Text('Item $index'),
            ),
          ],
        ),
      ),
    );
  }
}
