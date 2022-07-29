import 'package:flutter/material.dart';
import 'package:trabalho_final/apis.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:trabalho_final/classes/filter.dart';
import 'package:trabalho_final/screens/filter_screen.dart';
import 'package:trabalho_final/classes/point_of_interest.dart';
import 'package:trabalho_final/screens/point_of_interest_screen.dart';

class PossiblePlaceItem extends StatelessWidget {
  const PossiblePlaceItem({super.key, required this.pointOfInterest});

  final PointOfInterest pointOfInterest;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pointOfInterest.getDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PointOfInterestScreen.fromPointOfInterest(
                    selectedPointOfInterest: pointOfInterest,
                  );
                }),
              );
            },
            child: Text(pointOfInterest.name),
          );
        } else {
          return OutlinedButton(onPressed: () {}, child: Container());
        }
      },
    );
  }
}

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

        // TODO adicionar opções nas configurações
        buildingsEnabled: false,
        zoomControlsEnabled: false,

        onMapCreated: (controller) {
          MapScreen._mapController = controller;
          MapScreen.updateMarkers();
        },
        onTap: (position) async {
          GeocodingResponse response = await API.geoCoding.searchByLocation(
            Location(lat: position.latitude, lng: position.longitude),
          );

          if (response.results.isNotEmpty) {
            List<GeocodingResult> possiblePlaces = [];

            for (var result in response.results) {
              if (result.types.contains("point_of_interest")) { // TODO definir os tipos
                possiblePlaces.add(result);
              }
            }

            if (possiblePlaces.length == 1) {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PointOfInterestScreen(
                      pointOfInterestID: possiblePlaces.first.placeId,
                    );
                  }),
                );
              });
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Selecione um ponto de interesse:"),
                  content: Column(
                    children: [
                      for (GeocodingResult place in possiblePlaces)
                        PossiblePlaceItem(
                          pointOfInterest: PointOfInterest(place.placeId),
                        ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () =>  Navigator.pop(context, 'Cancelar'),
                      child: const Text("Cancelar"),
                    ),
                  ],
                ),
              );
            }
          }
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
