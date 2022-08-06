import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trabalho_final/models/point_of_interest.dart';
import 'package:trabalho_final/widgets/point_of_interest_details/rating_row.dart';

class PointOfInterestDetails extends StatelessWidget {
  PointOfInterestDetails({super.key, required String pointOfInterestID}) {
    pointOfInterest = PointOfInterest(pointOfInterestID);
  }

  static late PointOfInterest pointOfInterest;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pointOfInterest.setPlaceDetails(),

      builder: (context, snapshot) {
        if (snapshot.hasData) { // carregado
          return Scaffold(
            appBar: AppBar(
              title: Text(pointOfInterest.name),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: pointOfInterest.icon,
                ),
              ],
            ),
            body: ListView(
              children: <Widget>[
                // Tipos
                ListTile(
                  title: Row(
                    children: [
                      for (int typeCounter = 0; typeCounter < pointOfInterest.types.length ; typeCounter++)
                        typeCounter == pointOfInterest.types.length -1 ? (
                          Text("${pointOfInterest.types[typeCounter]}.")
                        ) : (
                          Text("${pointOfInterest.types[typeCounter]}, ")
                        ),
                    ],
                  ),
                ),

                // Endereço
                ListTile(
                  title: const Text("Endereço"),
                  subtitle: Text(pointOfInterest.address),
                ),

                // Preço
                ListTile(
                  title: const Text("Preço"),
                  subtitle: Text(pointOfInterest.priceLevel),
                ),
                // Classificação
                pointOfInterest.rating == -1 ? (
                  const ListTile(
                    title: Text("Esse lugar não possui classificação."),
                  )
                ) : (
                  ListTile(
                    title: const Text("Classificação"),
                    subtitle: RatingRow(rating: pointOfInterest.rating),
                  )
                ),

                // Avaliações
                Column(
                  children: [
                    for (Review review in pointOfInterest.reviews)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(children: [
                          ListTile(
                            title: Row(children: [
                              Image.network(review.profilePhotoUrl, width: 40),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(review.authorName),
                              ),
                            ]),
                            subtitle: RatingRow(rating: review.rating),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Text(review.text),
                            ),
                          ),
                        ]),
                      ),
                  ],
                ),
              ],
            ),
          );

        } else { // carregando
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.replay_outlined),
                  Text("Carregando..."),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
