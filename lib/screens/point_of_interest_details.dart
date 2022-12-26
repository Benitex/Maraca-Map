import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/models/point_of_interest.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/images_list_view.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/add_point_of_interest_to_list_dialog.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/types_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/opening_hours_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/address_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/phone_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/rating_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/price_level_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/places_page_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/route_floating_action_button.dart';

class PointOfInterestDetailsScreen extends ConsumerWidget {
  const PointOfInterestDetailsScreen({super.key, required this.pointOfInterestID});

  final String pointOfInterestID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Future<PointOfInterest>(() async {
        return PointOfInterest.fromPlaceDetails(
          placeDetails: await Places.getDetailsByPlaceId(pointOfInterestID),
          ref: ref,
        );
      }),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const LoadingScreen(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: ErrorScreen(error: snapshot.error!),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: const NoResults(),
          );
 
        } else {
          final PointOfInterest pointOfInterest = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(pointOfInterest.name),
              actions: [IconButton(
                tooltip: "Adicionar a uma lista",
                icon: const Icon(Icons.star),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AddPointOfInterestToListDialog(pointOfInterestId: pointOfInterestID),
                ),
              )],
            ),

            body: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                // Tipos
                pointOfInterest.types.isNotEmpty ? (
                  TypesTile(
                    types: pointOfInterest.types,
                    icon: pointOfInterest.icon,
                  )
                ) : Container(),

                OpeningHoursTile(openingHours: pointOfInterest.openingHoursToday),

                AddressTile(
                  location: pointOfInterest.location,
                  address: pointOfInterest.address,
                ),

                // Imagens
                pointOfInterest.images.isNotEmpty ? (
                  ListTile(
                    title: const Text("Fotos"),
                    subtitle: Container(
                      height: 160,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ImagesListView(images: pointOfInterest.images),
                    ),
                  )
                ) : Container(),

                PhoneTile(phoneNumber: pointOfInterest.phoneNumber),

                pointOfInterest.priceLevel == null ? (
                  const ListTile(
                    title: Text("Informações de preço indisponíveis."),
                  )
                ) : PriceLevelTile(priceLevel: pointOfInterest.priceLevel!),

                pointOfInterest.rating == null ? (
                  const ListTile(title: Text("Esse lugar não possui classificação."))
                ) : (
                  RatingTile(
                    rating: pointOfInterest.rating!,
                    reviews: pointOfInterest.reviews,
                  )
                ),

                PlacesPageTile(url: pointOfInterest.url),
              ],
            ),

            floatingActionButton: pointOfInterest.location == null ?
                Container() : RouteFloatingActionButton(location: pointOfInterest.location!),
          );
        }
      },
    );
  }
}
