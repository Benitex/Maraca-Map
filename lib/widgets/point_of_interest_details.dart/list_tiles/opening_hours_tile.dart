import 'package:flutter/material.dart';

class OpeningHoursTile extends StatelessWidget {
  const OpeningHoursTile({super.key, required this.openingHours});

  final List<String> openingHours;

  @override
  Widget build(BuildContext context) {
    if (openingHours[0] != 'Esse lugar não abre hoje.' && openingHours[0] != 'Horário de funcionamento indisponível.') {
      return ListTile(
        title: Text("Abre às ${openingHours[0]} e fecha às ${openingHours[1]}."),
      );
    } else {
      return ListTile(
        title: Text(openingHours[0]),
      );
    }
  }
}
