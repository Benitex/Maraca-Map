import 'package:flutter/material.dart';
import 'package:maraca_map/screens/image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:maraca_map/models/point_of_interest.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/price_row.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/review.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/rating_row.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/screens/map.dart';

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

            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
                await MapScreen.moveCamera(
                  LatLng(pointOfInterest.location.lat, pointOfInterest.location.lng),
                );
              },
              child: const Icon(Icons.location_searching),
            ),

            body: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                // Tipos
                pointOfInterest.types.isNotEmpty ? (
                  ListTile(
                    title: Row(children: [
                      for (int typeCounter = 0; typeCounter < pointOfInterest.types.length ; typeCounter++)
                        typeCounter == pointOfInterest.types.length -1 ? (
                          Text("${pointOfInterest.types[typeCounter]}.")
                        ) : (
                          Text("${pointOfInterest.types[typeCounter]}, ")
                        ),
                      const Spacer(),
                      pointOfInterest.icon,
                    ]),
                  )
                ) : (
                  Container()
                ),

                // Horário de funcionamento
                ListTile(
                  title: Text(pointOfInterest.openingHoursToday),
                ),

                // Endereço
                Column(children: [
                  ListTile(
                    title: const Text("Endereço"),
                    subtitle: Text(pointOfInterest.address),
                  ),
                  ListTile(
                    subtitle: Text(pointOfInterest.distance),
                  ),
                ]),

                // Imagens
                pointOfInterest.images.isNotEmpty ? (
                  ListTile(
                    title: const Text("Fotos"),
                    subtitle: Container(
                      height: 160,
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (Image image in pointOfInterest.images)
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ImageScreen(image: image);
                                }),
                              ),
                              child: image,
                            )
                        ],
                      ),
                    ),
                  )
                ) : Container(),

                // Telefone
                ListTile(
                  title: const Text("Telefone"),
                  subtitle: Row(children: [
                    Text(pointOfInterest.phoneNumber["phone_number"]!),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () async {
                        await launchUrl(Uri(
                          scheme: "tel",
                          path: "${pointOfInterest.phoneNumber['formatted_phone_number']}",
                        ));
                      },
                      child: const Icon(Icons.phone),
                    ),
                  ]),
                ),

                // Preço
                pointOfInterest.priceLevel is! places.PriceLevel ? (
                  const ListTile(
                    title: Text("Informações de preço indisponíveis."),
                  )
                ) : (
                  ListTile(
                    title: Row(children: [
                      const Text("Preço"),
                      const Spacer(),
                      PriceRow(price: pointOfInterest.priceLevel!),
                      Text("(${
                        pointOfInterest.priceLevel == places.PriceLevel.free ? "Grátis"
                        : pointOfInterest.priceLevel == places.PriceLevel.inexpensive ? "Barato"
                        : pointOfInterest.priceLevel == places.PriceLevel.moderate ? "Moderado"
                        : pointOfInterest.priceLevel == places.PriceLevel.expensive ? "Caro"
                        : "Muito caro"
                        })",
                      ),
                    ]),
                  )
                ),

                // Classificação
                pointOfInterest.rating == -1 ? (
                  const ListTile(
                    title: Text("Esse lugar não possui classificação."),
                  )
                ) : (
                  Column(children: [
                    ListTile(
                      title: Row(children: [
                        const Text("Classificação"),
                        const Spacer(),
                        RatingRow(rating: pointOfInterest.rating),
                      ]),
                    ),

                    const Divider(height: 10),
                    for (var review in pointOfInterest.reviews)
                      Review(review: review),
                  ])
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
                          child: Text(
                            pointOfInterest.url.toString(),
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
