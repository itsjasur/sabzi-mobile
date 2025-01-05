import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/app_back_button.dart';
import 'package:flutter_sabzi/core/widgets/map_view/models.dart';
import 'package:flutter_sabzi/core/widgets/map_view/my_radius_map_view.dart';

class MyRadiusPage extends StatefulWidget {
  const MyRadiusPage({super.key});

  @override
  State<MyRadiusPage> createState() => _MyRadiusPageState();
}

class _MyRadiusPageState extends State<MyRadiusPage> {
  List<double> _radiuses = [3, 6, 9, 12];
  double _selectedRadius = 0;

  @override
  void initState() {
    super.initState();
    _selectedRadius = _radiuses.first;
  }

  @override
  Widget build(BuildContext context) {
    final sliderColor = Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300 : Colors.grey.shade300;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 40,
        leading: const AppBarBackButton(isX: true),
        centerTitle: true,
        title: const Text(
          'My area settings',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: MyRadiusMapView(
              cordinates: LocationCordinates(latitude: 41.302542, longitude: 69.238718),
            ),
          ),
          Container(
            // color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // spacing: 30,
              children: [
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
                    tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 10.0),
                    // thumbColor: Theme.of(context).colorScheme.primary,
                    // overlayShape: SliderComponentShape.noThumb, //press splash color
                    // activeTickMarkColor: sliderColor,
                    // inactiveTickMarkColor: sliderColor,
                    // activeTrackColor: sliderColor,
                    // inactiveTrackColor: sliderColor,
                  ),
                  child: Slider(
                    value: _selectedRadius,
                    min: _radiuses.first,
                    max: _radiuses.last,
                    divisions: 3,
                    activeColor: sliderColor,
                    inactiveColor: sliderColor,
                    thumbColor: Theme.of(context).colorScheme.primary,
                    onChanged: (double value) {
                      _selectedRadius = value;
                      print(value);
                      setState(() {});
                      // ref.read(areaSettingsProvider.notifier).updateSliderValue(areaRadiusList[value.toInt()]);
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
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Farthest',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
