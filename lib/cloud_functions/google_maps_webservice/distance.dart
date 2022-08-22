import 'package:google_maps_webservice/distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maraca_map/cloud_functions/geolocator.dart';

class Distance {
  static const String _webAPIKey = "AIzaSyDGEN_ctKKkqaA0jtx6n7f1WH0y6KohfuI";
  static final GoogleDistanceMatrix _api = GoogleDistanceMatrix(apiKey: _webAPIKey);

  static Future<Element> fromHereTo(Location destination) async {
    LatLng userLocation = await Geolocator.getCurrentLatLng();
    Location origin = Location(lat: userLocation.latitude, lng: userLocation.longitude);

    DistanceResponse response = await _api.distanceWithLocation(
      [origin], [destination],
      travelMode: TravelMode.walking,
    );

    if (response.rows.isEmpty) {
      throw response.errorMessage!;
    } else {
      return response.rows[0].elements[0];
    }
  }
}
