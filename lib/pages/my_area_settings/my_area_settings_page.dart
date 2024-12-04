import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_provider.dart';
import 'package:flutter_sabzi/pages/my_area_settings/yandex_map_view.dart';

class MyAreaSettingsPage extends ConsumerWidget {
  const MyAreaSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Spacer(),
          Text(
            'My area settings',
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              width: double.infinity,
              child: YandexMapView(
                myPosition: const MapPosition(latitude: 55.751225, longitude: 37.62954),
                areaRadius: ref.watch(areaSettingsProvider).selectedAreaRadius,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25, top: 20, bottom: 40),
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  const Text(
                    'Move slider to adjust your area radius',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3,
                      overlayShape: SliderComponentShape.noThumb,
                      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 8.0),
                    ),
                    child: Slider(
                      value: ref.watch(areaSettingsProvider).selectedAreaRadius.index.toDouble(),
                      min: 0,
                      max: 3,
                      divisions: 3,
                      secondaryActiveColor: Colors.red,
                      activeColor: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade400 : Colors.grey.shade400,
                      inactiveColor: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade400 : Colors.grey.shade400,
                      thumbColor: Theme.of(context).colorScheme.primary,
                      onChanged: (double value) {
                        print(value);
                        ref.read(areaSettingsProvider.notifier).updateSliderValue(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nearest',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        'Farthest',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
