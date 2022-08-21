import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/cloud_functions/google_maps_webservice/geocoding.dart';
import 'package:maraca_map/cloud_functions/google_maps_webservice/geolocator.dart';
import 'package:maraca_map/providers/filter.dart';
import 'package:maraca_map/providers/types.dart';
import 'package:maraca_map/models/filter_option.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/widgets/map/floating_action_buttons.dart';
import 'package:maraca_map/widgets/map/place_selection.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  static late GoogleMapController controller;
  static List<FilterOption> filters = Types.getFilterOptions();

  static Future<void> moveCamera(LatLng location) async {
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 18, target: location),
      ),
    );
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

        trafficEnabled: Map.filters[6].active,

        // Configurações
        mapType: Settings.options[0].active ? MapType.hybrid : MapType.normal,
        zoomControlsEnabled: false,
        buildingsEnabled: false,
        compassEnabled: false,
        myLocationButtonEnabled: false,

        onMapCreated: (controller) => _onMapCreated(controller),
        onTap: (argument) => _searchPointsOfInterest(argument),
      ),

      // Botões
      floatingActionButton: Stack(
        children: [
          ExpandableFloatingActionButton(
            updateMap: () {
              setState(() {
                Map.controller.setMapStyle(Filter.getJSON(Map.filters));
              });
            }
          ),

          // Botão de mover a câmera para posição atual
          Positioned(bottom: 0, right: 0,
            child: FloatingActionButton(
              heroTag: "Posição atual",
              onPressed: () async => await Map.moveCamera(await Geolocator.getCurrentLatLng()),
              child: const Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    Map.controller = controller;
    Map.controller.setMapStyle(Filter.getJSON(Map.filters));
    Map.moveCamera(await Geolocator.getCurrentLatLng());
  }

  void _searchPointsOfInterest(LatLng position) async {
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
            MaterialPageRoute(builder: (context) {
              return PointOfInterestDetails(
                pointOfInterestID: possiblePlaces.first.placeId,
              );
            }),
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
