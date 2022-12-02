class PointOfInterestType {
  const PointOfInterestType({
    required this.id,
    required this.name,
    this.subtypes = const [],
  });

  final String id, name;
  final List<PointOfInterestType> subtypes;
}
