import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/map_view/models.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as yandex_mapkit;
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import 'package:yandex_maps_mapkit_lite/image.dart' as yanimage;

class MyRadiusMapView extends StatefulWidget {
  final LocationCordinates cordinates;
  final double zoomLevel;
  final double circleRadius;

  const MyRadiusMapView({super.key, required this.cordinates, required this.zoomLevel, required this.circleRadius});

  @override
  State<MyRadiusMapView> createState() => MyRadiusMapViewState();
}

class MyRadiusMapViewState extends State<MyRadiusMapView> {
  yandex_mapkit.MapWindow? _mapWindow;
  late final _cameraListener = MyCameraListener();

  @override
  void initState() {
    super.initState();
    _updateView();
  }

  @override
  void didUpdateWidget(MyRadiusMapView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.circleRadius != widget.circleRadius && oldWidget.zoomLevel != widget.zoomLevel) {
      _updateView();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mapWindow?.map.mapObjects.clear();
    _mapWindow?.map.removeCameraListener(_cameraListener);
  }

  void _updateView() {
    if (_mapWindow == null) return;
    _mapWindow!.map.mapObjects.clear();

    // this addds placemark to initial position
    _mapWindow!.map.mapObjects.addPlacemark()
      ..geometry = yandex_mapkit.Point(latitude: widget.cordinates.latitude, longitude: widget.cordinates.longitude)
      ..setIcon(_productImageProvider)
      ..setIconStyle(
        const yandex_mapkit.IconStyle(
          scale: 0.7,
        ),
      );

    // initial location
    _mapWindow!.map.moveWithAnimation(
      yandex_mapkit.CameraPosition(
        yandex_mapkit.Point(
          latitude: widget.cordinates.latitude,
          longitude: widget.cordinates.longitude,
        ),
        zoom: widget.zoomLevel,
        azimuth: 150.0,
        tilt: 0,
      ),
      const yandex_mapkit.Animation(yandex_mapkit.AnimationType.Smooth, duration: 0.5),
    );

    // circle placement
    _mapWindow!.map.mapObjects.addCircle(
      yandex_mapkit.Circle(
        yandex_mapkit.Point(
          latitude: widget.cordinates.latitude,
          longitude: widget.cordinates.longitude,
        ),
        radius: widget.circleRadius,
      ),
    )
      ..visible = false
      ..fillColor = Theme.of(context).colorScheme.primary.withAlpha(50)
      ..strokeColor = Theme.of(context).colorScheme.primary.withAlpha(50)
      ..strokeWidth = 2
      ..visible = true;

    setState(() {});
  }

  // pin image
  final _productImageProvider = yanimage.ImageProvider.fromImageProvider(
    const AssetImage("assets/location.png"),
    cacheable: true,
  );

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      onMapCreated: (yandex_mapkit.MapWindow mapWindow) {
        mapWindow.map.scrollGesturesEnabled = false;
        mapWindow.map.zoomGesturesEnabled = false;
        mapWindow.map.mode = yandex_mapkit.MapMode.Map;
        // mapWindow.map.nightModeEnabled = Theme.of(context).brightness == Brightness.dark;
        mapWindow.map.logo.setAlignment(const yandex_mapkit.LogoAlignment(yandex_mapkit.LogoHorizontalAlignment.Right, yandex_mapkit.LogoVerticalAlignment.Top));

        _mapWindow = mapWindow;

        //  this is camera listener
        _mapWindow?.map.addCameraListener(_cameraListener);

        _updateView();
      },
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
