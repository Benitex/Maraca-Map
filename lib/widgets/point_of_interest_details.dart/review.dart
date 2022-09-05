import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart' as api;
import 'package:maraca_map/widgets/point_of_interest_details.dart/rating_row.dart';
import 'package:url_launcher/url_launcher.dart';

class Review extends StatelessWidget {
  const Review({super.key, required this.review});

  final api.Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        GestureDetector(
          onTap: () async {
            if (!await launchUrl(Uri.parse(review.authorUrl))) {
              throw "Could not launch ${Uri.parse(review.authorUrl)}";
            }
          },

          child: ListTile(
            title: Row(children: [
              Image.network(review.profilePhotoUrl, width: 40),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(review.authorName),
              ),
            ]),
            subtitle: RatingRow(rating: review.rating),
          ),
        ),

        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(review.text),
          ),
        ),

        const Divider(height: 10),
      ]),
    );
  }
}
