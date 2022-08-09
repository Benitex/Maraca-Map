import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/cloud_functions/places.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';

// AlertDialog de seleção de PointOfInterest quando há mais de um na mesma coordenada

class PlaceSelection extends StatelessWidget {
  const PlaceSelection({super.key, required this.places});

  final List<GeocodingResult> places;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Escolha um lugar:"),
      content: Column(
        children: [
          for (GeocodingResult place in places)
            PointOfInterestOption(pointOfInterestID: place.placeId)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        )
      ],
    );
  }
}

// Modelo de tiles de PointOfInterest

class PointOfInterestOption extends StatelessWidget {
  const PointOfInterestOption({super.key, required this.pointOfInterestID});

  final String pointOfInterestID;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Places.getDetailsByPlaceId(pointOfInterestID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(children: [Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointOfInterestDetails(
                    pointOfInterestID: pointOfInterestID,
                  )),
                );
              },
              child: Text(snapshot.data!.name),
            ),
          )],);
        } else {
          return Container();
        }
      },
    );
  }
}
