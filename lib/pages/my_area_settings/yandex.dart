import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import 'package:yandex_maps_mapkit_lite/image.dart' as yanimage;

class YandexMapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  const YandexMapView({super.key, required this.latitude, required this.longitude});

  @override
  State<YandexMapView> createState() => YandexMapViewState();
}

class YandexMapViewState extends State<YandexMapView> {
  //  for programmatically changing camera position or adding/removing markers. if not remove _mapWindow.
  MapWindow? _mapWindow;

  //camera positionlistener
  late final _cameraListener = MyCameraListener();

  final _imageProvider = yanimage.ImageProvider.fromImageProvider(const AssetImage("assets/pin.png"), cacheable: true);

  late final AppLifecycleListener _lifecycleListener;
  bool _isMapkitActive = false;

  @override
  void initState() {
    super.initState();
    _startMapkit();
    _lifecycleListener = AppLifecycleListener(
      onResume: _startMapkit,
      onInactive: _stopMapkit,
    );
  }

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
  void dispose() {
    _lifecycleListener.dispose();
    _mapWindow?.map.removeCameraListener(_cameraListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      onMapCreated: (MapWindow mapWindow) {
        _mapWindow = mapWindow;

        // this sets initial camera position
        mapWindow.map.move(
          CameraPosition(
            Point(latitude: widget.latitude, longitude: widget.longitude),
            zoom: 17,
            azimuth: 150.0,
            tilt: 0,
          ),
        );

        // this addds placemark to initial position
        mapWindow.map.mapObjects.addPlacemark()
          ..geometry = Point(latitude: widget.latitude, longitude: widget.longitude)
          ..setIcon(_imageProvider)
          ..setIconStyle(const IconStyle(scale: 0.3));

        // this is camera listener
        mapWindow.map.addCameraListener(_cameraListener);
      },
    );
  }
}

// this class acts as camera listener
class MyCameraListener implements MapCameraListener {
  @override
  void onCameraPositionChanged(
    Map map,
    CameraPosition cameraPosition,
    CameraUpdateReason reason,
    bool finished,
  ) {
    print('Zoom: ${cameraPosition.zoom}');
    print('Position: ${cameraPosition.target}');
  }
}
