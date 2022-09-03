import 'package:flutter/material.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:maraca_map/services/local_storage.dart';

class FilterSelectionScreen extends StatefulWidget {
  const FilterSelectionScreen({super.key, required this.updateMarkers});

  final Function updateMarkers;

  @override
  State<FilterSelectionScreen> createState() => _FilterSelectionScreenState();
}

class _FilterSelectionScreenState extends State<FilterSelectionScreen> {
  final List<Filter> filters = [
    MapScreen.filters["business"]!,
    MapScreen.filters["publicTransportStations"]!,
    MapScreen.filters["schools"]!,
    MapScreen.filters["attractions"]!,
    MapScreen.filters["traffic"]!,
    MapScreen.filters["medical"]!,
    MapScreen.filters["placesOfWorship"]!,
    MapScreen.filters["accessibility"]!,
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
            Card(
              child: SwitchListTile(
                title: Text(filter.name),
                subtitle: Text(filter.description),
                isThreeLine: true,
                value: filter.active,
                onChanged: (value) async {
                  await LocalStorage.setFilterValue(filter, value);
                  setState(() => widget.updateMarkers());
                }
              ),
            ),
        ],
      ),
    );
  }
}
