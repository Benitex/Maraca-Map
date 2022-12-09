import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:maraca_map/services/geolocator.dart';
import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/screens/explore.dart';
import 'package:maraca_map/screens/point_of_interest_lists.dart';
import 'package:maraca_map/screens/settings.dart';

class CircularMenu extends StatelessWidget {
  const CircularMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      alignment: Alignment.bottomCenter,
      ringColor: Colors.black26,
      fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: const Icon(Icons.close, color: Colors.white),
      animationDuration: const Duration(milliseconds: 500),

      children: <FloatingActionButton>[
        FloatingActionButton(
          heroTag: "filters",
          tooltip: "Filtros do mapa",
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const MapFilterSelectionScreen();
            }),
          ),
          child: const Icon(Icons.filter_alt),
        ),

        FloatingActionButton(
          heroTag: "explore",
          tooltip: "Explorar lugares próximos",
          onPressed: () async {
            var location = await Geolocator.getCurrentLocation();
            if (!context.mounted) return;
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ExploreScreen(location: location);
              }),
            );
          },
          child: const Icon(Icons.share_location),
        ),

        FloatingActionButton(
          heroTag: "pointOfInterestLists",
          tooltip: "Listas de lugares",
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const PointOfInterestLists();
            }),
          ),
          child: const Icon(Icons.star),
        ),

        FloatingActionButton(
          heroTag: "settings",
          tooltip: "Configurações",
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const SettingsScreen();
            }),
          ),
          child: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
