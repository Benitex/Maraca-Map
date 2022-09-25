import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/services/google_maps_webservice/geocoding.dart';
import 'package:maraca_map/services/geolocator.dart';
import 'package:maraca_map/services/map_style.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/screens/search.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/widgets/map/floating_action_buttons.dart';
import 'package:maraca_map/widgets/map/place_selection.dart';
import 'package:maraca_map/widgets/search_field.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.updateTheme});

  final Function updateTheme;
  static late GoogleMapController controller;

  static late Map<String, Filter> filters;
  static late Set<Marker> accessibilityPoints;

  static Future<void> moveCamera(LatLng location) async {
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 18, target: location),
      ),
    );
  }

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final SearchField _searchField = SearchField();

  void _onMapCreated(GoogleMapController controller) async {
    MapScreen.controller = controller;
    MapScreen.controller.setMapStyle(MapStyle.toJSON(MapScreen.filters));
    MapScreen.moveCamera(await Geolocator.getCurrentLatLng());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de pesquisa
      appBar: AppBar(
        title: _searchField,
        actions: [IconButton(
          tooltip: "Buscar",
          icon: const Icon(Icons.search),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (_searchField.controller.text != '') {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SearchScreen(searchField: _searchField);
                  }),
                );
              });
            }
          }
        )],
      ),

      // Mapa
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(-22.912392877001498, -43.224780036813414),
        ),
        myLocationEnabled: true,

        // Filtro de trânsito
        trafficEnabled: MapScreen.filters["traffic"]!.active,

        // Ícones de acessibilidade
        markers: MapScreen.filters["accessibility"]!.active ? MapScreen.accessibilityPoints : {},

        // Configurações
        mapType: SettingsScreen.options["Mapa de satélite"]!.active ? MapType.hybrid : MapType.normal,
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
                MapScreen.controller.setMapStyle(MapStyle.toJSON(MapScreen.filters));
                widget.updateTheme();
              });
            },
          ),

          // Botão de mover a câmera para posição atual
          Positioned(
            bottom: 0, right: 0,
            child: FloatingActionButton.small(
              tooltip: "Mover para posição atual",
              heroTag: "Posição atual",
              onPressed: () async => await MapScreen.moveCamera(await Geolocator.getCurrentLatLng()),
              child: const Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }

  void _searchPointsOfInterest(LatLng position) async {
    List<GeocodingResult> allPlaces = await Geocoding.searchByLocation(position);

    if (allPlaces.isNotEmpty) {
      List<GeocodingResult> possiblePlaces = [];

      for (GeocodingResult result in allPlaces) {
        if (result.types.contains("point_of_interest")) {
          // Verificação se um filtro ativo contém um dos subtipos
          MapScreen.filters.forEach((key, filter) {
            if (filter.active) {
              for (var subtype in filter.subtypes) {
                if (result.types.contains(subtype.id) && !possiblePlaces.contains(result)) {
                  possiblePlaces.add(result);
                  break;
                }
              }
            }
          });
        }
      }

      if (possiblePlaces.length == 1) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return PointOfInterestDetailsScreen(
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
