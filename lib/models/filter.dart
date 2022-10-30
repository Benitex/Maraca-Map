import 'package:maraca_map/models/point_of_interest_type.dart';

class Filter extends PointOfInterestType {
  Filter({
    required String id,
    required String name,
    required this.active,
    required this.description,
    required this.subtypes,
  }) : super(id: id, name: name);

  bool active;
  final String description;
  final List<PointOfInterestType> subtypes;
}
