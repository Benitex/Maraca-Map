import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/cloud_functions/places.dart';
import 'package:maraca_map/widgets/explore/points_of_interest_results_row.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late List<PointsOfInterestResultsRow> results;
  Map<String, dynamic> filters = {
    "distance": 1000,
    "maxPrice": PriceLevel.veryExpensive,
  };

  Future<void> _getSearchResults() async {
    results = [
      PointsOfInterestResultsRow(
        typeName: "Lazer e turismo",
        results: await Places.nearbySearch(
          type: "atração",
          maxprice: filters["maxPrice"],
          radius: filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Restaurantes",
        results: await Places.nearbySearch(
          type: "comida",
          maxprice: filters["maxPrice"],
          radius: filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Lojas",
        results: await Places.nearbySearch(
          type: "loja",
          maxprice: filters["maxPrice"],
          radius: filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Hospitais", 
        results: await Places.nearbySearch(
          type: "hospital",
          maxprice: filters["maxPrice"],
          radius: filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Templos religiosos",
        results: await Places.nearbySearch(
          type: "religião",
          maxprice: filters["maxPrice"],
          radius: filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Escolas",
        results: await Places.nearbySearch(
          type: "escola",
          maxprice: filters["maxPrice"],
          radius: filters["distance"],
        ),
      ),
      PointsOfInterestResultsRow(
        typeName: "Transporte público",
        results: await Places.nearbySearch(
          type: "transporte público",
          maxprice: filters["maxPrice"],
          radius: filters["distance"],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorar"),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // TODO adicionar filtros
          FutureBuilder(
            future: _getSearchResults(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: Center(child: CircularProgressIndicator()),
                );

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
}
