import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';

class Geocoding {
  static const String _webAPIKey = "AIzaSyDGEN_ctKKkqaA0jtx6n7f1WH0y6KohfuI";
  static final GoogleMapsGeocoding _API = GoogleMapsGeocoding(apiKey: _webAPIKey);

  static Future<List<GeocodingResult>> searchByLocation(LatLng position) async {
    GeocodingResponse response = await _API.searchByLocation(
      Location(lat: position.latitude, lng: position.longitude),
    );

    return response.results;
  }
}
