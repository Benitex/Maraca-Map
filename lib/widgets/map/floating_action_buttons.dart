import 'package:flutter/material.dart';
import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/screens/explore.dart';
import 'package:maraca_map/screens/settings.dart';

class ExpandableFloatingActionButton extends StatefulWidget {
  const ExpandableFloatingActionButton({super.key, required this.updateMap});

  final Function updateMap;

  @override
  State<ExpandableFloatingActionButton> createState() => ExpandableFloatingActionButtonState();
}

class ExpandableFloatingActionButtonState extends State<ExpandableFloatingActionButton> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: !_open ? (
        [
          Positioned(bottom: 0, right: 0, left: 35,
            child: FloatingActionButton(
              heroTag: "menu",
              tooltip: "Menu",
              onPressed: () => setState(() {
                _open = true;
              }),
              child: const Icon(Icons.menu),
            ),
          ),
        ]

      ) : (
        [
          Positioned(bottom: 0, right: 0, left: 35,
            child: FloatingActionButton(
              heroTag: "close",
              tooltip: "Fechar menu",
              onPressed: () => setState(() {
                _open = false;
              }),
              child: const Icon(Icons.close),
            ),
          ),

          Positioned(bottom: 80, right: 150, left: 35,
            child: FloatingActionButton(
              heroTag: "filters",
              tooltip: "Filtros do mapa",
              onPressed: () => setState(() {
                _open = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return FilterSelectionScreen(updateMarkers: widget.updateMap);
                  }),
                );
              }),
              child: const Icon(Icons.filter_alt),
            ),
          ),

          Positioned(bottom: 130, right: 0, left: 35,
            child: FloatingActionButton(
              heroTag: "explore",
              tooltip: "Explorar a região",
              onPressed: () => setState(() {
                _open = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ExploreScreen();
                  }),
                );
              }),
              child: const Icon(Icons.location_on),
            ),
          ),

          Positioned(bottom: 80, right: 0, left: 185,
            child: FloatingActionButton(
              heroTag: "settings",
              tooltip: "Configurações",
              onPressed: () => setState(() {
                _open = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SettingsScreen(updateMap: widget.updateMap);
                  }),
                );
              }),
              child: const Icon(Icons.settings),
            ),
          ),
        ]
      ),
    );
  }
}
