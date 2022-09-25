import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/explore/distance_form_field.dart';
import 'package:maraca_map/widgets/explore/points_of_interest_results_row.dart';
import 'package:maraca_map/widgets/explore/price_dropdown_menu.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.location});

  final Location location;

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
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(children: const [
                Text("Distância média: ", style: TextStyle(color: Colors.white)),
                DistanceFormField(),
                Text("m", style: TextStyle(color: Colors.white)),
              ]),
            ),

            const Text("Preço: ", style: TextStyle(color: Colors.white)),
            const PriceDropdownMenu(),

            const Spacer(),
            IconButton(
              tooltip: "Filtrar",
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
          PointsOfInterestResultsRow(
            location: widget.location,
            typeName: "Restaurantes",
            searchFor: "food",
          ),
          PointsOfInterestResultsRow(
            location: widget.location,
            typeName: "Lojas",
            searchFor: "store",
          ),
          PointsOfInterestResultsRow(
            location: widget.location,
            typeName: "Transporte público",
            searchFor: "transport",
          ),
          PointsOfInterestResultsRow(
            location: widget.location,
            typeName: "Escolas",
            searchFor: "school",
          ),
          PointsOfInterestResultsRow(
            location: widget.location,
            typeName: "Lazer e turismo",
            searchFor: "attraction",
          ),
          PointsOfInterestResultsRow(
            location: widget.location,
            typeName: "Hospitais",
            searchFor: "medical",
          ),
          PointsOfInterestResultsRow(
            location: widget.location,
            typeName: "Templos religiosos",
            searchFor: "place of worship",
          ),
        ],
      ),
    );
  }
}
