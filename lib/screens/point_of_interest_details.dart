import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trabalho_final/models/point_of_interest.dart';

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
                //Endereço
                ListTile(
                  title: const Text("Endereço"),
                  subtitle: Text(pointOfInterest.address),
                ),

                // Classificação
                pointOfInterest.rating == -1 ? (
                  const ListTile(
                    title: Text("Esse lugar não possui classificação."),
                  )
                ) : (
                  ListTile(
                    title: const Text("Classificação"),
                    subtitle: Row(
                      children: [
                        Text(pointOfInterest.rating.toString()),
                        for (int starCounter = 1; starCounter <= 5; starCounter++)
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: Icon(
                              pointOfInterest.rating >= starCounter ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                          ),
                      ],
                    ),
                  )
                ),

                // Preço
                ListTile(
                  title: const Text("Preço"),
                  subtitle: Text(pointOfInterest.priceLevel),
                ),
              ],
            ),
          );
        } else { // carregando
          return Scaffold(appBar: AppBar());
        }
      },
    );
  }
}
