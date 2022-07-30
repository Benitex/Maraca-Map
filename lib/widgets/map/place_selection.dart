import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:trabalho_final/providers/places.dart';
import 'package:trabalho_final/screens/point_of_interest_details.dart';

class PlaceSelection extends StatelessWidget {
  const PlaceSelection({super.key, required this.places});

  final List<GeocodingResult> places;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Selecione um ponto de interesse:"),
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

class PointOfInterestOption extends StatelessWidget {
  const PointOfInterestOption({super.key, required this.pointOfInterestID});

  final String pointOfInterestID;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Places.getDetailsByPlaceId(pointOfInterestID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return OutlinedButton(
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}
