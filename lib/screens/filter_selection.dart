import 'package:flutter/material.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/map.dart';

class FilterSelectionScreen extends StatefulWidget {
  const FilterSelectionScreen({super.key, required this.updateMarkers});

  final Function updateMarkers;

  @override
  State<FilterSelectionScreen> createState() => _FilterSelectionScreenState();
}

class _FilterSelectionScreenState extends State<FilterSelectionScreen> {
  final List<Filter> filters = []; 

  @override
  void initState() {
    MapScreen.filters.forEach((key, filter) {
      filters.add(filter);
    });
    super.initState();
  }

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
              value: filter.active,
              onChanged: (value) => setState(() {
                filter.active = value;
                widget.updateMarkers();
              }),
            )),
        ],
      ),
    );
  }
}
