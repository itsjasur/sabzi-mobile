enum AreaRadius {
  small(zoomLevel: 14.0, circleRadius: 1000),
  medium(zoomLevel: 13.0, circleRadius: 2000),
  large(zoomLevel: 12.4, circleRadius: 3000),
  huge(zoomLevel: 12, circleRadius: 4000);

  final double zoomLevel;
  final double circleRadius;

  const AreaRadius({required this.zoomLevel, required this.circleRadius});

  static AreaRadius fromString(String value) {
    return AreaRadius.values.firstWhere((e) => e.name == value.toLowerCase(), orElse: () => AreaRadius.small);
  }
}

class MapPosition {
  final double latitude;
  final double longitude;

  const MapPosition({
    required this.latitude,
    required this.longitude,
  });

  factory MapPosition.fromMap(Map<String, dynamic> map) {
    return MapPosition(
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

  // == operator: Defines when two MapPosition objects should be considered equal (same latitude and longitude)
  @override
  bool operator ==(Object other) {
    return other is MapPosition && other.latitude == latitude && other.longitude == longitude;
  }

// hashCode: Generates a unique identifier for the object, needed for correct behavior in collections like Sets and Maps
  @override
  int get hashCode => Object.hash(latitude, longitude);
}
