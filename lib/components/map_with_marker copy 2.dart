// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';
// import 'dart:ui' as ui;

// class MapImageWidget extends StatefulWidget {
//   @override
//   _MapImageWidgetState createState() => _MapImageWidgetState();
// }

// class _MapImageWidgetState extends State<MapImageWidget> {
//   Future<ui.Image>? _imageFuture;

//   @override
//   void initState() {
//     super.initState();
//     _imageFuture = _captureMap();
//   }

//   Future<ui.Image> _captureMap() async {
//     final mapState = _MapWithMarkerState();
//     await mapState._initPlacemark();
//     return await mapState.captureWidgetAsImage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ui.Image>(
//       future: _imageFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//           return RawImage(image: snapshot.data);
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }

// class MapWithMarker extends StatefulWidget {
//   const MapWithMarker({Key? key}) : super(key: key);

//   @override
//   State<MapWithMarker> createState() => _MapWithMarkerState();
// }

// class _MapWithMarkerState extends State<MapWithMarker> {
//   PlacemarkMapObject? placemarkMapObject;
//   final GlobalKey _globalKey = GlobalKey();

//   Future<void> _initPlacemark() async {
//     try {
//       placemarkMapObject = PlacemarkMapObject(
//         mapId: const MapObjectId('placemark_1'),
//         point: const Point(latitude: 55.751244, longitude: 37.618423),
//         icon: PlacemarkIcon.single(
//           PlacemarkIconStyle(
//             image: BitmapDescriptor.fromAssetImage('lib/assets/pin.png'),
//             scale: 0.6,
//           ),
//         ),
//         opacity: 1,
//       );
//     } catch (e) {
//       print('Error initializing placemark: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       key: _globalKey,
//       child: YandexMap(
//         logoAlignment: const MapAlignment(horizontal: HorizontalAlignment.left, vertical: VerticalAlignment.bottom),
//         mapObjects: [
//           if (placemarkMapObject != null) placemarkMapObject!,
//         ],
//         onMapCreated: (YandexMapController controller) {
//           controller.moveCamera(
//             CameraUpdate.newCameraPosition(
//               const CameraPosition(target: Point(latitude: 55.751244, longitude: 37.618423), zoom: 16),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<ui.Image> captureWidgetAsImage() async {
//     await Future.delayed(Duration(seconds: 1)); // Give time for the map to load
//     RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     return image;
//   }
// }
