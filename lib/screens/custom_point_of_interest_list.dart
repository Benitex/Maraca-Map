import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/providers/point_of_interest_lists_provider.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/services/local_storage.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/widgets/point_of_interest_tile.dart';

class CustomPointOfInterestList extends ConsumerWidget {
  const CustomPointOfInterestList({super.key, required this.listName});

  final String listName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(pointOfInterestListProvider)[listName];
    final listsController = ref.read(pointOfInterestListProvider.notifier);
    final localStorage = ref.read(localStorageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: Future<List<PlaceDetails>>(() async {
          List<PlaceDetails> placeDetails = [];
          for (String id in list!) {
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
                    Dismissible(
                      key: Key(details.placeId),
                      onDismissed: (direction) async {
                        listsController.removePointOfInterestFrom(
                          listName: listName,
                          removedId: details.placeId,
                        );
                        await localStorage.savePointOfInterestIdsList(
                          listName,
                          [
                            for (String id in list!)
                              if (id != details.placeId) id,
                          ],
                        );
                      },
                      background: Container(color: Colors.red),
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child: PointOfInterestTile.fromPlaceDetails(placeDetails: details),
                      ),
                    ),
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
