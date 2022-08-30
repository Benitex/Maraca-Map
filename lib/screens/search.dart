import 'package:flutter/material.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/widgets/search/search_field.dart';
import 'package:maraca_map/widgets/point_of_interest_tile.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.searchField});

  final SearchField searchField;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.searchField,
        actions: [IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() => FocusManager.instance.primaryFocus?.unfocus());
          }
        )],
      ),

      body: FutureBuilder(
        future: Places.searchByText(widget.searchField.controller.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const ErrorScreen();
          } else if (!snapshot.hasData) {
            return const NoResults();

          } else {
            return ListView(
              children: [
                for (var result in snapshot.data!)
                  PointOfInterestTile(pointOfInterest: result),
              ],
            );
          }
        },
      ),
    );
  }
}
