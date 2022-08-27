import 'package:flutter/material.dart';
import 'package:maraca_map/screens/map.dart';

class FilterSelection extends StatefulWidget {
  const FilterSelection({super.key, required this.updateMarkers});

  final Function updateMarkers;

  @override
  State<FilterSelection> createState() => _FilterSelectionState();
}

class _FilterSelectionState extends State<FilterSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtros"),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          for (var filter in Map.filters)
            Card(child: SwitchListTile(
              title: Text(
                filter.name,
              ),
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
