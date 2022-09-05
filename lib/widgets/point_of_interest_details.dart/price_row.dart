import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class PriceRow extends StatelessWidget {
  PriceRow({super.key, required this.price}) {
    switch (price) {
      case PriceLevel.free:
        _priceLevel = 0;
        break;
      case PriceLevel.inexpensive:
        _priceLevel = 1;
        break;
      case PriceLevel.moderate:
        _priceLevel = 2;
        break;
      case PriceLevel.expensive:
        _priceLevel = 3;
        break;
      case PriceLevel.veryExpensive:
        _priceLevel = 4;
        break;
      default:
    }
  }

  final PriceLevel price;
  late final int _priceLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int signCounter = 1; signCounter <= 5; signCounter++)
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Icon(
              Icons.attach_money,
              color: _priceLevel >= signCounter ? Colors.amber : Colors.grey,
            ),
          ),
      ],
    );
  }
}
