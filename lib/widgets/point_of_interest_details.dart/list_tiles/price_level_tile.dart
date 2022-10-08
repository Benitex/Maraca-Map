import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/price_row.dart';

class PriceLevelTile extends StatelessWidget {
  const PriceLevelTile({super.key, required this.priceLevel});

  final PriceLevel priceLevel;

  @override
  Widget build(BuildContext context) {
    String price = "Muito caro";
    switch (priceLevel) {
      case PriceLevel.free:
        price = "Grátis";
        break;
      case PriceLevel.inexpensive:
        price = "Barato";
        break;
      case PriceLevel.moderate:
        price = "Moderado";
        break;
      case PriceLevel.expensive:
        price = "Caro";
        break;
      default: "Muito caro";
    }

    return ListTile(
      title: Row(children: [
        const Text("Preço"),
        const Spacer(),
        PriceRow(price: priceLevel),
        Text("($price)",
        ),
      ]),
    );
  }
}
