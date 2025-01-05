import 'package:flutter/material.dart';
import 'package:flutter_sabzi/core/widgets/map_view/models.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as yandex_mapkit;
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import 'package:yandex_maps_mapkit_lite/image.dart' as yanimage;

// ClipRRect(
//   borderRadius: BorderRadius.circular(6),
//   child: const SizedBox(
//     height: 150,
//     child: ProductMapView(
//       cordinates: LocationCordinates(latitude: 41.302542, longitude: 69.238718),
//     ),
//   ),
// ),

class ProductMapView extends StatefulWidget {
  final LocationCordinates cordinates;
  const ProductMapView({super.key, required this.cordinates});

  @override
  State<ProductMapView> createState() => ProductMapViewState();
}

class ProductMapViewState extends State<ProductMapView> {
  // pin image
  final _productImageProvider = yanimage.ImageProvider.fromImageProvider(
    const AssetImage("assets/pin.png"),
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

        // initial location
        mapWindow.map.move(
          yandex_mapkit.CameraPosition(
            yandex_mapkit.Point(
              latitude: widget.cordinates.latitude,
              longitude: widget.cordinates.longitude,
            ),
            zoom: 13,
            azimuth: 150.0,
            tilt: 0,
          ),
        );

        // this addds placemark to initial position
        mapWindow.map.mapObjects.addPlacemark()
          ..geometry = yandex_mapkit.Point(latitude: widget.cordinates.latitude, longitude: widget.cordinates.longitude)
          ..setIcon(_productImageProvider)
          ..setIconStyle(const yandex_mapkit.IconStyle(scale: 0.5));

        mapWindow.map.logo.setAlignment(const yandex_mapkit.LogoAlignment(yandex_mapkit.LogoHorizontalAlignment.Right, yandex_mapkit.LogoVerticalAlignment.Top));
      },
    );
  }
}
