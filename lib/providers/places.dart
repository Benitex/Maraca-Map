import 'package:google_maps_webservice/places.dart';

class Places {
  static const String _webAPIKey = "AIzaSyDGEN_ctKKkqaA0jtx6n7f1WH0y6KohfuI";
  static final GoogleMapsPlaces _API = GoogleMapsPlaces(apiKey: _webAPIKey);

  static Future<PlaceDetails> getDetailsByPlaceId(String id) async {
    PlacesDetailsResponse response = await _API.getDetailsByPlaceId(id, language: "pt-BR");

    return response.result;
  }
}
