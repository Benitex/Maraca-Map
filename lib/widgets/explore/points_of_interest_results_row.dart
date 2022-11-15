import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/providers/explore_filters_provider.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/point_of_interest_tile.dart';

class PointsOfInterestResultsRow extends ConsumerWidget {
  const PointsOfInterestResultsRow({
    super.key,
    required this.location,
    required this.typeName,
    required this.searchFor,
  });

  final Location location;
  final String typeName, searchFor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(exploreFiltersProvider);
    return Column(children: [
      ListTile(title: Text(typeName)),
      SizedBox(
        height: 280,
        child: FutureBuilder(
          future: Future<List<PlacesSearchResult>>(() async {
            return await Places.nearbySearch(
              location: location,
              type: searchFor,
              maxprice: filters["maxPrice"],
              radius: filters["distance"],
            );
          }),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return ErrorScreen(error: snapshot.error!);
            } else if (snapshot.data!.isEmpty) {
              return const NoResults();

            } else {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (PlacesSearchResult result in snapshot.data!)
                    PointOfInterestTile(pointOfInterest: result, origin: location),
                ],
              );
            }
          },
        ),
      ),
    ]);
  }
}
