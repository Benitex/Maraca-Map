import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trabalho_final/classes/filter.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  // TODO colocar a camera na posição do usuário automáticamente
  CameraPosition cefet = const CameraPosition(
    target: LatLng(-22.912392877001498, -43.224780036813414),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cefet,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          controller.setMapStyle(Filter.get());
        },
      ),
    );
  }
}
