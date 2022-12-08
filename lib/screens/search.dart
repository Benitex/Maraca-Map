import 'package:flutter/material.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/widgets/search_field.dart';
import 'package:maraca_map/widgets/point_of_interest_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchField});

  final SearchField searchField;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.searchField,
        actions: [IconButton(
          tooltip: "Buscar",
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
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return ErrorScreen(error: snapshot.error!);
          } else if (!snapshot.hasData) {
            return const NoResults();

          } else {
            return ListView(
              children: [
                for (var result in snapshot.data!)
                  PointOfInterestTile.fromPlaceSearchResult(result: result),
              ],
            );
          }
        },
      ),
    );
  }
}
