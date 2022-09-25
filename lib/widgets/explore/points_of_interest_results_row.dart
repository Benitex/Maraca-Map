import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/screens/explore.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/point_of_interest_tile.dart';

class PointsOfInterestResultsRow extends StatelessWidget {
  const PointsOfInterestResultsRow({super.key, required this.location, required this.typeName, required this.searchFor});

  final Location location;
  final String typeName, searchFor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(title: Text(typeName, textAlign: TextAlign.start)),
      SizedBox(
        height: 280,
        child: FutureBuilder(
          future: _getSearchResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return const ErrorScreen();
            } else if (snapshot.data!.isEmpty) {
              return const NoResults();

            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return PointOfInterestTile(
                    pointOfInterest: snapshot.data![index],
                    origin: location,
                  );
                },
              );
            }
          },
        ),
      ),
    ]);
  }

  Future<List<PlacesSearchResult>> _getSearchResults() async {
    return await Places.nearbySearch(
      location: location,
      type: searchFor,
      maxprice: ExploreScreen.filters["maxPrice"],
      radius: ExploreScreen.filters["distance"],
    );
  }
}
