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
  final List<double> _radiuses = [3000, 6000, 9000, 12000];
  final List<double> _zoomLevels = [12.6, 11.7, 11.1, 10.7];
  double _selectedIndex = 0;

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
          Expanded(
            child: MyRadiusMapView(
              // key: ValueKey(_selectedIndex),
              cordinates: const LocationCordinates(latitude: 41.302542, longitude: 69.238718),
              circleRadius: _radiuses[_selectedIndex.toInt()],
              zoomLevel: _zoomLevels[_selectedIndex.toInt()],
            ),
          ),
          Container(
            // color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // spacing: 30,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Move slider to adjust your area radius',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
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
                    value: _selectedIndex,
                    min: 0,
                    max: (_radiuses.length - 1).toDouble(),
                    divisions: _radiuses.length - 1,
                    activeColor: sliderColor,
                    inactiveColor: sliderColor,
                    thumbColor: Theme.of(context).colorScheme.primary,
                    onChanged: (double value) {
                      _selectedIndex = value;
                      // print(value);
                      print(_radiuses[_selectedIndex.toInt()]);
                      print(_radiuses[_selectedIndex.toInt()]);
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
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
