import 'package:flutter/material.dart';
import 'package:maraca_map/screens/settings.dart';

class RatingRow extends StatelessWidget {
  const RatingRow({super.key, required this.rating});

  final num rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int starCounter = 1; starCounter <= 5; starCounter++)
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Icon(
              rating >= starCounter ? Icons.star : Icons.star_border,
              color: SettingsScreen.options["Modo escuro"]!.active ? const Color(0xFF3CA6A6) : const Color(0xFF012030),
            ),
          ),
        Text(rating.toString()),
      ],
    );
  }
}
