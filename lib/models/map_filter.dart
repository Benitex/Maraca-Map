import 'package:maraca_map/models/point_of_interest_type.dart';

class MapFilter {
  MapFilter({
    required this.id,
    required this.name,
    required this.active,
    required this.description,
    required this.subtypes,
  });

  bool active;
  final String id, name, description;
  final List<PointOfInterestType> subtypes;

  MapFilter copyWith(bool value) {
    return MapFilter(
      id: id,
      name: name,
      active: value,
      description: description,
      subtypes: subtypes,
    );
  }
}
