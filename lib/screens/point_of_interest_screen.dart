import 'package:flutter/material.dart';
import 'package:trabalho_final/classes/point_of_interest.dart';

class PointOfInterestScreen extends StatefulWidget {
  PointOfInterestScreen({super.key, required String pointOfInterestID}) {
    pointOfInterest = PointOfInterest(pointOfInterestID);
  }
  PointOfInterestScreen.fromPointOfInterest({super.key, required PointOfInterest selectedPointOfInterest}) {
    pointOfInterest = selectedPointOfInterest;
  }

  static late PointOfInterest pointOfInterest;

  @override
  State<PointOfInterestScreen> createState() => _PointOfInterestScreenState();
}

class _PointOfInterestScreenState extends State<PointOfInterestScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PointOfInterestScreen.pointOfInterest.getDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) { // carregado
          return Scaffold(
            appBar: AppBar(
              title: Text(PointOfInterestScreen.pointOfInterest.name),
              actions: [PointOfInterestScreen.pointOfInterest.icon],
            ),

            body: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text("Endereço"),
                  subtitle: Text(PointOfInterestScreen.pointOfInterest.address),
                  isThreeLine: true,
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
