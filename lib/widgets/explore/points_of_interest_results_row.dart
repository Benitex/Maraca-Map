import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/point_of_interest_tile.dart';

class PointsOfInterestResultsRow extends StatelessWidget {
  const PointsOfInterestResultsRow({super.key, required this.typeName, required this.searchFor, required this.filters});

  final String typeName, searchFor;
  final Map<String, dynamic> filters;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(typeName, textAlign: TextAlign.start),
      SizedBox(
        height: 300,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            FutureBuilder(
              future: _getSearchResults(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen();
                } else if (snapshot.hasError) {
                  return const ErrorScreen();
                } else if (snapshot.data!.isEmpty) {
                  return const NoResults();

                } else {
                  return Row(
                    children: [
                      for (PlacesSearchResult result in snapshot.data!)
                        PointOfInterestTile(pointOfInterest: result),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    ]);
  }

  Future<List<PlacesSearchResult>> _getSearchResults() async {
    return await Places.nearbySearch(
      type: searchFor,
      maxprice: filters["maxPrice"],
      radius: filters["distance"],
    );
  }
}
