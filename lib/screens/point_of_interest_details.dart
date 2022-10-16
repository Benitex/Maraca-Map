import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maraca_map/models/point_of_interest.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:maraca_map/services/google_maps_webservice/directions.dart';
import 'package:maraca_map/widgets/images_list_view.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/types_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/opening_hours_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/address_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/phone_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/rating_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/price_level_tile.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/list_tiles/places_page_tile.dart';

class PointOfInterestDetailsScreen extends StatelessWidget {
  PointOfInterestDetailsScreen({super.key, required String pointOfInterestID}) {
    pointOfInterest = PointOfInterest(pointOfInterestID);
  }

  late final PointOfInterest pointOfInterest;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pointOfInterest.setPlaceDetails(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const LoadingScreen(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: const ErrorScreen(),
          );

        } else {
          return Scaffold(
            appBar: AppBar(title: Text(pointOfInterest.name)),

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
                  distance: pointOfInterest.distance,
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

            floatingActionButton: FloatingActionButton(
              tooltip: "Mostrar rotas no mapa",
              onPressed: () async {
                var route = await Directions.getRouteToDestination(
                  destination: pointOfInterest.location,
                );
                MapScreen.polylines = {
                  Polyline(
                    polylineId: const PolylineId("polyline"),
                    color: Colors.red,
                    points: Directions.decodePolyline(
                      route.overviewPolyline.points,
                    ),
                  ),
                };

                if (!context.mounted) return;
                Navigator.popUntil(context, (route) => route.isFirst);
                // TODO updateMap
                for (var warning in route.warnings) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(warning)),
                  );
                }
              },
              child: const Icon(Icons.route),
            ),
          );
        }
      },
    );
  }
}
