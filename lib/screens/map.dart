import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/models/map_filter.dart';
import 'package:maraca_map/providers/filters_provider.dart';
import 'package:maraca_map/providers/map_polylines_provider.dart';
import 'package:maraca_map/providers/settings_provider.dart';
import 'package:maraca_map/services/google_maps_webservice/geocoding.dart';
import 'package:maraca_map/services/geolocator.dart';
import 'package:maraca_map/services/map_style.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/screens/search.dart';
import 'package:maraca_map/widgets/map/circular_menu.dart';
import 'package:maraca_map/widgets/map/place_selection.dart';
import 'package:maraca_map/widgets/search_field.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  static final SearchField _searchField = SearchField();
  static late GoogleMapController controller;
  static late Set<Marker> accessibilityPoints;

  static Future<void> moveCamera({required LatLng location, double zoom = 18}) async {
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: zoom, target: location),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final filters = ref.watch(mapFiltersProvider);
    final polylinesController = ref.watch(mapPolylinesProvider.notifier);

    void onMapCreated(GoogleMapController controller) async {
      MapScreen.controller = controller;
      controller.setMapStyle(ref.read(mapStyleConversorProvider).toJSON());
      moveCamera(location: await Geolocator.getCurrentLatLng());
    }

    void searchPointsOfInterest(List<GeocodingResult> results) {
      if (results.isNotEmpty) {
        List<GeocodingResult> possiblePlaces = [];

        for (GeocodingResult result in results) {
          if (result.types.contains("point_of_interest")) {
            // Verificação se um filtro ativo contém um dos subtipos
            for (MapFilter filter in ref.read(mapFiltersProvider).values) {
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
        trafficEnabled: filters["traffic"]!.active,

        // Ícones de acessibilidade
        markers: filters["accessibility"]!.active ? accessibilityPoints : {},

        // Configurações
        mapType: settings["satelliteMap"]!.active ? MapType.hybrid : MapType.normal,
        zoomControlsEnabled: false,
        buildingsEnabled: false,
        compassEnabled: false,
        myLocationButtonEnabled: false,

        // Rotas
        polylines: ref.watch(mapPolylinesProvider),

        onMapCreated: (controller) => onMapCreated(controller),
        onTap: (location) async => searchPointsOfInterest(
          await Geocoding.searchByLocation(location),
        ),
      ),

      // Botões
      floatingActionButton: Stack(
        children: [
          const CircularMenu(),

          Positioned(
            bottom: 0, right: 0,
            child: FloatingActionButton.small(
              tooltip: "Mover para posição atual",
              heroTag: "Posição atual",
              onPressed: () async => await moveCamera(location: await Geolocator.getCurrentLatLng()),
              child: const Icon(Icons.location_searching),
            ),
          ),

          polylinesController.isEmpty() ? Container() : Positioned(
            bottom: 60, right: 0,
            child: FloatingActionButton.small(
              tooltip: "Remover rota",
              heroTag: "Remover rota",
              onPressed: () => polylinesController.clear(),
              child: const Icon(Icons.cancel_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
