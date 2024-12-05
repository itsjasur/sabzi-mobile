import 'package:flutter/material.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as yandex_mapkit;
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import 'package:yandex_maps_mapkit_lite/image.dart' as yanimage;

class YandexMapView extends StatefulWidget {
  // final double latitude;
  // final double longitude;
  final LocationCordinates currenLocationCordinates;
  final AreaRadiusModel areaRadius;
  const YandexMapView({super.key, required this.currenLocationCordinates, required this.areaRadius});

  @override
  State<YandexMapView> createState() => YandexMapViewState();
}

class YandexMapViewState extends State<YandexMapView> {
  //  for programmatically changing camera position or adding/removing markers. if not remove _mapWindow.
  yandex_mapkit.MapWindow? _mapWindow;

  //camera positionlistener
  late final _cameraListener = MyCameraListener();

  final _imageProvider = yanimage.ImageProvider.fromImageProvider(const AssetImage("assets/pin.png"), cacheable: true);

  late final AppLifecycleListener _lifecycleListener;
  bool _isMapkitActive = false;

  @override
  void didUpdateWidget(YandexMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.areaRadius != widget.areaRadius) {
      _updateView(widget.areaRadius);
    }
  }

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

  _updateView(AreaRadiusModel areaRadius) {
    if (_mapWindow == null) return;

    _mapWindow!.map.mapObjects.clear();

    //adding circle radis from user's location * meters
    _mapWindow!.map.mapObjects.addCircle(yandex_mapkit.Circle(
      yandex_mapkit.Point(latitude: widget.currenLocationCordinates.latitude, longitude: widget.currenLocationCordinates.longitude),
      radius: areaRadius.circleRadius,
    ))
      ..visible = false
      ..fillColor = Theme.of(context).colorScheme.primary.withOpacity(0.3)
      ..strokeColor = Theme.of(context).colorScheme.primary.withOpacity(0.8)
      ..strokeWidth = 2
      ..visible = true;

    // this sets camera position
    _mapWindow!.map.moveWithAnimation(
      yandex_mapkit.CameraPosition(
        yandex_mapkit.Point(latitude: widget.currenLocationCordinates.latitude, longitude: widget.currenLocationCordinates.longitude),
        zoom: areaRadius.zoomLevel,
        azimuth: 150.0,
        tilt: 0,
      ),
      const yandex_mapkit.Animation(
        yandex_mapkit.AnimationType.Smooth,
        duration: 0.5,
      ),
    );

    // this addds placemark to initial position
    _mapWindow!.map.mapObjects.addPlacemark()
      ..geometry = yandex_mapkit.Point(latitude: widget.currenLocationCordinates.latitude, longitude: widget.currenLocationCordinates.longitude)
      ..setIcon(_imageProvider)
      ..setIconStyle(const yandex_mapkit.IconStyle(scale: 0.3));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YandexMap(
          // platformViewType: PlatformViewType.TextureHybrid,
          onMapCreated: (yandex_mapkit.MapWindow mapWindow) {
            // mapWindow.map.scrollGesturesEnabled = false;
            _mapWindow = mapWindow;

            _mapWindow?.map.logo.setAlignment(
              const yandex_mapkit.LogoAlignment(
                yandex_mapkit.LogoHorizontalAlignment.Right,
                yandex_mapkit.LogoVerticalAlignment.Top,
              ),
            );

            // this is camera listener
            _mapWindow?.map.addCameraListener(_cameraListener);
            _updateView(widget.areaRadius);
          },

          // scale: 1,
        ),
      ],
    );
  }
}

// this class acts as camera listener
class MyCameraListener implements yandex_mapkit.MapCameraListener {
  @override
  void onCameraPositionChanged(
    yandex_mapkit.Map map,
    yandex_mapkit.CameraPosition cameraPosition,
    yandex_mapkit.CameraUpdateReason reason,
    bool finished,
  ) {
    print('Zoom: ${cameraPosition.zoom}');
    print('Position: ${cameraPosition.target}');
  }
}
