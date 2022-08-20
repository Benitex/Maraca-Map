import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/explore/point_of_interest_tile.dart';

class PointsOfInterestResultsRow extends StatelessWidget {
  const PointsOfInterestResultsRow({super.key, required this.typeName, required this.results});

  final String typeName;
  final List<PlacesSearchResult> results;

  @override
  Widget build(BuildContext context) {
    return results.isEmpty ? Container() :
    SizedBox(
      height: 300,
      child: Column(children: [

        Text(typeName, textAlign: TextAlign.start),
        SizedBox(
          height: 280,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (PlacesSearchResult pointOfInterest in results)
                PointOfInterestTile(pointOfInterest: pointOfInterest),
            ],
          ),
        ),

      ]),
    );
  }
}
