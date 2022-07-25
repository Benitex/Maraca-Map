// APIs module

import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class API {
  static const String _webAPIKey = "AIzaSyDGEN_ctKKkqaA0jtx6n7f1WH0y6KohfuI";

  static final GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _webAPIKey);
  static final GoogleMapsGeocoding geoCoding = GoogleMapsGeocoding(apiKey: _webAPIKey);
}
