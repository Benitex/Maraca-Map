import 'package:flutter/material.dart';

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
              color: Theme.of(context).primaryColor,
            ),
          ),
        Text("($rating)"),
      ],
    );
  }
}
