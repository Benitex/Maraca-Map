import 'package:flutter/material.dart';
import 'package:maraca_map/screens/filter_selection.dart';
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
              onPressed: () => setState(() {
                _open = false;
              }),
              child: const Icon(Icons.close),
            ),
          ),

          Positioned(bottom: 80, right: 150, left: 35,
            child: FloatingActionButton(
              heroTag: "filters",
              onPressed: () => setState(() {
                _open = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return FilterSelection(updateMarkers: widget.updateMap);
                  })
                );
              }),
              child: const Icon(Icons.location_on),
            ),
          ),
          
          Positioned(bottom: 130, right: 0, left: 35,
            child: FloatingActionButton(
              heroTag: "search",
              onPressed: () {
                // TODO adicionar tela de busca
              },
              child: const Icon(Icons.search),
            ),
          ),

          Positioned(bottom: 80, right: 0, left: 185,
            child: FloatingActionButton(
              heroTag: "settings",
              onPressed: () => setState(() {
                _open = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Settings(updateMap: widget.updateMap);
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
