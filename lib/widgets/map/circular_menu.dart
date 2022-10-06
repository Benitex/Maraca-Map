import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/screens/explore.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/services/geolocator.dart';

class CircularMenu extends StatefulWidget {
  const CircularMenu({super.key, required this.updateMap});

  final Function updateMap;

  @override
  State<CircularMenu> createState() => _CircularMenuState();
}

class _CircularMenuState extends State<CircularMenu> {
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
          onPressed: () => setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return FilterSelectionScreen(updateMarkers: widget.updateMap);
              }),
            );
          }),
          child: const Icon(Icons.filter_alt),
        ),
        FloatingActionButton(
          heroTag: "explore",
          tooltip: "Explorar lugares próximos",
          onPressed: () async {
            var location = await Geolocator.getCurrentLocation();
            setState(() {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ExploreScreen(location: location);
                }),
              );
            });
          },
          child: const Icon(Icons.share_location),
        ),
        FloatingActionButton(
          heroTag: "settings",
          tooltip: "Configurações",
          onPressed: () => setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return SettingsScreen(updateMap: widget.updateMap);
              }),
            );
          }),
          child: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
