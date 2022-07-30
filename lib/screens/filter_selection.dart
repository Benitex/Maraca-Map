import 'package:flutter/material.dart';
import 'package:trabalho_final/classes/filter.dart';
import 'package:trabalho_final/screens/map.dart';

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
        itemCount: Filter.options.length,
        itemBuilder: (context, index) {
          return Card(
            child: SwitchListTile(
              title: Text(
                Filter.options[index].type,
                style: const TextStyle(), // TODO adicionar o estilo
              ),
              value: Filter.options[index].active,
              onChanged: (value) => setState(() {
                Filter.options[index].active = value;
                Map.updateMarkers();
              }),
            ),
          );
        },
      ),
    );
  }
}
