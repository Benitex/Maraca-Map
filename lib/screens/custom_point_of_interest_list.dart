import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/point_of_interest_tile.dart';

class CustomPointOfInterestList extends StatelessWidget {
  const CustomPointOfInterestList({
    super.key,
    required this.listName,
    required this.idsList,
  });

  final String listName;
  final List<String> idsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: Future<List<PlaceDetails>>(() async {
          List<PlaceDetails> placeDetails = [];
          for (var id in idsList) {
            placeDetails.add(await Places.getDetailsByPlaceId(id));
          }
          return placeDetails;
        }),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return ErrorScreen(error: snapshot.error!);

          } else if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView(
                children: [
                  for (PlaceDetails details in snapshot.data!)
                    PointOfInterestTile.fromPlaceDetails(placeDetails: details),
                ],
              );
            }
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Nenhum lugar foi adicionado à lista \"$listName\".")),
            ],
          );
        },
      ),
    );
  }
}
