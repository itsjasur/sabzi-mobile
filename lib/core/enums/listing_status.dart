enum ListingStatus {
  sold('sold'),
  active('active');

  final String value;
  const ListingStatus(this.value);

  // Factory method to convert string to enum
  static ListingStatus fromString(String value) {
    return ListingStatus.values.firstWhere(
      (status) => status.value == value.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid listing status: $value'),
    );
  }

  // Optional: Override toString to return the string value
  @override
  String toString() => value;
}
