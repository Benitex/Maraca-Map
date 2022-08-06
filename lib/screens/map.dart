import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:trabalho_final/providers/geocoding.dart';
import 'package:trabalho_final/providers/filter.dart';
import 'package:trabalho_final/providers/geolocator.dart';
import 'package:trabalho_final/providers/types.dart';
import 'package:trabalho_final/screens/filter_selection.dart';
import 'package:trabalho_final/models/filter_option.dart';
import 'package:trabalho_final/screens/point_of_interest_details.dart';
import 'package:trabalho_final/widgets/map/place_selection.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  static late GoogleMapController controller;
  static late List<FilterOption> filters;

  static void updateMarkers() {
    controller.setMapStyle(Filter.getJSON(filters));
  }

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mapa
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(-22.912392877001498, -43.224780036813414),
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,

        // TODO adicionar opções nas configurações
        buildingsEnabled: false,
        mapType: MapType.normal,
        zoomControlsEnabled: false,

        onMapCreated: (controller) => _onMapCreated(controller),
        onTap: (argument) => _viewPointOfInterestDetails(argument),
      ),

      // Botões
      floatingActionButton: Stack(
        children: [
          // Botão dos filtros
          Positioned(bottom: 70, right: 0,
            child: FloatingActionButton(
              heroTag: "Filtros",
              onPressed: () => setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FilterSelection()),
                );
              }),
              child: const Icon(Icons.filter_alt),
            ),
          ),

          // Botão de mover a câmera para posição atual
          Positioned(bottom: 0, right: 0,
            child: FloatingActionButton(
              heroTag: "Posição atual",
              onPressed: () async => await Map.controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(zoom: 18, target: await Geolocator.getCurrentLatLng()),
                ),
              ),
              child: const Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    Map.controller = controller;
    Map.filters = Types.getFilterOptions();
    Map.updateMarkers();
    Map.controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(zoom: 18, target: await Geolocator.getCurrentLatLng()),
    ));
  }

  void _viewPointOfInterestDetails(LatLng position) async {
    List<GeocodingResult> allPlaces = await Geocoding.searchByLocation(position);

    if (allPlaces.isNotEmpty) {
      List<GeocodingResult> possiblePlaces = [];

      for (GeocodingResult result in allPlaces) {
        if (result.types.contains("point_of_interest")) {
          // Verificação se um filtro ativo contém um dos subtipos
          filtersLoop:
          for (FilterOption option in Map.filters) {
            if (option.active) {
              for (String subtype in Types.getSubtypesByName(option.name)) {
                if (result.types.contains(subtype) && !possiblePlaces.contains(result)) {
                  possiblePlaces.add(result);
                  break filtersLoop;
                }
              }
            }
          }
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
