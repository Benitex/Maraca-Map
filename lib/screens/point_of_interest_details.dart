import 'package:flutter/material.dart';
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
              actions: [pointOfInterest.icon],
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text("Endereço"),
                  subtitle: Text(pointOfInterest.address),
                ),

                // TODO adicionar os outros campos
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
