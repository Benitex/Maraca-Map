import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class PriceDropdownMenu extends StatefulWidget {
  const PriceDropdownMenu({super.key});

  static PriceLevel price = PriceLevel.veryExpensive;

  @override
  State<PriceDropdownMenu> createState() => _PriceDropdownMenuState();
}

class _PriceDropdownMenuState extends State<PriceDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<PriceLevel>(
      style: const TextStyle(color: Colors.white),
      dropdownColor: Theme.of(context).primaryColor,

      value: PriceDropdownMenu.price,

      items: const <DropdownMenuItem<PriceLevel>>[
        DropdownMenuItem(value: PriceLevel.free, child: Text("Grátis")),
        DropdownMenuItem(value: PriceLevel.inexpensive, child: Text("Barato")),
        DropdownMenuItem(value: PriceLevel.moderate, child: Text("Moderado")),
        DropdownMenuItem(value: PriceLevel.expensive, child: Text("Caro")),
        DropdownMenuItem(value: PriceLevel.veryExpensive, child: Text("Qualquer valor")),
      ],

      onChanged: (value) => setState(() => PriceDropdownMenu.price = value!),
    );
  }
}
