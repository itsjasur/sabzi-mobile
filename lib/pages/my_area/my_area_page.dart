import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/app_back_button.dart';
import 'package:flutter_sabzi/core/widgets/map_view/models.dart';
import 'package:flutter_sabzi/core/widgets/map_view/my_radius_map_view.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/my_area/my_area_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MyAreaPage extends ConsumerWidget {
  const MyAreaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myAreaProvider);
    final notifier = ref.read(myAreaProvider.notifier);

    final sliderColor = Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300 : Colors.grey.shade300;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 40,
        leading: const AppBarBackButton(isX: true),
        centerTitle: true,
        title: const Text('My area settings'),
        actions: [
          ScaledTap(
            onTap: () {
              // TODO: SHOW HTML INFO ON HOW MY RADIUS WORKS (WEBVIEW)
            },
            child: Icon(
              PhosphorIcons.info(PhosphorIconsStyle.regular),
              size: 25,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MyAreaMapView(
              cordinates: const LocationCordinates(latitude: 41.302542, longitude: 69.238718),
              circleArea: state.radiuses[state.currentIndex.toInt()],
              zoomLevel: state.zoomLevels[state.currentIndex.toInt()],
            ),
          ),
          SafeArea(
            child: Container(
              // color: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                // spacing: 30,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Move slider to adjust your area area',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3,
                      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 10.0),
                      overlayShape: SliderComponentShape.noThumb, //press splash color
                      overlayColor: Colors.transparent,
                    ),
                    child: Slider(
                      value: state.currentIndex,
                      min: 0,
                      max: (state.radiuses.length - 1).toDouble(),
                      divisions: state.radiuses.length - 1,
                      activeColor: sliderColor,
                      inactiveColor: sliderColor,
                      thumbColor: Theme.of(context).colorScheme.primary,
                      onChanged: notifier.changeIndex,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nearest',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Farthest',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
