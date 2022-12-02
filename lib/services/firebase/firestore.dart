import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maraca_map/models/accessibility_marker.dart';
import 'package:maraca_map/models/map_filter.dart';
import 'package:maraca_map/models/point_of_interest_type.dart';
import 'package:maraca_map/providers/filters_provider.dart';

final firestoreProvider = Provider<Firestore>((ref) {
  return Firestore(ref);
});

class Firestore {
  Firestore(this.ref);

  ProviderRef ref;

  /// Recebe os marcadores de acessibilidade do banco de dados e retorna como um [Set] de [AccessibilityMarker].
  Future<Set<AccessibilityMarker>> getAccessibilityPoints() async {
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

  /// Carrega os [MapFilter] do Firestore para seu [StateNotifierProvider].
  Future<void> loadMapFilters() async {
    /// Converte o [map] de subtypes do banco de dados em uma [List] de [PointOfInterestType].
    List<PointOfInterestType> getTypesFromMap(Map map) {
      List<PointOfInterestType> subtypes = [];

      map.forEach((key, value) {
        subtypes.add(
          PointOfInterestType(id: key, name: value),
        );
      });

      return subtypes;
    }

    final QuerySnapshot<Map<String, dynamic>> filtersCollection =
        await FirebaseFirestore.instance.collection("filters").get();

    Map<String, MapFilter> filters = {};

    for (var document in filtersCollection.docs) {
      Map<String, dynamic> filter = document.data();

      filters[filter["id"]] = MapFilter(
        id: filter['id'],
        name: filter["portuguese_name"],
        active: filter["initial_value"],
        description: filter["description"],
        subtypes: getTypesFromMap(filter["subtypes"]),
      );
    }

    ref.read(mapFiltersProvider.notifier).setFilters(filters);
  }
}
