import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/screens/explore.dart';

class PriceDropdownMenu extends StatefulWidget {
  const PriceDropdownMenu({super.key});

  @override
  State<PriceDropdownMenu> createState() => _PriceDropdownMenuState();
}

class _PriceDropdownMenuState extends State<PriceDropdownMenu> {
  String _price = "veryExpensive";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _price,

      items: const <DropdownMenuItem<String>>[
        DropdownMenuItem(value: "free", child: Text("Grátis")),
        DropdownMenuItem(value: "inexpensive", child: Text("Barato")),
        DropdownMenuItem(value: "moderate", child: Text("Moderado")),
        DropdownMenuItem(value: "expensive", child: Text("Caro")),
        DropdownMenuItem(value: "veryExpensive", child: Text("Qualquer valor")),
      ],

      onChanged: (value) {
        setState(() {
          _price = value!;
        });
        switch (value) {
          case "free":
            Explore.filters["maxPrice"] = PriceLevel.free;
            break;
          case "inexpensive":
            Explore.filters["maxPrice"] = PriceLevel.inexpensive;
            break;
          case "moderate":
            Explore.filters["maxPrice"] = PriceLevel.moderate;
            break;
          case "expensive":
            Explore.filters["maxPrice"] = PriceLevel.expensive;
            break;
          case "veryExpensive":
            Explore.filters["maxPrice"] = PriceLevel.veryExpensive;
            break;
        }
      }
    );
  }
}
