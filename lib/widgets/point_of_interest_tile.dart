import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/services/google_maps_webservice/distance.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/widgets/rating_row.dart';

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
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 300, width: 320,
          decoration: BoxDecoration(border: Border.all()),
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
                Places.getImageFromPhoto(pointOfInterest.photos.first)
                // TODO adicionar mais imagens se sobrar espaço na row
              ),
            ),

            // Nome
            Text(pointOfInterest.name, maxLines: 1),

            // Média das avaliações
            pointOfInterest.rating is num ?
              RatingRow(rating: pointOfInterest.rating!) : Container(),

            // Preço
            _priceRow(),

            // Aberto ou fechado
            pointOfInterest.openingHours is OpeningHoursDetail ?
              Text(
                pointOfInterest.openingHours!.openNow ? "Aberto" : "Fechado",
                style: TextStyle(color: pointOfInterest.openingHours!.openNow ? Colors.green : Colors.red),
              ) : Container(),

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
                  return Text(snapshot.data!.distance.text);
                }
              },
            ),
          ]),
        ),
      ),
    );
  }

  Widget _priceRow() {
    if (pointOfInterest.priceLevel is! PriceLevel) {
      return Container();
    } else {
      int priceLevel = 0;

      switch (pointOfInterest.priceLevel) {
        case PriceLevel.inexpensive:
          priceLevel = 1;
          break;
        case PriceLevel.moderate:
          priceLevel = 2;
          break;
        case PriceLevel.expensive:
          priceLevel = 3;
          break;
        case PriceLevel.veryExpensive:
          priceLevel = 4;
          break;
        default:
      }

      return Row(
        children: [
          for (int signCounter = 1; signCounter <= 5; signCounter++)
            Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Icon(
                Icons.attach_money,
                color: priceLevel >= signCounter ? Colors.amber : Colors.grey,
              ),
            ),
        ],
      );
    }
  }
}
