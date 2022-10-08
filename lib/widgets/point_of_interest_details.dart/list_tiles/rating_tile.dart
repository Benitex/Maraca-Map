import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:maraca_map/widgets/point_of_interest_details.dart/rating_row.dart';
import 'package:maraca_map/widgets/point_of_interest_details.dart/review.dart';

class RatingTile extends StatelessWidget {
  const RatingTile({super.key, required this.rating, required this.reviews});

  final num rating;
  final List<places.Review> reviews; 

  @override
  Widget build(BuildContext context) {
    if (rating == -1) {
      return const ListTile(
        title: Text("Esse lugar não possui classificação."),
      );
    } else {
      return Column(children: [
        ListTile(
          title: Row(children: [
            const Text("Classificação"),
            const Spacer(),
            RatingRow(rating: rating),
          ]),
        ),

        const Divider(height: 10),
        for (var review in reviews)
          Review(review: review),
      ]);
    }
  }
}
