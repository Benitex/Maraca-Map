import 'package:flutter/material.dart';
import 'package:trabalho_final/classes/filter.dart';
import 'package:trabalho_final/screens/map_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
                MapScreen.updateMarkers();
              }),
            ),
          );
        },
      ),
    );
  }
}
