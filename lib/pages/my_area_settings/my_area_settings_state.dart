import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';

class MyAreaSettingsState {
  final List<AreaRadiusModel> areaRadiusList;
  final LocationCordinates? currentLocationCordination;
  final AreaRadiusModel? currentRadius;
  final bool isLoading;

  // getter for selected index
  int get selectedIndex {
    if (currentRadius == null) return 0;
    final index = areaRadiusList.indexWhere((item) => item.zoomLevel == currentRadius?.zoomLevel && item.circleRadius == currentRadius?.circleRadius);
    return index == -1 ? 0 : index;
  }

  MyAreaSettingsState({
    required this.areaRadiusList,
    this.currentLocationCordination,
    this.currentRadius,
    required this.isLoading,
  });

  MyAreaSettingsState copyWith({
    List<AreaRadiusModel>? areaRadiusList,
    int? selectedIndex,
    LocationCordinates? currentLocationCordination,
    AreaRadiusModel? currentRadius,
    bool? isLoading,
  }) {
    return MyAreaSettingsState(
      areaRadiusList: areaRadiusList ?? this.areaRadiusList,
      currentLocationCordination: currentLocationCordination ?? this.currentLocationCordination,
      isLoading: isLoading ?? this.isLoading,
      currentRadius: currentRadius ?? this.currentRadius,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': currentLocationCordination?.latitude,
      'longitude': currentLocationCordination?.longitude,
      "zoom_level": currentRadius?.zoomLevel,
      "circle_radius": currentRadius?.circleRadius,
    };
  }
}
