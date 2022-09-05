import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/services/google_maps_webservice/distance.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/price_row.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/rating_row.dart';

class PointOfInterestTile extends StatelessWidget {
  const PointOfInterestTile({super.key, required this.pointOfInterest});

  final PlacesSearchResult pointOfInterest;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PointOfInterestDetailsScreen(
          pointOfInterestID: pointOfInterest.placeId,
        )),
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Card(
          child: SizedBox(
            height: 280, width: 320,
            child: Column(children: [
              // Foto
              SizedBox(
                height: 180,
                child: pointOfInterest.photos.isEmpty ? (
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [Text("Nenhuma imagem disponível")],
                  )
                ) : (
                  Image(
                    image: Places.getImageFromPhoto(pointOfInterest.photos.first).image,
                    width: 320, fit: BoxFit.fitWidth,
                  )
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(children: [
                  // Nome
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      pointOfInterest.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 6),
                    child: Row(children: [
                      pointOfInterest.rating is num ?
                        RatingRow(rating: pointOfInterest.rating!) : Container(),
                      const Spacer(),
                      pointOfInterest.priceLevel is! PriceLevel ? (
                        Container()
                      ) : (
                        PriceRow(price: pointOfInterest.priceLevel!)
                      ),
                    ]),
                  ),

                  Row(children: [
                    // Aberto ou fechado
                    pointOfInterest.openingHours is OpeningHoursDetail ?
                      Text(
                        pointOfInterest.openingHours!.openNow ? "Aberto" : "Fechado",
                        style: TextStyle(
                          fontSize: 16,
                          color: pointOfInterest.openingHours!.openNow ? Colors.green : Colors.red,
                        ),
                      ) : Container(),

                    const Spacer(),
                    // Distância até o usuário
                    FutureBuilder(
                      future: Distance.fromHereTo(pointOfInterest.geometry!.location),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container();
                        } else if (snapshot.hasError) {
                          return const Text("Não foi possível calcular a distância até você.");
                        } else if (!snapshot.hasData) {
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
