import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/services/google_maps_webservice/distance.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/price_row.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/rating_row.dart';

class PointOfInterestTile extends StatelessWidget {
  const PointOfInterestTile({
    super.key,
    required this.placeId,
    required this.name,
    required this.location,
    this.photos = const [],
    this.rating,
    this.priceLevel,
    this.openingHours,
    this.origin,
  });

  PointOfInterestTile.fromPlaceSearchResult({
    super.key,
    required PlacesSearchResult result,
    this.origin,
  }) : placeId = result.placeId,
      name = result.name,
      photos = result.photos,
      rating = result.rating,
      priceLevel = result.priceLevel,
      openingHours = result.openingHours,
      location = result.geometry!.location;

  PointOfInterestTile.fromPlaceDetails({
    super.key,
    required PlaceDetails placeDetails,
    this.origin,
  }) : placeId = placeDetails.placeId,
      name = placeDetails.name,
      photos = placeDetails.photos,
      rating = placeDetails.rating,
      priceLevel = placeDetails.priceLevel,
      openingHours = placeDetails.openingHours,
      location = placeDetails.geometry!.location;

  final String placeId, name;
  final List<Photo> photos;
  final num? rating;
  final PriceLevel? priceLevel;
  final OpeningHoursDetail? openingHours;
  final Location location;
  final Location? origin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return PointOfInterestDetailsScreen(
            pointOfInterestID: placeId,
          );
        }),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Card(
          child: SizedBox(
            height: 280, width: 320,
            child: Column(children: [
              // Foto
              SizedBox(
                height: 180,
                child: photos.isEmpty ? (
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [Text("Nenhuma imagem disponível")],
                  )
                ) : (
                  Image(
                    image: Places.getImageFromPhoto(photos.first).image,
                    width: 320, fit: BoxFit.fitWidth,
                  )
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(children: [
                  // Nome
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 6),
                    child: Row(children: [
                      rating is num ? RatingRow(rating: rating!) : Container(),
                      const Spacer(),
                      priceLevel is PriceLevel ? PriceRow(price: priceLevel!) : Container(),
                    ]),
                  ),

                  Row(children: [
                    // Aberto ou fechado
                    openingHours is OpeningHoursDetail ?
                      Text(
                        openingHours!.openNow ? "Aberto" : "Fechado",
                        style: TextStyle(
                          fontSize: 16,
                          color: openingHours!.openNow ? Colors.green : Colors.red,
                        ),
                      ) : Container(),

                    const Spacer(),
                    FutureBuilder(
                      future: origin == null ? (
                        Distance.fromHereTo(location)
                      ) : (
                        Distance.between(origin: origin!, destination: location)
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError || !snapshot.hasData) {
                          return Container();
                        } else {
                          return Text(snapshot.data!.distance.text, style: const TextStyle(fontSize: 18));
                        }
                      },
                    ),
                  ]),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
