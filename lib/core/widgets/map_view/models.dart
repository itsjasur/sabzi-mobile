class LocationCordinates {
  final double latitude;
  final double longitude;

  const LocationCordinates({
    required this.latitude,
    required this.longitude,
  });

  factory LocationCordinates.fromMap(Map<String, dynamic> map) {
    return LocationCordinates(
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
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
