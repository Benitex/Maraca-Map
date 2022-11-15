import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/providers/explore_filters_provider.dart';

class PriceDropdownMenu extends ConsumerWidget {
  const PriceDropdownMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<PriceLevel>(
      value: ref.watch(exploreFiltersProvider)["maxPrice"],
      style: const TextStyle(color: Colors.white),
      dropdownColor: Theme.of(context).primaryColor,

      items: const <DropdownMenuItem<PriceLevel>>[
        DropdownMenuItem(value: PriceLevel.free, child: Text("Grátis")),
        DropdownMenuItem(value: PriceLevel.inexpensive, child: Text("Barato")),
        DropdownMenuItem(value: PriceLevel.moderate, child: Text("Moderado")),
        DropdownMenuItem(value: PriceLevel.expensive, child: Text("Caro")),
        DropdownMenuItem(value: PriceLevel.veryExpensive, child: Text("Qualquer valor")),
      ],

      onChanged: (value) => ref.read(exploreFiltersProvider.notifier).setMaxPrice(value!),
    );
  }
}
