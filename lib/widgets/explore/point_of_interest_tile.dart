import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/cloud_functions/places.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';
import 'package:maraca_map/widgets/point_of_interest_details/rating_row.dart';

class PointOfInterestTile extends StatelessWidget {
  const PointOfInterestTile({super.key, required this.pointOfInterest});

  final PlacesSearchResult pointOfInterest;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PointOfInterestDetails(
          pointOfInterestID: pointOfInterest.placeId,
        )),
      ),

      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 280, width: 300,
          decoration: BoxDecoration(border: Border.all()),
          child: Column(children: [
            // Foto
            SizedBox(
              height: 180, width: 300,
              child: pointOfInterest.photos.isEmpty ? (
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [Text("Nenhuma imagem disponível")],
                )
              ) : (
                Places.getImageFromPhoto(pointOfInterest.photos.first)
                // TODO procurar lista de imagem que muda quando arrasta pro lado
              ),
            ),

            // Nome
            Text(pointOfInterest.name),

            // Média das avaliações
            pointOfInterest.rating is num ?
              RatingRow(rating: pointOfInterest.rating!) : Container(),

            // Aberto ou fechado
            pointOfInterest.openingHours is OpeningHoursDetail ?
              Text(
                pointOfInterest.openingHours!.openNow ? "Aberto" : "Fechado",
                style: TextStyle(color: pointOfInterest.openingHours!.openNow ? Colors.green : Colors.red),
              ) : Container(),

            // TODO distância até o usuário
          ]),
        ),
      ),
    );
  }
}
