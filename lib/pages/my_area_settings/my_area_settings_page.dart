import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_provider.dart';
import 'package:flutter_sabzi/pages/my_area_settings/yandex_map_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MyAreaSettingsPage extends ConsumerWidget {
  const MyAreaSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(areaSettingsProvider.select((state) => state.selectedIndex));
    LocationCordinates currentLocationCordination = ref.watch(areaSettingsProvider.select((state) => state.currentLocationCordination));
    bool isLoading = ref.watch(areaSettingsProvider.select((state) => state.isLoading));
    AreaRadiusModel? currentRadius = ref.watch(areaSettingsProvider.select((state) => state.currentRadius));
    List<AreaRadiusModel> areaRadiusList = ref.watch(areaSettingsProvider.select((state) => state.areaRadiusList));

    final sliderColor = Theme.of(context).brightness == Brightness.light ? Colors.grey.shade400 : Colors.grey.shade400;

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? ScaledTap(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    PhosphorIcons.x(PhosphorIconsStyle.regular),
                    size: 25,
                  ),
                ),
              )
            : null,
        centerTitle: true,
        title: const Text('My area settings', style: TextStyle(fontSize: 16)),
      ),
      body: isLoading
          ? Align(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey.shade50,
                    width: double.infinity,
                    child: YandexMapView(
                      key: ValueKey(currentLocationCordination),
                      currenLocationCordinates: currentLocationCordination,
                      circleRadius: currentRadius?.circleRadius,
                      zoomLevel: currentRadius?.zoomLevel,
                    ),
                  ),
                ),
                if (areaRadiusList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            'Move slider to adjust your area radius',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              overlayShape: SliderComponentShape.noThumb,
                              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 8.0),
                              // thumbShape: SliderComponentShape.noThumb,
                            ),
                            child: Slider(
                              value: selectedIndex.toDouble(),
                              min: 0,
                              max: areaRadiusList.length - 1,
                              divisions: areaRadiusList.length - 1,
                              secondaryActiveColor: Colors.red,
                              activeColor: sliderColor,
                              inactiveColor: sliderColor,
                              thumbColor: Theme.of(context).colorScheme.primary,
                              onChanged: (double value) {
                                ref.read(areaSettingsProvider.notifier).updateSliderValue(areaRadiusList[value.toInt()]);
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
                          ),
                          const SizedBox(height: 15),
                          PrimaryButton(
                            onTap: ref.read(areaSettingsProvider.notifier).updateLocationCordinates,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(PhosphorIcons.gpsFix(PhosphorIconsStyle.regular)),
                                const SizedBox(width: 5),
                                const Text('Update location'),
                              ],
                            ),
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
