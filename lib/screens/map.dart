import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/services/google_maps_webservice/geocoding.dart';
import 'package:maraca_map/services/geolocator.dart';
import 'package:maraca_map/services/map_style.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/screens/search.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/widgets/map/circular_menu.dart';
import 'package:maraca_map/widgets/map/place_selection.dart';
import 'package:maraca_map/widgets/search_field.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.updateTheme});

  final Function updateTheme;
  static late GoogleMapController controller;

  static Set<Polyline> polylines = {};
  static late Set<Marker> accessibilityPoints;

  static Future<void> moveCamera({required LatLng location, double zoom = 18}) async {
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: zoom, target: location),
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
    MapScreen.controller.setMapStyle(MapStyle.toJSON());
    MapScreen.moveCamera(location: await Geolocator.getCurrentLatLng());
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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return SearchScreen(searchField: _searchField);
                }),
              );
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
        trafficEnabled: FilterSelectionScreen.traffic.active,

        // Ícones de acessibilidade
        markers: FilterSelectionScreen.accessibility.active ? MapScreen.accessibilityPoints : {},

        // Configurações
        mapType: SettingsScreen.satelliteMap.active ? MapType.hybrid : MapType.normal,
        zoomControlsEnabled: false,
        buildingsEnabled: false,
        compassEnabled: false,
        myLocationButtonEnabled: false,

        // Rotas
        polylines: MapScreen.polylines,

        onMapCreated: (controller) => _onMapCreated(controller),
        onTap: (argument) async => _searchPointsOfInterest(
          await Geocoding.searchByLocation(argument),
        ),
      ),

      // Botões
      floatingActionButton: Stack(
        children: [
          CircularMenu(
            updateMap: () {
              setState(() {
                MapScreen.controller.setMapStyle(MapStyle.toJSON());
                widget.updateTheme();
              });
            },
          ),

          Positioned(
            bottom: 0, right: 0,
            child: FloatingActionButton.small(
              tooltip: "Mover para posição atual",
              heroTag: "Posição atual",
              onPressed: () async => await MapScreen.moveCamera(location: await Geolocator.getCurrentLatLng()),
              child: const Icon(Icons.location_searching),
            ),
          ),

          MapScreen.polylines.isEmpty ? Container() : Positioned(
            bottom: 60, right: 0,
            child: FloatingActionButton.small(
              tooltip: "Remover rota",
              heroTag: "Remover rota",
              onPressed: () => setState(() => MapScreen.polylines.clear()),
              child: const Icon(Icons.cancel_outlined),
            ),
          ),
        ],
      ),
    );
  }

  void _searchPointsOfInterest(List<GeocodingResult> results) {
    if (results.isNotEmpty) {
      List<GeocodingResult> possiblePlaces = [];
      List<Filter> filters = [
        FilterSelectionScreen.accessibility,
        FilterSelectionScreen.attractions,
        FilterSelectionScreen.business,
        FilterSelectionScreen.medical,
        FilterSelectionScreen.placesOfWorship,
        FilterSelectionScreen.publicTransportStations,
        FilterSelectionScreen.schools,
        FilterSelectionScreen.traffic,
      ];

      for (GeocodingResult result in results) {
        if (result.types.contains("point_of_interest")) {
          // Verificação se um filtro ativo contém um dos subtipos
          for (Filter filter in filters) {
            if (filter.active) {
              for (var subtype in filter.subtypes) {
                if (result.types.contains(subtype.id) && !possiblePlaces.contains(result)) {
                  possiblePlaces.add(result);
                  break;
                }
              }
            }
          }
        }
      }

      if (possiblePlaces.length == 1) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return PointOfInterestDetailsScreen(
              pointOfInterestID: possiblePlaces.first.placeId,
            );
          }),
        );
      } else if (possiblePlaces.length > 1) {
        showDialog(
          context: context,
          builder: (context) => PlaceSelection(places: possiblePlaces),
        );
      }
    }
  }
}
