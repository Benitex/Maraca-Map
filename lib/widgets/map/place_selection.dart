import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';

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
            _PointOfInterestTile(pointOfInterestID: place.placeId)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar", style: TextStyle(color: Colors.blue)),
        )
      ],
    );
  }
}

class _PointOfInterestTile extends StatelessWidget {
  const _PointOfInterestTile({required this.pointOfInterestID});

  final String pointOfInterestID;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Places.getDetailsByPlaceId(pointOfInterestID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return OutlinedButton(onPressed: () {}, child: const LoadingScreen());
        } else if (snapshot.hasError) {
          return Container();

        } else {
          return Row(children: [
            Flexible(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PointOfInterestDetailsScreen(
                      pointOfInterestID: pointOfInterestID,
                    )),
                  );
                },
                child: Text(
                  snapshot.data!.name,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ]);
        }
      },
    );
  }
}
