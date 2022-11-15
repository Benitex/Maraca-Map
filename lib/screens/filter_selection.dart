import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/services/local_storage.dart';
import 'package:maraca_map/services/map_style.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/providers/filters_provider.dart';
import 'package:maraca_map/screens/map.dart';

class MapFilterSelectionScreen extends ConsumerWidget {
  const MapFilterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(mapFiltersProvider).values;
    final filtersController = ref.read(mapFiltersProvider.notifier);
    final localStorage = ref.read(localStorageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtros"),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          for (MapFilter filter in filters)
            Card(child: SwitchListTile(
              title: Text(filter.name),
              subtitle: Text(filter.description),
              isThreeLine: true,
              value: filter.active,
              onChanged: (value) async {
                filtersController.updateFilter(filter.id, value);
                MapScreen.controller.setMapStyle(
                  ref.read(mapStyleConversorProvider).toJSON(),
                );
                await localStorage.saveFilter(filter.id, value);
              }
            )),
        ],
      ),
    );
  }
}
