import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'dart:ui' as ui;

class MapWithMarker extends StatefulWidget {
  const MapWithMarker({super.key});

  @override
  State<MapWithMarker> createState() => _MapWithMarkerState();
}

class _MapWithMarkerState extends State<MapWithMarker> {
  PlacemarkMapObject? placemarkMapObject;

  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initPlacemark();
  }

  Future<void> _initPlacemark() async {
    try {
      // final Uint8List imageData = await rootBundle.load('lib/assets/pin.png').then((byteData) => byteData.buffer.asUint8List());
      placemarkMapObject = PlacemarkMapObject(
        mapId: const MapObjectId('placemark_1'),
        point: const Point(latitude: 55.751244, longitude: 37.618423),
        // text: const PlacemarkText(text: 'asasdas', style: PlacemarkTextStyle(color: Colors.red)),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('lib/assets/pin.png'),
            scale: 0.6,
          ),
        ),

        opacity: 1,
      );

      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: YandexMap(
        // nightModeEnabled: true,
        logoAlignment: const MapAlignment(horizontal: HorizontalAlignment.left, vertical: VerticalAlignment.bottom),
        mapObjects: [
          if (placemarkMapObject != null) placemarkMapObject!,
        ],
        onMapCreated: (YandexMapController controller) {
          controller.moveCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(target: Point(latitude: 55.751244, longitude: 37.618423), zoom: 16),
            ),
          );
        },
      ),
    );
  }

  Future<ui.Image> captureWidgetAsImage() async {
    await Future.delayed(const Duration(seconds: 1));
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    return image;
  }

//   void _launchYandexMaps(Point location) async {
//   final url = 'yandexmaps://maps.yandex.ru/?pt=${location.longitude},${location.latitude}&z=14&l=map';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     // Fall back to web URL if app is not installed
//     launch('https://yandex.com/maps/?pt=${location.longitude},${location.latitude}&z=14&l=map');
//   }
// }
}
