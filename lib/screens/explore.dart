import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/cloud_functions/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/widgets/explore/distance_form_field.dart';
import 'package:maraca_map/widgets/explore/points_of_interest_results_row.dart';
import 'package:maraca_map/widgets/explore/price_dropdown_menu.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  static Map<String, dynamic> filters = {
    "distance": 1000,
    "maxPrice": PriceLevel.veryExpensive,
  };

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late List<PointsOfInterestResultsRow> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorar"),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(children: [
            const Text("Distância: "),
            const DistanceFormField(),

            const Text("Preço: "),
            const PriceDropdownMenu(),

            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() {
                Explore.filters["filters"] = int.parse(DistanceFormField.controller.text);
              }),
            ),
          ]),

          // Pontos de interesse próximos
          FutureBuilder(
            future: _getSearchResults(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else if (snapshot.hasError) {
                return const ErrorScreen();
              } else if (results.isEmpty) {
                return const NoResults();

              } else {
                return Column(
                  children: [
                    for (PointsOfInterestResultsRow resultRow in results)
                      resultRow,
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _getSearchResults() async {
    results = [
      PointsOfInterestResultsRow(
        typeName: "Lazer e turismo",
        results: await Places.nearbySearch(
          type: "atração",
          maxprice: Explore.filters["maxPrice"],
          radius: Explore.filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Restaurantes",
        results: await Places.nearbySearch(
          type: "comida",
          maxprice: Explore.filters["maxPrice"],
          radius: Explore.filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Lojas",
        results: await Places.nearbySearch(
          type: "loja",
          maxprice: Explore.filters["maxPrice"],
          radius: Explore.filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Hospitais", 
        results: await Places.nearbySearch(
          type: "hospital",
          maxprice: Explore.filters["maxPrice"],
          radius: Explore.filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Templos religiosos",
        results: await Places.nearbySearch(
          type: "religião",
          maxprice: Explore.filters["maxPrice"],
          radius: Explore.filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Escolas",
        results: await Places.nearbySearch(
          type: "escola",
          maxprice: Explore.filters["maxPrice"],
          radius: Explore.filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Transporte público",
        results: await Places.nearbySearch(
          type: "transporte público",
          maxprice: Explore.filters["maxPrice"],
          radius: Explore.filters["distance"],
        ),
      ),
    ];
  }
}
