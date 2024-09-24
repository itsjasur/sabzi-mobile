import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/image.dart' as yanimage;
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';

class YandexTest extends StatefulWidget {
  final bool scrollGesturesEnabled;
  const YandexTest({super.key, this.scrollGesturesEnabled = true});

  @override
  State<YandexTest> createState() => _YandexTestState();
}

class _YandexTestState extends State<YandexTest> {
  MapWindow? _mapWindow;
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();

    _startMapkit();

    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        _startMapkit();
      },
      onInactive: () {
        _stopMapkit();
      },
    );
  }

  bool _isMapkitActive = false;

  void _startMapkit() {
    if (!_isMapkitActive) {
      _isMapkitActive = true;
      mapkit.onStart();
    }
  }

  void _stopMapkit() {
    if (_isMapkitActive) {
      _isMapkitActive = false;
      mapkit.onStop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IgnorePointer(
        ignoring: !widget.scrollGesturesEnabled,
        child: YandexMap(
          // scale: 13,
          onMapCreated: _onMapCreated,
          platformViewType: PlatformViewType.Compat,
        ),
      ),
    );
  }

  void _onMapCreated(MapWindow mapWindow) {
    mapWindow.map.nightModeEnabled = Theme.of(context).brightness == Brightness.dark;
    mapWindow.map.scrollGesturesEnabled = widget.scrollGesturesEnabled;

    mapWindow.map.move(
      const CameraPosition(
        Point(latitude: 55.751225, longitude: 37.62954),
        zoom: 17,
        azimuth: 150.0,
        tilt: 0,
      ),
    );
    // final imageProvider = ImageProvider.fromImageProvider(const AssetImage("assets/images/ic_pin.png"));
    final imageProvider = yanimage.ImageProvider.fromImageProvider(
      const AssetImage("assets/images/placeholder.png"),
      cacheable: true,
    );

    mapWindow.map.mapObjects.addPlacemark()
      ..geometry = const Point(latitude: 55.751225, longitude: 37.62954)
      ..setIcon(imageProvider)
      ..setIconStyle(const IconStyle(scale: 0.2));

    _mapWindow = mapWindow;

    // _mapWindow?.map.mapObjects.addPlacemark()
    // ..geometry = const Point(latitude: 55.751225, longitude: 37.62954);
  }
}
