import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trabalho_final/classes/filter.dart';
import 'package:trabalho_final/screens/filter_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  static late GoogleMapController _mapController;

  static void updateMarkers() {
    MapScreen._mapController.setMapStyle(Filter.getJSON());
  }

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // TODO colocar a camera na posição do usuário automáticamente
  CameraPosition cefet = const CameraPosition(
    target: LatLng(-22.912392877001498, -43.224780036813414),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mapa
      body: GoogleMap(
        initialCameraPosition: cefet,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          MapScreen._mapController = controller;
          MapScreen.updateMarkers();
        },
      ),

      // Botão para acesso aos filtros
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FilterScreen()),
          );
        }),
        child: const Icon(Icons.filter_alt),
      ),
    );
  }
}
