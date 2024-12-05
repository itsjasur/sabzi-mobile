// enum AreaRadius {
//   small(zoomLevel: 14.0, circleRadius: 1000),
//   medium(zoomLevel: 13.0, circleRadius: 2000),
//   large(zoomLevel: 12.4, circleRadius: 3000),
//   huge(zoomLevel: 12, circleRadius: 4000);

//   final double zoomLevel;
//   final double circleRadius;

//   const AreaRadius({required this.zoomLevel, required this.circleRadius});

//   static AreaRadius fromString(String value) {
//     return AreaRadius.values.firstWhere((e) => e.name == value.toLowerCase(), orElse: () => AreaRadius.small);
//   }
// }

class AreaRadiusModel {
  final double zoomLevel;
  final double circleRadius;

  const AreaRadiusModel({
    required this.zoomLevel,
    required this.circleRadius,
  });

  factory AreaRadiusModel.fromJson(Map<String, dynamic> json) {
    return AreaRadiusModel(
      zoomLevel: json['zoomLevel'] as double,
      circleRadius: json['circleRadius'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'zoomLevel': zoomLevel,
      'circleRadius': circleRadius,
    };
  }
}

class LocationCordinates {
  final double latitude;
  final double longitude;

  const LocationCordinates({
    required this.latitude,
    required this.longitude,
  });

  factory LocationCordinates.fromMap(Map<String, dynamic> map) {
    return LocationCordinates(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // == operator: Defines when two LocationCordinates objects should be considered equal (same latitude and longitude)
  @override
  bool operator ==(Object other) {
    return other is LocationCordinates && other.latitude == latitude && other.longitude == longitude;
  }

// hashCode: Generates a unique identifier for the object, needed for correct behavior in collections like Sets and Maps
  @override
  int get hashCode => Object.hash(latitude, longitude);
}
