import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/models/type.dart';

class Firestore {
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

    filters.add(
      Filter(
        id: "traffic",
        name: "Trânsito",
        active: false,
        description: "Linhas de trânsito no mapa, quanto mais vermelho, mais engarrafado.",
        subtypes: [],
      ),
    );

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
