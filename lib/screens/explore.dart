import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/explore/distance_form_field.dart';
import 'package:maraca_map/widgets/explore/points_of_interest_results_row.dart';
import 'package:maraca_map/widgets/explore/price_dropdown_menu.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorar"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: const [
              Text("Distância média: ", style: TextStyle(color: Colors.white)),
              DistanceFormField(),
              Text("m", style: TextStyle(color: Colors.white)),
              Spacer(),
              Text("Preço: ", style: TextStyle(color: Colors.white)),
              PriceDropdownMenu(),
            ]),
          ),
        ),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          PointsOfInterestResultsRow(
            location: location,
            typeName: "Restaurantes",
            searchFor: "food",
          ),
          PointsOfInterestResultsRow(
            location: location,
            typeName: "Lojas",
            searchFor: "store",
          ),
          PointsOfInterestResultsRow(
            location: location,
            typeName: "Transporte público",
            searchFor: "transport",
          ),
          PointsOfInterestResultsRow(
            location: location,
            typeName: "Escolas",
            searchFor: "school",
          ),
          PointsOfInterestResultsRow(
            location: location,
            typeName: "Lazer e turismo",
            searchFor: "attraction",
          ),
          PointsOfInterestResultsRow(
            location: location,
            typeName: "Hospitais",
            searchFor: "medical",
          ),
          PointsOfInterestResultsRow(
            location: location,
            typeName: "Templos religiosos",
            searchFor: "place of worship",
          ),
        ],
      ),
    );
  }
}
