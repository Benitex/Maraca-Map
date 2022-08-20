import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/models/point_of_interest.dart';
import 'package:maraca_map/widgets/point_of_interest_details/rating_row.dart';
import 'package:maraca_map/screens/map.dart';

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
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );

        } else {
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

            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
                await Map.moveCamera(
                  LatLng(pointOfInterest.location.lat, pointOfInterest.location.lng),
                );
              },
              child: const Icon(Icons.location_searching),
            ),

            body: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                // Tipos
                ListTile(
                  title: Row(children: [
                    for (int typeCounter = 0; typeCounter < pointOfInterest.types.length ; typeCounter++)
                      typeCounter == pointOfInterest.types.length -1 ? (
                        Text("${pointOfInterest.types[typeCounter]}.")
                      ) : (
                        Text("${pointOfInterest.types[typeCounter]}, ")
                      ),
                  ]),
                ),

                // Horário de funcionamento
                ListTile(
                  title: Text(pointOfInterest.openingHoursToday),
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

                // Imagens
                pointOfInterest.images.isNotEmpty ? (
                  ListTile(
                    title: const Text("Imagens"),
                    subtitle: SizedBox(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: pointOfInterest.images,
                      ),
                    ),
                  )
                ) : Container(),

                // Telefone
                ListTile(
                  title: const Text("Telefone"),
                  subtitle: Row(children: [
                    Text(pointOfInterest.phoneNumber["phone_number"]!),
                    OutlinedButton(
                      onPressed: () async {
                        await launchUrl(Uri(
                          scheme: "tel",
                          path: "tel:${pointOfInterest.phoneNumber['formatted_phone_number']}",
                        ));
                      },
                      child: const Icon(Icons.phone),
                    ),
                  ]),
                ),

                // Página do Google Places
                ListTile(
                  title: const Text("Mais detalhes"),
                  subtitle: pointOfInterest.url == "Página indisponível." ? (
                    Text(pointOfInterest.url)
                  ) : (
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Conheça mais sobre esse lugar em sua página do Google Places:"),
                        TextButton(
                          onPressed: () async {
                            if (!await launchUrl(pointOfInterest.url)) {
                              throw "Could not launch ${pointOfInterest.url}";
                            }
                          },
                          child: Text("${pointOfInterest.url}"),
                        ),
                      ],
                    )
                  ),
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
        }
      },
    );
  }
}
