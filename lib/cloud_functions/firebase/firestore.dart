import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maraca_map/models/accessibility_point.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/models/type.dart';

class Firestore {
  static Future<Set<AccessibilityMarker>> getAccessibilityPoints() async {
    final QuerySnapshot<Map<String, dynamic>> pointsCollection =
        await FirebaseFirestore.instance.collection("accessibility_markers").get();

    Set<AccessibilityMarker> points = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> document in pointsCollection.docs) {
      Map<String, dynamic> databasePoints = document.data();

      databasePoints.forEach((key, point) {
        points.add(
          AccessibilityMarker(
            id: MarkerId(key),
            type: document.id,
            position: LatLng(
              point['position'].latitude,
              point['position'].longitude,
            ),
          ),
        );
      });
    }

    return points;
  }

  static Future<List<Filter>> getFilters() async {
    final QuerySnapshot<Map<String, dynamic>> filtersCollection =
        await FirebaseFirestore.instance.collection("filters").get();

    List<Filter> filters = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> document in filtersCollection.docs) {
      Map<String, dynamic> filter = document.data();

      filters.add(
        Filter(
          id: filter['id'],
          name: filter["portuguese_name"],
          active: filter["initial_value"],
          description: filter["description"],
          subtypes: _getTypesFromMap(filter["subtypes"]),
        ),
      );
    }

    return filters;
  }

  static List<PointOfInterestType> _getTypesFromMap(Map map) {
    List<PointOfInterestType> subtypes = [];

    map.forEach((key, value) {
      subtypes.add(
        PointOfInterestType(id: key, name: value),
      );
    });

    return subtypes;
  }
}
