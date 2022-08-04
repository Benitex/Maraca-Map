import 'package:flutter/material.dart';
import 'package:trabalho_final/models/filter_option.dart';
import 'package:trabalho_final/screens/map.dart';

class FilterSelection extends StatefulWidget {
  const FilterSelection({super.key});

  @override
  State<FilterSelection> createState() => _FilterSelectionState();
}

class _FilterSelectionState extends State<FilterSelection> {
  static final List<FilterOption> _filterOptions = [
    FilterOption('attractions', true),
    FilterOption('business', true),
    FilterOption('medical', false),
    FilterOption('placesOfWorship', false),
    FilterOption('schools', true),
    FilterOption('publicTransportStations', true),
    FilterOption('accessibility', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtros"),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          return Card(
            child: SwitchListTile(
              title: Text(
                _filterOptions[index].name,
              ),
              value: _filterOptions[index].active,
              onChanged: (value) => setState(() {
                _filterOptions[index].active = value;
                Map.updateMarkers(_filterOptions);
              }),
            ),
          );
        },
      ),
    );
  }
}
