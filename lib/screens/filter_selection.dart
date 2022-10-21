import 'package:flutter/material.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/services/local_storage.dart';

class FilterSelectionScreen extends StatefulWidget {
  const FilterSelectionScreen({super.key, required this.updateMarkers});

  final Function updateMarkers;

  static late Filter accessibility;
  static late Filter attractions;
  static late Filter business;
  static late Filter medical;
  static late Filter placesOfWorship;
  static late Filter publicTransportStations;
  static late Filter schools;
  static late Filter traffic;

  static set filters(Map<String, Filter> filters) {
    accessibility = filters["accessibility"]!;
    attractions = filters["attractions"]!;
    business = filters["business"]!;
    medical = filters["medical"]!;
    placesOfWorship = filters["placesOfWorship"]!;
    publicTransportStations = filters["publicTransportStations"]!;
    schools = filters["schools"]!;
    traffic = filters["traffic"]!;
  }

  @override
  State<FilterSelectionScreen> createState() => _FilterSelectionScreenState();
}

class _FilterSelectionScreenState extends State<FilterSelectionScreen> {
  List<Filter> filters = [
    FilterSelectionScreen.business,
    FilterSelectionScreen.publicTransportStations,
    FilterSelectionScreen.schools,
    FilterSelectionScreen.attractions,
    FilterSelectionScreen.traffic,
    FilterSelectionScreen.medical,
    FilterSelectionScreen.placesOfWorship,
    FilterSelectionScreen.accessibility,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtros"),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          for (Filter filter in filters)
            Card(child: SwitchListTile(
              title: Text(filter.name),
              subtitle: Text(filter.description),
              isThreeLine: true,
              value: filter.active,
              onChanged: (value) async {
                filter.active = value;
                await LocalStorage.saveFilter(filter);
                setState(() => widget.updateMarkers());
              }
            )),
        ],
      ),
    );
  }
}
