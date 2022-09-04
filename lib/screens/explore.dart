import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/explore/distance_form_field.dart';
import 'package:maraca_map/widgets/explore/points_of_interest_results_row.dart';
import 'package:maraca_map/widgets/explore/price_dropdown_menu.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  static Map<String, dynamic> filters = {
    "distance": 1000,
    "maxPrice": PriceLevel.veryExpensive,
  };

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorar"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Distância: ",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const DistanceFormField(),

            const Text("Preço: ", style: TextStyle(color: Colors.white)),
            const PriceDropdownMenu(),

            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () => setState(() {
                ExploreScreen.filters["filters"] = int.parse(DistanceFormField.controller.text);
              }),
            ),
          ]),
        ),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // Pontos de interesse próximos
          PointsOfInterestResultsRow(
            typeName: "Restaurantes",
            searchFor: "comida",
            filters: ExploreScreen.filters,
          ),
          PointsOfInterestResultsRow(
            typeName: "Lojas",
            searchFor: "loja",
            filters: ExploreScreen.filters,
          ),
          PointsOfInterestResultsRow(
            typeName: "Transporte público",
            searchFor: "transporte público",
            filters: ExploreScreen.filters,
          ),
          PointsOfInterestResultsRow(
            typeName: "Escolas",
            searchFor: "escola",
            filters: ExploreScreen.filters,
          ),
          PointsOfInterestResultsRow(
            typeName: "Lazer e turismo",
            searchFor: "atração",
            filters: ExploreScreen.filters,
          ),
          PointsOfInterestResultsRow(
            typeName: "Hospitais",
            searchFor: "hospital",
            filters: ExploreScreen.filters,
          ),
          PointsOfInterestResultsRow(
            typeName: "Templos religiosos",
            searchFor: "religião",
            filters: ExploreScreen.filters,
          ),
        ],
      ),
    );
  }
}
