import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trabalho_final/models/filter_option.dart';
import 'package:trabalho_final/providers/geocoding.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:trabalho_final/providers/filter.dart';
import 'package:trabalho_final/screens/filter_selection.dart';
import 'package:trabalho_final/widgets/map/place_selection.dart';
import 'package:trabalho_final/screens/point_of_interest_details.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  static late GoogleMapController _mapController;

  static void updateMarkers(List<FilterOption> options) {
    Map._mapController.setMapStyle(Filter.getJSON(options));
  }

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
      // Mapa
      body: GoogleMap(
        initialCameraPosition: cefet,
        myLocationEnabled: true,

        // TODO adicionar opções nas configurações
        buildingsEnabled: false,
        zoomControlsEnabled: false,

        onMapCreated: (controller) {
          Map._mapController = controller;
          Map.updateMarkers([
            FilterOption('attractions', true),
            FilterOption('business', true),
            FilterOption('medical', false),
            FilterOption('placesOfWorship', false),
            FilterOption('schools', true),
            FilterOption('publicTransportStations', true),
            FilterOption('accessibility', false)
          ]);
        },
        onTap: (argument) => _viewPointOfInterestDetails(argument),
      ),

      // Botão dos filtros
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FilterSelection()),
          );
        }),
        child: const Icon(Icons.filter_alt),
      ),
    );
  }

  void _viewPointOfInterestDetails(LatLng position) async {
    List<GeocodingResult> allPlaces = await Geocoding.searchByLocation(position);

    if (allPlaces.isNotEmpty) {
      List<GeocodingResult> possiblePlaces = [];

      for (GeocodingResult result in allPlaces) {
        if (result.types.contains("point_of_interest")) { // TODO definir os tipos
          possiblePlaces.add(result);
        }
      }

      if (possiblePlaces.length == 1) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PointOfInterestDetails(
              pointOfInterestID: possiblePlaces.first.placeId,
            )),
          );
        });
      } else if (possiblePlaces.length > 1) {
        showDialog(
          context: context,
          builder: (context) => PlaceSelection(places: possiblePlaces),
        );
      }
    }
  }
}
