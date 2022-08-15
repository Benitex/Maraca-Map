import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/cloud_functions/geocoding.dart';
import 'package:maraca_map/cloud_functions/geolocator.dart';
import 'package:maraca_map/providers/filter.dart';
import 'package:maraca_map/providers/types.dart';
import 'package:maraca_map/models/filter_option.dart';
import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/widgets/map/place_selection.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  static List<FilterOption> filters = Types.getFilterOptions();

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static late GoogleMapController _mapController;

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
        trafficEnabled: Map.filters[6].active,


        onMapCreated: (controller) => _onMapCreated(controller),
        onTap: (argument) => _searchPointsOfInterest(argument),
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
                  MaterialPageRoute(builder: (context) {
                    return FilterSelection(
                      updateMarkers: () {
                        setState(() {
                          _mapController.setMapStyle(Filter.getJSON(Map.filters));
                        });
                      },
                    );
                  })
                );
              }),
              child: const Icon(Icons.filter_alt),
            ),
          ),

          // Botão de mover a câmera para posição atual
          Positioned(bottom: 0, right: 0,
            child: FloatingActionButton(
              heroTag: "Posição atual",
              onPressed: () async => await _mapController.animateCamera(
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
    _mapController = controller;
    _mapController.setMapStyle(Filter.getJSON(Map.filters));
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(zoom: 18, target: await Geolocator.getCurrentLatLng()),
    ));
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
