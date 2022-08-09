import 'package:flutter/material.dart';
import 'package:maraca_map/screens/map.dart';

class FilterSelection extends StatefulWidget {
  const FilterSelection({super.key});

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

      body: ListView.builder(
        itemCount: Map.filters.length,
        itemBuilder: (context, index) {
          return Card(
            child: SwitchListTile(
              title: Text(
                Map.filters[index].name,
              ),
              value: Map.filters[index].active,
              onChanged: (value) => setState(() {
                Map.filters[index].active = value;
                Map.updateMarkers();
              }),
            ),
          );
        },
      ),
    );
  }
}
